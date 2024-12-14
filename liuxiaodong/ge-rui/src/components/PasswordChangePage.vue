<template>
  <div class="content-wrapper" :style="{ backgroundImage: `url(${backgroundPicture})` }">
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

    <!-- 右侧修改密码框 -->
    <div class="login-box">
      <h2>密码修改</h2>
      <form @submit.prevent="handlePasswordChange">
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
          <label for="oldPassword">旧密码</label>
          <input
            v-model="oldPassword"
            type="password"
            id="oldPassword"
            placeholder="请输入旧密码"
          />
        </div>
        <div class="form-group">
          <label for="newPassword">新密码</label>
          <input
            v-model="newPassword"
            type="password"
            id="newPassword"
            placeholder="请输入新密码"
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
        <button type="submit" class="btn-login">修改密码</button>
      </form>
      <div class="register-link">
        <router-link to="/">返回登录</router-link>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      logo: "",
      backgroundPicture: "",
      mainTitle: "默认主标题",
      subTitle: "默认副标题",
      username: "",
      oldPassword: "",
      newPassword: "",
      captcha: "",
    };
  },
  created() {
    this.fetchPageSettings();
  },
  methods: {
    // 获取页面设置
    fetchPageSettings() {
      axios
        .post("http://114.242.62.62:8808/api/get_page_setting/", {
          Gkey: "kaiumph",
          page: "password_change",
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

    // 处理密码修改逻辑
    handlePasswordChange() {
      if (!this.username || !this.oldPassword || !this.newPassword || !this.captcha) {
        alert("请完整填写所有信息！");
        return;
      }

      // 验证码校验（模拟校验）
      if (this.captcha !== "1234") {
        alert("验证码错误！");
        return;
      }

      // 模拟提交数据
      alert(`密码修改成功，欢迎 ${this.username}！`);
      this.$router.push("/"); // 修改成功后跳转到登录页面
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

/* 修改密码框样式 */
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
  text-decoration: none;
}

.register-link a:hover {
  text-decoration: underline;
}
</style>
