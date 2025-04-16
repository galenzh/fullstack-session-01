<template>
	<div class="list-page" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="back_view" v-if="centerType">
                <el-button class="back_btn" @click="backClick" type="primary">返回</el-button>
            </div>
        </div>
		<div class="section_title">
            <span>{{formName}}</span>
		</div>
		<el-form :model="searchQuery" class="list_search">
			<div class="search_view">
				<div class="search_label">
					在线测试：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.papername" placeholder="在线测试名称"
						size="small" clearable>
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
					<el-table v-loading="listLoading" border :stripe='true' ref="table" :data="list">
						<el-table-column label="序号" width="120" :resizable='true' align="left" header-align="left">
							<template #default="scope">{{ scope.$index + 1}}</template>
						</el-table-column>
						<el-table-column label="考生姓名" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.username}}
							</template>
						</el-table-column>
						<el-table-column label="在线测试名称" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.papername}}
							</template>
						</el-table-column>
						<el-table-column label="得分" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								<el-tag type="success" v-if="scope.row.myscore>0 && !scope.row.ismark">{{scope.row.myscore}}</el-tag>
								<el-tag type="danger" v-else-if="scope.row.myscore==0 && !scope.row.ismark">{{scope.row.myscore}}</el-tag>
							</template>

						</el-table-column>
						<el-table-column label="操作" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								<el-button class="viewExam_btn" :type="'primary'" @click="infoClick(scope.row)" size="small">查看答卷</el-button>
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
		<formModel ref="formRef" @formModelChange="formModelChange"></formModel>
	</div>
</template>

<script setup>
	import {
		ref,
		nextTick,
		getCurrentInstance
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	import {
		ElMessageBox
	} from 'element-plus'
	import formModel from './examrecordFormModel.vue'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'examrecord'
	const formName = '考试记录'
	const router = useRouter()
	const route = useRoute() 
	//基础信息
	const listLoading = ref(false)
	const list = ref([])
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
	//权限验证
	const btnAuth = (e, a) => {
		return context?.$toolUtil.isAuth(e, a)
	}
	//搜索
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	const table = ref(null)
	const listChange = (row) => {
		nextTick(() => {
			table.value.clearSelection()
			table.value.toggleRowSelection(row)
		})
	}
	const listQuery = ref({
		page: 1,
		limit: 20,
	})
	const searchQuery = ref({})
	const selRows = ref([])
	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
	}
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if (searchQuery.value.papername && searchQuery.value.papername != '') {
			params['papername'] = '%' + searchQuery.value.papername + '%'
		}
		context?.$http({
			url: `examrecord/groupby`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}
	const formRef = ref(null)
	const formModelChange = () => {
		searchClick()
	}
	const infoClick = (row) => {
		nextTick(() => {
			formRef.value.init(row)
		})
	}
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
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
										// 查看答卷
										.viewExam_btn {
											border: 0;
											cursor: pointer;
											border-radius: 4px;
											padding: 0 10px;
											margin: 0 5px 10px 0;
											outline: none;
											color: #fff;
											background: #32e1e3;
											width: auto;
											font-size: 14px;
											height: 32px;
										}
										// 查看答卷-悬浮
										.viewExam_btn:hover {
											background: #32e1e390;
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