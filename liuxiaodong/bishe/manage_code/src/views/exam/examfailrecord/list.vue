<template>
	<div>
		<div class="center_view">
			<div>
				<div class="list_search_view">
					<el-form :model="searchQuery" class="search_form">
						<div class="search_view">
							<div class="search_label">
								在线测试名称：
							</div>
							<div class="search_box">
								<el-input class="search_inp" v-model="searchQuery.papername" placeholder="在线测试名称"
									clearable>
								</el-input>
							</div>
						</div>
						<div class="search_view">
							<div class="search_label">
								试题库名称：
							</div>
							<div class="search_box">
								<el-input class="search_inp" v-model="searchQuery.questionname" placeholder="试题库名称"
									clearable>
								</el-input>
							</div>
						</div>
						<div class="search_btn_view">
							<el-button class="search_btn" type="primary" @click="searchClick()">搜索</el-button>
						</div>
					</el-form>
				</div>
			</div>
			<br>
			<el-table v-loading="listLoading" border :stripe='false' @selection-change="handleSelectionChange" ref="table"
				 :data="list" @row-click="listChange">
				<el-table-column :resizable='true' align="left" header-align="left" type="selection" width="55" />
				<el-table-column label="序号" width="120" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">{{ scope.$index + 1}}</template>
				</el-table-column>
				<el-table-column label="在线测试名称" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.papername}}
					</template>
				</el-table-column>
				<el-table-column label="试题库名称" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.questionname}}
					</template>
				</el-table-column>
                <el-table-column label="考生姓名" v-if="role=='管理员'" :resizable='true' :sortable='true' align="left" header-align="left">
                    <template #default="scope">
                        {{scope.row.username}}
                    </template>
                </el-table-column>
				<el-table-column label="考生答案" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
                        {{scope.row.type!=2?scope.row.myanswer:{'A':'对','B':'错'}[scope.row.myanswer]}}
					</template>
				</el-table-column>
                <el-table-column label="正确答案" :resizable='true' :sortable='true' align="left" header-align="left">
                    <template #default="scope">
                        <template v-if="scope.row.type<4">
                            <span v-if="scope.row.type==2">{{scope.row.answer=='A'?'对':'错'}}</span>
                            <span v-else>{{scope.row.answer}}</span>
                        </template>
                    </template>
                </el-table-column>
				<el-table-column label="解析" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.analysis}}
					</template>
				</el-table-column>
				<el-table-column label="考试时间" :resizable='true' :sortable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.addtime}}
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
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'examfailrecord'
	const formName = '错题本'
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
    const role = ref(context.$toolUtil.storageGet('role'))
	const listQuery = ref({
		page: 1,
		limit: 20,
		sort: 'id',
		userid: role.value=="管理员"||localStorage.getItem('isAdmin')==1?null:context?.$toolUtil.storageGet('admin_userid'),
		myscore: 0
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
		if (searchQuery.value.questionname && searchQuery.value.questionname != '') {
			params['questionname'] = '%' + searchQuery.value.questionname + '%'
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