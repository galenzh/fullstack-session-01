<template>
	<div class="list-page" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            <div class="back_view" v-if="centerType">
                <el-button class="back_btn" @click="backClick" type="primary">返回</el-button>
            </div>
        </div>
		<el-form :inline="true" :model="searchQuery" class="list_search">
			<div class="search_view">
				<div class="search_label">
					试卷名称：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.name" placeholder="试卷名称"
						clearable>
					</el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn" type="primary" @click="searchClick">搜索</el-button>
			</div>
		</el-form>
		<div class="page_list">
			<div class="data_box">
				<div class="table_view">
					<el-table v-loading="listLoading" border :stripe='true' @selection-change="handleSelectionChange" ref="table"
						:data="list" @row-click="listChange">
						<el-table-column type="selection" width="55" :resizable='true' align="left" header-align="left" />
						<el-table-column label="序号" width="120" :resizable='true' align="left" header-align="left">
							<template #default="scope">{{ scope.$index + 1}}</template>
						</el-table-column>
						<el-table-column label="试卷名称" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								<span v-if="scope.row.id === 1" class="personality-test">{{scope.row.name}}</span>
								<span v-else>{{scope.row.name}}</span>
							</template>
						</el-table-column>
						<el-table-column label="考试时长(分钟)" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.time}}
							</template>
						</el-table-column>
						<el-table-column label="试卷状态" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.status}}
							</template>
						</el-table-column>
						<el-table-column label="操作" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								<el-button v-if="scope.row.id === 1" class="exam_btn personality-btn" type="primary" @click="examClick(scope.row.id)" size="small">开始测试</el-button>
								<el-button v-else class="exam_btn" @click="examClick(scope.row.id)" size="small">开始考试</el-button>
							</template>
						</el-table-column>
					</el-table>
				</div>
				<el-pagination
					background 
					:layout="layouts.join(',')"
					:total="total" 
					:page-size="listQuery.limit"
                    v-model:current-page="listQuery.page"
					prev-text="上一页"
					next-text="下一页"
					:hide-on-single-page="false"
					:style='{}'
					@size-change="sizeChange"
					@current-change="currentChange"/>
			</div>
		</div>
	</div>
</template>
<script setup>
	import {
		reactive,
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
        computed,
	} from 'vue'
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	import {
		ElMessageBox
	} from 'element-plus'
    import {
        useStore
    } from 'vuex';
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	
	//基础信息
	const tableName = 'exampaper'
	const formName = '考试'
	const breadList = ref([{
		name: formName
	}])
	//基础信息
	onMounted(() => {})
	//列表数据
	const list = ref(null)
	const table = ref(null)
	const listQuery = ref({
		page: 1,
		limit: 20,
		sort: 'id',
		status: 1
	})
	const searchQuery = ref({})
	const selRows = ref([])
	const listLoading = ref(false)
	const listChange = (row) => {
		nextTick(() => {
			table.value.clearSelection()
			table.value.toggleRowSelection(row)
		})
	}
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		params['sort'] = 'id'
		params['order'] = 'desc'
		if (searchQuery.value.name && searchQuery.value.name != '') {
			params['name'] = '%' + searchQuery.value.name + '%'
		}
		if(searchQuery.value.name&&searchQuery.value.name!=''){
			params.name = '%' + searchQuery.value.name + '%'
		}
		context?.$http({
			url: `${tableName}/list`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}
	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
	}
	//列表数据
	//分页
	const layouts = ref(["total","prev","pager","next","sizes","jumper"])
	const total = ref(0)
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//分页
	//搜索
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	//表单
	const formRef = ref(null)
	//开始考试
	const examClick = (id) => {
		if (id) {
			// 性格测试（ID为1）特殊处理
			if (id === 1) {
				// 删除可能存在的旧记录
				context?.$http({
					url: `examrecord/deleteRecords?userid=${context?.$toolUtil.storageGet('userid')}&&paperid=${id}`,
					method: 'post'
				})
				// 直接跳转到考试页面
				router.push(`/examination?id=${id}`)
			} else {
				// 其他考试的正常流程
			context?.$http({
				url: `examrecord/deleteRecords?userid=${context?.$toolUtil.storageGet('userid')}&&paperid=${id}`,
				method: 'post'
			})
			router.push(`/examination?id=${id}`)
			}
		}
	}
	//表单

	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	//下拉列表
	//初始化
	const init = () => {
		if (route.query.centerType) {
			centerType.value = true
		}
		getList()
	}
	init()
</script>
<style lang="scss" scoped>
	// 返回盒子
	.back_view {
		border-radius: 4px;
		padding: 10px 0px;
		margin: 10px auto;
		z-index: 999;
		background: none;
		width: 100%;
		text-align: right;
		// 返回按钮
		.back_btn {
			border: 1px solid #0076ca50;
			cursor: pointer;
			border-radius: 4px;
			padding: 0 24px;
			color: #0076ca;
			background: #fff;
			width: auto;
			font-size: 14px;
			height: 34px;
		}
		// 返回按钮-悬浮
		.back_btn:hover {
		}
	}
	
	// 性格测试样式
	.personality-test {
		font-weight: bold;
		color: #409EFF;
		position: relative;
		&::after {
			content: '【推荐】';
			color: #F56C6C;
			font-size: 12px;
			margin-left: 5px;
		}
	}
	
	.personality-btn {
		font-weight: bold;
	}
	
	// 面包屑盒子
	.bread_view {
		:deep(.breadcrumb) {
			.el-breadcrumb__separator {
			}
			.first_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
			.second_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
		}
	}

	//搜索
	.list_search {
		.search_view {
			.search_label {
			}
			.search_box {
				// 输入框
				:deep(.search_inp) {
				}
			}
		}
		.search_btn_view {
			// 搜索按钮
			.search_btn {
			}
			// 搜索按钮-悬浮
			.search_btn:hover {
			}
		}
	}
	// 数据盒子
	.page_list {
		//列表
		.data_box {
			.data_view {
				// 表格样式
				.el-table {
					padding: 0;
					background: #fff;
					width: 100%;
					border-color: #eee;
					border-width: 1px 0 0 1px;
					border-style: solid;
					:deep(.el-table__header-wrapper) {
						thead {
							width: 100%;
							tr {
								background: #fff;
								th {
									padding: 10px 0;
									border-color: #eee;
									border-width: 0 1px 1px 0;
									border-style: solid;
									text-align: left;
									.cell {
										padding: 0 0 0 5px;
										word-wrap: normal;
										color: #666;
										white-space: normal;
										font-weight: bold;
										display: flex;
										vertical-align: middle;
										font-size: 13px;
										line-height: 24px;
										text-overflow: ellipsis;
										word-break: break-all;
										width: 100%;
										align-items: center;
										position: relative;
										//未选中样式
										.el-checkbox {
											//复选框
											.el-checkbox__inner {
												background: #fff;
												border-color: #999;
											}
										}
										//选中样式
										.is-checked {
											//复选框
											.el-checkbox__inner {
												background: #55ffff;
												border-color: #55ffff;
											}
										}
									}
								}
							}
						}
					}
					:deep(.el-table__body-wrapper) {
						tbody {
							width: 100%;
							tr {
								background: #fff;
								td {
									padding: 10px 0 0;
									color: #666;
									background: #fff;
									border-color: #eee;
									border-width: 0 1px 1px 0;
									border-style: solid;
									text-align: left;
									.cell {
										padding: 0 0 0 5px;
										overflow: hidden;
										word-break: break-all;
										white-space: normal;
										line-height: 24px;
										text-overflow: ellipsis;
										//未选中样式
										.el-checkbox {
											//复选框
											.el-checkbox__inner {
												background: #fff;
												border-color: #999;
											}
										}
										//选中样式
										.is-checked {
											//复选框
											.el-checkbox__inner {
												background: #55ffff;
												border-color: #55ffff;
											}
										}
										// 开始考试
										.exam_btn {
											border: 0;
											cursor: pointer;
											border-radius: 4px;
											padding: 0 10px;
											margin: 0 5px 10px 0;
											outline: none;
											color: #fff;
											background: #67C23A;
											width: auto;
											font-size: 14px;
											height: 32px;
										}
										// 开始$examAlias-悬浮
										.exam_btn:hover {
											background: rgba(103,194,58,.5);
										}
									}
								}
							}
							tr.el-table__row--striped {
								td {
									background: #FAFAFA !important;
								}
							}
							tr:hover {
								td {
									padding: 10px 0 0;
									color: #333;
									background: #f6f6f6;
									border-color: #eee;
									border-width: 0 1px 1px 0;
									border-style: solid;
									text-align: left;
								}
							}
						}
					}
				}
			}
		}
	}
	// 分页器
	.el-pagination {
		// 总页码
		:deep(.el-pagination__total) {
		}
		// 上一页
		:deep(.btn-prev) {
		}
		// 下一页
		:deep(.btn-next) {
		}
		// 上一页禁用
		:deep(.btn-prev:disabled) {
		}
		// 下一页禁用
		:deep(.btn-next:disabled) {
		}
		// 页码
		:deep(.el-pager) {
			// 数字
			.number {
			}
			// 数字悬浮
			.number:hover {
			}
			// 选中
			.number.is-active {
			}
		}
		// sizes
		:deep(.el-pagination__sizes) {
			.el-select {
				//去掉默认样式
				.select-trigger{
					height: 100%;
					.el-input{
						height: 100%;
					}
				}
			}
		}
		// 跳页
		:deep(.el-pagination__jump) {
			// 输入框
			.el-input {
			}
		}
	}
</style>