<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="80%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="测试项目" prop="ceshixiangmu">
							<el-input class="list_inp" v-model="form.ceshixiangmu" placeholder="测试项目"
                                type="text"
								:readonly="!isAdd||disabledForm.ceshixiangmu?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="测试时间" prop="ceshishijian">
							<el-date-picker
								class="list_date"
								v-model="form.ceshishijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.ceshishijian?true:false"
								placeholder="请选择测试时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
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
					<el-col :span="12">
						<el-form-item label="测试成绩" prop="ceshichengji">
							<el-input class="list_inp" v-model="form.ceshichengji" placeholder="测试成绩"
                                type="text"
								:readonly="!isAdd||disabledForm.ceshichengji?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="身体机能评估" prop="shentijinengpinggu">
							<el-input class="list_inp" v-model="form.shentijinengpinggu" placeholder="身体机能评估"
                                type="text"
								:readonly="!isAdd||disabledForm.shentijinengpinggu?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="账号" prop="zhanghao">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.zhanghao?true:false"
								v-model="form.zhanghao" 
								placeholder="请选择账号"
								@change="zhanghaoChange">
								<el-option v-for="(item,index) in zhanghaoLists" :label="item" :value="item">
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="姓名" prop="xingming">
							<el-input class="list_inp" v-model="form.xingming" placeholder="姓名"
                                type="text"
								:readonly="!isAdd||disabledForm.xingming?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="性别" prop="xingbie">
							<el-input class="list_inp" v-model="form.xingbie" placeholder="性别"
                                type="text"
								:readonly="!isAdd||disabledForm.xingbie?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="报告时间" prop="baogaoshijian">
							<el-date-picker
								class="list_date"
								v-model="form.baogaoshijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.baogaoshijian?true:false"
								placeholder="请选择报告时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="咨询师账号" prop="zixunshizhanghao">
							<el-input class="list_inp" v-model="form.zixunshizhanghao" placeholder="咨询师账号"
                                type="text"
								:readonly="!isAdd||disabledForm.zixunshizhanghao?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="咨询师姓名" prop="zixunshixingming">
							<el-input class="list_inp" v-model="form.zixunshixingming" placeholder="咨询师姓名"
                                type="text"
								:readonly="!isAdd||disabledForm.zixunshixingming?true:false" />
						</el-form-item>
					</el-col>

				</el-row>
			</el-form>
			<template #footer v-if="isAdd||type=='logistics'||type=='reply'">
				<span class="formModel_btn_box">
					<el-button class="cancel_btn" @click="closeClick">取消</el-button>
					<el-button class="confirm_btn" type="primary" @click="save"
						>
						提交
					</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>
<script setup>
	import {
		reactive,
		ref,
		getCurrentInstance,
		nextTick,
		computed,
		defineEmits
	} from 'vue'
    import {
        useStore
    } from 'vuex';
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;	
	const emit = defineEmits(['formModelChange'])
	//基础信息
	const tableName = 'ceshibaogao'
	const formName = '测试报告'
	//基础信息
	//form表单
	const form = ref({})
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
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
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
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//测试报告上传回调
	const ceshibaogaoUploadSuccess=(e)=>{
		form.value.ceshibaogao = e
	}
	//账号列表
	const zhanghaoLists = ref([])

	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
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
		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			form.value = res.data.data
			formVisible.value = true
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init=(formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null)=>{
		resetForm()
			form.value.baogaoshijian = context?.$toolUtil.getCurDateTime()
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
			formTitle.value = '新增' + formName
			formVisible.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			formTitle.value = '查看' + formName
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			formTitle.value = '修改' + formName
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			formTitle.value = formNames
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
			formVisible.value = true
		}

		context?.$http({
			url: `${context?.$toolUtil.storageGet('sessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(json.hasOwnProperty('zixunshizhanghao')&& context?.$toolUtil.storageGet("role")!="管理员"){
				form.value.zixunshizhanghao = json.zixunshizhanghao
				disabledForm.value.zixunshizhanghao = true;
			}
			if(json.hasOwnProperty('zixunshixingming')&& context?.$toolUtil.storageGet("role")!="管理员"){
				form.value.zixunshixingming = json.zixunshixingming
				disabledForm.value.zixunshixingming = true;
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
	//声明父级调用
	defineExpose({
		init
	})
	//关闭
	const closeClick = () => {
		formVisible.value = false
	}
	const zhanghaoChange=()=>{
		context?.$http({
			url: `follow/yonghu/zhanghao?columnValue=` + form.value.zhanghao,
			method: 'get'
		}).then(res=>{
			if(res.data.data.xingming){
				form.value.xingming = res.data.data.xingming
			}
			if(res.data.data.xingbie){
				form.value.xingbie = res.data.data.xingbie
			}
		})
	}
	//富文本
	const editorChange = (e,name) =>{
		form.value[name] = e
	}
	//提交
	const save= async ()=>{
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
					crossUserId = user.value.id
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
							}).then(async res=>{
								emit('formModelChange')
								context?.$toolUtil.message(`操作成功`,'success')
                                formVisible.value = false
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(async (res)=>{
						emit('formModelChange')
						context?.$toolUtil.message(`操作成功`,'success')
                        formVisible.value = false
					})
				}
			}else{
                context.$message.error('请完善信息')
            }
		})
	}
	//修改跨表数据
	const changeCrossData = async (row)=>{
        if(type.value == 'cross'){
            await context?.$http({
                url: `${crossTable.value}/update`,
                method: 'post',
                data: row
            }).then(res=>{})
        }
	}
</script>
<style lang="scss" scoped>
	// 表单
	.formModel_form{
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
		.cancel_btn {
		}
		.cancel_btn:hover {
		}
		
		.confirm_btn {
		}
		.confirm_btn:hover {
		}
	}
</style>
