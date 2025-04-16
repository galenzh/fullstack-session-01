	import {
		createRouter,
		createWebHashHistory
	} from 'vue-router'
	import ceshibaogao from '@/views/ceshibaogao/list'
	import xinlijiankangxuexi from '@/views/xinlijiankangxuexi/list'
	import examquestion from '@/views/exam/examquestion/list'
	import discussxinlijiankangxuexi from '@/views/discussxinlijiankangxuexi/list'
	import storeup from '@/views/storeup/list'
	import zixunshiyuyue from '@/views/zixunshiyuyue/list'
	import cart from '@/views/cart/list'
	import chathelper from '@/views/chathelper/list'
	import zixunshi from '@/views/zixunshi/list'
	import chatFriend from '@/views/chatFriend/list'
	import yonghu from '@/views/yonghu/list'
	import discussgaopinggongju from '@/views/discussgaopinggongju/list'
	import news from '@/views/news/list'
	import address from '@/views/address/list'
	import gaopinggongju from '@/views/gaopinggongju/list'
	import exampaper from '@/views/exampaper/list'
	import discusskechengxinxi from '@/views/discusskechengxinxi/list'
	import kechengxinxi from '@/views/kechengxinxi/list'
	import users from '@/views/users/list'
	import kechengleixing from '@/views/kechengleixing/list'
	import chatMessage from '@/views/chatMessage/list'
	import forum from '@/views/forum/list'
	import ceshipingfen from '@/views/ceshipingfen/list'
	import jiankangjianyi from '@/views/jiankangjianyi/list'
	import chat from '@/views/chat/list'
	import messages from '@/views/messages/list'
	import orders from '@/views/orders/list'
	import examquestionbank from '@/views/exam/examquestionbank/list'
	import config from '@/views/config/list'
	import exampaperlist from '@/views/exam/exampaperlist/list'
	import examination from '@/views/exam/exampaperlist/examination'
	import examrecord from '@/views/exam/examrecord/list'
	import examfailrecord from '@/views/exam/examfailrecord/list'
	import usersCenter from '@/views/users/center'
	import zixunshiRegister from '@/views/zixunshi/register'
	import zixunshiCenter from '@/views/zixunshi/center'
	import keshizhureng from '@/views/keshizhureng/list'
	import keshizhurengCenter from '@/views/keshizhureng/center'

export const routes = [{
		path: '/login',
		name: 'login',
		component: () => import('../views/login.vue')
	},{
		path: '/',
		name: '首页',
		component: () => import('../views/index'),
		children: [{
			path: '/',
			name: '首页',
			component: () => import('../views/HomeView.vue'),
			meta: {
				affix: true
			}
		}, {
			path: '/updatepassword',
			name: '修改密码',
			component: () => import('../views/updatepassword.vue')
		}
		
		,{
			path: '/usersCenter',
			name: '管理员个人中心',
			component: usersCenter
		}
		,{
			path: '/zixunshiCenter',
			name: '咨询师个人中心',
			component: zixunshiCenter
		}
		,{
			path: '/ceshibaogao',
			name: '测试报告',
			component: ceshibaogao
		}
		,{
			path: '/xinlijiankangxuexi',
			name: '心理健康学习',
			component: xinlijiankangxuexi
		}
		,{
			path: '/examquestion',
			name: '试题管理',
			component: examquestion
		}
		,{
			path: '/discussxinlijiankangxuexi',
			name: '心理健康学习评论-评论',
			component: discussxinlijiankangxuexi
		}
		,{
			path: '/storeup',
			name: '我的收藏',
			component: storeup
		}
		,{
			path: '/zixunshiyuyue',
			name: '咨询师预约',
			component: zixunshiyuyue
		}
		,{
			path: '/cart',
			name: '购物车',
			component: cart
		}
		,{
			path: '/chathelper',
			name: '聊天助手',
			component: chathelper
		}
		,{
			path: '/zixunshi',
			name: '咨询师',
			component: zixunshi
		}
		,{
			path: '/chatFriend',
			name: '好友表',
			component: chatFriend
		}
		,{
			path: '/yonghu',
			name: '用户',
			component: yonghu
		}
		,{
			path: '/discussgaopinggongju',
			name: '高评工具评论-评论',
			component: discussgaopinggongju
		}
		,{
			path: '/news',
			name: '心理资讯',
			component: news
		}
		,{
			path: '/address',
			name: '地址',
			component: address
		}
		,{
			path: '/gaopinggongju',
			name: '高评工具',
			component: gaopinggongju
		}
		,{
			path: '/exampaper',
			name: '在线测试',
			component: exampaper
		}
		,{
			path: '/discusskechengxinxi',
			name: '课程信息评论-评论',
			component: discusskechengxinxi
		}
		,{
			path: '/kechengxinxi',
			name: '课程信息',
			component: kechengxinxi
		}
		,{
			path: '/users',
			name: '管理员',
			component: users
		}
		,{
			path: '/kechengleixing',
			name: '课程类型',
			component: kechengleixing
		}
		,{
			path: '/chatMessage',
			name: '消息表',
			component: chatMessage
		}
		,{
			path: '/forum',
			name: '我的发布',
			component: forum
		}
		,{
			path: '/ceshipingfen',
			name: '测试评分',
			component: ceshipingfen
		}
		,{
			path: '/jiankangjianyi',
			name: '健康建议',
			component: jiankangjianyi
		}
		,{
			path: '/chat',
			name: '客服聊天',
			component: chat
		}
		,{
			path: '/messages',
			name: '反馈建议',
			component: messages
		}
		,{
			path: '/orders',
			name: '订单管理',
			component: orders
		}
		,{
			path: '/examquestionbank',
			name: '试题库管理',
			component: examquestionbank
		}
		,{
			path: '/config',
			name: '轮播图',
			component: config
		}
		, {
			path: '/exampaperlist',
			name: '考试列表',
			component: exampaperlist
		}, {
			path: '/examrecord',
			name: '考试记录',
			component: examrecord
		}, {
			path: '/examfailrecord',
			name: '错题本',
			component: examfailrecord
		}
		]
	},
	{
		path: '/zixunshiRegister',
		name: '咨询师注册',
		component: zixunshiRegister
	},
	{
		path: '/examination',
		name: '考试',
		component: examination
	},
	{
		path: '/keshizhureng',
		name: '科室主任管理',
		component: keshizhureng
	},
	{
		path: '/keshizhurengCenter',
		name: '科室主任个人中心',
		component: keshizhurengCenter
	}
]

const router = createRouter({
	history: createWebHashHistory(process.env.BASE_URL),
	routes
})

export default router
