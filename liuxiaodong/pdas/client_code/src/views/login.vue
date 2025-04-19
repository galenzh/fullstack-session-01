<template>
  <div class="main">
    <div class="login-form-wrap">
      <div class="title">人格障碍诊断系统的设计与实现登录</div>
      <div class="list-item">
        <div class="account">
          <div class="label">用户类型：</div>
          <div class="list">
            <el-select v-model="ruleForm.loginType" placeholder="请选择用户类型">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              ></el-option>
            </el-select>
          </div>
        </div>
      </div>
      <!-- 其他表单项... -->
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      options: [
        {
          value: '管理员',
          label: '管理员'
        },
        {
          value: '用户',
          label: '用户'
        },
        {
          value: '咨询师',
          label: '咨询师'
        },
        {
          value: '科室主任',
          label: '科室主任'
        }
      ],
      // 其他数据...
    };
  },
  // 其他方法...
}
</script> 