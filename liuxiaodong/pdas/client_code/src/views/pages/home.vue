<template>
	<div>
		<div class="home_box">
			<!-- 课程信息推荐 -->
			<div class="recomList_view">
				<div class="recomList_title">
                    <span>课程信息推荐</span>
                </div>
				<div class="recommend_list_three">
					<div class="item_left">
						<div class="item_left_top animation_box" v-if="kechengxinxiRecomList.length>0" @click="detailClick('kechengxinxi',kechengxinxiRecomList[0].id)">
							<div class="recommend_img_box">
								<img class="recommend_img" v-if="isHttp(kechengxinxiRecomList[0].kechengtupian)" :src="kechengxinxiRecomList[0].kechengtupian.split(',')[0]" alt="">
								<img class="recommend_img" v-else :src="kechengxinxiRecomList[0].kechengtupian?$config.url + kechengxinxiRecomList[0].kechengtupian.split(',')[0]:''" alt="">
							</div>
							<div class="recommend_content">
								<div class='recommend_title'>
									{{kechengxinxiRecomList[0].kechengmingcheng}}
								</div>
							</div>
						</div>
						<div class="item_left_bottom animation_box" v-if="kechengxinxiRecomList.length>1" @click="detailClick('kechengxinxi',kechengxinxiRecomList[1].id)">
							<div class="recommend_img_box">
								<img class="recommend_img" v-if="isHttp(kechengxinxiRecomList[1].kechengtupian)" :src="kechengxinxiRecomList[1].kechengtupian.split(',')[0]" alt="">
								<img class="recommend_img" v-else :src="kechengxinxiRecomList[1].kechengtupian?$config.url + kechengxinxiRecomList[1].kechengtupian.split(',')[0]:''" alt="">
							</div>
							<div class="recommend_content">
								<div class='recommend_title'>
									{{kechengxinxiRecomList[1].kechengmingcheng}}
								</div>
							</div>
						</div>
					</div>
					<div class="item_center animation_box" v-if="kechengxinxiRecomList.length>2" @click="detailClick('kechengxinxi',kechengxinxiRecomList[2].id)">
						<div class="recommend_img_box">
							<img class="recommend_img" v-if="isHttp(kechengxinxiRecomList[2].kechengtupian)" :src="kechengxinxiRecomList[2].kechengtupian.split(',')[0]" alt="">
							<img class="recommend_img" v-else :src="kechengxinxiRecomList[2].kechengtupian?$config.url + kechengxinxiRecomList[2].kechengtupian.split(',')[0]:''" alt="">
						</div>
						<div class="recommend_content">
							<div class='recommend_title'>
								{{kechengxinxiRecomList[2].kechengmingcheng}}
							</div>
						</div>
					</div>
					<div class="item_right">
						<div class="item_right_top animation_box" v-if="kechengxinxiRecomList.length>3" @click="detailClick('kechengxinxi',kechengxinxiRecomList[3].id)">
							<div class="recommend_img_box">
								<img class="recommend_img" v-if="isHttp(kechengxinxiRecomList[3].kechengtupian)" :src="kechengxinxiRecomList[3].kechengtupian.split(',')[0]" alt="">
								<img class="recommend_img" v-else :src="kechengxinxiRecomList[3].kechengtupian?$config.url + kechengxinxiRecomList[3].kechengtupian.split(',')[0]:''" alt="">
							</div>
							<div class="recommend_content">
								<div class='recommend_title'>
									{{kechengxinxiRecomList[3].kechengmingcheng}}
								</div>
							</div>
						</div>
						<div class="item_right_bottom animation_box" v-if="kechengxinxiRecomList.length>4" @click="detailClick('kechengxinxi',kechengxinxiRecomList[4].id)">
							<div class="recommend_img_box">
								<img class="recommend_img" v-if="isHttp(kechengxinxiRecomList[4].kechengtupian)" :src="kechengxinxiRecomList[4].kechengtupian.split(',')[0]" alt="">
								<img class="recommend_img" v-else :src="kechengxinxiRecomList[4].kechengtupian?$config.url + kechengxinxiRecomList[4].kechengtupian.split(',')[0]:''" alt="">
							</div>
							<div class="recommend_content">
								<div class='recommend_title'>
									{{kechengxinxiRecomList[4].kechengmingcheng}}
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="recommend_more_view" @click="moreClick('kechengxinxi')">
					<span class="recommend_more_text">查看更多</span>
				</div>
			</div>
			<!-- 咨询师首页展示 -->
			<div class="homeList_view">
				<div class="homeList_title">
                    <span>咨询师展示</span>
                </div>
				<div class="homeList">
					<div class="item" v-for="(item,index) in zixunshiHomeList" :key="index" @click="detailClick('zixunshi',item.id)">
						<div class="img-box">
							<img v-if="isHttp(item.touxiang)" :src="item.touxiang.split(',')[0]" alt="">
							<img v-else :src="item.touxiang?$config.url + item.touxiang.split(',')[0]:''" alt="">
						</div>
						<div class="content-box">
							<div class="title">
								咨询师账号：{{item.zixunshizhanghao}}
							</div>
							<div class="title">
								咨询师姓名：{{item.zixunshixingming}}
							</div>
							<div class="statistic">
								<div class="like">
									<span class="iconfont icon-thumb-up-line1"></span>
									<div class="num">{{item.thumbsupNumber}}</div>
								</div>
								<div class="collect">
									<span class="iconfont icon-likeline4"></span>
									<div class="num">{{item.storeupNumber}}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="homeList_more_view" @click="moreClick('zixunshi')">
					<span class="homeList_more_text">更多 +</span>
				</div>
			</div>
			<!-- 心理健康学习首页展示 -->
			<div class="homeList_view">
				<div class="homeList_title">
                    <span>心理健康学习展示</span>
                </div>
				<div class="homeList">
					<div class="item" v-for="(item,index) in xinlijiankangxuexiHomeList" :key="index" @click="detailClick('xinlijiankangxuexi',item.id)">
						<div class="img-box">
							<img v-if="isHttp(item.fengmian)" :src="item.fengmian.split(',')[0]" alt="">
							<img v-else :src="item.fengmian?$config.url + item.fengmian.split(',')[0]:''" alt="">
						</div>
						<div class="content-box">
							<div class="title">
								标题：{{item.biaoti}}
							</div>
							<div class="statistic">
								<div class="like">
									<span class="iconfont icon-thumb-up-line1"></span>
									<div class="num">{{item.thumbsupNumber}}</div>
								</div>
								<div class="collect">
									<span class="iconfont icon-likeline4"></span>
									<div class="num">{{item.storeupNumber}}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="homeList_more_view" @click="moreClick('xinlijiankangxuexi')">
					<span class="homeList_more_text">更多 +</span>
				</div>
			</div>
			<!-- 课程信息首页展示 -->
			<div class="homeList_view">
				<div class="homeList_title">
                    <span>课程信息展示</span>
                </div>
				<div class="categoryList">
					<div class="item" @click="kechengxinxiCategoryChange(-1)" style="cursor: pointer" :class="{active:kechengxinxi_index==-1}">全部</div>
					<div class="item" v-for="(item,index) in kechengxinxiCategorys" @click="kechengxinxiCategoryChange(index)" :class="{active:kechengxinxi_index==index}" style="cursor: pointer">
						{{item}}
					</div>
				</div>
				<div class="homeList">
					<div class="item" v-for="(item,index) in kechengxinxiHomeList" :key="index" @click="detailClick('kechengxinxi',item.id)">
						<div class="img-box">
							<img v-if="isHttp(item.kechengtupian)" :src="item.kechengtupian.split(',')[0]" alt="">
							<img v-else :src="item.kechengtupian?$config.url + item.kechengtupian.split(',')[0]:''" alt="">
						</div>
						<div class="content-box">
							<div class="title">
								{{item.kechengmingcheng}}
							</div>
							<div class="title">
								发布时间：{{item.fabushijian}}
							</div>
							<div class="price">
								￥{{item.price}}
							</div>
							<div class="statistic">
								<div class="collect">
									<span class="iconfont icon-likeline4"></span>
									<div class="num">{{item.storeupNumber}}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="homeList_more_view" @click="moreClick('kechengxinxi')">
					<span class="homeList_more_text">更多 +</span>
				</div>
			</div>
			<!-- 心理资讯 -->
			<div class="newsList_view">
				<div class="ntitle"> <div class="n1">心理资讯</div> </div>
				
				    <div class="nlist">
				         <ul> 
				        <li v-for="(item,index) in newsList" :key="index" @click="newsDetailClick(item)">
				          
				          <div class="infobox">
				            <div class="nam">{{item.title}}</div>
				            <div class="info">{{item.introduction}}</div>
				            <div class="tim">{{moment(item.addtime).format('YYYY-MM-DD')}}</div>
				          </div>
				          
				          <div class="imgbox">
				                <img :src="item.imgUrl" >
				            </div>
				          
				        </li>
				         </ul> 
				    </div>
				
				<div class="nmore" @click="moreClick('news')" style="cursor: pointer">查看更多</div>
			</div>

		</div>
		<formModel ref="newsFormModelRef"></formModel>
	</div>
</template>

<script setup>
	import {
		ref,
		getCurrentInstance
	} from 'vue';
	import moment from 'moment'
	import {
		useRouter
	} from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	//咨询师首页展示
	const zixunshiHomeList = ref([])
	const getzixunshiHomeList = () => {
		let params = {
			page: 1,
			limit: 8,
            sort:'id',
            order:'desc',
		}
		context?.$http({
			url: 'zixunshi/list',
			method: 'get',
			params: params
		}).then(res => {
			zixunshiHomeList.value = res.data.data.list
			zixunshiHomeList.value.forEach(item=>{
				if(!isHttp(item.touxiang)){
					item.imgUrls = item.touxiang.split(',').map(item=>context.$config.url+item)
				}
			})
		})
	}
	//心理健康学习首页展示
	const xinlijiankangxuexiHomeList = ref([])
	const getxinlijiankangxuexiHomeList = () => {
		let params = {
			page: 1,
			limit: 8,
            sort:'id',
            order:'desc',
		}
		context?.$http({
			url: 'xinlijiankangxuexi/list',
			method: 'get',
			params: params
		}).then(res => {
			xinlijiankangxuexiHomeList.value = res.data.data.list
			xinlijiankangxuexiHomeList.value.forEach(item=>{
				if(!isHttp(item.fengmian)){
					item.imgUrls = item.fengmian.split(',').map(item=>context.$config.url+item)
				}
			})
		})
	}
	//课程信息推荐
	const kechengxinxiRecomList = ref([])
	const getkechengxinxiRecomList = () => {
		let autoSortUrl = 'kechengxinxi/autoSort'
		if(context?.$toolUtil.storageGet('frontToken')){
			autoSortUrl = "kechengxinxi/autoSort2"
		}
		let params = {
			page: 1,
			limit: 5
		}
		context?.$http({
			url: autoSortUrl,
			method: 'get',
			params: params
		}).then(res => {
			kechengxinxiRecomList.value = res.data.data.list
			kechengxinxiRecomList.value.forEach(item=>{
				if(!isHttp(item.kechengtupian)){
					item.imgUrls = item.kechengtupian.split(',').map(item=>context.$config.url+item)
				}
			})
		})
	}
	//课程信息首页展示
	const kechengxinxiCategorys = ref([])
	const kechengxinxi_index = ref(-1)
	const getkechengxinxiCategorys = () => {
		context?.$http({
			url: 'option/kechengleixing/kechengleixing',
			method: 'get'
		}).then(res => {
			kechengxinxiCategorys.value = res.data.data
		})
	}
	getkechengxinxiCategorys()
	const kechengxinxiCategoryChange = (index)=>{
		kechengxinxi_index.value = index
		getkechengxinxiHomeList()
	}
	const kechengxinxiHomeList = ref([])
	const getkechengxinxiHomeList = () => {
		let params = {
			page: 1,
			limit: 8,
            sort:'id',
            order:'desc',
		}
		if(kechengxinxi_index.value>=0){
            params.kechengleixing = kechengxinxiCategorys.value[kechengxinxi_index.value]
		}
		context?.$http({
			url: 'kechengxinxi/list',
			method: 'get',
			params: params
		}).then(res => {
			kechengxinxiHomeList.value = res.data.data.list
			kechengxinxiHomeList.value.forEach(item=>{
				if(!isHttp(item.kechengtupian)){
					item.imgUrls = item.kechengtupian.split(',').map(item=>context.$config.url+item)
				}
			})
		})
	}
	//心理资讯弹窗
	import formModel from './news/formModel'
	const newsFormModelRef = ref(null)
	//心理资讯
	const newsList = ref([])
	const getNewsList = () => {
		context?.$http({
			url: 'news/list',
			method: 'get',
			params:{
				page:1,
				limit: 3,
                sort:'id',
                order:'desc',
			}
		}).then(res=>{
			newsList.value = res.data.data.list
			newsList.value.forEach(item=>{
				if(!isHttp(item.picture)){
					item.imgUrl=context.$config.url+item.picture.split(',')[0]
				}
			})
		})
	}
	const newsDetailClick = (item) => {
		if (item && item.id){
			newsFormModelRef.value.init(item.id)
		}
	}
	//判断图片链接是否带http
	const isHttp = (str) => {
        return str && str.substr(0,4)=='http';
    }
	//跳转详情
	const detailClick = (table,id) => {
		router.push(`/index/${table}Detail?id=${id}`)
	}
	const moreClick = (table) => {
		router.push(`/index/${table}List`)
	}
	const init = () => {
		//咨询师首页展示
		getzixunshiHomeList()
		//心理健康学习首页展示
		getxinlijiankangxuexiHomeList()
		//课程信息推荐
		getkechengxinxiRecomList()
		//课程信息首页展示
		getkechengxinxiHomeList()
		//心理资讯
		getNewsList()
	}
	init()
</script>

<style lang="scss">
	.home_box {
	}

	// 推荐
	.recomList_view {
		.recomList_title {
		}
		// list
		.recommend_list_three {
			display: flex;
			justify-content: space-between;
			// 左边盒子
			.item_left {
				margin: 0 0px 0 0;
				width: calc(30% - 20px);
				// 左上
				.item_left_top {
					cursor: pointer;
					margin: 0 0 20px;
					width: 100%;
					position: relative;
					.recommend_img_box {
						.recommend_img {
							border-radius: 10px;
							object-fit: cover;
							width: 100%;
							height: 300px;
						}
					}
					.recommend_content {
						border-radius: 10px;
						z-index: 1002;
						color: #fff;
						left: 0;
						bottom: 0;
						background: rgba(0,0,0,.3);
						width: 100%;
						line-height: 3;
						position: absolute;
						text-align: center;
						.recommend_title {
						}
					}
				}
				// 左下
				.item_left_bottom {
					cursor: pointer;
					width: 100%;
					position: relative;
					.recommend_img_box {
						.recommend_img {
							border-radius: 10px;
							object-fit: cover;
							width: 100%;
							height: 300px;
						}
					}
					.recommend_content {
						border-radius: 10px;
						z-index: 1002;
						color: #fff;
						left: 0;
						bottom: 0;
						background: rgba(0,0,0,.3);
						width: 100%;
						line-height: 3;
						position: absolute;
						text-align: center;
						.recommend_title {
						}
					}
				}
			}
			// 中间
			.item_center {
				cursor: pointer;
				width: 40%;
				position: relative;
				.recommend_img_box {
					.recommend_img {
						border-radius: 10px;
						object-fit: cover;
						width: 100%;
						height: 620px;
					}
				}
				.recommend_content {
					border-radius: 10px;
					z-index: 1002;
					color: #fff;
					left: 0;
					bottom: 0;
					background: rgba(0,0,0,.3);
					width: 100%;
					line-height: 3;
					position: absolute;
					text-align: center;
					.recommend_title {
					}
				}
			}
			// 右边盒子
			.item_right {
				// 右上
				.item_right_top {
					cursor: pointer;
					margin: 0 0 20px;
					width: 100%;
					position: relative;
					.recommend_img_box {
						.recommend_img {
							border-radius: 10px;
							object-fit: cover;
							width: 100%;
							height: 300px;
						}
					}
					.recommend_content {
						border-radius: 10px;
						z-index: 1002;
						color: #fff;
						left: 0;
						bottom: 0;
						background: rgba(0,0,0,.3);
						width: 100%;
						line-height: 3;
						position: absolute;
						text-align: center;
						.recommend_title {
						}
					}
				}
				// 右下
				.item_right_bottom {
					cursor: pointer;
					width: 100%;
					position: relative;
					.recommend_img_box {
						font-size: 0;
						.recommend_img {
							border-radius: 10px;
							object-fit: cover;
							width: 100%;
							height: 300px;
						}
					}
					.recommend_content {
						border-radius: 10px;
						z-index: 1002;
						color: #fff;
						left: 0;
						bottom: 0;
						background: rgba(0,0,0,.3);
						width: 100%;
						line-height: 3;
						position: absolute;
						text-align: center;
						.recommend_title {
						}
					}
				}
			}
		}
		// list
		// animation
		.animation_box {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		.animation_box img {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box img:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		// animation
		// 更多
		.recommend_more_view {
			.recommend_more_text {
			}
		}
	}
	// 推荐
	// 新闻资讯
	.newsList_view {

		.newsList_title {
		}
		// list
		.news_list_one {
			display: flex;
			flex-wrap: wrap;
			.news_item {
				box-shadow: 0 4px 6px rgba(0,0,0,.3);
				margin: 0 10px 10px;
				background: #fff;
				display: flex;
				width: calc(33% - 20px);
				align-items: center;
				.news_img_box {
					width: 40%;
					font-size: 0;
					.news_img {
						object-fit: cover;
						width: 100%;
						height: 200px;
					}
				}
				.news_content {
					margin: 0 0 0 20px;
					width: calc(60% - 20px);
					.news_title {
						font-weight: bold;
						font-size: 20px;
					}
					.news_text {
						font-size: 14px;
						line-height: 1.5;
					}
					.news_time {
						color: #999;
						width: 100%;
						text-align: right;
					}
				}
			}
		}
		// list
		// animation
		.animation_box {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		.animation_box img {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box img:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		// animation
		// 更多
		.news_more_view {
			.news_more_text {
			}
			.el-icon {
			}
		}
	}
	// 新闻资讯
	// 首页展示
	.homeList_view {

		.homeList_title {
		}
		// list
		// list
		// animation
		.animation_box {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		.animation_box img {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box img:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		// animation
		// 更多
		.homeList_more_view {
			cursor: pointer;
			.homeList_more_text {
			}
		}
	}
	// 首页展示
</style>
<style>
.home_box{
    width: 100%;
    margin: 0px auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    background: #eee;
}
/* 总盒子 */
.recomList_view {
    width: 100%;
    margin:20px auto;
    padding: 0px calc((100% - 1200px)/2) 0px;
    background: url() center top / cover no-repeat;
    text-align: center;
    position:relative;
    order:0;
}
/* 标题 */
.recomList_view .recomList_title{
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
/* 样式一 总盒子 */
.recomList_view .recommend_list_one{
    width: 1200px;
    display: flex;
    flex-wrap: wrap;
    margin: 0px auto;
}
/* item */
.recomList_view .recommend_list_one .recommend_item{
    width: calc(32% - 0px);
    margin: 0px 2% 20px 0;
    background: rgb(255, 255, 255);
    cursor: pointer;
}
.recomList_view .recommend_list_one .recommend_item:nth-child(3n){
    margin-right:0px; 
}

/* 图片 盒子 */
.recomList_view .recommend_list_one .recommend_item .recommend_img_box{
    width: 100%;
    height: 280px;
    overflow: hidden;
    margin: 0px 0px 5px;
}
/* 图片 */
.recomList_view .recommend_list_one .recommend_item .recommend_img_box .recommend_img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* 内容区 盒子 */
.recomList_view .recommend_list_one .recommend_item .recommend_content{
    width: 100%;
}
/* 标题 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_title{
    font-size: 16px;
    text-align: left;
    font-weight: 600;
    color: rgb(0, 0, 0);
    width: 100%;
    line-height: 1.5;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
/* 价格 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_price{
    width: 100%;
    padding: 0 10px;
    color: rgb(255, 0, 0);
    text-align: right;
    font-size: 16px;
}

/* 底部 小元素 总盒子 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_bottom{
    width: 100%;
    display: flex;
    align-items: center;
    padding: 0 10px;
}
/* 点赞 盒子 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_bottom .recommend_like{
    display: flex;
    align-items: center;
    color: rgb(153, 153, 153);
    font-size: 16px;
    margin: 0px 10px 0px 0px;
}
/* 图标 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_bottom .like_icon{
    color: inherit;
    margin: 0px 4px 0px 0px;
}
/* 关注 盒子 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_bottom .recommend_collect{
    display: flex;
    align-items: center;
    color: rgb(153, 153, 153);
    font-size: 16px;
    margin: 0px 10px 0px 0px;
}
/* 图标 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_bottom .recommend_collect .el-icon-star-on{
    color: inherit;
    margin: 0px 4px 0px 0px;
}
/* 数量 */
.recomList_view .recommend_list_one .recommend_item .recommend_content .recommend_bottom .recommend_collect .num{
    color: inherit;
}

/* 更多 */
.recomList_view .recommend_more_view{
    position: absolute;
    top: 6px;
    right: calc((100% - 1200px) / 2);
    background: url(http://clfile.zggen.cn/20241210/48b0aff854e54b1fa53b3745de5b79cd.png) no-repeat 10px center,var(--theme);
    padding:0 10px 0 25px;
    height:32px;
    line-height:32px;
    border-radius:20px;
    min-width:90px;
}
.recomList_view .recommend_more_view .recommend_more_text{
    cursor: pointer;
    font-size: 14px;
    color:#fff;
    text-align: center;
}

/* 总盒子 */
.homeList_view{
    width: 100%;
    margin:10px auto;
    padding: 0px calc((100% - 1220px)/2) 0px;
    background: none ;
    overflow: hidden;
    position:relative;
    order: 3;
    display:flex;
    flex-wrap:wrap;
    justify-content:space-between;
}
/* 标题 */
.homeList_view .homeList_title{
    width: calc(100% - 20px);
    text-align: left;
    margin: 0px auto 20px;
    font-size: 22px;
    color: #3092ac;
    min-height:50px;
    line-height:50px;
    background:url(http://clfile.zggen.cn/20241210/9b678cb2c28a49ec85a69af0b58e0c38.png) no-repeat left bottom;
    padding:0 0 0px 80px;
}
/* 分类 */
.homeList_view .categoryList{
    width: calc(100% - 20px);
    margin:0 auto;
    display: block;
    flex-wrap: wrap;
    background: #fff;
    border-radius:10px;
    padding:0 20px;
}
.homeList_view .categoryList .item{
    display:inline-block;
    background: none;
    line-height:50px;
    color:#333;
    text-align: center;
    margin:0 20px 0 0;
    padding:0 20px;
    cursor:pointer;
    font-size: 16px;
}
.homeList_view .categoryList .item:hover{
    background:#3092ac;
    color:#fff;
    border-radius:10px;
}

/* 样式七 总盒子 */
.homeList_view .homeList{
    width: calc(100% - 0px);
    margin: 20px 0 0;
    display: flex;
    flex-wrap: wrap;
    order:2;
}
.homeList_view .homeList .item{
    width: calc(25% - 20px);
    margin: 0px 10px 20px;
    padding:0 0 10px;
    background: #fff;
    cursor: pointer;
    overflow:hidden;
    position:relative;
    border-radius:10px;
}
.homeList_view .homeList .item .img-box{
    width: 100%;
    height: 250px;
    overflow: hidden;
    margin: 0 0 5px;
    text-align:center;
}
.homeList_view .homeList .item .img-box img{
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius:10px;
}
.homeList_view .homeList .item .content-box{
    width: 100%;
}
.homeList_view .homeList .item:hover .content-box{  }

.homeList_view .homeList .item .content-box .title{
    width: 100%;
    padding:0 20px;
    line-height: 24px;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
    text-align:center;
}
.homeList_view .homeList .item:hover .content-box .title{
}
.homeList_view .homeList .item .content-box .price{
    width: 100%;
    padding:0 20px;
    text-align:right;
    color: #f00;
    font-size:16px;
}
.homeList_view .homeList .item:hover .content-box .price{
}
.homeList_view .homeList .item .content-box .statistic{
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin:10px 0 0;
    color: #888;
}
.homeList_view .homeList .item:hover .content-box .statistic{
}
.homeList_view .homeList .item .content-box .statistic .iconfont{
    color: inherit;
    margin: 0px 4px 0px 0px;
}
.homeList_view .homeList .item .content-box .statistic .num{
    color: inherit;
}
.homeList_view .homeList .item .content-box .statistic .like{
    display: flex;
    align-items: center;
    color: inherit;
    font-size: 16px;
    margin: 0px 10px 0px 0px;
}
.homeList_view .homeList .item .content-box .statistic .collect{
    display: flex;
    align-items: center;
    color: inherit;
    font-size: 16px;
    margin: 0px 10px 0px 0px;
}
.homeList_view .homeList .item .content-box .statistic .clickNum{
    display: flex;
    align-items: center;
    color: inherit;
    font-size: 16px;
    margin: 0px 10px 0px 0px;
}

/* 更多 */
.homeList_view .homeList_more_view{
    position: absolute;
    top: 6px;
    right: calc((100% - 1200px) / 2);
    background: url(http://clfile.zggen.cn/20241210/48b0aff854e54b1fa53b3745de5b79cd.png) no-repeat 10px center,var(--theme);
    padding:0 10px 0 25px;
    height:32px;
    line-height:32px;
    border-radius:20px;
    min-width:90px;
}
.homeList_view .homeList_more_view .homeList_more_text{
    cursor: pointer;
    font-size: 14px;
    color:#fff;
    text-align: center;
}
/* 总盒子 */
.newsList_view {
    width: 1200px;
    margin:20px auto;
    padding: 0px 20px;
    background: #fff;
    overflow: hidden;
    position:relative;
    order: 2;
    display:block;
    border-radius:10px;
}
/* 自定义 start*/
.newsList_view .ntitle{
    width: 100%;
    margin: 20px auto 20px;
    font-size: 22px;
    color: #3092ac;
    min-height:50px;
    line-height:50px;
    background:url(http://clfile.zggen.cn/20241210/9b678cb2c28a49ec85a69af0b58e0c38.png) no-repeat left bottom;
    padding:0 0 0px 80px;
}
.newsList_view .ntitle .n1{
    display:block;
    text-align: left;
    font-size: 22px;
    color: #333;
}
.newsList_view .ntitle .n2{
    display:block;
    font-size: 18px;
    line-height:30px;
    color:#ccc;
    margin-left:5px;
}
.newsList_view .nlist{
    width: 100%;
    margin:30px auto 0;
}
.newsList_view .nlist ul{
    margin:0;
    padding:0;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    align-content: flex-start;
}
.newsList_view .nlist ul li{
    width: calc(100% - 0px);
    text-align: left;
    background: none;
    border-bottom: 1px dashed #aaa;
    cursor:pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding-bottom:10px;
    margin:0 0 10px 0;
}
.newsList_view .nlist ul li:last-child{
    border-bottom:none;
}
.newsList_view .nlist ul li .imgbox{
    width: 160px;
    height: 160px;
    margin-bottom:5px; 
}
.newsList_view .nlist ul li .imgbox img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.newsList_view .nlist ul li .infobox {
    width: calc(100% - 180px);
    padding:0;
}
.newsList_view .nlist ul li .infobox .nam {
    color: #333;
    font-size: 15px;
    font-weight: 600;
    line-height: 24px;
    width:100%; 
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}
.newsList_view .nlist ul li .infobox .info {
    color: #888;
    font-size: 15px;
    line-height: 24px;
    height:48px;
    overflow:hidden;
    margin-top: 5px;
}
.newsList_view .nlist ul li .infobox .tim {
    width: 100%;
    text-align:right;
    color: #888;
    font-size: 15px;
}

/* 更多 */
.newsList_view .nmore{
    position: absolute;
    top: 26px;
    right: calc((100% - 1160px) / 2);
    color: #fff;
    background: url(http://clfile.zggen.cn/20241210/48b0aff854e54b1fa53b3745de5b79cd.png) no-repeat 10px center,var(--theme);
    padding:0 10px 0 25px;
    height:32px;
    line-height:32px;
    border-radius:20px;
    min-width:90px;
}
/* 自定义 end*/

</style>