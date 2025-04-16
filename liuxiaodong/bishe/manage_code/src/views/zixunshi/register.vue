<template>
	<div>
		<div class="register_view">
			<el-form :model="registerForm" class="register_form">
				<div class="title_view">{{projectName}}注册</div>
				<div class="list_item">
					<div class="list_label">咨询师账号：</div>
					<el-input class="list_inp"
						 v-model="registerForm.zixunshizhanghao" 
						 placeholder="请输入咨询师账号"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">密码：</div>
					<el-input class="list_inp"
						 v-model="registerForm.mima" 
						 placeholder="请输入密码"
						 type="password"
						 />
				</div>
				<div class="list_item">
					<div class="list_label">确认密码：</div>
					<el-input class="list_inp" v-model="registerForm.mima2" type="password" placeholder="请输入确认密码" />
				</div>
				<div class="list_item">
					<div class="list_label">咨询师姓名：</div>
					<el-input class="list_inp"
						 v-model="registerForm.zixunshixingming" 
						 placeholder="请输入咨询师姓名"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">性别：</div>
					<el-select 
						class="list_sel"
						v-model="registerForm.xingbie" 
						placeholder="请选择性别"
						>
						<el-option v-for="item in zixunshixingbieLists" :label="item" :value="item"></el-option>
					</el-select>
				</div>

				<div class="list_item">
					<div class="list_label">头像：</div>
					<div :style='{}' class="list_file_list">
						<uploads
							action="file/upload" 
							tip="请上传头像"
							:fileUrls="registerForm.touxiang?registerForm.touxiang:''" 
							@change="touxiangUploadSuccess">
						</uploads>
					</div>
				</div>
				<div class="list_item">
					<div class="list_label">联系方式：</div>
					<el-input class="list_inp"
						 v-model="registerForm.lianxifangshi" 
						 placeholder="请输入联系方式"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">资质认证：</div>
					<div :style='{}' class="list_file_list">
						<uploads
							action="file/upload" 
							tip="请上传资质认证"
							:fileUrls="registerForm.zizhirenzheng?registerForm.zizhirenzheng:''" 
							@change="zizhirenzhengUploadSuccess">
						</uploads>
					</div>
				</div>
				<div class="list_item">
					<div class="list_label">收藏数：</div>
					<el-input class="list_inp"
						 v-model="registerForm.storeupNumber" 
						 placeholder="请输入收藏数"
						 type="text"
						/>
				</div>
				<div class="list_btn">
					<el-button class="register" type="success" @click="handleRegister">注册</el-button>
					<div class="r-login" @click="close">已有账号，直接登录</div>
				</div>
			</el-form>
		</div>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
	} from 'vue';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const projectName = context?.$project.projectName
	//获取注册类型
	import { useRoute } from 'vue-router';
	const route = useRoute()
	const tableName = ref('zixunshi')
	
	//公共方法
	const getUUID=()=> {
		return new Date().getTime();
	}
	const registerForm = ref({
        xingbie: '',
	})
	const zixunshixingbieLists = ref([])
	const init=()=>{
		zixunshixingbieLists.value = "男,女".split(',')
	}
    const touxiangUploadSuccess=(fileUrls)=> {
        registerForm.value.touxiang = fileUrls;
    }
    const zizhirenzhengUploadSuccess=(fileUrls)=> {
        registerForm.value.zizhirenzheng = fileUrls;
    }
	// 多级联动参数
	//注册按钮
	const handleRegister = () => {
		let url = tableName.value +"/register";
		if(registerForm.value.mima!=registerForm.value.mima2){
			context?.$toolUtil.message('两次密码输入不一致','error')
			return false
		}
		if(registerForm.value.touxiang!=null){
			registerForm.value.touxiang = registerForm.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if(registerForm.value.lianxifangshi&&(!context?.$toolUtil.isMobile(registerForm.value.lianxifangshi))){
			context?.$toolUtil.message(`联系方式应输入手机格式`,'error')
			return false
		}
		if(registerForm.value.zizhirenzheng!=null){
			registerForm.value.zizhirenzheng = registerForm.value.zizhirenzheng.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if(registerForm.value.thumbsupNumber&&(!context?.$toolUtil.isIntNumer(registerForm.value.thumbsupNumber))){
			context?.$toolUtil.message(`赞应输入整数`,'error')
			return false
		}
		if(registerForm.value.crazilyNumber&&(!context?.$toolUtil.isIntNumer(registerForm.value.crazilyNumber))){
			context?.$toolUtil.message(`踩应输入整数`,'error')
			return false
		}
		if(registerForm.value.storeupNumber&&(!context?.$toolUtil.isIntNumer(registerForm.value.storeupNumber))){
			context?.$toolUtil.message(`收藏数应输入整数`,'error')
			return false
		}
		context?.$http({
			url:url,
			method:'post',
			data:registerForm.value
		}).then(res=>{
			context?.$toolUtil.message('注册成功','success', obj=>{
				context?.$router.push({
					path: "/login"
				});
			})
		})
	}
	//返回登录
	const close = () => {
		context?.$router.push({
			path: "/login"
		});
	}
	init()
	onMounted(()=>{

	})
</script>
<style lang="scss" scoped>
	
	.register_view {
        background-image: url("http://clfile.zggen.cn/20241107/33cefbfd9c7a4b76a40be61cd680f10c.webp")!important;
		// 表单盒子
		.register_form {
		}
		// 标题样式
		.title_view {
		}
		// item盒子
		.list_item {
			// label
			.list_label {
			}
			// 输入框
			:deep(.list_inp) {
			}
		}
		//下拉框样式
		:deep(.list_sel) {
			//去掉默认样式
			.select-trigger{
				height: 100%;
				.el-input{
					height: 100%;
				}
			}
		}
		//按钮盒子
		.list_btn {
			//注册按钮
			.register {
			}
			//注册按钮悬浮样式
			.register:hover {
			}
			//已有账号
			.r-login {
			}
		}
		//图片上传样式
		.list_file_list  {
			//提示语
			:deep(.el-upload__tip){
			}
			//外部盒子
			:deep(.el-upload--picture-card){
				//图标
				.el-icon{
				}
			}
			:deep(.el-upload-list__item) {
			}
		}
	}
</style>
<style>
.register_view {
    min-height: 100vh;
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-position: center center;
    background-size: 100% 100% !important;
    background-repeat: no-repeat;
    background-attachment: initial;
    background-origin: initial;
    background-clip: initial;
    background-color: initial;
}


.register_view .register_form{width: 600px;margin:30px auto;padding: 30px 50px 40px 50px;background: #E8ECEF;border-radius: 10px;transform: scale(1);-webkit-transform: scale(1);-ms-transform: scale(1);z-index: 5;box-shadow: 0px 8px 24px 0px rgba(17,17,26,0.1);background: rgba(0,0,0,0.3);}

.register_view .register_form .title_view{width: 100%;float: left;line-height: 46px;font-size:24px;font-weight: 600;letter-spacing: 2px;color: #fff;position: relative;margin-bottom:20px;text-align: center;}


.register_view .register_form .list_item {display: flex;align-items: center;width: 100%;justify-content: flex-start;margin: 10px auto;background: #fff;border: 0px solid #727272;padding: 6px 10px;border-radius: 6px;}
.register_view .register_form .list_item .list_label{display:block;margin-right:10px;white-space:nowrap;font-size:16px;min-width: 80px;text-align: right;}
.register_view .register_form .list_item .list_label i {  font-size:24px; color:#999;  }
.register_view .register_form .list_item .el-input .el-input__inner{width:100%;border:none;border-bottom: 0px solid #ddd;height:40px;line-height:40px;border-radius:0;font-size:16px;color:#999;}
.register_view .register_form .list_item .el-select {width:100%;border: none;}
.register_view .register_form .list_type{ margin-bottom:20px;  }
.register_view .register_form .list_code{  }
.register_view .register_form .list_code .el-input .el-input__inner{width:100%;border:none;border-bottom: 0px solid #ddd;height:40px;line-height:40px;border-radius:0;font-size:16px;color:#999;}


.register_view .register_form .list_item .list_file_list{ width: 100%;  margin:10px 20px 10px 0px; flex:1; }

.register_view .register_form .list_item .list_file_list .el-upload{ background-color: rgb(255, 255, 255);  width: 100px;  height: 60px; line-height: 68px;  text-align: center;  border: 1px solid rgb(221, 221, 221);  border-radius: 0px; cursor: pointer; }

.register_view .register_form .list_item .list_file_list .el-upload .el-icon{ font-size: 26px; color: rgb(187, 187, 187); }

.register_view .register_form .list_item .list_file_list .img-uploader .el-upload__tip{ font-size: 16px;  color: rgb(102, 102, 102);margin: 7px 0px 0px; display: flex; align-items: center;  justify-content: flex-start; }


.register_view .register_form .list_item .el-upload-dragger{ background-color: rgb(255, 255, 255); border: 1px solid rgb(221, 221, 221);  border-radius: 0px;  box-sizing: border-box;  width: 100%; height: auto; text-align: center; cursor: pointer; overflow: hidden; padding: 4px 20px 8px; }

.register_view .register_form .list_item .el-upload-dragger .el-icon--upload{font-size: 48px;color: var(--theme);line-height: 40px;margin: 0px;}

.register_view .register_form .list_item .upload-demo .el-upload__tip{ font-size: 16px; color: rgb(102, 102, 102); margin: 7px 0px 0px; }

.register_view .register_form .list_item .el-upload-dragger .el-upload__text{  font-size: 16px;  }
.register_view .register_form .list_item .el-upload-dragger .el-upload__text em{ color: rgb(139, 92, 126); }


.register_view .register_form .list_item .list_radio{ display: flex; width: 80%; align-items: center; flex-wrap: wrap; background: none; height: 36px; flex: 1; }

.register_view .register_form .list_item .list_radio .el-radio{ width: auto; margin: 0px 20px 0px 0px; display: flex; justify-content: center; align-items: center; }

.register_view .register_form .list_item .list_radio .el-radio .el-radio__label { font-size: 16px; color: rgb(153, 153, 153);   }

.register_view .register_form .list_item .list_radio .el-radio.is-checked .el-radio__label {color: var(--theme);}

.register_view .register_form .list_item .list_radio .el-radio .el-radio__input .el-radio__inner{ border-color: rgb(153, 153, 153); background: rgb(255, 255, 255); }

.register_view .register_form .list_item .list_radio .el-radio .el-radio__input.is-checked .el-radio__inner{border-color: var(--theme);background: var(--theme);}


.register_view .register_form .list_item .list_checkbox { display: flex; width: 80%;  flex-wrap: wrap; align-items: center; background: none; height: 36px; flex:1; }

.register_view .register_form .list_item .list_checkbox .el-checkbox{ width: auto; margin: 0px 20px 0px 0px; display: flex;  justify-content: center;  align-items: center; }

.register_view .register_form .list_item .list_checkbox .el-checkbox .el-checkbox__label { color: rgb(153, 153, 153);  font-size: 16px; }

.register_view .register_form .list_item .list_checkbox .el-checkbox.is-checked .el-checkbox__label {color: var(--theme);}

.register_view .register_form .list_item .list_checkbox .el-checkbox .el-checkbox__input .el-checkbox__inner{ border-color: rgb(153, 153, 153);  background: rgb(255, 255, 255); }

.register_view .register_form .list_item .list_checkbox .el-checkbox.is-checked .el-checkbox__input .el-checkbox__inner{border-color: var(--theme);background: var(--theme);}


.register_view .register_form .list_code{display: flex;align-items: center;width: 100%;margin: 10px auto;background: #fff;padding: 6px 10px;border: 0px solid #727272;border-radius: 6px;}
.register_view .register_form .list_code .list_code_label{ font-size:16px; }

.register_view .register_form .list_code .list_code_item{ width: calc(100% - 130px); display: flex; align-items: center; flex: 1;  }

.register_view .register_form .list_code .list_code_item .list_code_inp{font-size:16px;color:#999;border: none;}

.register_view .register_form .list_code .list_code_item .list_code_btn{width: 150px;height: 36px;line-height: 36px;padding: 0px;border: 0px solid rgb(73, 189, 227);background: var(--theme);border-radius: 0px;color: rgb(255, 255, 255);font-size: 16px;}


.register_view .register_form .list_btn{  text-align:center;  }
.register_view .register_form .list_btn .register{width: 100%;height: 50px;line-height: 46px;background: var(--theme);border: 0px solid #ccc;font-weight: 600;font-size: 20px;color: #fff;margin-bottom:20px;padding:0;margin-top:20px;} 
.register_view .register_form .list_btn .register:hover {} 
.register_view .register_form .list_btn .r-login{  font-size: 16px; color: #999;  } 
.register_view .register_form .list_btn .r-login:hover{cursor:pointer;color: var(--theme);} 


.register_view .el-input.list_inp {
    border: none;
}

</style>