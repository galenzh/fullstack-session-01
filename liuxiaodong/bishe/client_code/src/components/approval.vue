<template>
	<div>
		<el-dialog v-model="approvalVisible" :title="'审核'" width="70%" destroy-on-close>
			<el-form ref="ruleFormRef" :model="approvalForm" label-width="120px" :rules="rules">
				<el-row>
					<el-col :span="24">
						<el-form-item label="审核回复" prop="shhf">
							<el-input v-model="approvalForm.shhf" type="textarea" />
						</el-form-item>
					</el-col>

				</el-row>
			</el-form>
			<template #footer>
				<span class="dialog-footer" v-if="sfshType==1">
					<el-button type="danger" @click="approvalSave('否')">拒绝</el-button>
					<el-button type="primary" @click="approvalSave('是')">
						通过
					</el-button>
				</span>
				<span class="dialog-footer" v-if="sfshType==2">
					<el-button type="danger" @click="approvalVisible=false">取消</el-button>
					<el-button type="primary" @click="approvalSave()">
						回复
					</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>

<script setup>
	import {
		ref,
		toRefs,
		getCurrentInstance,
		defineEmits
	} from 'vue';
	const emit = defineEmits(['shChange'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//props
	const props = defineProps({
		tableName: String
	})
	const {
		tableName
	} = toRefs(props)
	//props

	const rules = ref({
		shhf: [{
			required: true,
			message: '请输入审核回复',
			trigger: 'blur'
		}, ],
	})
	const approvalForm = ref({})
	const approvalVisible = ref(false)
	//ref
	const ruleFormRef = ref(null)
	const sfshType = ref(1)

	const approvalClick = (row,type=1) => {
		console.log('approval组件接收到数据:', row)
		sfshType.value = type
		approvalForm.value = JSON.parse(JSON.stringify(row))
		console.log('approval组件设置表单:', approvalForm.value)
		approvalVisible.value = true
	}

	//声明父级调用
	defineExpose({
		approvalClick
	})
	const approvalSave = (type) => {
		console.log('approvalSave被调用, type:', type)
		if(sfshType.value == 1){
			approvalForm.value.sfsh = type
		}
		console.log('表单验证前, 表单数据:', approvalForm.value)
		
		// 直接使用通过按钮
		if (type === '是') {
			// 使用最简单方式直接调用接口
			const id = approvalForm.value.id;
			const apiUrl = `/pdas/zixunshiyuyue/update`;
			
			console.log('尝试使用原生fetch请求:', apiUrl);
			
			// 准备提交的数据
			const submitData = {
				id: id,
				sfsh: '是',
				shhf: approvalForm.value.shhf || '通过',
				status: '已确认'
			};
			
			console.log('发送数据:', submitData);
			
			// 使用原生fetch API
			fetch(apiUrl, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
					'token': context?.$toolUtil.storageGet('frontToken')
				},
				body: JSON.stringify(submitData)
			})
			.then(response => {
				console.log('收到响应:', response);
				return response.json();
			})
			.then(data => {
				console.log('响应数据:', data);
				context?.$toolUtil.message('审核成功', 'success', obj => {
					approvalVisible.value = false;
					emit('shChange');
					// 刷新页面
					setTimeout(() => {
						window.location.reload();
					}, 1000);
				});
			})
			.catch(error => {
				console.error('请求错误:', error);
				context?.$toolUtil.message('审核失败: ' + error.message, 'error');
			});
			
			return;
		}
		
		ruleFormRef.value.validate((valid) => {
			console.log('表单验证结果:', valid)
			if (valid) {
				// 简化请求，直接使用update接口，不使用sh接口
				const url = `/pdas/zixunshiyuyue/update`;
				console.log('发送请求到update接口:', url);
				
				const submitData = {
					id: approvalForm.value.id,
					sfsh: type || approvalForm.value.sfsh,
					shhf: approvalForm.value.shhf
				};
				
				if (type === '是') {
					submitData.status = '已确认';
				} else if (type === '否') {
					submitData.status = '已取消';
				}
				
				console.log('提交数据:', submitData);
				
				context?.$http({
					url: url,
					method: 'post',
					data: submitData
				}).then(res => {
					console.log('审核响应:', res);
					context?.$toolUtil.message('审核成功', 'success', obj => {
						approvalVisible.value = false;
						emit('shChange');
						// 刷新页面
						setTimeout(() => {
							window.location.reload();
						}, 1000);
					});
				}).catch(err => {
					console.error('审核失败:', err);
					context?.$toolUtil.message('审核失败: ' + (err.message || '未知错误'), 'error');
				});
			}
		});
	}
</script>

<style>
</style>
