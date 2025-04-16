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
        
        <!-- 预约须知卡片 -->
        <div class="appointment-notice">
            <div class="notice-header">
                <i class="el-icon-info-filled"></i>
                <span>预约须知</span>
            </div>
            <div class="notice-content">
                <p><i class="el-icon-check"></i> 请选择合适的时间和咨询师进行预约</p>
                <p><i class="el-icon-check"></i> 预约成功后，咨询师将通过您提供的联系方式与您联系</p>
                <p><i class="el-icon-check"></i> 如需取消预约，请提前24小时联系咨询师</p>
                <p><i class="el-icon-check"></i> 初次咨询前，建议完成心理测试以便咨询师更好了解您的情况</p>
            </div>
        </div>
        
		<el-form ref="formRef" :model="form" class="add_form" label-width="120px" :rules="rules">
			<el-row>
				<el-col :span="24">
					<el-form-item label="预约编号" prop="yuyuebianhao">
						<el-input class="list_inp" v-model="form.yuyuebianhao" placeholder="请输入预约编号" readonly></el-input>
						<div class="form-tip">系统自动生成预约编号，无需手动输入</div>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="咨询师选择" prop="zixunshizhanghao">
						<el-select 
							v-model="form.zixunshizhanghao" 
							placeholder="请选择咨询师" 
							style="width:100%;"
							filterable
							@change="handleConsultantChange"
							:disabled="!isAdd||disabledForm.zixunshizhanghao?true:false">
							<el-option
								v-for="item in consultantOptions"
								:key="item.value"
								:label="item.label"
								:value="item.value">
							</el-option>
						</el-select>
						<div class="form-tip">选择一位您希望咨询的心理咨询师</div>
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="咨询师联系方式" prop="lianxifangshi">
						<el-input class="list_inp" v-model="form.lianxifangshi" placeholder="咨询师联系方式"
							 type="text" readonly />
						<div class="form-tip">系统自动获取咨询师联系方式，无需手动填写</div>
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="预约日期" prop="yuyueshijian">
						<el-date-picker
							class="list_date"
							v-model="form.yuyueshijian"
							format="YYYY-MM-DD"
							value-format="YYYY-MM-DD"
							type="date"
							:disabled-date="yuyueshijianDisabledDate"
							style="width:100%;"
							:readonly="!isAdd||disabledForm.yuyueshijian?true:false"
							placeholder="请选择预约日期" />
						<div class="form-tip">只能选择今天及以后的日期进行预约</div>
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="预约时段" prop="timeSlot">
						<el-select v-model="form.timeSlot" placeholder="请选择预约时段" style="width:100%;" :disabled="!form.yuyueshijian || !form.zixunshizhanghao">
							<el-option
								v-for="item in availableTimeSlots"
								:key="item.value"
								:label="item.label"
								:value="item.value">
							</el-option>
						</el-select>
						<div class="form-tip" v-if="availableTimeSlots.length === 0 && form.yuyueshijian && form.zixunshizhanghao">
							该日期下咨询师暂无可用时段，请选择其他日期
						</div>
						<div class="form-tip" v-else>
							请先选择咨询师和日期，再选择具体时段
						</div>
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="咨询时长" prop="duration">
						<el-input-number 
							v-model="form.duration" 
							:min="30" 
							:max="120" 
							:step="30"
							style="width:100%;"
							placeholder="请选择咨询时长(分钟)">
						</el-input-number>
						<div class="form-tip">一般咨询时长为30-120分钟，可根据需求选择</div>
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="您的账号" prop="zhanghao">
						<el-input class="list_inp" v-model="form.zhanghao" placeholder="账号"
							 type="text" :readonly="!isAdd||disabledForm.zhanghao?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="联系电话" prop="shouji">
						<el-input class="list_inp" v-model="form.shouji" placeholder="请输入您的联系电话"
							 type="text" :readonly="!isAdd||disabledForm.shouji?true:false" />
						<div class="form-tip">请确保电话畅通，咨询师将通过此电话与您联系</div>
					</el-form-item>
				</el-col>

				<el-col :span="24">
					<el-form-item label="预约咨询时间" prop="yuyuezixunshijian">
						<el-input
							class="list_inp"
							v-model="yuyuezixunshijianDisplay"
							placeholder="预约咨询时间将自动生成"
							readonly>
						</el-input>
						<div class="form-tip">根据您选择的日期和时段自动生成，无需手动输入</div>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="预约备注" prop="yuyuebeizhu">
						<el-input 
							type="textarea" 
							:rows="4" 
							class="textarea_inp" 
							v-model="form.yuyuebeizhu" 
							placeholder="请简要描述您的咨询需求，帮助咨询师更好地了解您的情况"
							:readonly="!isAdd||disabledForm.yuyuebeizhu?true:false" />
						<div class="form-tip">请描述您的咨询需求、困扰等信息，方便咨询师提前了解</div>
					</el-form-item>
				</el-col>

			</el-row>
			<div class="formModel_btn_box">
				<el-button class="formModel_cancel" @click="backClick">取消</el-button>
				<el-button class="formModel_confirm"
                           @click="save"
                           type="success"
				>
					提交预约
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
	const tableName = 'zixunshiyuyue'
	const formName = '咨询师预约'
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
		yuyuebianhao: getUUID(),
		zixunshizhanghao: '',
		lianxifangshi: '',
		yuyueshijian: '',
		timeSlot: '',
		duration: 60,
		status: '待确认',
		zhanghao: '',
		shouji: '',
		yuyuezixunshijian: '',
		yuyuebeizhu: '',
		shhf: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	const disabledForm = ref({
		yuyuebianhao : false,
		zixunshizhanghao : false,
		lianxifangshi : false,
		yuyueshijian : false,
		zhanghao : false,
		shouji : false,
		yuyuezixunshijian : false,
		yuyuebeizhu : false,
		sfsh : false,
		shhf : false,
	})
	const isAdd = ref(false)
	//表单验证
	const rules = ref({
		yuyuebianhao: [
		],
		zixunshizhanghao: [
			{ required: true, message: '请选择咨询师', trigger: 'change' }
		],
		lianxifangshi: [
		],
		yuyueshijian: [
			{ required: true, message: '请选择预约日期', trigger: 'change' }
		],
		zhanghao: [
		],
		shouji: [
		],
		yuyuezixunshijian: [
		],
		yuyuebeizhu: [
		],
		sfsh: [
		],
		shhf: [
		],
		timeSlot: [
			{ required: true, message: '请选择预约时段', trigger: 'change' }
		],
		duration: [
			{ required: true, message: '请选择咨询时长', trigger: 'change' }
		]
	})
	// 限制预约时间只能选择今天和以后的日期
	const yuyueshijianDisabledDate = (date) => {
		return date.getTime() < Date.now() - 8.64e7;
	}
	
	// 咨询师选项列表
	const consultantOptions = ref([])
	// 获取咨询师列表
	const getConsultantList = () => {
		context?.$http({
			url: `option/zixunshi/zixunshizhanghao`,
			method: 'get'
		}).then(res => {
			if (res.data.code === 0) {
				consultantOptions.value = res.data.data.map(item => ({
					value: item,
					label: item
				}))
			}
		})
	}
	
	// 检查用户测试评分
	const checkTestScore = () => {
		return new Promise((resolve, reject) => {
			context?.$http({
				url: `ceshipingfen/checkScore`,
				method: 'get'
			}).then(res => {
				if (res.data.code === 0) {
					// 检查评分是否低于60分
					const passScore = res.data.data.pass || false
					if (!passScore) {
						resolve(true) // 允许预约
					} else {
						resolve(true) // 测试合格，允许预约
					}
				} else {
					// 如果接口不存在或出错，仍然允许用户预约
					resolve(true)
				}
			}).catch(() => {
				// 如果请求失败，仍然允许用户预约
				resolve(true)
			})
		})
	}
	
	// 咨询师变更处理
	const handleConsultantChange = (value) => {
		// 清空已选择的时间段，因为不同咨询师可用时间段不同
		form.value.timeSlot = ''
		
		// 如果有选择咨询师，获取咨询师联系方式
		if (value) {
			context?.$http({
				url: `zixunshi/page`,
				method: 'get',
				params: {
					page: 1,
					limit: 1,
					zixunshizhanghao: value
				}
			}).then(res => {
				if (res.data.code === 0 && res.data.data && res.data.data.list && res.data.data.list.length > 0) {
					form.value.lianxifangshi = res.data.data.list[0].lianxifangshi || ''
					console.log("获取到咨询师联系方式:", form.value.lianxifangshi)
				}
			}).catch(error => {
				console.error("获取咨询师信息失败:", error)
			})
		}
		
		// 如果已选择日期，更新可用时间段
		if (form.value.yuyueshijian) {
			getAvailableTimeSlots()
		}
	}

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
			form.value.yuyueshijian = context?.$toolUtil.getCurDateTime()
			
			// 获取咨询师列表
			getConsultantList()
			
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
				if(x=='yuyuebianhao'){
					form.value.yuyuebianhao = row[x];
					disabledForm.value.yuyuebianhao = true;
					continue;
				}
				if(x=='zixunshizhanghao'){
					form.value.zixunshizhanghao = row[x];
					disabledForm.value.zixunshizhanghao = true;
					continue;
				}
				if(x=='lianxifangshi'){
					form.value.lianxifangshi = row[x];
					disabledForm.value.lianxifangshi = true;
					continue;
				}
				if(x=='yuyueshijian'){
					form.value.yuyueshijian = row[x];
					disabledForm.value.yuyueshijian = true;
					continue;
				}
				if(x=='zhanghao'){
					form.value.zhanghao = row[x];
					disabledForm.value.zhanghao = true;
					continue;
				}
				if(x=='shouji'){
					form.value.shouji = row[x];
					disabledForm.value.shouji = true;
					continue;
				}
				if(x=='yuyuezixunshijian'){
					form.value.yuyuezixunshijian = row[x];
					disabledForm.value.yuyuezixunshijian = true;
					continue;
				}
				if(x=='yuyuebeizhu'){
					form.value.yuyuebeizhu = row[x];
					disabledForm.value.yuyuebeizhu = true;
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
			if(json.hasOwnProperty('zhanghao') && context?.$toolUtil.storageGet("frontRole")!="管理员"){
				form.value.zhanghao = json.zhanghao
				disabledForm.value.zhanghao = true;
			}
			if(json.hasOwnProperty('shouji') && context?.$toolUtil.storageGet("frontRole")!="管理员"){
				form.value.shouji = json.shouji
				disabledForm.value.shouji = true;
			}
            if (localStorage.getItem('autoSave')) {
                localStorage.removeItem('autoSave')
                save()
            }
		})
	}
	//初始化
	//取消
	const backClick = () => {
		history.back()
	}
	//提交
	const save=()=>{
		// 检查是否选择了预约时段
		if (!form.value.timeSlot) {
			context?.$toolUtil.message('请选择预约时段', 'error')
			return
		}
		
		// 检查是否选择了预约日期
		if (!form.value.yuyueshijian) {
			context?.$toolUtil.message('请选择预约日期', 'error')
			return
		}
		
		// 先检查用户测试评分
		checkTestScore().then(canBook => {
			if (!canBook) {
				context?.$toolUtil.message('根据测试评分，您暂时无法预约咨询师，请先完成心理测试', 'error')
				return
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
									// 显示更详细的预约成功信息
									let successMsg = `预约成功！您已成功预约${form.value.zixunshizhanghao}在${form.value.yuyueshijian} ${form.value.timeSlot}的咨询`
									context?.$toolUtil.message(successMsg, 'success', () => {
                                history.back()
									})
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(res=>{
							// 显示更详细的预约成功信息
							let successMsg = `预约成功！您已成功预约${form.value.zixunshizhanghao}在${form.value.yuyueshijian} ${form.value.timeSlot}的咨询`
							context?.$toolUtil.message(successMsg, 'success', () => {
                        history.back()
							})
					})
				}
			}
			})
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
	const availableTimeSlots = ref([
		{ value: '09:00-10:00', label: '09:00-10:00' },
		{ value: '10:00-11:00', label: '10:00-11:00' },
		{ value: '11:00-12:00', label: '11:00-12:00' },
		{ value: '14:00-15:00', label: '14:00-15:00' },
		{ value: '15:00-16:00', label: '15:00-16:00' },
		{ value: '16:00-17:00', label: '16:00-17:00' }
	])
	
	// 获取咨询师可用时间段
	const getAvailableTimeSlots = () => {
		if (!form.value.yuyueshijian || !form.value.zixunshizhanghao) {
			return
		}
		
		context?.$http({
			url: `zixunshiyuyue/getAvailableTimeSlots`,
			method: 'get',
			params: {
				date: form.value.yuyueshijian,
				zixunshizhanghao: form.value.zixunshizhanghao
			}
		}).then(res => {
			if (res.data.code === 0 && res.data.data) {
				// 更新可用时间段
				availableTimeSlots.value = res.data.data.map(time => ({
					value: time,
					label: time
				}))
				
				// 如果当前选择的时间段不在可用列表中，清除选择
				if (form.value.timeSlot && !res.data.data.includes(form.value.timeSlot)) {
					form.value.timeSlot = ''
				}
			}
		})
	}
	
	// 监听日期变化，更新可用时间段
	watch(() => form.value.yuyueshijian, (newVal) => {
		if (newVal) {
			getAvailableTimeSlots()
		} else {
			form.value.timeSlot = ''
		}
	})
	
	// 监听咨询师变化，更新可用时间段
	watch(() => form.value.zixunshizhanghao, (newVal) => {
		if (newVal && form.value.yuyueshijian) {
			getAvailableTimeSlots()
		}
	})

	// 计算属性: 根据选择的日期和时段生成咨询时间显示
	const yuyuezixunshijianDisplay = computed(() => {
		if (form.value.yuyueshijian && form.value.timeSlot) {
			return `${form.value.yuyueshijian} ${form.value.timeSlot}`
		}
		return ''
	})

	// 设置时间段和日期的联动
	watch([() => form.value.yuyueshijian, () => form.value.timeSlot], ([date, timeSlot]) => {
		if (date && timeSlot) {
			// 分割时间段，取开始时间
			const startTime = timeSlot.split('-')[0]
			// 合并日期和时间
			form.value.yuyuezixunshijian = `${date} ${startTime}`
		}
	}, { immediate: true })
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
    width: 1000px;
    margin: 30px auto;
    padding: 0;
    background: #fff;
    overflow: hidden;
    font-size: 16px;
    color:#666;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    animation: pageLoad 0.8s ease forwards;
}

@keyframes pageLoad {
    from { opacity: 0; }
    to { opacity: 1; }
}

.edit_view .breadcrumb-wrapper {
    background: linear-gradient(135deg, var(--theme) 0%, #409EFF 100%);
    padding: 20px 30px;
    border-radius: 10px 10px 0 0;
}

.edit_view .bread_view {
    color: #fff;
}

.edit_view .bread_view :deep(.breadcrumb) {
    color: #fff;
}

.edit_view .bread_view :deep(.breadcrumb .el-breadcrumb__separator) {
    color: rgba(255, 255, 255, 0.7);
}

.edit_view .bread_view :deep(.breadcrumb .el-breadcrumb__inner) {
    color: rgba(255, 255, 255, 0.9);
    font-weight: normal;
}

.edit_view .bread_view :deep(.breadcrumb .first_breadcrumb .el-breadcrumb__inner) {
    color: #fff;
    font-size: 18px;
    font-weight: 500;
}

.edit_view .add_form{
    width: 100%;
    padding: 30px 40px 40px;
    border: 0;
    background: #fff;
    animation: fadeInUp 0.6s ease forwards;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.edit_view .add_form .el-form-item{
    margin: 0 0 25px;
    display: flex;
    position: relative;
    opacity: 0;
    animation: fadeIn 0.5s ease forwards;
}

.edit_view .add_form .el-form-item:nth-child(1) { animation-delay: 0.1s; }
.edit_view .add_form .el-form-item:nth-child(2) { animation-delay: 0.2s; }
.edit_view .add_form .el-form-item:nth-child(3) { animation-delay: 0.3s; }
.edit_view .add_form .el-form-item:nth-child(4) { animation-delay: 0.4s; }
.edit_view .add_form .el-form-item:nth-child(5) { animation-delay: 0.5s; }
.edit_view .add_form .el-form-item:nth-child(6) { animation-delay: 0.6s; }
.edit_view .add_form .el-form-item:nth-child(7) { animation-delay: 0.7s; }
.edit_view .add_form .el-form-item:nth-child(8) { animation-delay: 0.8s; }
.edit_view .add_form .el-form-item:nth-child(9) { animation-delay: 0.9s; }

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.edit_view .add_form .el-form-item:hover {
    transform: translateY(-1px);
    transition: transform 0.3s;
}

.edit_view .add_form .el-form-item .el-form-item__label{
    width: 150px;
    background: none;
    text-align: right;
    display: block;
    font-size: 16px;
    color: #333;
    font-weight: 500;
    padding-right: 20px;
    line-height: 40px;
}

.edit_view .add_form .el-form-item .el-form-item__content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-wrap: wrap;
    width: calc(100% - 150px);
}

.edit_view .add_form .el-form-item .el-form-item__content .list_inp{
    height: 40px;
    line-height: 40px;
    border: 1px solid #dcdfe6;
    padding: 0 15px;
    width: 100%;
    box-sizing: border-box;
    background: #fff;
    font-size: 16px;
    border-radius: 6px;
    transition: all 0.3s;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_inp:hover {
    border-color: #c0c4cc;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_inp:focus {
    border-color: var(--theme);
    box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.edit_view .add_form .el-form-item .el-form-item__content .list_date{
    height: 40px;
    line-height: 40px;
    border: 1px solid #dcdfe6;
    box-sizing: border-box;
    width: 100%;
    border-radius: 6px;
    background: #fff;
    font-size: 16px;
    transition: all 0.3s;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_date:hover {
    border-color: #c0c4cc;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_date:focus {
    border-color: var(--theme);
    box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.edit_view .formModel_btn_box {
    display: flex;
    justify-content: center;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #f0f0f0;
}

.edit_view .formModel_btn_box .formModel_cancel {
    margin-right: 20px;
    padding: 12px 25px;
    font-size: 16px;
    border-radius: 6px;
    border: 1px solid #dcdfe6;
    background: #f5f7fa;
    color: #606266;
    transition: all 0.3s;
}

.edit_view .formModel_btn_box .formModel_cancel:hover {
    background: #e9ecf2;
    color: #333;
}

.edit_view .formModel_btn_box .formModel_confirm {
    padding: 12px 30px;
    font-size: 16px;
    border-radius: 6px;
    background: linear-gradient(135deg, var(--theme) 0%, #409EFF 100%);
    border: none;
    color: #fff;
    transition: all 0.3s;
    box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
}

.edit_view .formModel_btn_box .formModel_confirm:hover {
    animation: pulse 1.5s infinite;
}

@keyframes pulse {
    0% {
        box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
    }
    50% {
        box-shadow: 0 4px 20px rgba(64, 158, 255, 0.5);
    }
    100% {
        box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
    }
}

/* 下拉选择框样式 */
.edit_view .add_form :deep(.el-select) {
    width: 100%;
}

.edit_view .add_form :deep(.el-select .el-input__wrapper) {
    border-radius: 6px;
    transition: all 0.3s;
}

.edit_view .add_form :deep(.el-select .el-input__wrapper:hover) {
    box-shadow: 0 0 0 1px #c0c4cc inset;
}

.edit_view .add_form :deep(.el-select .el-input__wrapper.is-focus) {
    box-shadow: 0 0 0 1px var(--theme) inset;
}

/* 数字输入框样式 */
.edit_view .add_form :deep(.el-input-number) {
    width: 100%;
}

.edit_view .add_form :deep(.el-input-number .el-input__wrapper) {
    border-radius: 6px;
}

.edit_view .add_form :deep(.el-input-number .el-input-number__decrease),
.edit_view .add_form :deep(.el-input-number .el-input-number__increase) {
    border-radius: 4px;
    background: #f5f7fa;
    color: #606266;
    transition: all 0.3s;
}

.edit_view .add_form :deep(.el-input-number .el-input-number__decrease:hover),
.edit_view .add_form :deep(.el-input-number .el-input-number__increase:hover) {
    background: #e9ecf2;
    color: #409EFF;
}

/* 添加特殊效果 */
/* 添加鼠标悬停效果 */
.edit_view .add_form .el-form-item:hover {
    transform: translateY(-1px);
    transition: transform 0.3s;
}

/* 表单项标签特效 */
.edit_view .add_form .el-form-item .el-form-item__label::after {
    content: '';
    position: absolute;
    bottom: 15px;
    left: 150px;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--theme), transparent);
    transition: width 0.3s;
}

.edit_view .add_form .el-form-item:hover .el-form-item__label::after {
    width: 60px;
}

/* 添加响应式设计 */
@media screen and (max-width: 1200px) {
    .edit_view {
        width: 90%;
    }
}

@media screen and (max-width: 768px) {
    .edit_view .add_form {
        padding: 20px;
    }
    
    .edit_view .add_form .el-form-item {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .edit_view .add_form .el-form-item .el-form-item__label {
        width: 100%;
        text-align: left;
        padding-bottom: 8px;
        line-height: normal;
    }
    
    .edit_view .add_form .el-form-item .el-form-item__content {
        width: 100%;
    }
}

/* 预约须知卡片样式 */
.appointment-notice {
    margin: 0 40px;
    margin-top: -15px;
    padding: 20px;
    background-color: #f9f9ff;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
    margin-bottom: 20px;
    border-left: 4px solid var(--theme);
    animation: fadeInUp 0.6s ease forwards;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.notice-header {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    color: var(--theme);
    font-weight: bold;
    font-size: 18px;
}

.notice-header i {
    margin-right: 8px;
    font-size: 20px;
}

.notice-content {
    color: #666;
    line-height: 1.8;
    position: relative;
    padding-left: 5px;
    transition: all 0.3s;
}

.notice-content:hover {
    transform: translateX(5px);
    color: #333;
}

.notice-content p {
    margin: 10px 0;
    display: flex;
    align-items: flex-start;
}

.notice-content p i {
    color: #67C23A;
    margin-right: 8px;
    font-size: 16px;
    transition: all 0.3s;
}

.notice-content p:hover i {
    transform: scale(1.2);
}

/* 表单提示信息 */
.form-tip {
    font-size: 12px;
    color: #909399;
    margin-top: 5px;
    width: 100%;
    transition: all 0.3s;
}

/* 文本域样式 */
.textarea_inp {
    width: 100%;
    border-radius: 6px;
    transition: all 0.3s;
    min-height: 100px;
    padding: 10px 15px;
    border: 1px solid #dcdfe6;
}

.textarea_inp:hover {
    border-color: #c0c4cc;
}

.textarea_inp:focus {
    border-color: var(--theme);
    box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

/* 添加更多动画和交互效果 */

/* 卡片缓入动画 */
.appointment-notice, .add_form {
    animation: fadeInUp 0.6s ease forwards;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* 交错动画，让表单项一个接一个淡入 */
.add_form .el-form-item {
    opacity: 0;
    animation: fadeIn 0.5s ease forwards;
}

.add_form .el-form-item:nth-child(1) { animation-delay: 0.1s; }
.add_form .el-form-item:nth-child(2) { animation-delay: 0.2s; }
.add_form .el-form-item:nth-child(3) { animation-delay: 0.3s; }
.add_form .el-form-item:nth-child(4) { animation-delay: 0.4s; }
.add_form .el-form-item:nth-child(5) { animation-delay: 0.5s; }
.add_form .el-form-item:nth-child(6) { animation-delay: 0.6s; }
.add_form .el-form-item:nth-child(7) { animation-delay: 0.7s; }
.add_form .el-form-item:nth-child(8) { animation-delay: 0.8s; }
.add_form .el-form-item:nth-child(9) { animation-delay: 0.9s; }

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

/* 按钮悬停脉冲效果 */
.formModel_btn_box .formModel_confirm {
    transition: all 0.3s;
}

.formModel_btn_box .formModel_confirm:hover {
    animation: pulse 1.5s infinite;
}

@keyframes pulse {
    0% {
        box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
    }
    50% {
        box-shadow: 0 4px 20px rgba(64, 158, 255, 0.5);
    }
    100% {
        box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
    }
}

/* 选项卡片效果 */
.el-select-dropdown__item {
    transition: all 0.3s;
    border-radius: 4px;
    margin: 2px 0;
}

.el-select-dropdown__item.selected {
    background-color: rgba(64, 158, 255, 0.1);
    color: var(--theme);
    font-weight: bold;
}

.el-select-dropdown__item:hover {
    background-color: rgba(64, 158, 255, 0.05);
    transform: translateX(3px);
}

/* 注意提醒项动画 */
.notice-content p {
    position: relative;
    padding-left: 5px;
    transition: all 0.3s;
}

.notice-content p:hover {
    transform: translateX(5px);
    color: #333;
}

.notice-content p i {
    transition: all 0.3s;
}

.notice-content p:hover i {
    transform: scale(1.2);
}

/* 可用时间段为空时的提示动画 */
.form-tip {
    transition: all 0.3s;
}

[v-if="availableTimeSlots.length === 0 && form.yuyueshijian && form.zixunshizhanghao"] {
    color: #E6A23C;
    animation: attention 2s infinite;
}

@keyframes attention {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.7; }
}
</style>