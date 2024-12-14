<template>
  <div class="content-wrapper">
    <!-- 顶部右上角 Logo -->
    <div class="header-logo">
      <img src="/images/logo_ag.svg" alt="顶部Logo" />
    </div>

    <!-- 左侧部分 -->
    <div class="main-content">
      <img class="main-logo" src="/images/logo_ag.svg" alt="格睿 Logo" />
      <h1>基因变异快速遗传分析与解读工作站</h1>
      <p>Integrated Genetic Rapid Analysis & Interpretation</p>
      <button class="main-button">全新上线</button>
    </div>

    <!-- 右侧注册框 -->
    <div class="login-box">
      <img class="top-logo" src="/images/logo_ag.svg" alt="格睿 Logo" />
      <h2>用户注册</h2>
      <form @submit.prevent="handleRegister">
        <div class="form-group">
          <label for="username">用户名</label>
          <input
            v-model="username"
            type="text"
            id="username"
            placeholder="请输入用户名"
          />
        </div>
        <div class="form-group">
          <label for="password">密码</label>
          <input
            v-model="password"
            type="password"
            id="password"
            placeholder="请输入密码"
          />
        </div>
        <div class="form-group">
          <label for="confirmPassword">确认密码</label>
          <input
            v-model="confirmPassword"
            type="password"
            id="confirmPassword"
            placeholder="请再次输入密码"
          />
        </div>
        <div class="form-group">
          <label for="phone">手机号</label>
          <input
            v-model="phone"
            type="text"
            id="phone"
            placeholder="请输入手机号"
          />
        </div>
        <div class="form-group">
          <label for="captcha">验证码</label>
          <input
            v-model="captcha"
            type="text"
            id="captcha"
            placeholder="请输入验证码"
          />
        </div>
        <button type="submit" class="btn-login">注册</button>
      </form>
      <div class="register-link">
        已有账号？<router-link to="/">立即登录</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: "",
      password: "",
      confirmPassword: "",
      phone: "",
      captcha: "",
    };
  },
  methods: {
    handleRegister() {
      if (
        this.username &&
        this.password &&
        this.confirmPassword &&
        this.phone &&
        this.captcha
      ) {
        if (this.password !== this.confirmPassword) {
          alert("两次密码输入不一致！");
        } else {
          alert(`注册成功，欢迎 ${this.username}！`);
        }
      } else {
        alert("请完整填写所有信息！");
      }
    },
  },
};
</script>

<style>
/* 样式保持一致 */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  height: 100vh;
  background: url("@/../public/images/bg.png") no-repeat center center fixed;
  background-size: cover;
  color: #fff;
  display: flex;
  justify-content: center;
  align-items: center;
}

.content-wrapper {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 80%;
  max-width: 1200px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

.header-logo {
  position: fixed;
  top: 20px;
  right: 40px;
  z-index: 10;
}

.header-logo img {
  width: 60px;
}

.main-content {
  flex: 1;
  text-align: left;
}

.main-logo {
  width: 120px;
  margin-bottom: 20px;
}

.main-content h1 {
  font-size: 30px;
  color: #fff;
}

.main-content p {
  font-size: 16px;
  color: #ddd;
}

.main-button {
  padding: 12px 30px;
  background-color: transparent;
  color: white;
  border: 2px solid white;
  border-radius: 25px;
  font-size: 16px;
  cursor: pointer;
}

.main-button:hover {
  background-color: white;
  color: #007bff;
}

.login-box {
  flex-shrink: 0;
  background: #fff;
  width: 360px;
  padding: 25px 30px;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  color: #333;
}

.login-box h2 {
  font-size: 22px;
  text-align: center;
  color: #333;
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

.btn-login {
  width: 100%;
  padding: 10px;
  background: #007bff;
  color: #fff;
  font-size: 16px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.btn-login:hover {
  background: #0056b3;
}

.register-link {
  text-align: center;
  margin-top: 10px;
}

.register-link a {
  color: #007bff;
}
</style>
