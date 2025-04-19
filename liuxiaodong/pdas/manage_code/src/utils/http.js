import axios from 'axios'
import router from '../router/index'
import toolUtil from '@/utils/toolUtil'
import config from '@/utils/config'
import { ElMessage } from 'element-plus'

const http = axios.create({
    timeout: 1000 * 86400,
    withCredentials: true,
    baseURL: process.env.VUE_APP_BASE_API,
    headers: {
        'Content-Type': 'application/json; charset=utf-8'
    }
})
// 请求拦截
http.interceptors.request.use(config => {
    // 添加日志
    console.log("发送请求:", config.url, config.method, config.data || config.params);
    
    config.headers['Token'] = toolUtil.storageGet('Token') // 请求头带上token
    return config
}, error => {
    console.error("请求错误:", error);
    return Promise.reject(error)
})
// 响应拦截
http.interceptors.response.use(response => {
    // 添加日志
    console.log("收到响应:", response.config.url, response.status, response.data);
    
    if (response.data && response.data.code == 401) { // 401, token失效
		toolUtil.storageClear()
		ElMessage.error({
            message:response.data.msg,
            grouping:true,
            repeatNum:-99,
        })
        router.push('/login')
		return Promise.reject(response)
    }
	else if(response.data && response.data.code == 0){
		return response
	}else{
		ElMessage.error({
            message:response.data.msg,
            grouping:true,
            repeatNum:-99,
        })
		return Promise.reject(response)
	}
    
}, error => {
    console.error("响应错误:", error);
    return Promise.reject(error)
})
export default http