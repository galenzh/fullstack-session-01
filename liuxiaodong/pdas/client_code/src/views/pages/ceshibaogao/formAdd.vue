<template>
	<div class="edit_view" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
        </div>
		<el-form ref="formRef" :model="form" class="add_form" label-width="120px" :rules="rules">
			<el-row>
				<el-col :span="24">
					<el-form-item label="测试项目" prop="ceshixiangmu">
						<el-input class="list_inp" v-model="form.ceshixiangmu" placeholder="测试项目"
							 type="text" 							:readonly="!isAdd||disabledForm.ceshixiangmu?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="测试时间" prop="ceshishijian">
						<el-date-picker
							class="list_date"
							v-model="form.ceshishijian"
							format="YYYY-MM-DD HH:mm:ss"
							value-format="YYYY-MM-DD HH:mm:ss"
							type="datetime"
							style="width:100%;"
							:readonly="!isAdd||disabledForm.ceshishijian?true:false"
							placeholder="请选择测试时间" />
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="测试报告" prop="ceshibaogao">
						<uploads
							:disabled="!isAdd||disabledForm.ceshibaogao?true:false"
							type="file"
							action="file/upload" 
							tip="请上传测试报告" 
							:limit="1" 
							style="width: 100%;text-align: left;"
							:fileUrls="form.ceshibaogao?form.ceshibaogao:''" 
							@change="ceshibaogaoUploadSuccess">
						</uploads>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="测试成绩" prop="ceshichengji">
						<el-input class="list_inp" v-model="form.ceshichengji" placeholder="测试成绩"
							 type="text" 							:readonly="!isAdd||disabledForm.ceshichengji?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="身体机能评估" prop="shentijinengpinggu">
						<el-input class="list_inp" v-model="form.shentijinengpinggu" placeholder="身体机能评估"
							 type="text" 							:readonly="!isAdd||disabledForm.shentijinengpinggu?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="账号" prop="zhanghao">
						<el-select
							class="list_sel"
							:disabled="!isAdd||disabledForm.zhanghao?true:false"
							v-model="form.zhanghao" 
							placeholder="请选择账号"
							style="width:100%;"
							@change="zhanghaoChange">
							<el-option v-for="(item,index) in zhanghaoLists" :label="item" :value="item">
							</el-option>
						</el-select>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="姓名" prop="xingming">
						<el-input class="list_inp" v-model="form.xingming" placeholder="姓名"
							 type="text" 							:readonly="!isAdd||disabledForm.xingming?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="性别" prop="xingbie">
						<el-input class="list_inp" v-model="form.xingbie" placeholder="性别"
							 type="text" 							:readonly="!isAdd||disabledForm.xingbie?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="报告时间" prop="baogaoshijian">
						<el-date-picker
							class="list_date"
							v-model="form.baogaoshijian"
							format="YYYY-MM-DD HH:mm:ss"
							value-format="YYYY-MM-DD HH:mm:ss"
							type="datetime"
							style="width:100%;"
							:readonly="!isAdd||disabledForm.baogaoshijian?true:false"
							placeholder="请选择报告时间" />
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="咨询师账号" prop="zixunshizhanghao">
						<el-input class="list_inp" v-model="form.zixunshizhanghao" placeholder="咨询师账号"
							 type="text" 							:readonly="!isAdd||disabledForm.zixunshizhanghao?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="咨询师姓名" prop="zixunshixingming">
						<el-input class="list_inp" v-model="form.zixunshixingming" placeholder="咨询师姓名"
							 type="text" 							:readonly="!isAdd||disabledForm.zixunshixingming?true:false" />
					</el-form-item>
				</el-col>

			</el-row>
			<div class="formModel_btn_box">
				<el-button class="formModel_cancel" @click="backClick">取消</el-button>
				<el-button class="formModel_confirm"
                           @click="save"
                           type="success"
				>
					保存
				</el-button>
			</div>
		</el-form>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
		nextTick,
		computed
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
    import moment from "moment";
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'ceshibaogao'
	const formName = '测试报告'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//form表单
	const form = ref({
		ceshixiangmu: '',
		ceshishijian: '',
		ceshibaogao: '',
		ceshichengji: '',
		shentijinengpinggu: '',
		zhanghao: '',
		xingming: '',
		xingbie: '',
		baogaoshijian: '',
		zixunshizhanghao: '',
		zixunshixingming: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	const disabledForm = ref({
		ceshixiangmu : false,
		ceshishijian : false,
		ceshibaogao : false,
		ceshichengji : false,
		shentijinengpinggu : false,
		zhanghao : false,
		xingming : false,
		xingbie : false,
		baogaoshijian : false,
		zixunshizhanghao : false,
		zixunshixingming : false,
	})
	const isAdd = ref(false)
	//表单验证
	const rules = ref({
		ceshixiangmu: [
		],
		ceshishijian: [
		],
		ceshibaogao: [
		],
		ceshichengji: [
		],
		shentijinengpinggu: [
		],
		zhanghao: [
		],
		xingming: [
		],
		xingbie: [
		],
		baogaoshijian: [
		],
		zixunshizhanghao: [
		],
		zixunshixingming: [
		],
	})
	//测试报告上传回调
	const ceshibaogaoUploadSuccess=(e)=>{
		form.value.ceshibaogao = e
	}
	//账号列表
	const zhanghaoLists = ref([])
	//methods

	//methods
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			form.value = res.data.data
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init = (formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null) => {
			form.value.baogaoshijian = context?.$toolUtil.getCurDateTime()
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			// getInfo()
			for(let x in row){
				if(x=='ceshixiangmu'){
					form.value.ceshixiangmu = row[x];
					disabledForm.value.ceshixiangmu = true;
					continue;
				}
				if(x=='ceshishijian'){
					form.value.ceshishijian = row[x];
					disabledForm.value.ceshishijian = true;
					continue;
				}
				if(x=='ceshibaogao'){
					form.value.ceshibaogao = row[x];
					disabledForm.value.ceshibaogao = true;
					continue;
				}
				if(x=='ceshichengji'){
					form.value.ceshichengji = row[x];
					disabledForm.value.ceshichengji = true;
					continue;
				}
				if(x=='shentijinengpinggu'){
					form.value.shentijinengpinggu = row[x];
					disabledForm.value.shentijinengpinggu = true;
					continue;
				}
				if(x=='zhanghao'){
					form.value.zhanghao = row[x];
					disabledForm.value.zhanghao = true;
					continue;
				}
				if(x=='xingming'){
					form.value.xingming = row[x];
					disabledForm.value.xingming = true;
					continue;
				}
				if(x=='xingbie'){
					form.value.xingbie = row[x];
					disabledForm.value.xingbie = true;
					continue;
				}
				if(x=='baogaoshijian'){
					form.value.baogaoshijian = row[x];
					disabledForm.value.baogaoshijian = true;
					continue;
				}
				if(x=='zixunshizhanghao'){
					form.value.zixunshizhanghao = row[x];
					disabledForm.value.zixunshizhanghao = true;
					continue;
				}
				if(x=='zixunshixingming'){
					form.value.zixunshixingming = row[x];
					disabledForm.value.zixunshixingming = true;
					continue;
				}
			}
			if(row){
				crossRow.value = row
			}
			if(table){
				crossTable.value = table
			}
			if(tips){
				crossTips.value = tips
			}
			if(statusColumnName){
				crossColumnName.value = statusColumnName
			}
			if(statusColumnValue){
				crossColumnValue.value = statusColumnValue
			}
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(json.hasOwnProperty('zixunshizhanghao') && context?.$toolUtil.storageGet("frontRole")!="管理员"){
				form.value.zixunshizhanghao = json.zixunshizhanghao
				disabledForm.value.zixunshizhanghao = true;
			}
			if(json.hasOwnProperty('zixunshixingming') && context?.$toolUtil.storageGet("frontRole")!="管理员"){
				form.value.zixunshixingming = json.zixunshixingming
				disabledForm.value.zixunshixingming = true;
			}
            if (localStorage.getItem('autoSave')) {
                localStorage.removeItem('autoSave')
                save()
            }
		})
		context?.$http({
			url: `option/yonghu/zhanghao`,
			method: 'get'
		}).then(res=>{
			zhanghaoLists.value = res.data.data
		})
		//由上级字段带出不可改
		disabledForm.value.xingming = true;
		//由上级字段带出不可改
		disabledForm.value.xingbie = true;
	}
	//初始化
	//取消
	const backClick = () => {
		history.back()
	}
	//账号回调
	const zhanghaoChange=()=>{
		context?.$http({
			url: `follow/yonghu/zhanghao?columnValue=` + form.value.zhanghao,
			method: 'get'
		}).then(res=>{
			//带出姓名字段
			if(res.data.data.xingming){
				form.value.xingming = res.data.data.xingming
			}
			//带出性别字段
			if(res.data.data.xingbie){
				form.value.xingbie = res.data.data.xingbie
			}
		})
	}
	//提交
	const save=()=>{
		if(form.value.ceshibaogao!=null) {
			form.value.ceshibaogao = form.value.ceshibaogao.replace(new RegExp(context?.$config.url,"g"),"");
		}
		var table = crossTable.value
		var objcross = JSON.parse(JSON.stringify(crossRow.value))
		let crossUserId = ''
		let crossRefId = ''
		let crossOptNum = ''
		if(type.value == 'cross'){
			if(crossColumnName.value!=''){
				if(!crossColumnName.value.startsWith('[')){
					for(let o in objcross){
						if(o == crossColumnName.value){
							objcross[o] = crossColumnValue.value
						}
					}
					//修改跨表数据
					changeCrossData(objcross)
				}else{
					crossUserId = context?.$toolUtil.storageGet('userid')
					crossRefId = objcross['id']
					crossOptNum = crossColumnName.value.replace(/\[/,"").replace(/\]/,"")
				}
			}
		}
		formRef.value.validate((valid)=>{
			if(valid){
				if(crossUserId&&crossRefId){
					form.value.crossuserid = crossUserId
					form.value.crossrefid = crossRefId
					let params = {
						page: 1,
						limit: 1000, 
						crossuserid:form.value.crossuserid,
						crossrefid:form.value.crossrefid,
					}
					context?.$http({
						url: `${tableName}/page`,
						method: 'get', 
						params: params 
					}).then(res=>{
						if(res.data.data.total>=crossOptNum){
							context?.$toolUtil.message(`${crossTips.value}`,'error')
							return false
						}else{
							context?.$http({
								url: `${tableName}/${!form.value.id ? "save" : "update"}`,
								method: 'post', 
								data: form.value 
							}).then(res=>{
                                context?.$toolUtil.message(`操作成功`,'success')
                                history.back()
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(res=>{
                        context?.$toolUtil.message(`操作成功`,'success')
                        history.back()
					})
				}
			}
		})
	}
	//修改跨表数据
	const changeCrossData=(row)=>{
        if(type.value == 'cross'){
            context?.$http({
                url: `${crossTable.value}/update`,
                method: 'post',
                data: row
            }).then(res=>{})
        }
	}
	onMounted(()=>{
		type.value = route.query.type?route.query.type:'add'
		let row = null
		let table = null
		let statusColumnName = null
		let tips = null
		let statusColumnValue = null
		if(type.value == 'cross'){
			row = context?.$toolUtil.storageGet('crossObj')?JSON.parse(context?.$toolUtil.storageGet('crossObj')):{}
			table = context?.$toolUtil.storageGet('crossTable')
			statusColumnName = context?.$toolUtil.storageGet('crossStatusColumnName')
			tips = context?.$toolUtil.storageGet('crossTips')
			statusColumnValue = context?.$toolUtil.storageGet('crossStatusColumnValue')
		}
		init(route.query.id?route.query.id:null, type.value,'', row, table, statusColumnName, tips, statusColumnValue)
	})
    onUnmounted(()=>{
        Object.keys(localStorage).map(item=>{
            if(item.startsWith('cross')){
                localStorage.removeItem(item)
            }
        })
    })
</script>
<style lang="scss" scoped>
	// 面包屑盒子
	.bread_view {
		:deep(.breadcrumb) {
			.el-breadcrumb__separator {
			}
			.first_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
			.second_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
		}
	}
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
				//日期选择器
				.list_date {
				}
				// 下拉框
				.list_sel {
					//去掉默认样式
					.select-trigger{
						height: 100%;
						.el-input{
							height: 100%;
						}
					}
				}
				//文件上传样式
				.upload-demo {
					width: 100%;
					//外部盒子
					.el-upload-dragger {
					}
					//图标
					.el-icon--upload {
					}
					//提示文字
					.el-upload__text {
						em {
						}
					}
					//提示文字
					.el-upload__tip {
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
<style>
.edit_view {
    width: 1200px;
    margin: 20px auto;
    padding: 0px ;
    background: #fff;
    overflow: hidden;
    font-size: 16px;
    color:#666;
}
.edit_view .add_form{
    width: 100%;
    padding: 30px;
    border:0px solid #eee
}
.edit_view .add_form .el-form-item{
    margin: 0px 0px 20px;
    display: flex;
}
.edit_view .add_form .el-form-item .el-form-item__label{
    width: 150px;
    background: none;
    text-align: right;
    display: block;
    font-size: 16px;
    color: rgb(51, 51, 51);
    font-weight: 500;
}
.edit_view .add_form .el-form-item .el-form-item__content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-wrap: wrap;
    width: calc(100% - 120px);
}
.edit_view .add_form .el-form-item .el-form-item__content .list_inp{
    height: 36px;
    line-height: 36px;
    border: 1px solid rgb(221, 221, 221);
    padding: 0px 10px;
    width: 100%;
    box-sizing: border-box;
    background: rgb(255, 255, 255);
    font-size: 16px;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_sel{
    line-height: 36px;
    border: 1px solid rgb(221, 221, 221);
    box-sizing: border-box;
    width: calc(100% - 0px);
    padding: 0px 10px;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    font-size: 16px;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_date{
    line-height: 36px;
    border: 1px solid rgb(221, 221, 221);
    box-sizing: border-box;
    width: 100%;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    font-size: 16px;
}






.edit_view .add_form .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger{
    background-color: rgb(255, 255, 255);
    border: 1px solid rgb(221, 221, 221);
    border-radius: 0px;
    box-sizing: border-box;
    width: 100%;
    height: auto;
    padding:0 0 10px;
    text-align: center;
    cursor: pointer;
    overflow: hidden;
}

.edit_view .add_form .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger .el-icon--upload{
    font-size: 67px;
    color: var(--theme);
    line-height: 50px;
    margin: 20px 0 10px;
}

.edit_view .add_form .el-form-item .el-form-item__content .upload-demo .el-upload__tip{
    font-size: 15px;
    color: #666;
    margin: 0px 0 0;
    line-height:1;
}

.edit_view .add_form .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger em{
    color: var(--theme);
    font-size: 15px;
}


</style>