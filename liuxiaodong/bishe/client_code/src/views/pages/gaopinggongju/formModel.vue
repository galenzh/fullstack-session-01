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

			<div class="info_view">
				<div class="title_view">
					<div class="detail_title">
						<span>{{detail.gongjumingcheng}}</span>
					</div>
				</div>
				<div class="info_item">
					<div class="info_label">价格</div>
					<div class="info_price"><span>￥</span>{{detail.price}}</div>
				</div>
				<div class="info_item" v-if="detail.jf">
					<div class="info_label">积分</div>
					<div class="info_price">{{detail.jf}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">详情</div>
					<div class="info_text">{{detail.xiangqing}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">使用方法</div>
					<div class="info_text">{{detail.shiyongfangfa}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">评论数</div>
					<div class="info_text">{{detail.discussNumber}}</div>
				</div>
				<div class="action-buttons">
					<div class="input-container">
						<el-input-number class="inputNumber" v-model="buyNumber" :min="1"></el-input-number>
					</div>
					<div class="buttons-container">
						<el-button class="cart-button" type="primary" @click="addCart">
							<i class="el-icon-shopping-cart-2"></i> 加入购物车
						</el-button>
						<el-button class="buy-button" type="success" @click="buyNow">
							<i class="el-icon-shopping-bag-1"></i> 立即购买
						</el-button>
					</div>
				</div>
				<div class="btn_view">
					<el-button class="edit_btn" v-if="centerType&&btnAuth('gaopinggongju','修改')" type="primary" @click="editClick">修改</el-button>
					<el-button class="del_btn" v-if="centerType&&btnAuth('gaopinggongju','删除')" type="danger" @click="delClick">删除</el-button>
				</div>
			</div>
		</div>
		<el-tabs type="border-card" v-model="activeName" class="tabs_view">
			<el-tab-pane label="评论" name="commentActive">
				<div class="my_comment_view">
					<el-form ref="commentFormRef" :model="commentForm" class="my_comment_form"
						:rules="commentRules">
						<el-form-item prop="content">
                            <editor :value="commentForm.content" placeholder="请分享您的使用体验和建议..."
                                    class="list_editor" @change="contentChange"></editor>
						</el-form-item>
					</el-form>
					<div class="comment_btn">
						<el-button class="add_btn" type="primary" @click="commentSave">
							<i class="el-icon-position"></i> 发表评论
						</el-button>
						<el-button class="reset_btn" @click="resetForm">
							<i class="el-icon-refresh-right"></i> 重置
						</el-button>
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
                                <span class="del" @click="commentDel(item)">
                                    <i class="el-icon-delete"></i> 删除
                                </span>
                            </div>
							<div class="comment_reply" v-if="item.reply">
								<span class="reply_label">管理员回复：</span>
								<span class="reply_content" v-html="item.reply"></span>
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
	const tableName = 'gaopinggongju'
	const formName = '高评工具'
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
    const activeName = ref('commentActive')
	const getDetail = () => {
		context?.$http({
			url: `${tableName}/detail/${route.query.id}`,
			method: 'get'
		}).then(res => {
            bannerList.value = res.data.data.tupian?res.data.data.tupian.split(','):[]
            title.value = res.data.data.gongjumingcheng
			detail.value = res.data.data
			getInCartList();
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
		// 评论
		getCommentList()
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
        console.log("开始提交评论", commentForm.value);
        if(!commentForm.value.content ||commentForm.value.content=='<p><br></p>'){
            return context.$message.error("请输入评论内容")
        }
		let sensitiveWords = "sb,艹";
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
		// 直接尝试提交评论，跳过验证和订单检查
        context?.$http({
            url: `discuss${tableName}/add`,
            method: 'post',
            data: commentForm.value
        }).then(res => {
            console.log("评论提交成功", res);
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
        }).catch(err => {
            console.error("评论提交失败", err);
            context?.$toolUtil.message('评论提交失败: ' + (err.message || '未知错误'), 'error')
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
	//查找是否已添加购物车
	const isInCart = ref(false)
	const getInCartList = () => {
        if(!context?.$toolUtil.storageGet('frontToken'))return
		context?.$http({url:'cart/list',method:'get',params:{userid:context?.$toolUtil.storageGet('userid'),tablename:tableName,goodid: detail.value.id}}).then(res=>{
			if(res.data.data.list.length){
				isInCart.value = true
			}else{
				isInCart.value = false
			}
		})
	}
	const cartForm = ref({
		userid:context?.$toolUtil.storageGet('userid')
	})
	const addCart = () => {
		if(isInCart.value){
			context?.$toolUtil.message('该商品已在购物车，请前往购买','error')
			return false
		}
		cartForm.value.buynumber = buyNumber.value
		cartForm.value.goodid = detail.value.id
		cartForm.value.goodname = title.value
		cartForm.value.tablename = tableName
		cartForm.value.picture = bannerList.value[0]
        cartForm.value.price = detail.value.price
		context?.$http({
			url: 'cart/save',
			method: 'post',
			data:cartForm.value
		}).then(res=>{
			context?.$toolUtil.message('添加成功','success')
			getInCartList()
		})
	}
	const buyNumber = ref(1)
	//立即购买
	const buyNow = () => {
		let data = {
			tablename: tableName,
			goodid: detail.value.id,
			goodname: title.value,
			buynumber: buyNumber.value,
			userid: context?.$toolUtil.storageGet('userid'),
			discountprice: detail.value.vipprice,
			picture: bannerList.value[0],
			price: detail.value.price
		}
		context?.$toolUtil.storageSet('orders_good',JSON.stringify([data]))
		let query = {
			type: 1
		}
		router.push({path: '/index/order_confirm', query: query})
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
		// 文字区
		.info_view {

			.title_view {

				.detail_title {
				}
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
				padding: 25px 0;
				display: flex;
				margin: 20px 0;
				flex-wrap: nowrap;
				align-items: center;
				border-top: 1px dashed #eee;
				// 数量输入框
				.inputNumber {
					position: relative;
					display: inline-block;
					width: 150px;
					height: 40px;
					:deep(.el-input-number__decrease) {
						i {
						}
					}
					:deep(.el-input-number__increase) {
						i {
						}
					}
					:deep(.el-input) {
						.el-input__wrapper {
						}
					}
				}
				
				.break {
					width: 15px;
				}
				
				// 加入购物车-按钮
				.addCart_btn {
					background: #1890ff;
					color: white;
					border: none;
					border-radius: 6px;
					padding: 0 20px;
					height: 40px;
					line-height: 40px;
					margin: 0 15px 0 0;
					min-width: 140px;
					display: inline-flex;
					align-items: center;
					justify-content: center;
					box-shadow: 0 4px 12px rgba(24, 144, 255, 0.15);
				}
				// 悬浮
				.addCart_btn:hover {
					background: #40a9ff;
					transform: translateY(-2px);
					box-shadow: 0 6px 16px rgba(24, 144, 255, 0.25);
				}
				// 立即购买-按钮
				.buyNow_btn {
					background: #52c41a;
					color: white;
					border: none;
					border-radius: 6px;
					padding: 0 20px;
					height: 40px;
					line-height: 40px;
					margin: 0;
					min-width: 140px;
					display: inline-flex;
					align-items: center;
					justify-content: center;
					box-shadow: 0 4px 12px rgba(82, 196, 26, 0.15);
				}
				// 悬浮
				.buyNow_btn:hover {
					background: #73d13d;
					transform: translateY(-2px);
					box-shadow: 0 6px 16px rgba(82, 196, 26, 0.25);
				}
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

	.action-buttons {
		margin: 20px 0;
		padding: 25px 0;
		border-top: 1px dashed #eee;
	}

	.input-container {
		margin-bottom: 15px;
	}

	.inputNumber {
		width: 150px;
		height: 40px;
	}

	.buttons-container {
		display: flex;
		align-items: center;
	}

	.cart-button, .buy-button {
		height: 40px;
		min-width: 140px;
		display: flex;
		align-items: center;
		justify-content: center;
		border: none;
		border-radius: 6px;
		padding: 0 20px;
	}

	.cart-button {
		background: #1890ff;
		color: white;
		margin-right: 15px;
		box-shadow: 0 4px 12px rgba(24, 144, 255, 0.15);
	}

	.cart-button:hover {
		background: #40a9ff;
		transform: translateY(-2px);
		box-shadow: 0 6px 16px rgba(24, 144, 255, 0.25);
	}

	.buy-button {
		background: #52c41a;
		color: white;
		box-shadow: 0 4px 12px rgba(82, 196, 26, 0.15);
	}

	.buy-button:hover {
		background: #73d13d;
		transform: translateY(-2px);
		box-shadow: 0 6px 16px rgba(82, 196, 26, 0.25);
	}
</style>
<style>
/* 评论区现代化样式 */
.my_comment_view {
    padding: 25px;
    background: #fafafa;
    border-radius: 12px;
    margin-bottom: 30px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

.my_comment_form {
    margin-bottom: 20px;
}

.list_editor {
    border-radius: 8px;
    overflow: hidden;
    border: 1px solid #e8e8e8;
    transition: all 0.3s;
}

.list_editor:hover {
    border-color: #c0c4cc;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.comment_btn {
    display: flex;
    justify-content: center;
    gap: 12px;
    margin-top: 15px;
}

.comment_btn .add_btn {
    background: #1890ff;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 0 25px;
    height: 40px;
    transition: all 0.3s;
    box-shadow: 0 2px 6px rgba(24, 144, 255, 0.15);
}

.comment_btn .add_btn:hover {
    background: #40a9ff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(24, 144, 255, 0.2);
}

.comment_btn .reset_btn {
    background: #f0f0f0;
    color: #666;
    border: none;
    border-radius: 6px;
    padding: 0 25px;
    height: 40px;
    transition: all 0.3s;
}

.comment_btn .reset_btn:hover {
    background: #e0e0e0;
    transform: translateY(-2px);
}

.comment_list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(45%, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.comment_list .comment {
    padding: 20px;
    border-radius: 10px;
    background: white;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
    transition: all 0.3s;
    border: 1px solid #f0f0f0;
}

.comment_list .comment:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
}

.comment_list .comment .comment_top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 12px;
    border-bottom: 1px solid #f5f5f5;
}

.comment_list .comment .comment_user {
    display: flex;
    align-items: center;
}

.comment_list .comment .comment_user_img img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #f0f0f0;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
}

.comment_list .comment .comment_user_info {
    margin-left: 12px;
    font-weight: 500;
    color: #333;
    font-size: 16px;
}

.comment_list .comment .comment_time {
    color: #999;
    font-size: 14px;
}

.comment_list .comment .comment_bottom {
    color: #555;
    line-height: 1.6;
}

.comment_list .comment .comment_content {
    margin-bottom: 15px;
    word-break: break-word;
}

.comment_list .comment .comment_action .del {
    color: #ff4d4f;
    cursor: pointer;
    font-size: 14px;
    padding: 4px 8px;
    border-radius: 4px;
    background: #fff2f2;
    display: inline-block;
    transition: all 0.3s;
}

.comment_list .comment .comment_action .del:hover {
    background: #ffd6d6;
}

.comment_list .comment .comment_reply {
    margin-top: 15px;
    padding: 12px 15px;
    background: #f9f9f9;
    border-radius: 8px;
    position: relative;
    border-left: 3px solid #1890ff;
}

.comment_list .comment .comment_reply .reply_label {
    font-weight: 500;
    color: #1890ff;
}

.comment_list .comment .comment_reply .reply_content {
    color: #444;
}

.tabs_view {
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 3px 15px rgba(0, 0, 0, 0.05) !important;
}
</style>