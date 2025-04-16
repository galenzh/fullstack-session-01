const config = {
    get() {
        return {
            url : process.env.VUE_APP_BASE_API_URL + process.env.VUE_APP_BASE_API + '/',
            name: process.env.VUE_APP_BASE_API,
			menuList:[
				{
					name: '心理健康学习',
					icon: '',
					child:[

						{
							name:'心理健康学习',
                            url:'/index/xinlijiankangxuexiList'

						},
					]
				},
				{
					name: '咨询师',
					icon: '',
					child:[

						{
							name:'咨询师',
                            url:'/index/zixunshiList'

						},
					]
				},
				{
					name: '在线测试',
					icon: 'icon-common43',
					child:[

						{
							name:'在线测试',
                            url:'/index/exampaperList'

						},
					]
				},
				{
					name: '论坛交流',
					icon: 'icon-common49',
					child:[

						{
							name:'论坛交流',
                            url:'/index/forumList'

						},
					]
				},
				{
					name: '反馈建议',
					icon: '',
					child:[

						{
							name:'反馈建议',
                            url:'/index/messagesList'

						},
					]
				},
				{
					name: '心理资讯',
					icon: '',
					child:[

						{
							name:'心理资讯',
                            url:'/index/newsList'

						},
					]
				},
				{
					name: '课程信息管理',
					icon: '',
					child:[

						{
							name:'课程信息',
                            url:'/index/kechengxinxiList'

						},
					]
				},
				{
					name: '客服聊天管理',
					icon: '',
					child:[
						{
							name:'客服聊天',
							url:'chat'
						},
					]
				},
				{
					name: '高评工具管理',
					                  icon: '',
					                  child:[

						{
							name:'高评工具',
                            url:'/index/gaopinggongjuList'

						},
					]
				},
			]
        }
    },
    getProjectName(){
        return {
            projectName: `人格障碍诊断系统的设计与实现`
        } 
    }
}
export default config
