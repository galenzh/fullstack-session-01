<template>
	<el-dialog v-model="formVisible" title="考卷" width="70%" destroy-on-close>
		<div class="list_view">
			<el-form :model="searchQuery" class="list_search">
				<div class="search_view">
					<div class="search_label">
                      题目名称：
					</div>
					<div class="search_box">
						<el-input class="search_inp" v-model="searchQuery.questionname" placeholder="题目名称" size="small" clearable>
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
							<el-table-column label="序号" width="120"  :resizable='true' align="left" header-align="left">
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
							<el-table-column label="题目名称" :resizable='true' align="left" header-align="left">
								<template #default="scope">
									{{scope.row.questionname}}
								</template>
							</el-table-column>
							<el-table-column label="考试得分" :resizable='true' align="left" header-align="left">
								<template #default="scope">
									<el-tag type="success" v-if="scope.row.myscore>0">{{scope.row.myscore}}</el-tag>
									<el-tag type="danger" v-else>{{scope.row.myscore}}</el-tag>
								</template>
							</el-table-column>
							<el-table-column label="考生答案" :resizable='true' align="left" header-align="left">
								<template #default="scope">
                                    {{scope.row.type!=2?scope.row.myanswer:{'A':'对','B':'错'}[scope.row.myanswer]}}
								</template>
							</el-table-column>
							<el-table-column label="考试时间" :resizable='true' align="left" header-align="left">
								<template #default="scope">
									{{scope.row.addtime}}
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
		
	</el-dialog>
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
	const formVisible = ref(false)
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'examrecord'
	const formName = '考试记录'
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
		if (searchQuery.value.questionname && searchQuery.value.questionname != '') {
			params['questionname'] = '%' + searchQuery.value.questionname + '%'
		}
		if(paperid.value){
			params['paperid'] = paperid.value
		}
		if(userid.value){
			params['userid'] = userid.value
		}
		context?.$http({
			url: `examrecord/page`,
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
		nextTick(()=>{
			formRef.value.init(row)
		})
	}
	const paperid = ref(0)
	const userid = ref(0)
	const init = (row) => {
		paperid.value = row.paperid
		userid.value = row.userid
		getList()
		formVisible.value = true
	}
	//声明父级调用
	defineExpose({
		init
	})
	
</script>

<style lang="scss" scoped>
	.list_view {
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