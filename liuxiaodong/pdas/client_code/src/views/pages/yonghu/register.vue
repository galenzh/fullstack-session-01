<template>
	<div>
		<div class="register_view">
			<el-form :model="registerForm" class="register_form">
				<div class="title_view">{{projectName}}注册</div>
				<div class="list_item">
					<div class="list_label">账号：</div>
					<input class="list_inp"
					 v-model="registerForm.zhanghao" 
					 placeholder="请输入账号"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">密码：</div>
					<input class="list_inp"
					 v-model="registerForm.mima" 
					 placeholder="请输入密码"
					 type="password"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">确认密码：</div>
					<input class="list_inp" v-model="registerForm.mima2" type="password" placeholder="请输入确认密码" />
				</div>
				<div class="list_item">
					<div class="list_label">姓名：</div>
					<input class="list_inp"
					 v-model="registerForm.xingming" 
					 placeholder="请输入姓名"
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
						<el-option v-for="item in yonghuxingbieLists" :label="item" :value="item"></el-option>
					</el-select>
				</div>
				<div class="list_item">
					<div class="list_label">头像：</div>
					<div class="list_file_list">
						<uploads
							action="file/upload" 
							tip="请上传头像"
							style="width: 100%;text-align: left;"
							:fileUrls="registerForm.touxiang?registerForm.touxiang:''" 
							@change="touxiangUploadSuccess">
						</uploads>
					</div>
				</div>
				<div class="list_item">
					<div class="list_label">年龄：</div>
					<input class="list_inp"
					 v-model="registerForm.nianling" 
					 placeholder="请输入年龄"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">手机：</div>
					<input class="list_inp"
					 v-model="registerForm.shouji" 
					 placeholder="请输入手机"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">邮箱：</div>
					<input class="list_inp" v-model="registerForm.email" placeholder="邮箱" />
				</div>
				<div class="list_code">
					<div class="list_code_label">验证码：</div>
					<div class="list_code_item">
						<input class="list_code_inp" v-model="emailCode" placeholder="请输入验证码" />
						<el-button class="list_code_btn" :disabled="getCodeType" :type="getCodeType?'info':'primary'" @click="getEmailCode">{{setCode}}</el-button>
					</div>
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
	const tableName = ref('yonghu')

	//公共方法
	const getUUID=()=> {
		return new Date().getTime();
	}
	
	const registerForm = ref({
        xingbie: '',
	})
	//验证码
	const time = ref(0)
	const setCode = ref('发送验证码')
	const getCodeType = ref(false)
	const timer=()=>{
		if(time.value>0){
			getCodeType.value = true
			setCode.value = time.value + 's'
			time.value--
			setTimeout(()=>{
				timer()
			},1000)
		}else{
			time.value = 0
			setCode.value = '发送验证码'
			getCodeType.value = false
		}
	}
	//邮箱验证码
	const emailCode = ref('')
	const getEmailCode=()=>{
		if((!registerForm.value.email)){
			context?.$toolUtil.message(`邮箱不能为空`,'error')
			return false
		}
		if(!context?.$toolUtil.isEmail(registerForm.value.email)){
			context?.$toolUtil.message(`邮箱格式不正确`,'error')
			return false
		}
		time.value = 60
		timer()
		context?.$http({
			url:`${tableName.value}/sendemail?email=`+registerForm.value.email,
			method:'get'
		}).then(res=>{
			context?.$toolUtil.message(`发送成功`,'success')
		})
	}
	const yonghuxingbieLists = ref([])
	const init=()=>{
		yonghuxingbieLists.value = "男,女".split(',')
	}
    const touxiangUploadSuccess=(fileUrls)=> {
        registerForm.value.touxiang = fileUrls;
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
		if(registerForm.value.nianling&&(!context?.$toolUtil.isIntNumer(registerForm.value.nianling))){
			context?.$toolUtil.message(`年龄应输入整数`,'error')
			return false
		}
		if(registerForm.value.shouji&&(!context?.$toolUtil.isMobile(registerForm.value.shouji))){
			context?.$toolUtil.message(`手机应输入手机格式`,'error')
			return false
		}
		if(registerForm.value.email&&(!context?.$toolUtil.isEmail(registerForm.value.email))){
			context?.$toolUtil.message(`邮箱应输入邮件格式`,'error')
			return false
		}
		if(registerForm.value.jf&&(!context?.$toolUtil.isNumber(registerForm.value.jf))){
			context?.$toolUtil.message(`积分应输入数字`,'error')
			return false
		}
		if(registerForm.value.money&&(!context?.$toolUtil.isNumber(registerForm.value.money))){
			context?.$toolUtil.message(`余额应输入数字`,'error')
			return false
		}
        url=tableName.value +"/register?emailcode="+emailCode.value;
        if(registerForm.value.email&&(!context?.$toolUtil.isEmail(registerForm.value.email))){
            context?.$toolUtil.message('请输入正确的邮箱格式','error')
            return false
        }
		if((!emailCode.value)){
			context?.$toolUtil.message('验证码不能为空','error')
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
        background-image: url("http://clfile.zggen.cn/20241210/4a2a77fab2d44e23aee94a9faad13283.jpg")!important;
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
		// 验证码盒子
		.list_code {
			// 验证码label
			.list_code_label {
			}
			// 验证码item
			.list_code_item {
				// 输入框
				:deep(.list_code_inp) {

				}
				// 验证码按钮
				.list_code_btn {
				}
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
	}
</style>
<style>

.register_view {
    min-height: 100vh;
    position: relative;
    background: url(http://clfile.zggen.cn/20241210/4a2a77fab2d44e23aee94a9faad13283.jpg) no-repeat center center / 100% 100%;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    justify-content: center;
}

.register_view .register_form{
    width: 45%;
    min-height:100vh;
    box-shadow: rgb(187, 187, 187) 0px 4px 9px;
    padding: 30px 10% 30px  5%;
    margin:0 0 0 50%;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    flex-direction: column;
    align-content: center;
    border-radius: 0px;
    background: url(http://clfile.zggen.cn/20241210/b827125d16cc4547b2301da56bdf4091.jpg) no-repeat right top / 80% auto,rgba(255, 255, 255,1);
    box-shadow: 0px 2px 20px 0px #497b9f;
}

.register_view .title_view{
	width:calc(100% - 120px);
	font-size:20px;
	font-weight:500;
	margin: 0px 0px 30px 120px;
	text-align: center;
}

.register_view .outTitle_view{
    display: flex;
    align-items: center;
    padding: 0px 0px 40px;
    margin:0 50% 0 0;
}
.register_view .outTitle_view .outTilte {
	font-size:32px;
	font-weight:600;
	text-align:center;
	background:-webkit-linear-gradient(left,#147B96,#7aa8c9 25%,#147B96 50%,#7aa8c9 75%,#147B96);
	color:transparent;
	-webkit-background-clip:text;
	background-size:200% 100%;
	animation:masked-animation 1s infinite linear;
}


.register_view .register_form .list_item{
    display: flex;
    align-items: center;
    width: 100%;
    justify-content: center;
    margin: 0px 10px 20px 0px;
}
.register_view .register_form .list_item .list_label{
    width: 120px;
    text-align: right;
    font-size: 16px;
}
.register_view .register_form .list_item .list_inp{
    height: 40px;
    line-height: 40px;
    border:none;
    border: 1px solid var(--theme);
    background:#fff;
    padding: 0px 10px;
    width: calc(100% - 120px);
    color:#999;
    font-size: 16px;
    border-radius: 4px;
}
.register_view .register_form .list_item .list_date{
    width: calc(100% - 120px)!important;
    height: 40px;
    line-height: 40px;
    border:none;
    border: 1px solid var(--theme);
    background:#fff;
    box-sizing: border-box;
    color:#999;
    font-size: 16px;
    border-radius: 4px;
}
.register_view .register_form .list_item .list_sel{
    line-height: 40px;
    border:none;
    border: 1px solid var(--theme);
    background:#fff; 
    box-sizing: border-box;
    width: calc(100% - 120px);
    padding: 0px 10px;
    color:#999;
    font-size: 16px;
    border-radius: 4px;
}


.register_view .register_form .list_item .list_file_list{
    width: calc(100% - 120px);
}

.register_view .register_form .list_item .el-upload--picture-card{
    background:#fff;
    width: 90px;
    height: 60px;
    line-height: 60px;
    text-align: center;
    border: 1px solid var(--theme);
    cursor: pointer;
    border-radius: 4px;
}

.register_view .register_form .list_item .el-upload--picture-card .el-icon{
    font-size: 22px;
    color: rgb(153, 153, 153);
}

.register_view .register_form .list_item .el-upload__tip{
    font-size: 16px;
    color: rgb(153, 153, 153);
    margin: 7px 0px 0px;
    display: flex;
    align-items: center;
    justify-content: flex-start;
}


.register_view .register_form .list_item .el-upload-dragger{
    background:#fff;
    border: 1px solid var(--theme);
    box-sizing: border-box;
    width: 100%;
    height: auto;
    text-align: center;
    cursor: pointer;
    overflow: hidden;
    padding: 10px;
    border-radius: 4px;
}

.register_view .register_form .list_item .el-upload-dragger .el-icon--upload{
    font-size: 60px;
    color: var(--theme);
    line-height: 50px;
    margin: 0px;
}

.register_view .register_form .list_item .el-upload-dragger .el-upload__text{
    font-size: 16px;
    color: rgb(153, 153, 153);
    margin: 5px 0px 0px;
}

.register_view .register_form .list_item .el-upload-dragger .el-upload__text em{
    color: var(--theme);
}


.register_view .register_form .list_item .list_radio{
    display: flex;
    width: calc(100% - 120px);
    align-items: center;
    flex-wrap: wrap;
}

.register_view .register_form .list_item .list_radio .el-radio{
    width: auto;
    margin: 0px 20px 0px 0px;
    display: flex;
    align-items: center;
}

.register_view .register_form .list_item .list_radio .el-radio .el-radio__inner{
    border-color: rgb(153, 153, 153);
    background: rgb(255, 255, 255);
}

.register_view .register_form .list_item .list_radio .el-radio.is-checked .el-radio__inner{
    border-color: var(--theme);
    background: var(--theme);
}

.register_view .register_form .list_item .list_radio .el-radio .el-radio__label{
    color: #999;
    font-size: 16px;
}

.register_view .register_form .list_item .list_radio .el-radio.is-checked .el-radio__label{
    color: var(--theme);
}


.register_view .register_form .list_item .list_checkbox{
    display: flex;
    width: calc(100% - 120px);
    flex-wrap: wrap;
    align-items: center;
}

.register_view .register_form .list_item .list_checkbox .el-checkbox{
    width: auto;
    margin: 0px 15px 0px 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.register_view .register_form .list_item .list_checkbox .el-checkbox .el-checkbox__inner{
    border-color: #999;
    background: #fff;
}

.register_view .register_form .list_item .list_checkbox .el-checkbox.is-checked .el-checkbox__inner{
    border-color: var(--theme);
    background: var(--theme);
}

.register_view .register_form .list_item .list_checkbox .el-checkbox .el-checkbox__label{
    color: #999;
    font-size: 16px;
}

.register_view .register_form .list_item .list_checkbox .el-checkbox.is-checked .el-checkbox__label{
    color: #999;
}


.register_view .register_form .list_code{
    display: flex;
    align-items: center;
    width: 100%;
    justify-content: center;
    margin: 0px 10px 10px 0px;
}
.register_view .register_form .list_code .list_code_label{
    width: 120px;
    text-align: right;
    font-size: 16px;
}
.register_view .register_form .list_code .list_code_item{
    width: calc(100% - 120px);
    display: flex;
    align-items: center;
}
.register_view .register_form .list_code .list_code_item .list_code_inp{
    height: 40px;
    line-height: 40px;
    border:none;
    border: 1px solid var(--theme);
    background: #fff;
    padding: 0px 10px;
    width: calc(100% - 110px);
    font-size: 16px;
    border-radius: 4px;
}
.register_view .register_form .list_code .list_code_btn{
    padding:0px;
    width: 100px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    border: none;
    background: var(--theme);
    color: rgb(255, 255, 255);
    font-size: 16px;
    margin-left:10px;
    border-radius: 4px;
}


.register_view .register_form .list_btn{
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    justify-content: center;
    width: 100%;
    margin: 20px 0px 0px;
    padding: 0 0 0 120px;
}

.register_view .register_form .list_btn .register{
    margin: 0px 0px 12px 0px;
    padding: 0px 10px;
    width: auto;
    height: 44px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: var(--theme);
    cursor: pointer;
    min-width:100%;
}

.register_view .register_form .list_btn .r-login{
    width: 100%;
    text-align: right;
    cursor: pointer;
    padding: 10px 0px 0px;
    color: #666;
    font-size: 16px;
}
.register_view .register_form .list_btn .r-login:hover{
    text-decoration:underline;
}

</style>