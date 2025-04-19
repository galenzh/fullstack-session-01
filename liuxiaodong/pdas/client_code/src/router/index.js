import { createRouter, createWebHashHistory } from 'vue-router'
import index from '../views'
import home from '../views/pages/home.vue'
import login from '../views/pages/login.vue'
import newsList from '@/views/pages/news/list'
import messagesList from '@/views/pages/messages/list'
import yonghuList from '@/views/pages/yonghu/list'
import yonghuDetail from '@/views/pages/yonghu/formModel'
import yonghuAdd from '@/views/pages/yonghu/formAdd'
import yonghuRegister from '@/views/pages/yonghu/register'
import yonghuCenter from '@/views/pages/yonghu/center'
import zixunshiList from '@/views/pages/zixunshi/list'
import zixunshiDetail from '@/views/pages/zixunshi/formModel'
import zixunshiAdd from '@/views/pages/zixunshi/formAdd'
import storeupList from '@/views/pages/storeup/list'
import chatMessageList from '@/views/pages/chatMessage/list'
import chatMessageDetail from '@/views/pages/chatMessage/formModel'
import chatMessageAdd from '@/views/pages/chatMessage/formAdd'
import chatFriendList from '@/views/pages/chatFriend/list'
import chatFriendDetail from '@/views/pages/chatFriend/formModel'
import chatFriendAdd from '@/views/pages/chatFriend/formAdd'
import zixunshiyuyueList from '@/views/pages/zixunshiyuyue/list'
import zixunshiyuyueDetail from '@/views/pages/zixunshiyuyue/formModel'
import zixunshiyuyueAdd from '@/views/pages/zixunshiyuyue/formAdd'
import xinlijiankangxuexiList from '@/views/pages/xinlijiankangxuexi/list'
import xinlijiankangxuexiDetail from '@/views/pages/xinlijiankangxuexi/formModel'
import xinlijiankangxuexiAdd from '@/views/pages/xinlijiankangxuexi/formAdd'
import ceshipingfenList from '@/views/pages/ceshipingfen/list'
import ceshipingfenDetail from '@/views/pages/ceshipingfen/formModel'
import ceshipingfenAdd from '@/views/pages/ceshipingfen/formAdd'
import forumList from '@/views/pages/forum/list'
import jiankangjianyiList from '@/views/pages/jiankangjianyi/list'
import jiankangjianyiDetail from '@/views/pages/jiankangjianyi/formModel'
import jiankangjianyiAdd from '@/views/pages/jiankangjianyi/formAdd'
import gaopinggongjuList from '@/views/pages/gaopinggongju/list'
import gaopinggongjuDetail from '@/views/pages/gaopinggongju/formModel'
import gaopinggongjuAdd from '@/views/pages/gaopinggongju/formAdd'
import kechengleixingList from '@/views/pages/kechengleixing/list'
import kechengleixingDetail from '@/views/pages/kechengleixing/formModel'
import kechengleixingAdd from '@/views/pages/kechengleixing/formAdd'
import kechengxinxiList from '@/views/pages/kechengxinxi/list'
import kechengxinxiDetail from '@/views/pages/kechengxinxi/formModel'
import kechengxinxiAdd from '@/views/pages/kechengxinxi/formAdd'
import cartList from '@/views/pages/shop_order/cart'
import addressList from '@/views/pages/shop_address/list'
import ceshibaogaoList from '@/views/pages/ceshibaogao/list'
import ceshibaogaoDetail from '@/views/pages/ceshibaogao/formModel'
import ceshibaogaoAdd from '@/views/pages/ceshibaogao/formAdd'
import chathelperList from '@/views/pages/chathelper/list'
import chathelperDetail from '@/views/pages/chathelper/formModel'
import chathelperAdd from '@/views/pages/chathelper/formAdd'
import emailregistercodeList from '@/views/pages/emailregistercode/list'
import emailregistercodeDetail from '@/views/pages/emailregistercode/formModel'
import emailregistercodeAdd from '@/views/pages/emailregistercode/formAdd'
import exampaperList from '@/views/pages/exam/exampaperList'
import examination from '@/views/pages/exam/examination'
import examrecordList from '@/views/pages/exam/examrecordList'
import examfailrecord from '@/views/pages/exam/examfailrecord'
import order_confirm from '@/views/pages/shop_order/confirm'
import ordersList from '@/views/pages/shop_order/list'

const routes = [{
		path: '/',
		redirect: '/index/home'
	},
	{
		path: '/index',
		component: index,
		children: [{
			path: 'home',
			component: home
		}
		, {
			path: 'newsList',
			component: newsList
		}
		, {
			path: 'messagesList',
			component: messagesList
		}
		, {
			path: 'yonghuList',
			component: yonghuList
		}, {
			path: 'yonghuDetail',
			component: yonghuDetail
		}, {
			path: 'yonghuAdd',
			component: yonghuAdd
		}
		, {
			path: 'yonghuCenter',
			component: yonghuCenter
		}
		, {
			path: 'zixunshiList',
			component: zixunshiList
		}, {
			path: 'zixunshiDetail',
			component: zixunshiDetail
		}, {
			path: 'zixunshiAdd',
			component: zixunshiAdd
		}
        , {
            path: 'storeupList',
            component: storeupList
        }
		, {
			path: 'chatMessageList',
			component: chatMessageList
		}, {
			path: 'chatMessageDetail',
			component: chatMessageDetail
		}, {
			path: 'chatMessageAdd',
			component: chatMessageAdd
		}
		, {
			path: 'chatFriendList',
			component: chatFriendList
		}, {
			path: 'chatFriendDetail',
			component: chatFriendDetail
		}, {
			path: 'chatFriendAdd',
			component: chatFriendAdd
		}
		, {
			path: 'zixunshiyuyueList',
			component: zixunshiyuyueList
		}, {
			path: 'zixunshiyuyueDetail',
			component: zixunshiyuyueDetail
		}, {
			path: 'zixunshiyuyueAdd',
			component: zixunshiyuyueAdd
		}
		, {
			path: 'xinlijiankangxuexiList',
			component: xinlijiankangxuexiList
		}, {
			path: 'xinlijiankangxuexiDetail',
			component: xinlijiankangxuexiDetail
		}, {
			path: 'xinlijiankangxuexiAdd',
			component: xinlijiankangxuexiAdd
		}
		, {
			path: 'ceshipingfenList',
			component: ceshipingfenList
		}, {
			path: 'ceshipingfenDetail',
			component: ceshipingfenDetail
		}, {
			path: 'ceshipingfenAdd',
			component: ceshipingfenAdd
		}
		, {
			path: 'forumList',
			component: forumList
		}
		, {
			path: 'jiankangjianyiList',
			component: jiankangjianyiList
		}, {
			path: 'jiankangjianyiDetail',
			component: jiankangjianyiDetail
		}, {
			path: 'jiankangjianyiAdd',
			component: jiankangjianyiAdd
		}
		, {
			path: 'gaopinggongjuList',
			component: gaopinggongjuList
		}, {
			path: 'gaopinggongjuDetail',
			component: gaopinggongjuDetail
		}, {
			path: 'gaopinggongjuAdd',
			component: gaopinggongjuAdd
		}
		, {
			path: 'kechengleixingList',
			component: kechengleixingList
		}, {
			path: 'kechengleixingDetail',
			component: kechengleixingDetail
		}, {
			path: 'kechengleixingAdd',
			component: kechengleixingAdd
		}
		, {
			path: 'kechengxinxiList',
			component: kechengxinxiList
		}, {
			path: 'kechengxinxiDetail',
			component: kechengxinxiDetail
		}, {
			path: 'kechengxinxiAdd',
			component: kechengxinxiAdd
		}
		, {
			path: 'cartList',
			component: cartList
		}
		, {
			path: 'addressList',
			component: addressList
		}
		, {
			path: 'ceshibaogaoList',
			component: ceshibaogaoList
		}, {
			path: 'ceshibaogaoDetail',
			component: ceshibaogaoDetail
		}, {
			path: 'ceshibaogaoAdd',
			component: ceshibaogaoAdd
		}
		, {
			path: 'chathelperList',
			component: chathelperList
		}, {
			path: 'chathelperDetail',
			component: chathelperDetail
		}, {
			path: 'chathelperAdd',
			component: chathelperAdd
		}
		, {
			path: 'emailregistercodeList',
			component: emailregistercodeList
		}, {
			path: 'emailregistercodeDetail',
			component: emailregistercodeDetail
		}, {
			path: 'emailregistercodeAdd',
			component: emailregistercodeAdd
		}
		, {
			path: 'exampaperList',
			component: exampaperList
		}, {
			path: 'examrecordList',
			component: examrecordList
		}, {
			path: 'examfailrecord',
			component: examfailrecord
		}
		, {
			path: 'order_confirm',
			component: order_confirm
		}
		, {
			path: 'ordersList',
			component: ordersList
		}
		]
	},
	{
		path: '/login',
		component: login
	}
	,{
		path: '/yonghuRegister',
		component: yonghuRegister
	}
	, {
		path: '/examination',
		component: examination
	}
	, {
		path: '/doctor/appointment',
		name: 'DoctorAppointment',
		component: () => import('@/views/pages/doctor/appointment.vue'),
		meta: { title: '医生预约' }
	}
]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})

export default router
