<template>
	<div>
		<div class="center_view">
			<div>
				<div class="list_search_view">
					<el-form :model="searchQuery" class="search_form">
						<div class="search_view">
							<div class="search_label">
								在线测试：
							</div>
							<div class="search_box">
								<el-input class="search_inp" v-model="searchQuery.papername" placeholder="在线测试名称"
								 clearable>
								</el-input>
							</div>
						</div>
						<div class="search_btn_view">
							<el-button class="search_btn" type="primary" @click="searchClick()">搜索</el-button>
						</div>
					</el-form>
					<br>
					<div class="btn_view">
						<el-button class="other_btn" type="default" @click="exportClick" v-if="btnAuth('examrecord','导出')">导出</el-button>
						<el-button class="other_btn" type="default" @click="printClick" v-if="btnAuth('examrecord','打印')">打印</el-button>
					</div>
				</div>
			</div>
			<br>
			<el-table v-loading="listLoading" border :stripe='false' ref="table" :data="list">
				<el-table-column label="序号" width="120" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">{{ scope.$index + 1}}</template>
				</el-table-column>
				<el-table-column label="考生姓名" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.username}}
					</template>
				</el-table-column>
				<el-table-column label="在线测试名称" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.papername}}
					</template>
				</el-table-column>
				<el-table-column label="考试得分" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.myscore>0">{{scope.row.myscore}}</el-tag>
						<el-tag type="danger" v-else>{{scope.row.myscore}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column label="操作" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						<el-button class="edit_btn" type="info" @click="infoClick(scope.row)" size="small">查看答卷</el-button>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				background
				:layout="layouts.join(',')"
				:total="total" 
				:page-size="listQuery.limit"
                v-model:current-page="listQuery.page"
				prev-text="<"
				next-text=">"
				:hide-on-single-page="false"
				:style='{}'
				@size-change="sizeChange"
				@current-change="currentChange"  />
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
	import formModel from './formModel.vue'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'examrecord'
	const formName = '考试记录'
	const route = useRoute()
	//基础信息
	const listLoading = ref(false)
	const list = ref([])
	//分页
	const total = ref(0)
	const layouts = ref(["total","prev","pager","next","sizes","jumper"])
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
    getList()
	const formRef = ref(null)
	const formModelChange = () => {
		searchClick()
	}
	const infoClick = (row) => {
		nextTick(()=>{
			formRef.value.init(row)
		})
	}
	//导出选中数据
	const exportClick = () => {
		import('@/utils/Export2Excel').then(excel => {
			const tHeader = [
				"考生姓名",
				"在线测试名称",
				"总分",
			]
			const filterVal = [
				"username",
				"papername",
				"myscore",
			]
			excel.export_json_to_excel2(tHeader, list.value, filterVal, formName)
		})
	}
	//打印
	const printClick = () => {
		let data = []
		for (let x in list.value) {
			data.push({
				username: list.value[x].username,
				papername: list.value[x].papername,
				myscore: list.value[x].myscore,
			})
		}
		printJS({
			printable: data,
			properties: [{
					field: 'username',
					displayName: '考生姓名',
					columnSize: 1
				},
				{
					field: 'papername',
					displayName: '在线测试名称',
					columnSize: 1
				},
				{
					field: 'myscore',
					displayName: '总分',
					columnSize: 1
				},
			],
			type: 'json',
			header: formName,
			gridStyle: 'border: 1px solid #3971A5; text-align: center; padding: 6px 10px',
			gridHeaderStyle: 'color: #000; border: 1px solid #3971A5; padding: 6px 10px'
		})
	}
</script>

<style lang="scss" scoped>
	// 操作盒子
	.list_search_view {
		// 搜索盒子
		.search_form {
			// 子盒子
			.search_view {
				// 搜索label
				.search_label {
				}
				// 搜索item
				.search_box {
					// 输入框
					:deep(.search_inp) {
					}
				}
			}
			// 搜索按钮盒子
			.search_btn_view {
				width: 20%;
				display: flex;
				padding: 0 20px;
				// 搜索按钮
				.search_btn {
				}
				// 搜索按钮-悬浮
				.search_btn:hover {
				}
			}
		}
		//头部按钮盒子
		.btn_view {
			// 导出
			:deep(.el-button--warning) {
			}
			// 导出-悬浮
			:deep(.el-button--warning:hover) {
			}
		}
	}
	// 表格样式
	.el-table {
		:deep(.el-table__header-wrapper) {
			thead {
				tr {
					th {
						.cell {
						}
					}
				}
			}
		}
		:deep(.el-table__body-wrapper) {
			tbody {
				tr {
					td {
						.cell {
							// 详情
							.el-button--info {
							}
							// 详情-悬浮
							.el-button--info:hover {
							}
						}
					}
				}
				tr:hover {
					td {
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
			.number.active {
			}
		}
		// sizes
		:deep(.el-pagination__sizes) {
			display: inline-block;
			vertical-align: top;
			font-size: 13px;
			line-height: 28px;
			height: 28px;
			.el-select {
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