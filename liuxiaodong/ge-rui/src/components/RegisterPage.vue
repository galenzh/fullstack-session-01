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

      <!-- 注册框部分 -->
      <div class="login-box">
        <h2>用户注册</h2>
        <form @submit.prevent="handleRegister">
          <div class="form-group">
            <label for="username">用户名</label>
            <input v-model="username" type="text" id="username" placeholder="请输入用户名" />
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input v-model="password" type="password" id="password" placeholder="请输入密码" />
          </div>
          <div class="form-group">
            <label for="confirmPassword">确认密码</label>
            <input v-model="confirmPassword" type="password" id="confirmPassword" placeholder="请再次输入密码" />
          </div>
          <div class="form-group">
            <label for="phone">手机号</label>
            <input v-model="phone" type="text" id="phone" placeholder="请输入手机号" />
          </div>
          <div class="form-group">
            <label for="captcha">验证码</label>
            <input v-model="captcha" type="text" id="captcha" placeholder="请输入验证码" />
            <button type="button" @click="sendCaptcha" class="btn-captcha">获取验证码</button>
          </div>
          <button type="submit" class="btn-login">注册</button>
        </form>
        <div class="register-link">
          已有账号？<router-link to="/login">立即登录</router-link>
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
      confirmPassword: "", // 确认密码
      phone: "", // 手机号
      captcha: "", // 验证码
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
          page: "register",
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

    // 发送验证码（这里只是模拟，实际项目中需要与后端接口对接）
    sendCaptcha() {
      if (this.phone) {
        alert("验证码已发送至您的手机号！");
        // 在这里可以通过 Axios 调用发送验证码的接口
        // axios.post('/api/send-captcha', { phone: this.phone })
        //   .then(response => { ... });
      } else {
        alert("请输入手机号！");
      }
    },

    // 注册处理逻辑
    handleRegister() {
      // 简单表单验证
      if (!this.username || !this.password || !this.confirmPassword || !this.phone || !this.captcha) {
        alert("所有字段不能为空！");
        return;
      }
      if (this.password !== this.confirmPassword) {
        alert("密码和确认密码不一致！");
        return;
      }
      const phonePattern = /^[1][3-9][0-9]{9}$/; // 手机号正则
      if (!phonePattern.test(this.phone)) {
        alert("请输入有效的手机号！");
        return;
      }

      // 假设后端注册接口
      axios
        .post("http://114.242.62.62:8808/api/get_page_setting/", {
          username: this.username,
          password: this.password,
          phone: this.phone,
          captcha: this.captcha,
        })
        .then((response) => {
          if (response.status === 200 && response.data.code === 200) {
            alert("注册成功！");
            this.$router.push("/login"); // 注册成功后跳转到登录页面
          } else {
            alert(response.data.msg || "注册失败，请稍后重试！");
          }
        })
        .catch((error) => {
          console.error("注册请求错误:", error);
          alert("无法连接到服务器，请检查网络！");
        });
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

/* 注册框样式 */
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

.btn-captcha {
  background: #ccc;
  padding: 8px 12px;
  font-size: 14px;
  border: none;
  cursor: pointer;
  border-radius: 5px;
  color: #fff;
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
