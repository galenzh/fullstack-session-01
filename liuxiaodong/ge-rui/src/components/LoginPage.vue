<template>
  <div class="login-page">
    <!-- 顶部 Logo -->
    <div class="header-logo">
      <img src="/images/logo_ag.svg" alt="格睿 Logo" />
    </div>

    <!-- 中间部分 -->
    <div class="main-content">
      <div class="logo-and-text">
        <img class="main-logo" src="/images/logo_ag.svg" alt="主 Logo" />
        <h1>{{ mainTitle }}</h1>
        <p>{{ subtitle }}</p>
      </div>
    </div>

    <!-- 登录框 -->
    <div class="login-box">
      <h2>密码登录</h2>
      <form @submit.prevent="handleLogin">
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
        <div class="form-options">
          <label>
            <input type="checkbox" v-model="rememberMe" /> 记住密码
          </label>
          <a href="#">忘记密码？</a>
        </div>
        <button type="submit" class="btn-login">登录</button>
      </form>
      <div class="register-link">
        还没有账号？<a href="#">立即注册</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '',
      password: '',
      rememberMe: false,
      mainTitle: '基因变异快速传分析与解读工作站',
      subtitle: 'Integrated Genetic Rapid Analysis & Interpretation',
    };
  },
  methods: {
    handleLogin() {
      if (this.username) {
        this.mainTitle = `欢迎使用，${this.username}`;
        this.subtitle = '您已成功登录工作站';
        alert(`登录成功，欢迎 ${this.username}`);
      } else {
        alert('请输入用户名和密码！');
      }
    },
  },
};
</script>

<style>
/* 保持背景不变 */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  height: 100vh;
  background: url('~@/../public/images/bg.png') no-repeat center center fixed;
  background-size: cover;
  color: #fff;
}

.login-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
}


.header-logo {
  position: absolute;
  top: 20px;
  right: 20px;
}

.header-logo img {
  width: 120px;
}

/* 其余样式省略，与之前一致 */
</style>