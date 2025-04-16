<template>
	<div>
		<div class="center_view">
			<div class="list_search_view">
				<el-form :model="searchQuery" class="search_form">
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
						<el-button class="search_btn" type="primary" @click="searchClick()" size="small">搜索</el-button>
					</div>
				</el-form>
			</div>
			<br>
			<el-table v-loading="listLoading" border :stripe='false' @selection-change="handleSelectionChange" ref="table"
				v-if="btnAuth('exampaper/12','查看')" :data="list" @row-click="listChange">
				<el-table-column :resizable='true' align="left" header-align="left" type="selection" width="55" />
				<el-table-column label="序号" width="120" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">{{ scope.$index + 1}}</template>
				</el-table-column>
				<el-table-column min-width="140"
					 :resizable='true'
					 :sortable='true'
					 align="left"
					 header-align="left"
					 prop="name"
					label="试卷名称">
					<template #default="scope">
						{{scope.row.name}}
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					 :resizable='true'
					 :sortable='true'
					 align="left"
					 header-align="left"
					 prop="time"
					label="考试时长(分钟)">
					<template #default="scope">
						{{scope.row.time}}
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					 :resizable='true'
					 :sortable='true'
					 align="left"
					 header-align="left"
					 prop="status"
					label="试卷状态">
					<template #default="scope">
						{{scope.row.status}}
					</template>
				</el-table-column>
				<el-table-column label="操作" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						<el-button class="edit_btn" type="success" @click="examClick(scope.row.id)">开始考试</el-button>
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
				@current-change="currentChange" />
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

	//基础信息
	const tableName = 'exampaper'
	const formName = '在线测试'
	const route = useRoute()
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
		if(searchQuery.value.name&&searchQuery.value.name!=''){
			params['name'] = '%' + searchQuery.value.name + '%'
		}
		context?.$http({
			url: `${tableName}/page`,
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
	//表单
	const formRef = ref(null)
	//考试
	const examClick = (id) => {
		if (id) {
			context?.$http({
				url: `examrecord/deleteRecords?userid=${context?.$toolUtil.storageGet('admin_userid')}&&paperid=${id}`,
				method: 'post'
			})
			router.push(`/examination?id=${id}`)
		}
	}
	//表单
	//搜索
	//初始化
	const init = () => {
		getList()
	}
	init()
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
							// 开始考试
							.el-button--success {
							}
							// 开始考试-悬浮
							.el-button--success:hover {
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