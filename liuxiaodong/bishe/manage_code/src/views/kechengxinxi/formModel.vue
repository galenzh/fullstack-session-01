<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="80%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="课程名称" prop="kechengmingcheng">
							<el-input class="list_inp" v-model="form.kechengmingcheng" placeholder="课程名称"
                                type="text"
								:readonly="!isAdd||disabledForm.kechengmingcheng?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item prop="kechengtupian"
									  label="课程图片"
						>
							<uploads
								:disabled="!isAdd||disabledForm.kechengtupian?true:false"
								action="file/upload"
								tip="请上传课程图片"
								style="width: 100%;text-align: left;"
								:fileUrls="form.kechengtupian?form.kechengtupian:''" 
								@change="kechengtupianUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="课程类型" prop="kechengleixing">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.kechengleixing?true:false"
								v-model="form.kechengleixing" 
								placeholder="请选择课程类型"
								>
								<el-option v-for="(item,index) in kechengleixingLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="课程视频" prop="kechengshipin">
							<uploads
								:disabled="!isAdd||disabledForm.kechengshipin?true:false"
								type="file"
								action="file/upload" 
								tip="请上传课程视频" 
								:limit="1" 
								style="width: 100%;text-align: left;"
								:fileUrls="form.kechengshipin?form.kechengshipin:''" 
								@change="kechengshipinUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="发布时间" prop="fabushijian">
							<el-date-picker
								class="list_date"
								v-model="form.fabushijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.fabushijian?true:false"
								placeholder="请选择发布时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="价格" prop="price">
							<el-input class="list_inp" v-model.number="form.price" placeholder="价格"
                                type="number"
								:readonly="!isAdd||disabledForm.price?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="积分" prop="jf">
							<el-input class="list_inp" v-model.number="form.jf" placeholder="积分"
                                type="text"
								:readonly="!isAdd||disabledForm.jf?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="课程简介" prop="kechengjianjie">
							<el-input v-model="form.kechengjianjie" placeholder="课程简介" type="textarea"
							:readonly="!isAdd||disabledForm.kechengjianjie?true:false"
							/>
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
	const tableName = 'kechengxinxi'
	const formName = '课程信息'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
        kechengmingcheng : false,
        kechengtupian : false,
        kechengleixing : false,
        kechengjianjie : false,
        kechengshipin : false,
        fabushijian : false,
        storeupNumber : false,
        discussNumber : false,
        clicktime : false,
        price : false,
        jf : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		kechengmingcheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		kechengtupian: [
		],
		kechengleixing: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		kechengjianjie: [
		],
		kechengshipin: [
		],
		fabushijian: [
		],
		storeupNumber: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		discussNumber: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		clicktime: [
		],
		price: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		jf: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//课程图片上传回调
	const kechengtupianUploadSuccess=(e)=>{
		form.value.kechengtupian = e
	}
	//课程类型列表
	const kechengleixingLists = ref([])
	//课程视频上传回调
	const kechengshipinUploadSuccess=(e)=>{
		form.value.kechengshipin = e
	}

	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			kechengmingcheng: '',
			kechengtupian: '',
			kechengleixing: '',
			kechengjianjie: '',
			kechengshipin: '',
			fabushijian: '',
			storeupNumber: '',
			discussNumber: '',
			clicktime: '',
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
			form.value.fabushijian = context?.$toolUtil.getCurDateTime()
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
				if(x=='kechengmingcheng'){
					form.value.kechengmingcheng = row[x];
					disabledForm.value.kechengmingcheng = true;
					continue;
				}
				if(x=='kechengtupian'){
					form.value.kechengtupian = row[x];
					disabledForm.value.kechengtupian = true;
					continue;
				}
				if(x=='kechengleixing'){
					form.value.kechengleixing = row[x];
					disabledForm.value.kechengleixing = true;
					continue;
				}
				if(x=='kechengjianjie'){
					form.value.kechengjianjie = row[x];
					disabledForm.value.kechengjianjie = true;
					continue;
				}
				if(x=='kechengshipin'){
					form.value.kechengshipin = row[x];
					disabledForm.value.kechengshipin = true;
					continue;
				}
				if(x=='fabushijian'){
					form.value.fabushijian = row[x];
					disabledForm.value.fabushijian = true;
					continue;
				}
				if(x=='storeupNumber'){
					form.value.storeupNumber = row[x];
					disabledForm.value.storeupNumber = true;
					continue;
				}
				if(x=='discussNumber'){
					form.value.discussNumber = row[x];
					disabledForm.value.discussNumber = true;
					continue;
				}
				if(x=='clicktime'){
					form.value.clicktime = row[x];
					disabledForm.value.clicktime = true;
					continue;
				}
				if(x=='price'){
					form.value.price = row[x];
					disabledForm.value.price = true;
					continue;
				}
				if(x=='jf'){
					form.value.jf = row[x];
					disabledForm.value.jf = true;
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
		})
		context?.$http({
			url: `option/kechengleixing/kechengleixing`,
			method: 'get'
		}).then(res=>{
			kechengleixingLists.value = res.data.data
		})
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
	//富文本
	const editorChange = (e,name) =>{
		form.value[name] = e
	}
	//提交
	const save= async ()=>{
		if(form.value.kechengtupian!=null) {
			form.value.kechengtupian = form.value.kechengtupian.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if(form.value.kechengshipin!=null) {
			form.value.kechengshipin = form.value.kechengshipin.replace(new RegExp(context?.$config.url,"g"),"");
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
				// 长文本
				.el-textarea__inner {
				}
				//图片上传样式
				.el-upload-list  {
					//提示语
					.el-upload__tip {
					}
					//外部盒子
					.el-upload--picture-card {
						//图标
						.el-icon{
						}
					}
					.el-upload-list__item {
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
