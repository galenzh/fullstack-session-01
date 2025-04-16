import { createRouter, createWebHistory } from 'vue-router';
import LoginPage from '../components/LoginPage.vue';
import RegisterPage from '../components/RegisterPage.vue';
import PasswordChangePage from '../components/ChangePasswordPage.vue'; 

const routes = [
  {
    path: '/',
    name: 'Login',
    component: LoginPage,
  },
  {
    path: '/register',
    name: 'Register',
    component: RegisterPage,
  },
  {
    path: '/change-password', 
    name: 'PasswordChange',
    component: PasswordChangePage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
