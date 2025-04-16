<template>
	<div class="list-page" :style='{}'>
		<div class="back_view" v-if="centerType">
			<el-button class="back_btn" @click="backClick" type="primary">返回</el-button>
		</div>
		<div class="section_title">
            <span>{{formName}}</span>
		</div>
        <el-form :inline="true" class="list_search">
            <div class="search_btn_view">
                <el-button class="add_btn" @click="addClick">
                    新增{{formName}}
                </el-button>
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
						<el-table-column label="地址" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.address}}
							</template>
						</el-table-column>
						<el-table-column label="收货人" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.name}}
							</template>
						</el-table-column>
						<el-table-column label="电话" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								{{scope.row.phone}}
							</template>
						</el-table-column>
						<el-table-column label="是否默认地址" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								<el-switch v-model="scope.row.isdefault" class="ml-2" @change="(e)=>isdefaultChange(e,scope.row)" active-value="是" inactive-value="否" />
							</template>
						</el-table-column>
						<el-table-column label="操作" :resizable='true' align="left" header-align="left">
							<template #default="scope">
								<el-button class="edit_btn" @click="editClick(scope.row.id)" type="primary" size="default">修改</el-button>
								<el-button class="del_btn" @click="delClick(scope.row.id)" type="danger" size="default">删除</el-button>
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
					@current-change="currentChange"  />
			</div>
		</div>
		<formModel ref="formModelRef" @formModelChange="formModelChange"></formModel>
	</div>
</template>

<script setup>
	import formModel from './formModel'
	import {
		ref,
		nextTick,
		getCurrentInstance
	} from 'vue';
	import {
		ElMessageBox
	} from 'element-plus'
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'address'
	const formName = '地址'
	const router = useRouter()
	const route = useRoute()
	//基础信息
	//权限验证
	const btnAuth = (e, a) => {
		return context?.$toolUtil.isAuth(e, a)
	}
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 20,
		userid: context?.$toolUtil.storageGet('userid')
	})
	const selRows = ref([])
	const searchQuery = ref({})
	const table = ref(null)
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		context?.$http({
			url: `address/list`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = res.data.data.total
		})
	}
	//定义弹窗
	const formModelRef = ref(null)
	const formModelChange = () =>{
		listQuery.value.page = 1
		getList()
	}
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
	//新增
	const addClick = () => {
		formModelRef.value.init(null,'新增' + formName)
	}
	//修改
	const editClick = (id = null) => {
		if (id) {
			formModelRef.value.init(id,'修改' + formName)
		}
	}
	const delClick = (id = null) => {
		if (id) {
			ElMessageBox.confirm(`是否删除选中${formName}`, '提示', {
				confirmButtonText: '是',
				cancelButtonText: '否',
				type: 'warning',
			}).then(() => {
				context?.$http({
					url: `address/delete`,
					method: 'post',
					data: [id]
				}).then(res => {
					context?.$toolUtil.message('删除成功', 'success', () => {
						getList()
					})
				})
			}).catch(_ => {})
		}
	}
	const isdefaultChange = (e,row) =>{
		context?.$http({
			url: `address/update`,
			method: 'post',
			data: row
		}).then(res => {
			getList()
		})
	}
	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
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

<style lang="scss">
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
	// 数据盒子
	.page_list {
		.data_box {
			.data_view {
			}
		}
	}
	.search_btn_view {
		// 新增按钮
		.add_btn {
		}
		// 新增按钮-悬浮
		.add_btn:hover {
		}
	}
	
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
							// 修改
							.edit_btn {
								border: 0;
								cursor: pointer;
								border-radius: 4px;
								padding: 0 10px;
								margin: 0 5px 10px 0;
								outline: none;
								color: #fff;
								background: #feb043;
								width: auto;
								font-size: 14px;
								height: 32px;
							}
							// 修改-悬浮
							.edit_btn:hover {
								background: #feb04390;
							}
							// 删除
							.del_btn {
								border: 0;
								cursor: pointer;
								border-radius: 4px;
								padding: 0 10px;
								margin: 0 5px 10px 0;
								outline: none;
								color: #fff;
								background: rgba(255, 73, 73, 1);
								width: auto;
								font-size: 14px;
								height: 32px;
							}
							// 删除-悬浮
							.del_btn:hover {
								background: rgba(255, 73, 73, 0.5);
							}
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