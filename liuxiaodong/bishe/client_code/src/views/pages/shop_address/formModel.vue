<template>
	<div>
		<el-dialog custom-class="edit_view" v-model="formVisible" :title="formTitle" width="60%" destroy-on-close>
			<el-form class="add_form" :model="form" label-width="80px" ref="formRef" :rules="rules">
				<el-col :span="24">
					<el-form-item prop="name" label="联系人">
						<el-input class="list_inp" v-model="form.name" placeholder="请输入联系人"></el-input>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item prop="phone" label="手机号">
						<el-input class="list_inp" v-model="form.phone" placeholder="请输入手机号"></el-input>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item prop="address" label="地址">
						<el-input class="list_inp" v-model="form.address" placeholder="请输入地址"></el-input>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item prop="isdefault" label="默认地址">
						<el-radio-group class="list_radio" v-model="form.isdefault">
							<el-radio label="是"></el-radio>
							<el-radio label="否"></el-radio>
						</el-radio-group>
					</el-form-item>
				</el-col>
			</el-form>
			<template #footer>
				<span class="formModel_btn_box">
					<el-button class="formModel_cancel" @click="formVisible=false">关闭</el-button>
					<el-button class="formModel_confirm" type="primary" @click="save">保存</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>
<script setup>
	import {
		ref,
		nextTick,
		getCurrentInstance,
		defineEmits
	} from 'vue';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const id = ref(0)
	const form = ref({})
	const formRef = ref(null)
	const formVisible = ref(false)
	const formTitle = ref('')
	const resetForm = () => {
		form.value = {
			userid: context?.$toolUtil.storageGet('userid'),
			name: '',
			phone: '',
			isdefault: '是',
			address: ''
		}
	}
	//匹配手机号码
	const validateMobile = (rule, value, callback) => {
		if (!value) {
			callback();
		} else if (!context?.$toolUtil.isMobile(value)) {
			callback(new Error("请输入正确的手机号码"));
		} else {
			callback();
		}
	}
	const rules = ({
		name: [{
			required: true,
			message: '请输入联系人',
			trigger: 'blur'
		}],
		phone: [{
			required: true,
			message: '请输入联系人',
			trigger: 'blur'
		}, {
			required: true,
			validator: validateMobile,
			trigger: 'blur'
		}],
		address: [{
			required: true,
			message: '请输入收货地址',
			trigger: 'blur'
		}],
	})
	const save = () => {
		formRef.value.validate((valid) => {
			if (valid) {
				context?.$http({
					url: `address/${form.value.id?'update':'add'}`,
					method: 'post',
					data: form.value
				}).then(res => {
					context?.$toolUtil.message(`保存成功`, 'success', () => {
						formVisible.value = false
						emit('formModelChange')
					})
				})
			}
		})
	}
	//初始化
	const init = (refid=null,text) => {
		resetForm()
		if(refid){
			id.value = refid
			getInfo()
		}
		formTitle.value = text
		formVisible.value = true
	}
	//声明父级调用
	defineExpose({
		init
	})
	//回调父级方法
	const emit = defineEmits(['formModelChange'])
	const getInfo = () => {
		context?.$http({
			url: `address/detail/${id.value}`,
			method: 'get'
		}).then(res => {
			form.value = res.data.data
		})
	}
</script>
<style lang="scss" scoped>

	// 表单
	.add_form{
		// form item
		:deep(.el-form-item) {
			//label
			.el-form-item__label {
			}
			// 内容盒子
			.el-form-item__content {
				// 输入框
				.list_inp {

				}
				//单选框样式
				.list_radio {
					//未选中样式
					.el-radio {
						//单选框
						.el-radio__inner {
						}
						//提示文字
						.el-radio__label{
						}
					}
					//选中样式
					.is-checked {
						//单选框
						.el-radio__inner {
						}
						//提示文字
						.el-radio__label{
						}
					}
				}
			}
		}
	}

	// 按钮盒子
	.formModel_btn_box {
		.formModel_cancel {
		}
		.formModel_cancel:hover {
		}
		
		.formModel_confirm {
		}
		.formModel_confirm:hover {
		}
	}
</style>