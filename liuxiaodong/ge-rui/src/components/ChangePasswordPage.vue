<template>
  <div class="change-password-page">
    <h2>忘记密码</h2>
    <form @submit.prevent="handlePasswordReset">
      <div class="form-group">
        <label for="email">注册邮箱</label>
        <input v-model="email" type="email" id="email" placeholder="请输入注册邮箱" />
      </div>
      <div class="form-group">
        <label for="captcha">验证码</label>
        <input v-model="captcha" type="text" id="captcha" placeholder="请输入验证码" />
      </div>
      <button type="submit" class="btn-reset">重置密码</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      captcha: "",
    };
  },
  methods: {
    handlePasswordReset() {
      if (!this.email || !this.captcha) {
        alert("请填写完整信息！");
        return;
      }
      alert(`重置密码邮件已发送至 ${this.email}！`);
    },
  },
};
</script>

<style>
.change-password-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  font-size: 14px;
  color: #666;
}

.form-group input {
  width: 100%;
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
}

.btn-reset {
  padding: 10px 20px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-reset:hover {
  background-color: #0056b3;
}
</style>
