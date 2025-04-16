<template>
  <div class="appointment-page">
    <div class="section_title">
      <span>医生预约</span>
    </div>
    
    <el-card class="appointment-card">
      <div class="appointment-info">
        <el-alert
          title="根据您的测试结果，建议您进行专业医生诊断"
          type="info"
          description="我们的专业医生团队将为您提供个性化的诊断和治疗方案"
          show-icon
          :closable="false">
        </el-alert>
      </div>
      
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px" class="appointment-form">
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" placeholder="请输入您的姓名"></el-input>
        </el-form-item>
        
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入您的联系电话"></el-input>
        </el-form-item>
        
        <el-form-item label="咨询师" prop="doctor">
          <el-select v-model="form.doctor" placeholder="请选择咨询师" style="width: 100%" @change="doctorChanged">
            <el-option 
              v-for="doctor in doctorList" 
              :key="doctor.value" 
              :label="doctor.label" 
              :value="doctor.value">
            </el-option>
          </el-select>
        </el-form-item>
        
        <el-form-item label="预约日期" prop="date">
          <el-date-picker
            v-model="form.date"
            type="date"
            placeholder="选择预约日期"
            :disabled-date="disabledDate"
            @change="loadAvailableTimeSlots"
            style="width: 100%">
          </el-date-picker>
        </el-form-item>
        
        <el-form-item label="预约时段" prop="timeSlot">
          <el-select v-model="form.timeSlot" placeholder="请选择预约时段" style="width: 100%" :disabled="!form.date || !form.doctor">
            <el-option 
              v-for="slot in availableTimeSlots" 
              :key="slot" 
              :label="slot" 
              :value="slot">
            </el-option>
          </el-select>
        </el-form-item>
        
        <el-form-item label="症状描述" prop="description">
          <el-input
            type="textarea"
            v-model="form.description"
            placeholder="请简要描述您的症状或问题"
            :rows="4">
          </el-input>
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="submitForm">提交预约</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, getCurrentInstance, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { formatDate } from '@/utils/date'

const router = useRouter()
const context = getCurrentInstance()?.appContext.config.globalProperties
const formRef = ref(null)
const availableTimeSlots = ref([])
const doctorList = ref([
  { value: '咨询师账号1', label: '王医生 (心理咨询)' },
  { value: '咨询师账号2', label: '张医生 (精神科)' },
  { value: '咨询师账号3', label: '李医生 (心理治疗)' }
])

// 表单数据
const form = reactive({
  name: '',
  phone: '',
  doctor: '',
  date: '',
  timeSlot: '',
  description: ''
})

// 表单验证规则
const rules = {
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入联系电话', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
  ],
  doctor: [
    { required: true, message: '请选择咨询师', trigger: 'change' }
  ],
  date: [
    { required: true, message: '请选择预约日期', trigger: 'change' }
  ],
  timeSlot: [
    { required: true, message: '请选择预约时段', trigger: 'change' }
  ],
  description: [
    { required: true, message: '请描述您的症状', trigger: 'blur' }
  ]
}

// 当咨询师改变时，清空日期和时间段
const doctorChanged = () => {
  form.date = ''
  form.timeSlot = ''
  availableTimeSlots.value = []
}

// 加载医生列表
const loadDoctorList = () => {
  // 实际应该从后端API获取医生列表
  context?.$http({
    url: '/zixunshi/list', // 假设这是获取咨询师列表的API
    method: 'GET'
  }).then(res => {
    if (res.data && res.data.code === 0 && res.data.data) {
      // 如果API成功返回数据，更新医生列表
      doctorList.value = res.data.data.map(item => ({
        value: item.zhanghao, // 咨询师账号
        label: `${item.xingming} (${item.keshi || '咨询师'})` // 名称+科室
      }))
    }
  }).catch(err => {
    console.error('获取咨询师列表失败:', err)
    // 保留默认列表
  })
}

// 加载可用时间段
const loadAvailableTimeSlots = () => {
  if (!form.date || !form.doctor) {
    availableTimeSlots.value = []
    return
  }
  
  const formattedDate = formatDate(form.date, 'yyyy-MM-dd')
  
  // 调用后端API获取可用时间段
  context?.$http({
    url: `/zixunshiyuyue/getAvailableTimeSlots?date=${formattedDate}&zixunshizhanghao=${form.doctor}`,
    method: 'GET'
  }).then(res => {
    if (res.data && res.data.code === 0) {
      availableTimeSlots.value = res.data.data || []
      if (availableTimeSlots.value.length === 0) {
        ElMessage.warning('该日期暂无可用预约时段')
      }
    } else {
      ElMessage.error(res.data.msg || '获取可用时间段失败')
      availableTimeSlots.value = []
    }
  }).catch(err => {
    console.error('获取时间段出错:', err)
    ElMessage.error('获取可用时间段失败，请稍后重试')
    availableTimeSlots.value = []
  })
}

// 禁用过去的日期
const disabledDate = (time) => {
  return time.getTime() < Date.now() - 8.64e7 // 禁用今天之前的日期
}

// 提交表单
const submitForm = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      console.log('提交表单数据:', form); // 添加日志
      
      // 构建预约数据
      const appointmentData = {
        zixunshizhanghao: form.doctor,
        lianxifangshi: form.phone,
        yuyuezixunshijian: formatDate(form.date, 'yyyy-MM-dd'),
        timeSlot: form.timeSlot,
        yuyuebeizhu: form.description,
        zhanghao: localStorage.getItem('userid') || '', // 从localStorage获取用户ID
        shouji: form.phone,
        sfsh: '待审核',
        status: '待确认'
      }
      
      console.log('发送到后端的数据:', appointmentData); // 添加日志
      
      // 提交预约
      context?.$http({
        url: '/zixunshiyuyue/save',
        method: 'POST',
        data: appointmentData
      }).then(res => {
        console.log('后端返回结果:', res.data); // 添加日志
        if (res.data && res.data.code === 0) {
          ElMessage.success('预约成功！我们的医生会尽快与您联系')
          setTimeout(() => {
            router.push('/index/home')  // 修改为正确的首页路径
          }, 1500)
        } else {
          ElMessage.error(res.data.msg || '预约失败，请稍后重试')
        }
      }).catch(err => {
        console.error('预约提交出错:', err)
        ElMessage.error('预约失败，请稍后重试')
      })
    } else {
      ElMessage.error('请完善表单信息')
      return false
    }
  })
}

// 重置表单
const resetForm = () => {
  formRef.value.resetFields()
  availableTimeSlots.value = []
}

// 页面加载时获取医生列表
onMounted(() => {
  loadDoctorList()
})
</script>

<style lang="scss" scoped>
.appointment-page {
  padding: 20px;
  
  .section_title {
    margin-bottom: 20px;
    font-size: 20px;
    font-weight: bold;
  }
  
  .appointment-card {
    max-width: 800px;
    margin: 0 auto;
    
    .appointment-info {
      margin-bottom: 30px;
    }
    
    .appointment-form {
      margin-top: 20px;
    }
  }
}
</style> 