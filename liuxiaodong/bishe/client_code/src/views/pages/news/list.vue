<template>
	<div class="list-page news-page" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
        </div>
		<el-form inline :model="searchQuery" class="list_search">
			<div class="search_view">
				<div class="search_label">
					标题：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.title" placeholder="标题" clearable></el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn" type="primary" @click="searchClick">搜索</el-button>
			</div>
		</el-form>
		<div class="news_list_one">
			<div class="list-item animation_box" v-for="(item,index) in list" :key="index" @click="newsDetail(item.id)">
				<div class="news_img_box">
					<img class="news_img" :src="item.picture?$config.url + item.picture.split(',')[0] :''" alt="">
				</div>
				<div class="news_content">
					<div class="news_title"><span>{{item.title}}</span></div>
					<div class="news_intro">{{item.introduction}}</div>
					<div class="news_time">{{item.addtime.split(' ')[0]}}</div>
				</div>
			</div>
		</div>
		<el-pagination
			background 
			:layout="layouts.join(',')"
			:total="total" 
			:page-size="listQuery.limit"
            v-model:current-page="listQuery.page"
			prev-text="上一页"
			next-text="下一页"
			:hide-on-single-page="false"
			:style='{}'
			@size-change="sizeChange"
			@current-change="currentChange"/>
		
		
		<formModel ref="formModelRef"></formModel>
	</div>
</template>

<script setup>
	import moment from 'moment'
	import formModel from './formModel'
	import {
		ref,
		nextTick,
		getCurrentInstance
	} from 'vue';
	import {
		ElMessageBox
	} from 'element-plus'
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'news'
	const formName = '心理资讯'
	const router = useRouter()
	const route = useRoute()
	//基础信息
    const breadList = ref([{
        name: formName
    }])
	//权限验证
	const btnAuth = (e, a) => {
		return context?.$toolUtil.isAuth(e, a)
	}
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 20,
		sort: 'addtime',
		order: 'desc'
	})
	const searchQuery = ref({})
	//分页
	const layouts = ref(["total","prev","pager","next","sizes","jumper"])
	const total = ref(0)
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//分页
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if (searchQuery.value.title && searchQuery.value.title != '') {
			params['title'] = `%${searchQuery.value.title}%`
		}
		context?.$http({
			url: `news/list`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = res.data.data.total
		})
	}
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	const init = () => {
		if (route.query.centerType) {
			centerType.value = true
		}
		getList()
        nextTick(()=>{
            if(route.query.id){
                newsDetail(route.query.id)
            }
        })
	}
	//定义弹窗
	const formModelRef = ref(null)
	const newsDetail = (id = null) => {
		if (id) {
			formModelRef.value.init(id)
		}
	}
	init()
</script>

<style lang="scss" scoped>
	// 返回盒子
	.back_view {
		border-radius: 4px;
		padding: 10px 0px;
		margin: 10px auto;
		z-index: 999;
		background: none;
		width: 100%;
		text-align: right;
		// 返回按钮
		.back_btn {
			border: 1px solid #0076ca50;
			cursor: pointer;
			border-radius: 4px;
			padding: 0 24px;
			color: #0076ca;
			background: #fff;
			width: auto;
			font-size: 14px;
			height: 34px;
		}
		// 返回按钮-悬浮
		.back_btn:hover {
		}
	}
	//搜索
	.list_search {
		.search_view {
			.search_label {
			}
			.search_box {
				// 输入框
				:deep(.search_inp) {

				}
			}
		}
		.search_btn_view {
			// 搜索按钮
			.search_btn {
			}
			// 搜索按钮-悬浮
			.search_btn:hover {
			}
		}
	}
	.news_list_one {
		.list-item {
			.news_img_box {
				.news_img {
				}
			}
			.news_content {
				.news_title {
				}
				.news_intro {
				}
				.news_time {
				}
			}
		}
	}
	// animation
	.animation_box {
		transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		z-index: initial;
	}
	.animation_box:hover {
		-webkit-perspective: 1000px;
		perspective: 1000px;
		transition: 0.6s;
	}
	.animation_box img {
		transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		z-index: initial;
	}
	.animation_box img:hover {
		-webkit-perspective: 1000px;
		perspective: 1000px;
		transition: 0.6s;
	}
	// animation
	// 分页器
	.el-pagination {
		// 总页码
		:deep(.el-pagination__total) {
		}
		// 上一页
		:deep(.btn-prev) {
		}
		// 下一页
		:deep(.btn-next) {
		}
		// 上一页禁用
		:deep(.btn-prev:disabled) {
		}
		// 下一页禁用
		:deep(.btn-next:disabled) {
		}
		// 页码
		:deep(.el-pager) {
			// 数字
			.number {
			}
			// 数字悬浮
			.number:hover {
			}
			// 选中
			.number.is-active {
			}
		}
		// sizes
		:deep(.el-pagination__sizes) {
			.el-select {
				//去掉默认样式
				.select-trigger{
					height: 100%;
					.el-input{
						height: 100%;

					}
				}
			}
		}
		// 跳页
		:deep(.el-pagination__jump) {
			// 输入框
			.el-input {

			}
		}
	}
</style>
<style>

.news-page {
    width: 100%;
    margin: 0px auto;
    padding: 20px calc((100% - 1200px)/2);
    background: #eee;
    overflow: hidden;
    font-size: 16px;
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
}


.news-page .list_search{
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 30px auto 10px ;
    background: none;
}
.news-page .list_search .search_view{
    display: flex;
    align-items: center;
    justify-content: center;
    font-size:16px;
}
.news-page .list_search .search_view .search_label{
    white-space:nowrap;
}
.news-page .list_search .search_view .search_box .el-input .el-input__inner{
    background: #fff;
    border:0px solid #ddd;
    padding:0 10px;
    height:40px;
    line-height:40px;
    border-radius: 0px;
    min-width:500px;
}
.news-page .list_search .search_btn_view{
    margin-left:10px;
}
.news-page .list_search .search_btn_view .search_btn{
    min-width:80px;
    border:none;
    border-radius: 0px;
    font-size:15px;
    background: var(--theme);
}
.news-page .list_search .search_btn_view .search_btn:hover{
    opacity: 0.8;
}


.news-page .categorys{
    width:100%;
    display: flex;
    flex-wrap: wrap;
    background: #c3dee3;
    padding: 0px 10px;
    margin: 0px 0px 0px 0;
    order:-1;
}

.news-page .categorys .category{
    width:auto;
    padding: 10px;
    margin: 10px 20px 0px;
    box-sizing: border-box;
    background: var(--theme);
    cursor: pointer;
    border: 0px dashed #ccc;
    border-radius:30px 30px 0 0;
    color: #fff;
    text-align: center;
    min-width:90px;
}

.news-page .categorys .category:hover{
    background: #fff !important;
    color:var(--theme) !important;
    border-color: var(--theme) !important;
}

.news-page .categorys.categoryActive{
    background: #fff !important;
    color:var(--theme) !important;
    border-color: var(--theme) !important;
}



.news-page .news_list_one{
    padding: 0;
    width: calc(100% - 240px);
    margin: 20px 0 0;
    background:none;
    order:3;
    flex:1;
    display:flex;
    flex-wrap:wrap;
    justify-content:space-between;
}
.news-page .news_list_one .list-item{
    width: 49%;
    display: flex;
    margin: 0 0 30px;
    height: auto;
    background: rgb(255, 255, 255);
    justify-content: space-between;
    padding: 10px;
    cursor: pointer;
    background: #fff;
    border-radius: 30px 30px 30px 0;
    margin: 0 0 20px;
}
.news-page .news_list_one .list-item:nth-child(2n){
    border-radius: 30px 30px 0 30px;
} 
.news-page .news_list_one .list-item:nth-child(2n) .news_img_box{
    order:-1;
} 


.news-page .news_list_one .list-item .news_img_box{
    width: 130px;
    height: 130px;
    display: block;
    overflow:hidden;
    order:2;
}
.news-page .news_list_one .list-item .news_img_box .news_img{
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition:all 0.6s;
    border-radius: 30px;
}
.news-page .news_list_one .list-item:hover .news_img_box .news_img{
    transform:scale(1.05);
}


.news-page .news_list_one .list-item .news_content{
    width: calc(100% - 150px);
    position: relative;
}
.news-page .news_list_one .list-item .news_content .news_title{
    padding: 0 10px;
    line-height: 40px;
    color: #000;
    font-size: 15px;
    width: 100%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    font-weight: 500;
}
.news-page .news_list_one .list-item .news_content .news_intro{
    padding: 0px;
    line-height: 24px;
    color: #666;
    font-size: 14px;
    height: 48px;
    overflow: hidden;
    text-indent: 2em;
    display: block;
}
.news-page .news_list_one .list-item .news_content .news_time{
    padding: 5px 10px;
    line-height: 21px;
    color: rgb(153, 153, 153);
    font-size: 15px;
    width: 100%;
    text-align: left;
    box-sizing: border-box;
}

.news-page .news_list_one .list-item:hover{
}
.news-page .news_list_one .list-item:nth-child(2n){
}
.news-page .news_list_one .list-item:nth-child(2n):hover{
}
.news-page .news_list_one .list-item:hover .news_content .news_title{
}
.news-page .news_list_one .list-item:hover .news_content .news_intro{
}
.news-page .news_list_one .list-item:hover .news_content .news_time{
}


.news-page .hot_view{
    width:100%;
    margin: 20px auto;
    order:20;
}
.news-page .hot_view .hot_title{
    width: 100%;
    text-align: left;
    margin: 0px 0px 20px;
    font-size: 22px;
    color: #3092ac;
    min-height:50px;
    line-height:50px;
    background:url(http://clfile.zggen.cn/20241210/9b678cb2c28a49ec85a69af0b58e0c38.png) no-repeat left bottom;
    padding:0 0 0px 80px;
}
.news-page .hot_view .hot_list{
    display: flex;
    align-items: center;
    justify-content: space-around;
    font-size:16px;
    margin: 0px;
    border:0px solid #eee;
    border-top:none;
    padding-top: 20px;
}

.news-page .hot_view .hot_list .hot{
    width: calc(25% - 20px);
    margin: 0px 10px 20px;
    background: #fff;
    padding: 10px 10px 10px 20px;
    box-sizing: border-box;
    cursor: pointer;
    border-radius:30px 30px 30px 0;
}
.news-page .hot_view .hot_list .hot .hot_img{
    width:110px;
    height:110px;
    overflow:hidden;
    float:right;
    border-radius:30px;
}
.news-page .hot_view .hot_list .hot .hot_img .el-image__inner{
    width:100%;
    height:100%;
    object-fit:cover;
    border:1px solid #eee;
}
.news-page .hot_view .hot_list .hot .hot_content{
    width:calc(100% - 120px);
    float:left;
}
.news-page .hot_view .hot_list .hot .hot_content .hot_text{
    width:100%;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
    font-size:15px;
    color:#666;
    line-height:30px;
}
.news-page .hot_view .hot_list .hot .hot_content .hot_date{
    width:100%;
    line-height:24px;
    text-align: left;
    font-size:14px;
    color:#999;
}

.news-page .hot_view .hot_list .hot:hover{
}
.news-page .hot_view .hot_list .hot:hover .hot_content .hot_text{
}
.news-page .hot_view .hot_list .hot:hover .hot_content .hot_date{
}


</style>