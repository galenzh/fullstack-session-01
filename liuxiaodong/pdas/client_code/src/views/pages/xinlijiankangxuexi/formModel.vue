<template>
	<div class="detail-page" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            <div class="back_view">
                <el-button class="back_btn" @click="backClick" type="primary">返回</el-button>
            </div>
        </div>
		<div class="detail_view">
			<div class="swiper_view">
				<mySwiper :data="bannerList" :type="3"
					:loop="false"
					:navigation="true"
					:pagination="false"
					:paginationType="1"
					:scrollbar="false"
					:slidesPerView="1"
					:spaceBetween="20"
					:autoHeight="false"
					:centeredSlides="false"
					:freeMode="false"
					:effectType="0"
					:direction="horizontal"
					:autoplay="false"
					:slidesPerColumn="1">
					<template #default="scope">
						<img :style='{"objectFit":"cover","width":"100%","height":"480px"}' :src="scope.row?$config.url + scope.row:''">
					</template>
				</mySwiper>
			</div>
			<div class="thumbs_view">
				<template v-if="!thumbsupOrCrazilyInfo.type">
					<div class="zan_view" @click="thumbsupOrCrazilyClick(21)">
						<i class="iconfont icon-thumb-up-line1"></i>
						<span>赞({{detail.thumbsupNumber}})</span>
					</div>
					<div class="zan_view can_view" @click="thumbsupOrCrazilyClick(22)">
						<i class="iconfont icon-thumb-down-line1"></i>
						<span>踩({{detail.crazilyNumber}})</span>
					</div>
				</template>
				<template v-else>
					<div class="zan_view zanActive" v-if="thumbsupOrCrazilyInfo.type==21" @click="cancelThumbsupOrCrazilyClick(21)">
						<i class="iconfont iconfontActive icon-thumb-up-fill1"></i>
						<span class="textActive">取消赞({{detail.thumbsupNumber}})</span>
					</div>
					<div class="zan_view can_view zanActive" v-else @click="cancelThumbsupOrCrazilyClick(22)">
						<i class="iconfont iconfontActive icon-thumb-down-fill1"></i>
						<span class="textActive">取消踩({{detail.crazilyNumber}})</span>
					</div>
				</template>
			</div>

			<div class="info_view">
				<div class="title_view">
					<div class="detail_title">
						<span>{{detail.biaoti}}</span>
					</div>
					<div class="collect_view" v-if="!collectType" @click="collectClick(1)">
						<i class="iconfont icon-likeline1"></i>
						<span>收藏</span>
					</div>
					<div class="collect_view" v-if="collectType" @click="collectClick(-1)">
						<i class="iconfont iconfontActive icon-likefill1"></i>
						<span class="textActive">取消收藏</span>
					</div>
				</div>
				<div class="info_item">
					<div class="info_label">发布时间</div>
					<div  class="info_text" >{{detail.fabushijian}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">咨询师账号</div>
					<div  class="info_text" >{{detail.zixunshizhanghao}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">咨询师姓名</div>
					<div  class="info_text" >{{detail.zixunshixingming}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">联系方式</div>
					<div  class="info_text" >{{detail.lianxifangshi}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">收藏数</div>
					<div  class="info_text" >{{detail.storeupNumber}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">评论数</div>
					<div  class="info_text" >{{detail.discussNumber}}</div>
				</div>
				<div class="btn_view">
					<el-button class="edit_btn" v-if="centerType&&btnAuth('xinlijiankangxuexi','修改')" type="primary" @click="editClick">修改</el-button>
					<el-button class="del_btn" v-if="centerType&&btnAuth('xinlijiankangxuexi','删除')" type="danger" @click="delClick">删除</el-button>
				</div>
			</div>
		</div>
		<el-tabs type="border-card" v-model="activeName" class="tabs_view">
			<el-tab-pane label="内容" name="first">
				<div v-html="detail.neirong"></div>
			</el-tab-pane>
			<el-tab-pane label="评论" name="commentActive">
				<div class="my_comment_view">
					<el-form ref="commentFormRef" :model="commentForm" class="my_comment_form"
						:rules="commentRules">
						<el-form-item prop="content">
                            <editor :value="commentForm.content" placeholder="善语结善缘,恶语伤人心"
                                    class="list_editor" @change="contentChange"></editor>
						</el-form-item>
					</el-form>
					<div class="comment_btn">
						<el-button class="add_btn" type="primary" @click="commentSave">立即评论</el-button>
						<el-button class="reset_btn" @click="resetForm">重置</el-button>
					</div>
				</div>
				<div class="comment_list">
					<div class="comment" v-for="(item,index) in commentList" :key="index">
						<div class="comment_top">
							<div class="comment_user">
								<div class="comment_user_img">
									<img :src="item.avatarurl?$config.url + item.avatarurl:'../../../assets/avatar.png'" alt="">
								</div>
								<div class="comment_user_info">
									{{item.nickname}}
								</div>
							</div>
							<div class="comment_time">{{item.addtime}}</div>
						</div>
						<div class="comment_bottom">
                            <div class="comment_content" v-html="item.content"></div>
                            <div v-if="item.userid==user.id" class="comment_action">
                                <span class="del" @click="commentDel(item)" style="cursor: pointer">删除</span>
                            </div>
							<div class="comment_reply" v-if="item.reply">
								回复：<span v-html="item.reply"></span>
							</div>
						</div>
					</div>
				</div>
				<el-pagination
					background
					:layout="layouts.join(',')"
					:total="commentTotal"
					:page-size="commentQuery.limit"
					prev-text="上一页"
					next-text="下一页"
					:hide-on-single-page="false"
					:style='{}'
					@size-change="commentSizeChange"
					@current-change="commentCurrentChange" />
			</el-tab-pane>
		</el-tabs>
	</div>
</template>
<script setup>
	import axios from 'axios'
	import moment from 'moment'
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
		nextTick,
		computed
	} from 'vue';
	import {
		ElMessageBox
	} from 'element-plus'
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	import {
		useStore
	} from 'vuex';
	const store = useStore()
	const user = computed(()=>store.getters['user/session'])
	const userAvatar = computed(()=>store.getters['user/avatar'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'xinlijiankangxuexi'
	const formName = '心理健康学习'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	//权限验证
	const btnAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isAuth(e,a)
		}
	}
	//查看权限验证
	const btnFrontAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isFrontAuth(e,a)
		}
	}
	// 返回
	const backClick = () =>{
		history.back()
	}
	// 轮播图
	const bannerList = ref([])
	// 详情
	const title = ref('')
	const detail = ref({})
    const activeName = ref('first')
	const getDetail = () => {
		context?.$http({
			url: `${tableName}/detail/${route.query.id}`,
			method: 'get'
		}).then(res => {
            bannerList.value = res.data.data.fengmian?res.data.data.fengmian.split(','):[]
            title.value = res.data.data.biaoti
			detail.value = res.data.data
		})
	}
	// 下载文件
	const downClick = (file) => {
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		let arr = file.replace(new RegExp('file/', "g"), "")
		axios.get((location.href.split(context?.$config.name).length>1 ? location.href.split(context?.$config.name)[0] :'') + context?.$config.name + '/file/download?fileName=' + arr, {
			headers: {
				token: context?.$toolUtil.storageGet('frontToken')
			},
			responseType: "blob"
		}).then(({
			data
		}) => {
			const binaryData = [];
			binaryData.push(data);
			const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
				type: 'application/pdf;chartset=UTF-8'
			}))
			const a = document.createElement('a')
			a.href = objectUrl
			a.download = arr
			// a.click()
			// 下面这个写法兼容火狐
			a.dispatchEvent(new MouseEvent('click', {
				bubbles: true,
				cancelable: true,
				view: window
			}))
			window.URL.revokeObjectURL(data)
		})
	}
	// 判断是否从个人中心跳转
	const centerType = ref(false)
	const init = () => {
		if(route.query.centerType){
			centerType.value = true
		}
		getDetail()
		// 赞踩状态
		getThumbsupOrCrazily()
		// 收藏
		getCollect()
		// 评论
		getCommentList()
	}
	// 赞or踩
	const thumbsupOrCrazilyInfo = ref({})
	// 获取赞踩状态
	const getThumbsupOrCrazily = () => {
		if (context?.$toolUtil.storageGet('frontToken')) {
			context?.$http({
				url: 'storeup/page',
				method: 'get',
				params: {
					page: 1,
					refid: route.query.id,
					tablename: tableName,
					userid: context?.$toolUtil.storageGet('userid')
				}
			}).then(res => {
				let list = res.data.data.list.filter(item=>(item.type==21||item.type==22))
				if(!list.length){
					thumbsupOrCrazilyInfo.value = {}
				}else{
					thumbsupOrCrazilyInfo.value = list[0]
				}
			})
		}
	}
	// 赞踩按钮
	const thumbsupOrCrazilyClick = (type) => {
		let params = {
			name: title.value,
			picture: bannerList.value[0],
			refid: detail.value.id,
			type: type,
			tablename: tableName,
			userid: context?.$toolUtil.storageGet('userid')
		}
		context?.$http({
			url: 'storeup/add',
			method: 'post',
			data: params
		}).then(res => {
			if (type == 21) detail.value.thumbsupNumber += 1
			if (type == 22) detail.value.crazilyNumber += 1
			context?.$http({
				url: `${tableName}/update`,
				method: 'post',
				data: detail.value
			})
			getThumbsupOrCrazily()
			context?.$toolUtil.message('操作成功', 'success')
		})
	}
	//取消赞踩按钮
	const cancelThumbsupOrCrazilyClick = (type) => {
		let ids = []
		ids.push(thumbsupOrCrazilyInfo.value.id)
		context?.$http({
			url: 'storeup/delete',
			method: 'post',
			data: ids
		}).then(res => {
			if (type == 21 && detail.value.thumbsupNumber>0) detail.value.thumbsupNumber -= 1
			if (type == 22 && detail.value.crazilyNumber>0) detail.value.crazilyNumber -= 1
			context?.$http({
				url: `${tableName}/update`,
				method: 'post',
				data: detail.value
			})
			getThumbsupOrCrazily()
			context?.$toolUtil.message('取消成功', 'success')
		})
	}
	// 收藏
	const collectType = ref(false)
	const collectInfo = ref({})
	const getCollect = () => {
		if (context?.$toolUtil.storageGet('frontToken')) {
			context?.$http({
				url: 'storeup/list',
				method: 'get',
				params: {
					page: 1,
					limit: 1,
					type: 1,
					refid: route.query.id,
					tablename: tableName,
					userid: context?.$toolUtil.storageGet('userid')
				}
			}).then(res => {
				if (res.data.data.list.length) {
					collectType.value = true
					collectInfo.value = res.data.data.list[0]
				}else{
					collectType.value = false
					collectInfo.value = {}
				}
			})
		}
	}
	// 收藏按钮
	const collectClick = (type) => {
		if (type == 1 && !collectType.value) {
			let params = {
				name: title.value,
				picture: bannerList.value[0],
				refid: detail.value.id,
				type: type,
				tablename: tableName,
				userid: context?.$toolUtil.storageGet('userid')
			}
			context?.$http({
				url: 'storeup/add',
				method: 'post',
				data: params
			}).then(res => {
				detail.value.storeupNumber += 1
				context?.$http({
					url: `${tableName}/update`,
					method: 'post',
					data: detail.value
				})
				collectType.value = true
				getCollect()
				context?.$toolUtil.message('收藏成功', 'success')
			})
		}
		else if (type == -1 && collectType.value) {
			let ids = []
			ids.push(collectInfo.value.id)
			context?.$http({
				url: 'storeup/delete',
				method: 'post',
				data: ids
			}).then(res => {
				detail.value.storeupNumber -= 1
				context?.$http({
					url: `${tableName}/update`,
					method: 'post',
					data: detail.value
				})
				collectInfo.value = {}
				collectType.value = false
				context?.$toolUtil.message('取消成功', 'success')
			})
		}
	}
    const contentChange = (e)=>{
        commentForm.value.content = e
    }
	//评论
	const commentForm = ref({
		content: '',
		refid: route.query.id,
		userid: context?.$toolUtil.storageGet('userid'),
		nickname: context?.$toolUtil.storageGet('frontName'),
		avatarurl: context?.$toolUtil.storageGet('headportrait') ? context?.$toolUtil.storageGet('headportrait') : '',
	})
	const commentRules = ref({
		content: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ]
	})
	const commentQuery = ref({
		page: 1,
		limit: 10,
		refid: route.query.id
	})
	const layouts = ref(["total","prev","pager","next","sizes","jumper"])
	const commentList = ref([])
	const commentTotal = ref(0)
	const commentFormRef = ref(null)
	const commentSizeChange = (size) =>{
		commentQuery.value.limit = size
		getCommentList()
	}
	const commentCurrentChange = (page) =>{
		commentQuery.value.page = page
		getCommentList()
	}
	const getCommentList = () => {
		context?.$http({
			url: `discuss${tableName}/list?sort=id&order=desc`,
			params: commentQuery.value,
			method: 'get'
		}).then(res => {
			commentList.value = res.data.data.list
			commentTotal.value = res.data.data.total

		})
	}
	//提交评论
	const commentSave = async () => {
        if(!commentForm.value.content ||commentForm.value.content=='<p><br></p>'){
            return context.$message.error("请输入评论内容")
        }
		let sensitiveWords = "去死,你妹的,艹,他妈的";
		let sensitiveWordsArr = [];
		if(sensitiveWords) {
		    sensitiveWordsArr = sensitiveWords.split(",");
		}
		for(var i=0; i<sensitiveWordsArr.length; i++){
		    //全局替换
		    var reg = new RegExp(sensitiveWordsArr[i],"g");
		    //判断内容中是否包括敏感词
		    if (commentForm.value.content.indexOf(sensitiveWordsArr[i]) > -1) {
		        // 将敏感词替换为 **
		        commentForm.value.content = commentForm.value.content.replace(reg,"**");
		    }
		}
		commentFormRef.value.validate((valid) => {
			if (valid) {
				context?.$http({
					url: `discuss${tableName}/add`,
					method: 'post',
					data: commentForm.value
				}).then(res => {
                    context.$http.get(`${tableName}/info/${detail.value.id}`).then(res=>{
                        let detail = res.data.data
                        detail.discussNumber++
                        context.$http.post(`${tableName}/update`,detail).then(()=>{
                            getDetail()
                        })
                    })
					context?.$toolUtil.message('评论成功', 'success')
                    resetForm()
                    getCommentList()
				})
			}
		})
	}
    const commentDel = (item)=>{
        context.$confirm("确定要删除该评论吗？","提示").then(()=>{
            context.$http.post(`discuss${tableName}/delete`,[item.id]).then(res=>{
                if(res.data.code==0){
                    context.$message.success("删除成功")
                    context.$http.get(`${tableName}/info/${detail.value.id}`).then(res=>{
                        let detail = res.data.data
                        detail.discussNumber--
                        context.$http.post(`${tableName}/update`,detail).then(()=>{
                            getDetail()
                        })
                    })
                    getCommentList()
                }
            })
        }).catch(()=>{})
    }
	const resetForm = () => {
		commentFormRef.value.resetFields()
	}
	//修改
	const editClick = () => {
		router.push(`/index/${tableName}Add?id=${detail.value.id}&&type=edit`)
	}
	//删除
	const delClick = () => {
		ElMessageBox.confirm(`是否删除此${formName}？`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(()=>{
			context?.$http({
				url: `${tableName}/delete`,
				method: 'post',
				data: [detail.value.id]
			}).then(res=>{
				context?.$toolUtil.message('删除成功','success',()=>{
					history.back()
				})
			})

		}).catch(_ => {})
	}
	onMounted(()=>{
		init()
	})
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
	// 面包屑盒子
	.bread_view {
		:deep(.breadcrumb) {
			.el-breadcrumb__separator {
			}
			.first_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
			.second_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
		}
	}

	.detail_view{
		// 轮播图
		.swiper_view {
		}
		// 赞踩盒子
		.thumbs_view {
			.zan_view {

				.iconfont {
				}
				.iconfontActive {
				}
				span {
				}
				.textActive {
				}
			}
			.zan_view:hover {
				color: #fff;
				background: #feb043;
			}
			.zan_view:active {
				transform: scale(0.8);
				background: #feb043;
			}
		}
		// 文字区
		.info_view {

			.title_view {

				.detail_title {
				}
				// 收藏盒子
				.collect_view {
					border: 0px solid #eee;
					cursor: pointer;
					border-radius: 10px;
					padding: 10px 0px;
					color: #eee;
					background: none;
					display: flex;
					width: auto;
					line-height: 1;
					justify-content: center;
					align-items: center;
					.iconfont {
						margin: 0 5px 0 0;
						color: #eee;
					}
					.iconfontActive {
						margin: 0 5px 0 0;
						color: #fcaaa8;
					}
					span {
						color: #eee;
					}
					.textActive {
						color: #fcaaa8;
					}
				}
				.collect_view:hover {
				}
				.collect_view:active {
					transform: scale(0.8);
				}
			}

			.info_item {

				.info_label {
				}
				.info_text {
				}
			}
			.btn_view {
				// 修改-按钮
				.edit_btn {
				}
				// 悬浮
				.edit_btn:hover {
				}
				// 删除-按钮
				.del_btn {
				}
				// 悬浮
				.del_btn:hover {
				}
			}
		}
	}

	//底部盒子
	.tabs_view {
		:deep(.el-tabs__header) {
			background: transparent;
			border: none;
		}
		// 头部
		:deep(.el-tabs__nav-scroll) {
			.el-tabs__nav {
				.el-tabs__item {
				}
				.el-tabs__item:hover {
				}
				.is-active {
				}
			}
		}
		// 内容区
		:deep(.el-tabs__content) {
		}
		//评论
		//我的评论
		.my_comment_view {

			.my_comment_form {
				// 输入框
				:deep(.el-textarea__inner) {
				}
			}
			// 按钮盒子
			.comment_btn {
				// 评论按钮
				.add_btn {
				}
				// 悬浮
				.add_btn:hover {
				}
				// 重置按钮
				.reset_btn {
				}
				// 悬浮
				.reset_btn:hover {
				}
			}
		}

		//评论列表
		.comment_list {

			.comment {
				.comment_top {

					.comment_user {
						.comment_user_img {

							img {
								border-radius: 50%;
								width: 40px;
								height: 40px;
							}
						}
						.comment_user_info {
						}
					}
					.comment_time{
					}
				}

				.comment_bottom {
					.comment_content {
					}
					.comment_reply {
					}
				}
			}
		}
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
	}
</style>