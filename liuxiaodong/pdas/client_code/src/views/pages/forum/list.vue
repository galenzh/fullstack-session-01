<template>
	<div class="forum_view" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="back_view" v-if="centerType">
                <el-button class="back_btn" @click="backClick" type="primary">返回</el-button>
            </div>
        </div>
		<div class="section_title">
			<span>{{myType?'我的发布':formName}}</span>
		</div>
		<el-form :model="searchQuery" class="list_search">
			<div class="search_view">
				<div class="search_label">
					标题：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.title" placeholder="标题" size="small" clearable>
					</el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn" type="primary" @click="searchClick">搜索</el-button>
				<el-button class="add_btn" @click="addClick" v-if="!myType&&btnAuth('forum','新增')" type="success">发布新帖</el-button>
			</div>
		</el-form>
		<div class="forum_list">
			<div class="forum_item" v-for="(item,index) in list" :key="index" @mouseenter="forumEnter(index)"
				@mouseleave="forumLeave" @click.stop="detailClick(item.id)">
				<div class="forum_item_left">
					<span class="forum_item_title">{{item.title}}</span>
					<span class="forum_item_name">
                        (发布人：{{item.username}})
                    </span>
				</div>
				<div class="forum_item_btn_box" v-if="item.userid==userid&&forumShowIndex==index&&(btnAuth('forum','修改')||btnAuth('forum','删除'))">
					<el-button class="forum_edit_btn" v-if="btnAuth('forum','修改')" type="primary" @click.stop="editClick(item.id)">修改</el-button>
					<el-button class="forum_del_btn" v-if="btnAuth('forum','删除')" type="danger" @click.stop="delClick(item.id)">删除</el-button>
				</div>
				<div class="forum_time" v-else>{{item.addtime}}</div>
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
				@current-change="currentChange" />
		</div>
		
		<el-dialog v-model="formVisible" :title="formTitle" width="70%" custom-class="edit_view" destroy-on-close>
			<el-form class="add_form" :model="form" label-width="120px" :rules="rules" ref="formRef">
				<el-row>
					<el-col :span="24">
						<el-form-item label="标题" prop="title">
							<el-input class="list_inp" v-model="form.title" placeholder="请输入标题"></el-input>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="类型">
							<el-radio-group class="list_radio" v-model="form.isdone">
								<el-radio label="开放">公开</el-radio>
								<el-radio label="关闭">私人</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="内容" prop="content">
							<editor :value="form.content" placeholder="请输入内容"
								class="list_editor" @change="contentChange"></editor>
						</el-form-item>
					</el-col>
				</el-row>
			</el-form>
			<template #footer>
				<span class="formModel_btn_box">
					<el-button class="formModel_cancel" @click="formVisible=false">关闭</el-button>
					<el-button class="formModel_confirm" type="primary" @click="save">{{form.id?'修改保存':'发布'}}</el-button>
				</span>
			</template>
		</el-dialog>
		<el-dialog v-model="detailVisible" :title="''" width="70%" destroy-on-close>
			<div class="forum_detail">
				<div class="forum_title">
					<span>{{detailForm.title}}</span>
				</div>
				<div class="forum_info">
					<span class="forum_name">
                        发布人：{{detailForm.username}}
                    </span>
					<span class="forum_time">发布时间：{{detailForm.addtime}}</span>
				</div>
                <div class="thumbs_view" style="display: flex;column-gap: 20px;margin: 0 auto;justify-content: center;">
                    <template v-if="!thumbsupOrCrazilyInfo.type">
                        <div class="zan_view" style="cursor: pointer" @click="thumbsupOrCrazilyClick(21)">
                            <i class="iconfont icon-thumb-up-line1"></i>
                            <span>赞({{detailForm.thumbsupNumber}})</span>
                        </div>
                        <div class="zan_view" style="cursor: pointer" @click="thumbsupOrCrazilyClick(22)">
                            <i class="iconfont icon-thumb-down-line1"></i>
                            <span>踩({{detailForm.crazilyNumber}})</span>
                        </div>
                    </template>
                    <template v-else>
                        <div class="zan_view" style="cursor: pointer" v-if="thumbsupOrCrazilyInfo.type==21" @click="cancelThumbsupOrCrazilyClick(21)">
                            <i class="iconfont iconfontActive icon-thumb-up-fill1"></i>
                            <span class="textActive">取消赞({{detailForm.thumbsupNumber}})</span>
                        </div>
                        <div class="zan_view" style="cursor: pointer" v-else @click="cancelThumbsupOrCrazilyClick(22)">
                            <i class="iconfont iconfontActive icon-thumb-down-fill1"></i>
                            <span class="textActive">取消踩({{detailForm.crazilyNumber}})</span>
                        </div>
                    </template>
                </div>
				<el-divider />
				<div class="forum_content" v-html="detailForm.content"></div>
			</div>
			<el-card class="forum_comment_box">
				<el-divider class="comment_divider" content-position="left">评论列表</el-divider>
				<div class="comment_add_box">
					<el-button class="comment_add" @click="commentClick" type="success">发表评论</el-button>
				</div>
				<div class="forum_comment_list">
					<div class="forum_comment" v-for="(item,index) in detailForm.childs" :key="index"
						@mouseenter="commentEnter(index)" @mouseleave="commentLeave">
						<div class="forum_comment_user">
							<img v-if="item.avatarurl" class="forum_comment_user_avatar"
								:src="$config.url + item.avatarurl.split(',')[0]" alt="">
							<img v-else class="forum_comment_user_avatar" src="@/assets/avatar.png" alt="">
							<span class="forum_comment_username">{{item.username}}</span>
						</div>
						<div class="forum_comment_content" v-html="item.content"></div>
						<div class="forum_comment_reply_view">
							<div class="forum_comment_del" v-if="commentShowIndex==index&&item.userid==userid"
								@click="commentDelClick(item.id)">删除</div>
							<div class="forum_comment_reply" v-if="commentShowIndex==index"
								@click="commentReplyClick(item.id)">回复</div>
						</div>
						<div class="forum_comment_second_list" v-if="item.childs">
							<el-divider class="forum_comment_second_divider" content-position="left">回复</el-divider>
							<div class="forum_comment_second" v-for="(items,indexs) in item.childs" :key="indexs"
								@mouseenter="commentEnter1(indexs)" @mouseleave="commentLeave1">
								<div class="forum_comment_second_user">
									<img v-if="items.avatarurl" class="forum_comment_second_user_avatar"
										:src="$config.url + items.avatarurl.split(',')[0]" alt="">
									<img v-else class="forum_comment_second_user_avatar" src="@/assets/avatar.png" alt="">
									<span class="forum_comment_second_username">{{items.username}}</span>
								</div>
								<div class="forum_comment_second_content" v-html="items.content"></div>
								<div class="forum_comment_second_reply_view">
									<div class="forum_comment_second_del" 
										v-if="commentShowIndex==index&&items.userid==userid&&commentShowIndex1==indexs"
										@click="commentDelClick(items.id)">删除</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</el-card>
		</el-dialog>
		<el-dialog v-model="commentVisible" :title="'发表评论'" width="50%" destroy-on-close>
			<el-form class="add_form" :model="commentForm" label-width="120px">
				<el-row>
					<el-col :span="24">
						<el-form-item prop="content" label="内容">
							<editor :value="commentForm.content" placeholder="请输入评论"
								class="list_editor" @change="commentChange"></editor>
						</el-form-item>
					</el-col>
				</el-row>
				
			</el-form>
			<template #footer>
				<span class="formModel_btn_box">
					<el-button class="formModel_cancel" @click="commentVisible=false">关闭</el-button>
					<el-button class="formModel_confirm" type="primary" @click="commentSave">发表</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>

<script setup>
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
	const tableName = 'forum'
	const formName = '论坛交流'
	const router = useRouter()
	const route = useRoute()
	//基础信息
	//权限验证
    const btnAuth = (e, a) => {
        if(context?.$toolUtil.isAuth(e, a)){
            return true
        }
        if(centerType.value){
            return context?.$toolUtil.isBackAuth(e,a)
        }
    }
	const list = ref([])
	const listLoading = ref(false)

	const listQuery = ref({
		page: 1,
		limit: 20,
		isdone: '开放',
		sort: 'isTop,topTime,addtime',
		order: 'desc,desc,desc'
	})
	const myListQuery = ref({
		page: 1,
		limit: 20,
		parentid: 0,
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
		let params = myType.value ? JSON.parse(JSON.stringify(myListQuery.value)) : JSON.parse(JSON.stringify(listQuery
			.value))
		if (searchQuery.value.title && searchQuery.value.title != '') {
			params['title'] = `%${searchQuery.value.title}%`
		}
		context?.$http({
			url: `forum/${myType.value?'page':'flist'}`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = res.data.data.total
		})
	}
	const userid = ref(0)
	const form = ref({
		title: '',
		isdone: '开放',
		content: '',
		parentid: 0,
		userid: userid.value,
		username: context?.$toolUtil.storageGet('frontName'),
        avatarurl:context?.$toolUtil.storageGet('headportrait')||''
	})
	const rules = ref({
		title: [{
			required: true,
			message: '请输入标题',
			trigger: 'blur'
		}, ],
		content: [{
			required: true,
			message: '请输入内容',
			trigger: 'blur'
		}, ],
	})
	const formRef = ref(null)
	const formVisible = ref(false)
	const formTitle = ref('')
	const forumShowIndex = ref(-1)
	//判断按钮显示
	const forumEnter = (index) => {
		forumShowIndex.value = index
	}
	const forumLeave = () => {
		forumShowIndex.value = -1
	}
	const resetForm = () => {
		form.value = {
			title: '',
			isdone: '开放',
			content: '',
			parentid: 0,
			userid: userid.value,
			username: context?.$toolUtil.storageGet('frontName'),
            avatarurl:context?.$toolUtil.storageGet('headportrait')||''
		}
	}
	//发布新贴
	const addClick = () => {
		resetForm()
		formTitle.value = '发布新帖'
		formVisible.value = true
	}
	//修改帖子
	const editClick = (id = null) => {
		if (id) {
			context?.$http({
				url: `forum/detail/${id}`,
				method: 'get'
			}).then(res => {
				form.value = res.data.data
				formTitle.value = '修改帖子'
				formVisible.value = true
			})
		}
	}
	//帖子内容回调
	const contentChange = (e)=>{
		form.value.content = e
	}
	//判断是否调我的发布列表
	const myType = ref(false)
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	//初始化
	const init = () => {
		if (route.query.centerType) {
			centerType.value = true
		}
		if (route.query.myType) {
			myType.value = true
		}
		userid.value = context?.$toolUtil.storageGet('userid')
		getList()
	}
	const detailVisible = ref(false)
	const detailForm = ref({})
	//详情
	const detailClick = (id = null) => {
		if (id) {
			context?.$http({
				url: `forum/list/${id}`,
				method: 'get'
			}).then(res => {
				detailForm.value = res.data.data
                // 赞踩状态
                getThumbsupOrCrazily()
				detailVisible.value = true
			})
		}
	}
	//删除
	const delClick = (id = null) => {
		if (id) {
			ElMessageBox.confirm(`是否删除选中帖子`, '提示', {
				confirmButtonText: '是',
				cancelButtonText: '否',
				type: 'warning',
			}).then(() => {
				context?.$http({
					url: `forum/delete`,
					method: 'post',
					data: [id]
				}).then(res => {
					context?.$toolUtil.message('删除成功', 'success', () => {
						getList()
					})
				})
			}).catch(_ => {})
		}
	}
	//发布帖子
	const save = () => {
		formRef.value.validate((valid) => {
			if (valid) {
				context?.$http({
					url: `forum/${form.value.id?'update':'add'}`,
					method: 'post',
					data: form.value
				}).then(res => {
					context?.$toolUtil.message(`${form.value.id?'修改':'发布'}成功`, 'success', () => {
						getList()
						formVisible.value = false
					})
				})
			}
		})
	}
	//评论
	const commentForm = ref({
		content: '',
		parentid: '',
		userid: '',
		username: '',
		avatarurl: '',
	})
	const commentVisible = ref(false)
	//重置评论
	const resetCommentForm = () => {
		commentForm.value = {
			content: '',
			parentid: '',
			userid: context?.$toolUtil.storageGet('userid'),
			username: context?.$toolUtil.storageGet('frontName'),
			avatarurl: context?.$toolUtil.storageGet('headportrait') ? context?.$toolUtil.storageGet('headportrait') : '',
		}
	}
	//发表评论
	const commentClick = () => {
		resetCommentForm()
		commentForm.value.parentid = detailForm.value.id
		commentVisible.value = true
	}
	//回复按钮显示
	const commentShowIndex = ref(-1)
	const commentShowIndex1 = ref(-1)
	const commentEnter = (index) => {
		commentShowIndex.value = index
	}
	const commentLeave = () => {
		commentShowIndex.value = -1
	}
	const commentEnter1 = (index) => {
		commentShowIndex1.value = index
	}
	const commentLeave1 = () => {
		commentShowIndex1.value = -1
	}
	//评论内容回调
	const commentChange = (e)=>{
		commentForm.value.content = e
	}
	//发表保存
	const commentSave = () => {
		if(commentForm.value.content==''){
			context?.$toolUtil.message(`请输入内容`, 'error')
			return false
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
		context?.$http({
			url: 'forum/add',
			method: 'post',
			data: commentForm.value
		}).then(res => {
			context?.$toolUtil.message(`发表成功`, 'success', () => {
				detailClick(detailForm.value.id)
				commentVisible.value = false
			})
		})
	}
	//评论删除
	const commentDelClick = (id = null) => {
		if (id) {
			ElMessageBox.confirm(`是否删除选中评论`, '提示', {
				confirmButtonText: '是',
				cancelButtonText: '否',
				type: 'warning',
			}).then(() => {
				context?.$http({
					url: `forum/delete`,
					method: 'post',
					data: [id]
				}).then(res => {
					context?.$toolUtil.message('删除成功', 'success', () => {
						detailClick(detailForm.value.id)
					})
				})
			}).catch(_ => {})
		}
	}
	//评论回复
	const commentReplyClick = (id = null) => {
		if (id) {
			resetCommentForm()
			commentForm.value.parentid = id
			commentVisible.value = true
		}
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
                    limit: 99,
                    refid: detailForm.value.id,
                    tablename: 'forum',
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
            name: detailForm.value.title,
            picture: '',
            refid: detailForm.value.id,
            type: type,
            tablename: 'forum',
            userid: context?.$toolUtil.storageGet('userid')
        }
        context?.$http({
            url: 'storeup/add',
            method: 'post',
            data: params
        }).then(res => {
            if (type == 21) detailForm.value.thumbsupNumber += 1
            if (type == 22) detailForm.value.crazilyNumber += 1
            context?.$http({
                url: `forum/update`,
                method: 'post',
                data: detailForm.value
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
            if (type == 21 && detailForm.value.thumbsupNumber>0) detailForm.value.thumbsupNumber -= 1
            if (type == 22 && detailForm.value.crazilyNumber>0) detailForm.value.crazilyNumber -= 1
            context?.$http({
                url: `forum/update`,
                method: 'post',
                data: detailForm.value
            })
            getThumbsupOrCrazily()
            context?.$toolUtil.message('取消成功', 'success')
        })
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
			// 新增按钮
			.add_btn {
			}
			// 新增按钮-悬浮
			.add_btn:hover {
			}
		}
	}
	// 列表盒子
	.forum_list {
		// item
		.forum_item {
			// item左部
			.forum_item_left {
				// 标题
				.forum_item_title {
				}
				// 发布人
				.forum_item_name {
				}
			}
			// 按钮盒子
			.forum_item_btn_box {
				// 修改按钮
				.forum_edit_btn {
				}
				// 修改按钮-悬浮
				.forum_edit_btn:hover {
				}
				// 删除按钮
				.forum_del_btn {
				}
				// 删除按钮-悬浮
				.forum_del_btn:hover {
				}
			}
			// 时间
			.forum_time {
			}
		}

		.forum_item:hover {
		}
	}

	//帖子详情
	.forum_detail {

		.forum_title {
		}

		.forum_info {
			.forum_name {
			}
			.forum_time {
			}
		}

		.forum_content {
		}
	}
	// 评论盒子
	.forum_comment_box {
		// 分割线
		:deep(.comment_divider) {
			border: none;
			background: #dcdfe6;
			// 分割线文字样式
			.el-divider__text {
				font-size: 16px;
			}
		}
		// 新增评论盒子
		.comment_add_box {
			margin: 0 0 20px;
			text-align: right;
			// 按钮
			.comment_add {
			}
			// 按钮-悬浮
			.comment_add:hover {
			}
		}
		//帖子评论
		.forum_comment_list {
			// 评论item
			.forum_comment {
				// 评论用户盒子
				.forum_comment_user {
					// 用户头像
					.forum_comment_user_avatar {
					}
					// 用户名
					.forum_comment_username {
					}
				}
				// 评论内容
				.forum_comment_content {
				}
				// 回复按钮盒子
				.forum_comment_reply_view {
					// 删除按钮
					.forum_comment_del {
					}
					// 删除按钮-悬浮
					.forum_comment_del:hover {
					}
					// 回复按钮
					.forum_comment_reply {
					}
					// 回复按钮-悬浮
					.forum_comment_reply:hover {
					}
				}
				// 二级评论盒子
				.forum_comment_second_list {
					// 分割线
					:deep(.forum_comment_second_divider) {
						border: none;
						background: #dcdfe6;
						// 分割线文字样式
						.el-divider__text {
							font-size: 16px;
						}
					}
					// 二级评论item
					.forum_comment_second {
						// 用户盒子
						.forum_comment_second_user {
							// 用户头像
							.forum_comment_second_user_avatar {
							}
							// 用户名
							.forum_comment_second_username {
							}
						}
						// 二级内容
						.forum_comment_second_content {
						}
						// 二级按钮盒子
						.forum_comment_second_reply_view {
							// 二级删除
							.forum_comment_second_del {
							}
							// 二级删除-悬浮
							.forum_comment_second_del:hover {
							}
						}
					}
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
	// 表单
	.add_form{
		// form item
		:deep(.el-form-item) {
			//label
			.el-form-item__label {
			}
			// 内容盒子
			.el-form-item__content {
				// 输入框
				.list_inp {

				}
				// 富文本
				.list_editor {
				}
				//单选框样式
				.list_radio {
					//未选中样式
					.el-radio {
						//单选框
						.el-radio__inner {
						}
						//提示文字
						.el-radio__label{
						}
					}
					//选中样式
					.is-checked {
						//单选框
						.el-radio__inner {
						}
						//提示文字
						.el-radio__label{
						}
					}
				}
			}
		}
	}
	// 按钮盒子
	.formModel_btn_box {
		.formModel_cancel {
		}
		.formModel_cancel:hover {
		}
		
		.formModel_confirm {
		}
		.formModel_confirm:hover {
		}
	}
</style>
<style>
/*总盒子*/
.forum_view {
    width: 100%;
    margin: 0px auto;
    padding: 20px calc((100% - 1200px)/2);
    background: #eee;
    overflow: hidden;
}
.forum_view .title{
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
/*搜索盒子*/
.forum_view .list_search{
    width: 100%;
    margin: 30px auto;
    display:flex;
    align-items:center;
    justify-content:center;
}
.forum_view .list_search .search_view{
    display:flex;
    align-items:center;
    margin-right:10px;
}
.forum_view .list_search .search_view .search_label{
    font-size:16px;
    white-space: nowrap;
}
.forum_view .list_search .search_view .search_box{
}
.forum_view .list_search .search_view .search_box .search_inp{
    padding:0 10px;
    border:1px solid #ddd;
    font-size:15px;
    height:38px;
    border-radius:4px;
    background:#fff;
}
.forum_view .list_search .search_btn_view .search_btn{
    background: var(--theme);
    color: rgb(255, 255, 255);
    border:0;
    border-radius:4px;
    height:38px;
    font-size:15px;
}
.forum_view .list_search .search_btn_view .search_btn:hover{
}
.forum_view .list_search .search_btn_view .add_btn{
    background: #00cab9;
    color: rgb(255, 255, 255);
    border:0;
    border-radius:4px;
    height:38px;
    font-size:15px;
}
.forum_view .list_search .search_btn_view .add_btn:hover{
}

/*列表盒子*/
.forum_view .forum_list{
    width: 100%;
    margin: 20px auto;
    padding: 20px 20px 40px;
    display:flex;
    flex-wrap:wrap;
    align-items:center;
    justify-content: space-between;
    border-radius: 10px;
    background: #fff;
}
/*item*/
.forum_view .forum_list .forum_item{
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0px 16px;
    cursor: pointer;
    color: rgb(102, 102, 102);
    height: 60px;
    border-image: initial;
    font-size: 16px;
    border-bottom: 2px solid var(--theme);
    border-radius: 0px;
    margin: 0px 0px 0px;
}
.forum_view .forum_list .forum_item:last-child{
}
.forum_view .forum_list .forum_item:hover{
}
/*左边内容盒子*/
.forum_view .forum_list .forum_item .forum_item_left{
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex:1;
    margin:0 120px 0 0;
}
/*标题*/
.forum_view .forum_list .forum_item .forum_item_left .forum_item_title{
    font-size: 16px;
    color: rgb(51, 51, 51);
    font-weight: 600;
    margin:0 auto 0 0;
}
.forum_view .forum_list .forum_item:hover .forum_item_left .forum_item_title{
    color: var(--theme);
}

/*发布人*/
.forum_view .forum_list .forum_item .forum_item_left .forum_item_name{
    color: rgb(153, 153, 153);
}
/*时间*/
.forum_view .forum_list .forum_item .forum_time{
    font-size: 15px;
    color: rgb(153, 153, 153);
}
/*按钮盒子*/
.forum_view .forum_list .forum_item .forum_item_btn_box{
    width:auto;
}
/*修改*/
.forum_view .forum_list .forum_item .forum_item_btn_box .forum_edit_btn{
    margin: 0px 10px 0px 0px;
    padding: 0px 24px;
    width: auto;
    height: 34px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: var(--theme);
    cursor: pointer;
}
/*删除*/
.forum_view .forum_list .forum_item .forum_item_btn_box .forum_del_btn{
    margin: 0px 10px 0px 0px;
    padding: 0px 24px;
    width: auto;
    height: 34px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: rgba(254, 66, 66, 0.8);
    cursor: pointer;
}

/*详情盒子*/
.forum_view .forum_detail{
    width: 100%;
    margin: 20px 0px;
    border-radius: 10px;
    background: #fff;
    padding:20px;
}
/*标题*/
.forum_view .forum_detail .forum_title{
    width: 100%;
    text-align: center;
    font-size: 22px;
    font-weight: bold;
    color: rgb(0, 0, 0);
}
/*info盒子*/
.forum_view .forum_detail .forum_info{
    width: 100%;
    text-align: center;
    color: rgb(153, 153, 153);
    font-size: 16px;
    margin: 20px 0px 10px;
}
/*发布人*/
.forum_view .forum_detail .forum_info .forum_name{
    margin: 0px 10px 0px 0px;
}
/*时间*/
.forum_view .forum_detail .forum_info .forum_time{
    margin: 0px 10px 0px 0px;
}
/*分割线*/
.forum_view .forum_detail .el-divider--horizontal{
    display: block;
    height: 0px;
    width: 100%;
    margin: 24px 0;
}
/*内容区*/
.forum_view .forum_detail .forum_content{
    width: 100%;
    text-align: left;
    font-size: 16px;
    color: rgb(102, 102, 102);
    text-indent: 2rem;
}

/*一级评论 盒子*/
.forum_view .forum_comment_box{
    margin: 40px 0px 0px;
    width: 100%;
    padding: 20px;
    border: 0px solid rgb(238, 238, 238);
    box-shadow: none;
    border-radius: 10px;
    background: #fff;
}
.forum_view .forum_comment_box .el-card__body{
    padding: 0px;
}
/*列表盒子*/
.forum_view .forum_comment_box .forum_comment_list{
    width: 100%;
    text-align: left;
}
/*item*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment{
    width: 100%;
    border: 1px solid #eee;
    border-radius: 4px;
    margin: 0px 0px 40px;
}
/*用户盒子*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_user{
    display: flex;
    align-items: center;
    background: none;
    padding: 5px 10px;
}
/*头像*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_user .forum_comment_user_avatar{
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin: 0px 10px 0px 0px;
}
/*用户名*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_user .forum_comment_username{
    font-size: 16px;
    color: #333;
}
/*内容*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_content{
    width: calc(100% - 60px);
    margin: 0px 0px 0px 60px;
    padding: 10px 0px 0px;
    font-size: 16px;
}
/*按钮盒子*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_reply_view{
    width: 100%;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding: 0px 20px 0px 0px;
    box-sizing: border-box;
}
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_reply_view .forum_comment_del{
    font-size: inherit;
    color: rgb(255, 255, 255);
    cursor: pointer;
    margin: 0px 0px 0px 10px;
    background: rgb(251, 137, 122);
    padding: 5px 10px;
    border-radius: 4px;
}
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_reply_view .forum_comment_reply{
    font-size: inherit;
    color: rgb(255, 255, 255);
    cursor: pointer;
    margin: 0px 0px 0px 10px;
    background: #00cab9;
    padding: 5px 10px;
    border-radius: 4px;
}

/*新增评论 按钮*/
.forum_view .forum_comment_box  .comment_add{
    margin: 0px 10px 0px 0px;
    padding: 0px 24px;
    width: auto;
    height: 40px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: var(--theme);
    cursor: pointer;
}

/*二级评论 盒子*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list{
    width: calc(100% - 60px);
    margin: 0px 0px 0px 60px;
    padding: 20px 0px 0px;
}
/*线*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second_divider{
    display: block;
    height: 1px;
    width: 100%;
    margin: 24px 0;
}
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second_divider .el-divider__text{
    font-size: 16px;
}
/*item*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second{
    width: 100%;
    padding: 10px 0px;
    border-width: 0px 0px 1px;
    border-style: solid;
    border-color: rgb(238, 238, 238);
    border-image: initial;
}
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second:last-child{
    border-width: 0px 0px 0px;
}

/*用户盒子*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second .forum_comment_second_user{
    display: flex;
    align-items: center;
}
/*头像*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second .forum_comment_second_user .forum_comment_second_user_avatar{
    width: 50px;
    height: 50px;
    border-radius: 50%;
    margin: 0px 10px 0px 0px;
}
/*用户名*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second .forum_comment_second_user .forum_comment_second_username{
    font-size: 16px;
}
/*内容*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second .forum_comment_second_content{
    width: calc(100% - 60px);
    margin: 0px 0px 0px 60px;
    padding: 10px 0px 0px;
    color:#999;
    font-size: 16px;
}
/*按钮盒子*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second .forum_comment_second_reply_view{
    width: 100%;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding: 0px 20px 0px 0px;
    box-sizing: border-box;
}
/*删除*/
.forum_view .forum_comment_box .forum_comment_list .forum_comment .forum_comment_second_list .forum_comment_second .forum_comment_second_reply_view .forum_comment_second_del{
    font-size: inherit;
    color: rgb(255, 255, 255);
    cursor: pointer;
    margin: 0px 0px 0px 10px;
    background: rgb(251, 137, 122);
    padding: 5px 10px;
    border-radius: 4px;
}

</style>