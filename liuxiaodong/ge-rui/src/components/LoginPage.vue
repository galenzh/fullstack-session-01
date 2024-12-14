<template>
  <div class="content-wrapper">
    <!-- 左侧部分 -->
    <div class="main-content">
      <img class="main-logo" src="/images/logo_ag.svg" alt="格睿 Logo" />
      <h1>{{ dynamicTitle }}</h1>
      <p>{{ subTitle }}</p>
      <button class="main-button">全新上线</button>
    </div>

    <!-- 右侧登录框 -->
    <div class="login-box">
      <img class="top-logo" src="@/../public/images/logo_ag.svg" alt="格睿 Logo" />
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
      username: "",
      password: "",
      rememberMe: false,
      mainTitle: "基因变异快速遗传分析与解读工作站",
      subTitle: "Integrated Genetic Rapid Analysis & Interpretation",
      dynamicTitle: "基因变异快速遗传分析与解读工作站", // 默认标题
    };
  },
  watch: {
    username(newVal) {
      this.dynamicTitle = newVal
        ? `欢迎，${newVal}！探索基因奥秘`
        : "基因变异快速遗传分析与解读工作站";
    },
  },
  methods: {
    handleLogin() {
      if (this.username && this.password) {
        alert(`欢迎登录，${this.username}！`);
      } else {
        alert("请输入用户名和密码！");
      }
    },
  },
};
</script>

<style>
/* 全局背景 */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  height: 100vh;
  background: url("@/../public/images/bg.png") no-repeat center center fixed;
  background-size: cover;
  display: flex;
  justify-content: center;
  align-items: center;
  color: #fff;
}

/* 主容器 Flex 布局 */
.content-wrapper {
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

/* 左侧内容 */
.main-content {
  flex: 1;
  padding-right: 50px;
  text-align: left;
}

.main-logo {
  width: 120px;
  margin-bottom: 20px;
}

.main-content h1 {
  font-size: 30px;
  font-weight: bold;
  line-height: 1.4;
  margin-bottom: 15px;
  color: #fff;
}

.main-content p {
  font-size: 16px;
  color: #ddd;
  margin-bottom: 25px;
}

.main-button {
  padding: 12px 30px;
  background-color: transparent;
  color: white;
  border: 2px solid white;
  border-radius: 25px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.main-button:hover {
  background-color: white;
  color: #007bff;
}

/* 右上角 Logo */
.top-logo {
  width: 100px;
  margin: 0 auto 20px;
  display: block;
}

/* 右侧登录框 */
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
  font-weight: bold;
  margin-bottom: 20px;
  text-align: center;
  color: #333;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  font-size: 14px;
  margin-bottom: 5px;
  color: #666;
}

.form-group input {
  width: 100%;
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
  font-size: 14px;
  color: #333;
}

.form-group input:focus {
  outline: none;
  border-color: #3498db;
  box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
}

.btn-login {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 5px;
  background: #007bff;
  color: #fff;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.3s ease, transform 0.2s ease;
}

.btn-login:hover {
  background: #0056b3;
  transform: scale(1.05);
}

.form-options {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  margin-bottom: 15px;
}

.form-options a {
  color: #3498db;
  text-decoration: none;
}

.form-options a:hover {
  text-decoration: underline;
}

.register-link {
  text-align: center;
  font-size: 14px;
  margin-top: 10px;
}

.register-link a {
  color: #3498db;
  text-decoration: none;
}

.register-link a:hover {
  text-decoration: underline;
}
</style>
