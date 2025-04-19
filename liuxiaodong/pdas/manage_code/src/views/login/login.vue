<template>
  <div class="login_view">
    <div class="login_box">
      <div class="login_title">人格障碍诊断系统</div>
      <div class="login_form">
        <el-form :model="loginForm" :rules="loginRules" ref="loginFormRef">
          <div class="list_type">
            <el-form-item prop="loginType">
              <el-select v-model="loginForm.loginType" placeholder="请选择登录类型" style="width: 100%;">
                <el-option label="管理员" value="users"></el-option>
                <el-option label="咨询师" value="zixunshi"></el-option>
                <el-option label="科室主任" value="keshizhureng"></el-option>
              </el-select>
            </el-form-item>
          </div>
          <el-form-item prop="username">
            <el-input v-model="loginForm.username" placeholder="请输入账号"></el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input type="password" v-model="loginForm.password" placeholder="请输入密码"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm" style="width: 100%;">登录</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup>
// ... 现有代码 ...

// 在登录处理函数中添加科室主任登录逻辑
const submitForm = () => {
  loginFormRef.value.validate((valid) => {
    if (valid) {
      if (loginForm.loginType === 'users') {
        // 管理员登录逻辑
        // ... 现有代码 ...
      } else if (loginForm.loginType === 'zixunshi') {
        // 咨询师登录逻辑
        // ... 现有代码 ...
      } else if (loginForm.loginType === 'keshizhureng') {
        // 科室主任登录逻辑
        http.post('keshizhureng/login', {
          zhanghao: loginForm.username,
          mima: loginForm.password
        }).then(({data}) => {
          if (data && data.code === 0) {
            toolUtil.storageSet('Token', data.token)
            toolUtil.storageSet('userId', data.data.id)
            toolUtil.storageSet('role', 'keshizhureng')
            toolUtil.storageSet('sessionTable', 'keshizhureng')
            router.push('/index')
          } else {
            ElMessage.error(data.msg)
          }
        })
      }
    }
  })
}
</script> 