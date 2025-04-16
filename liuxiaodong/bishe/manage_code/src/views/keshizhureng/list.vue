<template>
	<div class="center_view">
		<div class="list_search_view">
			<el-form :inline="true" :model="searchForm" class="search_form">
				<div class="search_view">
					<div class="search_label">账号：</div>
					<div class="search_box">
						<el-input v-model="searchForm.zhanghao" placeholder="账号" clearable></el-input>
					</div>
				</div>
				<div class="search_view">
					<div class="search_label">科室主任姓名：</div>
					<div class="search_box">
						<el-input v-model="searchForm.xingming" placeholder="科室主任姓名" clearable></el-input>
					</div>
				</div>
				<div class="search_btn_view">
					<el-button type="primary" @click="getList">查询</el-button>
					<el-button @click="resetForm">重置</el-button>
					<el-button type="primary" @click="addOrUpdateHandler()">新增</el-button>
					<el-button type="danger" @click="deleteHandler()">删除</el-button>
				</div>
			</el-form>
		</div>
		<div class="list_table_view">
			<el-table :data="dataList" border v-loading="listLoading" @selection-change="selectionChangeHandler">
				<el-table-column type="selection" width="50" align="center"></el-table-column>
				<el-table-column prop="zhanghao" header-align="center" align="center" label="账号"></el-table-column>
				<el-table-column prop="xingming" header-align="center" align="center" label="科室主任姓名"></el-table-column>
				<el-table-column prop="xingbie" header-align="center" align="center" label="性别"></el-table-column>
				<el-table-column prop="touxiang" header-align="center" align="center" label="头像">
					<template #default="scope">
						<div v-if="scope.row.touxiang">
							<img :src="$toolUtil.getImgUrl(scope.row.touxiang)" style="width: 100px;height: 100px;">
						</div>
						<div v-else>无图片</div>
					</template>
				</el-table-column>
				<el-table-column prop="shouji" header-align="center" align="center" label="手机"></el-table-column>
				<el-table-column prop="youxiang" header-align="center" align="center" label="邮箱"></el-table-column>
				<el-table-column prop="keshi" header-align="center" align="center" label="科室"></el-table-column>
				<el-table-column fixed="right" header-align="center" align="center" width="150" label="操作">
					<template #default="scope">
						<el-button type="text" size="small" @click="addOrUpdateHandler(scope.row.id)">修改</el-button>
						<el-button type="text" size="small" @click="deleteHandler(scope.row.id)">删除</el-button>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				@size-change="sizeChangeHandle"
				@current-change="currentChangeHandle"
				:current-page="pageIndex"
				:page-sizes="[10, 20, 50, 100]"
				:page-size="pageSize"
				:total="totalPage"
				layout="total, sizes, prev, pager, next, jumper"
				class="pagination">
			</el-pagination>
		</div>
		
		<el-dialog class="edit_form" v-model="addOrUpdateFlag" :title="!dataForm.id ? '添加' : '修改'" width="70%" destroy-on-close>
			<el-form :model="dataForm" :rules="dataFormRules" ref="dataFormRef" label-width="120px">
				<el-form-item label="账号" prop="zhanghao">
					<el-input v-model="dataForm.zhanghao" placeholder="账号"></el-input>
				</el-form-item>
				<el-form-item label="密码" prop="mima">
					<el-input v-model="dataForm.mima" placeholder="密码"></el-input>
				</el-form-item>
				<el-form-item label="科室主任姓名" prop="xingming">
					<el-input v-model="dataForm.xingming" placeholder="科室主任姓名"></el-input>
				</el-form-item>
				<el-form-item label="性别" prop="xingbie">
					<el-select v-model="dataForm.xingbie" placeholder="请选择性别">
						<el-option label="男" value="男"></el-option>
						<el-option label="女" value="女"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="头像" prop="touxiang">
					<upload v-model="dataForm.touxiang" type="img"></upload>
				</el-form-item>
				<el-form-item label="手机" prop="shouji">
					<el-input v-model="dataForm.shouji" placeholder="手机"></el-input>
				</el-form-item>
				<el-form-item label="邮箱" prop="youxiang">
					<el-input v-model="dataForm.youxiang" placeholder="邮箱"></el-input>
				</el-form-item>
				<el-form-item label="科室" prop="keshi">
					<el-input v-model="dataForm.keshi" placeholder="科室"></el-input>
				</el-form-item>
			</el-form>
			<template #footer>
				<div class="formModel_btn_box">
					<el-button @click="addOrUpdateFlag = false">取消</el-button>
					<el-button type="primary" @click="dataFormSubmit()">确定</el-button>
				</div>
			</template>
		</el-dialog>
	</div>
</template>

<script setup>
	import { ref, reactive, onMounted } from 'vue'
	import { ElMessage, ElMessageBox } from 'element-plus'
	import http from '@/utils/http'
	import config from '@/utils/config'
	import toolUtil from '@/utils/toolUtil'
	
	const searchForm = reactive({
		zhanghao: '',
		xingming: ''
	})
	
	const dataList = ref([])
	const pageIndex = ref(1)
	const pageSize = ref(10)
	const totalPage = ref(0)
	const listLoading = ref(false)
	const dataListSelections = ref([])
	
	const addOrUpdateFlag = ref(false)
	const dataForm = reactive({
		id: '',
		zhanghao: '',
		mima: '',
		xingming: '',
		xingbie: '',
		touxiang: '',
		shouji: '',
		youxiang: '',
		keshi: ''
	})
	
	const dataFormRef = ref(null)
	const dataFormRules = reactive({
		zhanghao: [{ required: true, message: '账号不能为空', trigger: 'blur' }],
		mima: [{ required: true, message: '密码不能为空', trigger: 'blur' }],
		xingming: [{ required: true, message: '科室主任姓名不能为空', trigger: 'blur' }],
		xingbie: [{ required: true, message: '性别不能为空', trigger: 'blur' }],
		keshi: [{ required: true, message: '科室不能为空', trigger: 'blur' }]
	})
	
	onMounted(() => {
		getList()
	})
	
	// 获取数据列表
	const getList = () => {
		listLoading.value = true
		let params = {
			page: pageIndex.value,
			limit: pageSize.value,
			zhanghao: searchForm.zhanghao,
			xingming: searchForm.xingming
		}
		http.get('keshizhureng/page', {params}).then(({data}) => {
			if (data && data.code === 0) {
				dataList.value = data.data.list
				totalPage.value = data.data.total
			}
			listLoading.value = false
		})
	}
	
	// 每页数
	const sizeChangeHandle = (val) => {
		pageSize.value = val
		pageIndex.value = 1
		getList()
	}
	
	// 当前页
	const currentChangeHandle = (val) => {
		pageIndex.value = val
		getList()
	}
	
	// 多选
	const selectionChangeHandler = (selection) => {
		dataListSelections.value = selection
	}
	
	// 重置表单
	const resetForm = () => {
		searchForm.zhanghao = ''
		searchForm.xingming = ''
		getList()
	}
	
	// 添加/修改
	const addOrUpdateHandler = (id) => {
		addOrUpdateFlag.value = true
		// 重置表单
		if (dataFormRef.value) {
			dataFormRef.value.resetFields()
		}
		
		if (id) {
			// 修改
			http.get(`keshizhureng/info/${id}`).then(({data}) => {
				if (data && data.code === 0) {
					Object.assign(dataForm, data.data)
				}
			})
		} else {
			// 新增
			Object.keys(dataForm).forEach(key => {
				dataForm[key] = ''
			})
		}
	}
	
	// 表单提交
	const dataFormSubmit = () => {
		dataFormRef.value.validate((valid) => {
			if (valid) {
				let url = dataForm.id ? 'keshizhureng/update' : 'keshizhureng/save'
				http.post(url, dataForm).then(({data}) => {
					if (data && data.code === 0) {
						ElMessage({
							message: '操作成功',
							type: 'success',
							duration: 1500,
							onClose: () => {
								addOrUpdateFlag.value = false
								getList()
							}
						})
					} else {
						ElMessage.error(data.msg)
					}
				})
			}
		})
	}
	
	// 删除
	const deleteHandler = (id) => {
		let ids = id ? [id] : dataListSelections.value.map(item => item.id)
		if (ids.length === 0) {
			ElMessage.error('请选择要删除的数据')
			return
		}
		
		ElMessageBox.confirm('确定要删除选中的数据吗?', '提示', {
			confirmButtonText: '确定',
			cancelButtonText: '取消',
			type: 'warning'
		}).then(() => {
			http.post('keshizhureng/delete', ids).then(({data}) => {
				if (data && data.code === 0) {
					ElMessage({
						message: '操作成功',
						type: 'success',
						duration: 1500,
						onClose: () => {
							getList()
						}
					})
				} else {
					ElMessage.error(data.msg)
				}
			})
		})
	}
</script>

<style scoped>
.center_view {
	padding: 20px;
}
.list_search_view {
	margin-bottom: 20px;
}
.search_form {
	display: flex;
	flex-wrap: wrap;
}
.search_view {
	display: flex;
	align-items: center;
	margin-right: 20px;
	margin-bottom: 10px;
}
.search_label {
	width: 100px;
	text-align: right;
}
.search_box {
	width: 200px;
}
.search_btn_view {
	margin-left: 20px;
}
.list_table_view {
	margin-top: 20px;
}
.pagination {
	margin-top: 20px;
	text-align: right;
}
</style> 