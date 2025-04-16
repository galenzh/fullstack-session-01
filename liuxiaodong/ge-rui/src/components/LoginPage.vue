<template>
  <div class="login-bg" :style="{ backgroundImage: `url(${backgroundPicture})` }">
    <div class="content-wrapper">
      <!-- 顶部右上角 Logo -->
      <div class="header-logo">
        <img :src="logo" alt="顶部Logo" />
      </div>

      <!-- 左侧内容部分 -->
      <div class="main-content">
        <img class="main-logo" :src="logo" alt="主Logo" />
        <h1>{{ mainTitle }}</h1>
        <p>{{ subTitle }}</p>
      </div>

      <!-- 登录框部分 -->
      <div class="login-box">
        <h2>密码登录</h2>
        <form @submit.prevent="handleLogin">
          <div class="form-group">
            <label for="username">用户名</label>
            <input v-model="username" type="text" id="username" placeholder="请输入用户名" />
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input v-model="password" type="password" id="password" placeholder="请输入密码" />
          </div>
          <div class="form-options">
            <label>
              <input type="checkbox" v-model="rememberMe" /> 记住密码
            </label>
            <router-link to="/change_password">忘记密码？</router-link>
          </div>
          <button type="submit" class="btn-login">登录</button>
        </form>
        <div class="register-link">
          还没有账号？<router-link to="/register">立即注册</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      logo: "", // 动态加载的顶部 Logo
      backgroundPicture: "", // 动态加载的背景图片
      mainTitle: "默认主标题", // 主标题
      subTitle: "默认副标题", // 副标题
      username: "", // 用户名
      password: "", // 密码
      rememberMe: false, // 是否记住密码
    };
  },
  created() {
    this.fetchPageSettings();
  },
  methods: {
    // 获取页面动态内容
    fetchPageSettings() {
      axios
        .post("http://114.242.62.62:8808/api/get_page_setting/", {
          Gkey: "kaiumph",
          page: "login",
        })
        .then((response) => {
          if (response.status === 200 && response.data.code === 200) {
            const data = response.data.msg;
            this.logo = data.logo || "";
            this.backgroundPicture = data.background_picture || "";
            [this.mainTitle, this.subTitle] = data.maintext
              ? data.maintext.split("\r\n")
              : ["默认主标题", "默认副标题"];
          } else {
            alert("获取页面信息失败，请稍后重试！");
          }
        })
        .catch((error) => {
          console.error("API请求错误:", error);
          alert("无法连接到服务器，请检查网络！");
        });
    },

    // 登录处理逻辑
    handleLogin() {
      if (this.username && this.password) {
        this.mainTitle = `欢迎，${this.username}！探索基因奥秘`;
        this.subTitle = "开始您的专属基因之旅！";
        if (this.rememberMe) {
          localStorage.setItem("username", this.username);
        }
        alert(`登录成功！欢迎 ${this.username}！`);
      } else {
        alert("请输入用户名和密码！");
      }
    },
  },
};
</script>

<style>
/* 页面背景 */
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  height: 100vh;
  background-color: #f0f2f5;
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-bg {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background-size: cover;
  background-position: center;
}

/* 主容器样式 */
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

/* 顶部右上角 Logo */
.header-logo {
  position: fixed;
  top: 20px;
  right: 40px;
}

.header-logo img {
  width: 60px;
}

/* 左侧内容部分 */
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

/* 登录框样式 */
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

.form-options {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
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
  text-decoration: none;
}

.register-link a:hover {
  text-decoration: underline;
}
</style>
