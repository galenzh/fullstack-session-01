<template>
	<div class="center_view" :style='{}'>
		<div class="section_title">
			<span>{{formName}}</span>
		</div>
		<div class="usersView">
			<div class="usersTabView">
				<div class="usersTab" :class="tabIndex=='center'?'usersTabActive':''" @click="tabClick({tableName:'center'})">个人中心</div>
				<div class="usersTab " :class="tabIndex=='updatePassword'?'usersTabActive':''" @click="tabClick({tableName:'updatePassword'})">修改密码</div>
                <div class="usersTab " :class="tabIndex=='chat'?'usersTabActive':''" @click="tabClick({tableName:'chat'})">聊天记录</div>
				<template v-for="(item,index) in menuList">
					<div v-if="item.child.length>1" class="usersTab" @mouseenter="usersTabHover(index)"
						 @mouseleave="usersTabLeave">
						{{item.menu}}
						<el-collapse-transition>
							<div class="usersTabHoverView" v-if="usersTabIndex==index">
								<div class="usersTabHoverTab" v-for="(items,indexs) in item.child" @click="tabClick(items)">
									{{items.menu}}
                                </div>
							</div>
						</el-collapse-transition>
					</div>
					<div v-else-if="hasBack(item.child[0]) " class="usersTab" @click="tabClick(item.child[0])">
						{{item.child[0].menu}}
					</div>
				</template>
                <div class="usersTab" @click="tabClick({tableName:'storeup',type:1})">我的收藏</div>
			</div>
			<div class="usersBox updateInfo" v-if="tabIndex=='center'">
				<el-form class="usersForm" ref="userFormRef" :model="userForm" label-width="120px" :rules="rules">
					<el-row>
						<el-col :span="12">
							<el-form-item prop="zhanghao" label="账号">
								<el-input class="list_inp" v-model="userForm.zhanghao" placeholder="账号" readonly></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="xingming" label="姓名">
								<el-input class="list_inp" v-model="userForm.xingming" placeholder="姓名" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="性别" prop="xingbie">
								<el-select
									class="list_sel"
									v-model="userForm.xingbie" 
									placeholder="请选择性别"
									style="width:100%;"
									>
									<el-option v-for="(item,index) in xingbieLists" :label="item" :value="item">
									</el-option>
								</el-select>
							</el-form-item>
						</el-col>
						<el-col :span="24">
							<el-form-item prop="touxiang" label="头像">
								<uploads
									action="file/upload" 
									tip="请上传头像"
									style="width: 100%;text-align: left;"
									:fileUrls="userForm.touxiang?userForm.touxiang:''" 
									@change="touxiangUploadSuccess">
								</uploads>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="nianling" label="年龄">
								<el-input class="list_inp" v-model="userForm.nianling" placeholder="年龄" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="shouji" label="手机">
								<el-input class="list_inp" v-model="userForm.shouji" placeholder="手机" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="email" label="邮箱">
								<el-input class="list_inp" v-model="userForm.email" placeholder="邮箱" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="jf" label="积分">
								<el-input class="list_inp" v-model="userForm.jf" placeholder="积分" readonly></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="money" label="余额">
								<div class="vip_item">
									<el-input class="vip_inp" v-model="userForm.money" placeholder="余额" readonly></el-input>
									<el-button class="vip_btn" @click="rechargeClick">点我充值</el-button>
								</div>
							</el-form-item>
						</el-col>
					</el-row>
					<div class="formModel_btn_box">
						<el-button class="formModel_confirm" @click="updateSession">更新信息</el-button>
						<el-button class="formModel_cancel" @click="loginout" type="danger">退出登录</el-button>
					</div>
				</el-form>
			</div>
			<div class="usersBox updatePassword" v-if="tabIndex=='updatePassword'">
				<el-form class="usersForm" ref="passwordFormRef" :model="passwordForm" label-width="120px"
					:rules="passwordRules">
					<el-row>
						<el-col :span="12">
							<el-form-item label="原密码" prop="mima">
								<el-input class="list_inp" v-model="passwordForm.mima" placeholder="原密码"
									type="password"></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="新密码" prop="newmima">
								<el-input class="list_inp" v-model="passwordForm.newmima" placeholder="新密码"
									type="password"></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="确认密码" prop="newmima2">
								<el-input class="list_inp" v-model="passwordForm.newmima2" placeholder="确认密码"
									type="password"></el-input>
							</el-form-item>
						</el-col>
					</el-row>
					<div class="formModel_btn_box">
						<el-button class="formModel_confirm" @click="updatePassword">修改密码</el-button>
					</div>
				</el-form>
			</div>
			<div class="usersBox chatRecord" v-if="tabIndex=='chat'">
				<div class="z-box" :style='{"width":"70%","padding":"20px","margin":"0 auto"}'>
					<div class="section-content" v-for="item in recordList" :key="item.id" @click="chatClick(item)">
						<img :src="item.picture?$config.url + item.picture:require('@/assets/avatar.png')" style="width: 60px;height:60px;border-radius: 50%;object-fit: cover;"
							 alt="">
						<div style="margin: 0 0 0 10px;display: flex;flex-direction: column;align-items: flex-start;">
							<div :style='{"fontSize":"14px","color":"#000","flex":"1","fontWeight":"bold"}'
								 class="item-style">{{item.name}}</div>
							<div :style='{"color":"#666","flex":"1","fontSize":"14px","lineHeight":"1.5","display":"flex","alignItems":"center"}'
								 class="item-style">
								<div v-if="item.notreadnum" style="padding: 0 5px;height: 16px;border-radius: 50%;text-align: center;line-height: 16px;font-size: 12px;background: #f00;color:#fff;width: auto;margin: 0 2px 0 0">{{item.notreadnum}}</div>
								{{item.content.split('/').length>1&&item.content.split('/')[0]=='upload'?'[图片]':item.content}}
							</div>
						</div>
					</div>
					<div class="noList" v-if="!recordList.length">
						暂无聊天记录
					</div>
				</div>
			</div>
		</div>
		<el-dialog v-model="rechargeVisible" :title="'用户充值'" width="50%" destroy-on-close class="rechargeDialog">
			<div class="centerPayInpView">
				<el-input class="pay_inp" v-model.number="rechargeForm.money" placeholder="充值金额" :min="1"></el-input>
			</div>
			<div class="centerPayList">
				<div class="centerPayView">
					<el-radio v-model="payType" label="1"><img src="@/assets/pay/weixin.png" alt>微信支付</el-radio>
				</div>
				<div class="centerPayView">
					<el-radio v-model="payType" label="2"><img src="@/assets/pay/zhifubao.png" alt>支付宝支付</el-radio>
				</div>
				<div class="centerPayView">
					<el-radio v-model="payType" label="3"><img src="@/assets/pay/yinhangka.png" alt>银行卡支付<el-icon :class="payType==3?'active':''"><ArrowDown /></el-icon></el-radio>
				</div>
				<el-collapse-transition>
					<div class="yinhang_view" v-show="payType==3">
						<div class="centerPayView">
							<el-radio v-model="payType1" label="1"><img src="@/assets/pay/zhonghang.png" alt>中国银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="2"><img src="@/assets/pay/nongye.png" alt>中国农业银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="3"><img src="@/assets/pay/jianshe.png" alt>中国建设银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="4"><img src="@/assets/pay/gonghang.png" alt>中国工商银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="5"><img src="@/assets/pay/jiaotong.png" alt>交通银行</el-radio>
						</div>
					</div>
				</el-collapse-transition>
				<div class="centerPayView">
					<el-radio v-model="payType" label="4"><img src="@/assets/pay/yunshanfu.png" alt>云闪付</el-radio>
				</div>
			</div>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="rechargeVisible=false">取消</el-button>
					<el-button type="primary" @click="rechargeSave">
						充值
					</el-button>
				</span>
			</template>
		</el-dialog>
		<el-dialog v-model="chatVisible" @close="clearChat" :title="nowname">
			<div class="chat-content" id="chat-content">
				<div v-bind:key="item.id" v-for="(item,index) in chatList">
                    <div v-if="index>1&&moment(chatList[index-1].addtime).date()!=moment(item.addtime).date()||index==0"
                         style="font-size: 12px;text-align: center;margin: 4px 0;">
                        {{moment(item.addtime).format("MM-DD HH:mm")}}
                    </div>
					<div v-if="item.uid==userForm.id" class="right-content">
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
								  type="warning"></el-alert>
                        <video v-else-if="item.content.endsWith('.mp4')" controls style="width: 200px;height: 160px">
                            <source  :src="$config.url + item.content">
                        </video>
						<el-image v-else fit="cover" :src="item.content?$config.url + item.content:''" style="width: 100px;height: 100px;" :preview-src-list="[item.content?$config.url + item.content:'']"></el-image>
						<img :src="mypic?$config.url + mypic:require('@/assets/avatar.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 0 0 10px;flex-shrink: 0;object-fit: cover;" />
					</div>
					<div v-else class="left-content">
						<img :src="nowfpic?$config.url + nowfpic:require('@/assets/avatar.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 10px 0 0;flex-shrink: 0;object-fit: cover;" />
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
								  type="success"></el-alert>
                        <video v-else-if="item.content.endsWith('.mp4')" controls style="width: 200px;height: 160px">
                            <source  :src="$config.url + item.content">
                        </video>
						<el-image v-else fit="cover" :src="item.content?$config.url + item.content:''" style="width: 100px;height: 100px;" :preview-src-list="[item.content?$config.url + item.content:'']"></el-image>
					</div>
					<div class="clear-float"></div>
				</div>
			</div>
			<div slot="footer" class="dialog-footer">
				<el-input @keydown.enter.native="addChat" v-model="chatForm.content" placeholder="请输入内容" style="width: calc(100% - 180px);float: left;border: 1px solid #ccc;margin-right: 10px;">
				</el-input>
				<el-button :disabled="chatForm.content?false:true" type="primary" @click="addChat">发送</el-button>
				<el-upload style="display: inline-block;margin: 0 0 0 6px;" class="upload-demo" :action="uploadUrl" :on-success="uploadSuccess"
						   :show-file-list="false" accept="image/*,.mp4">
					<el-button type="success">上传文件</el-button>
				</el-upload>
			</div>
		</el-dialog>
	</div>
</template>
<script setup>
	import {
		ElMessageBox
	} from 'element-plus'
	import moment from 'moment'
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	import { useStore } from 'vuex'
	const store = useStore()
	import menu from '@/utils/menu'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'yonghu'
	const formName = '个人中心'
	//基础信息
	const uploadUrl = context.$config.url + 'file/upload'
	//个人信息
	const userFormRef = ref(null)
	const userForm = ref({})
	//修改密码
	const passwordFormRef = ref(null)
	const passwordForm = ref({
		mima: '',
		newmima: '',
		newmima2: ''
	})
	const passwordRules = ref({
		mima: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ],
		newmima: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ],
		newmima2: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ],
	})
	//验证规则
	const rules = ref({
		zhanghao: [
		],
		mima: [
		],
		xingming: [
		],
		xingbie: [
		],
		touxiang: [
		],
		nianling: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		shouji: [
			{ validator: context.$toolUtil.validator.mobile, trigger: 'blur' },
		],
		email: [
			{ validator: context.$toolUtil.validator.email, trigger: 'blur' },
		],
		jf: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		money: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
	})
	const getSession = () =>{
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method:'get'
		}).then(res=>{
			context?.$toolUtil.storageSet('userid',res.data.data.id)
			context?.$toolUtil.storageSet("frontName", res.data.data.zhanghao)
			context?.$toolUtil.storageSet('headportrait',res.data.data.touxiang)
			userForm.value = res.data.data
		})
	}
	//菜单跳转
	const tabIndex = ref('center')
	const tabClick = (item) => {
		if (item.tableName == 'center') {
			tabIndex.value = 'center'
			return
		}
		if (item.tableName == 'updatePassword') {
			passwordForm.value = {
				mima: '',
				newmima: '',
				newmima2: ''
			}
			tabIndex.value = 'updatePassword'
			return
		}
		if (item.tableName == 'chat') {
			getRecordList()
			tabIndex.value = 'chat'
			return
		}
		if(item.tableName=='examrecord'&&item.menuJump=='22'){
			router.push(`/index/examfailrecord?centerType=1`)
			return
		}
		if(item.tableName=='forum'&&item.menuJump=='14'){
			router.push(`/index/forumList?centerType=1&&myType=1`)
			return
		}
        if(item.tableName=='storeup'){
            router.push(`/index/storeupList?centerType=1&&type=${item.type}`)
            return;
        }
        router.push(`/index/${item.classname||item.tableName}List?centerType=1${item.menuJump?'&menuJump='+item.menuJump:''}`)
	}
    const hasBack = (menu)=>{
        if(menu.tableName=='storeup'){
            return false
        }
        return true
    }
	// 修改密码
	const updatePassword = async ()=>{
		passwordFormRef.value.validate(async (valid) => {
			if (valid) {
				if(passwordForm.value.mima != userForm.value.mima){
					context?.$toolUtil.message('原密码不正确', 'error')
					return false
				}
				if(passwordForm.value.newmima != passwordForm.value.newmima2){
					context?.$toolUtil.message('两次密码输入不正确', 'error')
					return false
				}
				userForm.value.mima = passwordForm.value.newmima
				store.dispatch('user/update',userForm.value).then(res=>{
					if(res?.data&&res.data.code==0){
						context?.$toolUtil.message('更新成功','success')
						passwordForm.value = {
							mima: '',
							newmima: '',
							newmima2: ''
						}
						getSession()
					}
				})
			}
		})
	}
	//菜单
	const menuList = ref([])
	const role = ref('')
	//性别列表
	const xingbieLists = ref([])
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		userForm.value.touxiang = e
	}
	//初始化
	const init = () => {
		const menus = menu.list()
		let arr = []
		if (menus) {
			menuList.value = menus
		}
		role.value = context?.$toolUtil.storageGet('frontRole')
		for (let i = 0; i < menuList.value.length; i++) {
			if (menuList.value[i].roleName == role.value) {
				arr = menuList.value[i].backMenu
				break;
			}
		}
		menuList.value = arr
		xingbieLists.value = "男,女".split(',')
		getSession()
	}
	//菜单悬浮的显示与隐藏
	const usersTabIndex = ref(-1)
	const usersTabHover = (index) => {
		usersTabIndex.value = index
	}
	const usersTabLeave = () => {
		usersTabIndex.value = -1
	}
	//付款方式
	const payType = ref('')
	const payType1 = ref('')
	//充值
	const rechargeVisible = ref(false)
	const rechargeForm = ref({
		money:''
	})
	const rechargeClick = () => {
		payType.value = ''
		payType1.value = ''
		rechargeForm.value = {
			money:''
		}
		rechargeVisible.value = true
	}
	//充值保存
	const rechargeSave = () => {
		if(rechargeForm.value.money==''){
			context?.$toolUtil.message('请输入充值金额','error')
			return false
		}
		if(rechargeForm.value.money<=0){
			context?.$toolUtil.message('请输入正确充值金额','error')
			return false
		}
		if(typeof rechargeForm.value.money !== 'number'){
			context?.$toolUtil.message('请输入正确充值金额','error')
			return false
		}
		if(payType.value==''){
			context?.$toolUtil.message('请选择充值方式','error')
			return false
		}
		if(payType.value==3&&payType1.value==''){
			context?.$toolUtil.message('请选择充值银行','error')
			return false
		}
		let params = JSON.parse(JSON.stringify(userForm.value))
		params.money = parseFloat(params.money) + parseFloat(rechargeForm.value.money)
		store.dispatch('user/update',params).then(res=>{
			if(res?.data&&res.data.code==0){
				context?.$toolUtil.message('充值成功','success')
				rechargeVisible.value = false
				getSession()
			}
		})
	}
	//富文本
	const editorChange = (e,name) =>{
		userForm.value[name] = e
	}
	//保存
	const updateSession = () => {
		userFormRef.value.validate((valid)=>{
			if(valid){
				if(userForm.value.touxiang!=null){
					userForm.value.touxiang = userForm.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
				}
				store.dispatch('user/update',userForm.value).then(res=>{
					if(res?.data&&res.data.code==0){
						context?.$toolUtil.message('更新成功','success')
						getSession()
					}
				})
			}
		})
	}
	//退出登录
	const loginout = () => {
		context?.$toolUtil.message('退出成功', 'success')
		context?.$toolUtil.storageClear()
		router.replace('/index/home')
	}
	const recordList = ref([])
	const chatVisible = ref(false)
	const nowfid = ref(0)
	const nowfpic = ref('')
	const nowname = ref('')
	const mypic = ref(localStorage.getItem('headportrait'))
	const chatList = ref([])
	const chatForm = ref({
		content: ''
	})
	const chatTimer = ref(null)
	const getRecordList = () => {
		context.$http.get('chatfriend/page2', {
			params: {
				uid: Number(localStorage.getItem('userid')),
				type: 2
			}
		}).then(res => {
			if (res.data && res.data.code == 0) {
				recordList.value = res.data.data.list
			}
		})
	}
	const chatClick = (row) => {
		nowfid.value = row.fid
		nowfpic.value = row.picture
		nowname.value = row.name
		getChatList()
		chatVisible.value = true
	}
    const scrollFlag = ref(true)
	const getChatList = () => {
		context.$http.get('chatmessage/mlist', {
			params: {
				page: 1,
				limit: 1000,
				uid: Number(localStorage.getItem('userid')),
				fid: nowfid.value
			}
		}).then(res => {
			if (res.data && res.data.code == 0) {
				chatList.value = res.data.data.list
				let div = document.getElementsByClassName('chat-content')[0]
				setTimeout(() => {
                    if (div){
                        if(div.scrollTop+div.clientHeight==div.scrollHeight || scrollFlag.value){
                            div.scrollTop = div.scrollHeight
                            scrollFlag.value = false
                        }
                    }
				}, 0)
				chatTimer.value = setTimeout(() => {
					getChatList()
				}, 5000)
			}
		})
	}
	const clearChat = () => {
		clearTimeout(chatTimer.value)
		chatList.value = []
		getRecordList()
	}
	const uploadSuccess = (res) => {
		if (res.code == 0) {
			clearTimeout(chatTimer.value)
			context.$http.post('chatmessage/add', {
				uid: Number(localStorage.getItem('userid')),
				fid: nowfid.value,
				content: 'file/' + res.file,
				format: 2
			}).then(res2 => {
				chatForm.value = {
					content: ''
				}
                scrollFlag.value = true
				getChatList()
			})
		}
	}
	const addChat = () => {
		clearTimeout(chatTimer.value)
        let sensitiveWords = "去死,你妹的,艹,他妈的";
        let sensitiveWordsArr = [];
        if (sensitiveWords) {
            sensitiveWordsArr = sensitiveWords.split(",");
        }
        for (var i = 0; i < sensitiveWordsArr.length; i++) {
            //全局替换
            var reg = new RegExp(sensitiveWordsArr[i], "g");
            //判断内容中是否包括敏感词
            if (chatForm.value.content.indexOf(sensitiveWordsArr[i]) > -1) {
                // 将敏感词替换为 **
                chatForm.value.content = chatForm.value.content.replace(reg, "**");
            }
        }
		context.$http.post('chatmessage/add', {
			uid: Number(localStorage.getItem('userid')),
			fid: nowfid.value,
			content: chatForm.value.content,
			format: 1
		}).then(res2 => {
			chatForm.value = {
				content: ''
			}
            scrollFlag.value = true
			getChatList()
		})
	}
	init()
</script>

<style lang="scss" scoped>
	.usersView {

		.usersTabView {

			.usersTab {

				.usersTabHoverView {
					padding: 10px 0px;
					z-index: 999;
					top: 100%;
					background: #fff;
					display: block;
					width: 200px;
					position: absolute;
					right: 0;
					.usersTabHoverTab {
						color: #333;
						line-height: 40px;
					}
					.usersTabHoverTab:hover {
						color: #B20002;
					}
				}
			}
			.usersTab:hover {
			}
			.usersTabActive {
			}
		}

		.usersBox {
			.usersForm {
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
						// 下拉框
						.list_sel {
							//去掉默认样式
							.select-trigger{
								height: 100%;
								.el-input{
									height: 100%;
								}
							}
						}
						//图片上传样式
						.el-upload-list  {
							//提示语
							.el-upload__tip {
							}
							//外部盒子
							.el-upload--picture-card {
								//图标
								.el-icon{
								}
							}
							.el-upload-list__item {
							}
						}
						.vip_item {
							.vip_inp {
							}
							.vip_btn {
							}
							.vip_btn:hover {
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
	}
	:deep(.rechargeDialog) {
		border-radius: 30px;
		.el-dialog__header {
			padding: 0;
		}
		.el-dialog__title {
			padding: 0 46px;
			height: 60px;
			line-height: 60px;
			border-radius: 30px 30px 30px 0;
			display: inline-block;
			color: #fff;
			width: auto;
			background: linear-gradient(120deg, #2891FF 0%, #2B53F0 100%);
		}	
	}
	.centerPayInpView {
		border: 1px solid #d8d8d8;
		border-radius: 10px;
		width: calc(100% - 80px);
		display: flex;
		align-items: center;
		height: 100px;
		justify-content: center;
		margin: 0 40px;
		
		:deep(.pay_inp) {
			width: 60%;
			height: 50px;
			font-size: 30px;
			color: #f00;
			text-align: center;
			border-bottom: 1px solid #d8d8d8;
			.el-input__inner {
				height: 100%;
				color: inherit;
				text-align: center;
			}
		}
	}
	.centerPayList {
		padding: 40px;
		width: 100%;
		.yinhang_view {
			margin: 0 0 0 60px;
			width: calc(100% - 60px);
			:deep(.is-checked){
				.el-radio__inner {
					background: #f00;
					border-color: #f00;
				}
				.el-radio__label {
					color: #f00;
				}
			}
		}
		.centerPayView {
			width: 100%;
			padding: 20px 0;
			display: flex;
			justify-content: flex-start;
			align-items: center;
			border-bottom: 1px solid #d8d8d8;
			font-size: 18px;
			:deep(.el-radio){
				.el-radio__label{
					display: flex;
					align-items: center;
					img{
						width: 30px;
						margin-right: 6px;
					}
					.el-icon{
						margin-left: 10px;
						transition: all 0.3s;
					}
					.active {
						transform: rotate(180deg);
					}
				}
			}
			
		}
	}
	.section-content {
		cursor: pointer;
		padding: 20px;
		box-shadow: 0px 4px 10px 0px rgba(0, 0, 0, 0.3);
		margin: 0 0 20px;
		color: #333;
		background: #fff;
		display: flex;
		width: 100%;
		border-color: #efefef;
		border-width: 0;
		align-items: center;
		border-style: solid;
		position: relative;
	}

	.section-content:hover {
		color: #fff;
		background: #DF847F10;
	}
	.chat-content {
		padding-bottom: 20px;
		width: 100%;
		margin-bottom: 10px;
		max-height: 300px;
		height: 300px;
		overflow-y: scroll;
		border: 1px solid #eeeeee;
		background: #fff;

		.left-content {
			float: left;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}

		.right-content {
			float: right;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}
	}

	.clear-float {
		clear: both;
	}
	.noList {
		color: #9e9e9e;
		width: 100%;
		text-align: center;
		padding: 60px 0;
	}
</style>
<style>
/**总盒子**/
.center_view {
    width: 100%;
    margin: 0px auto;
    padding: 20px calc((100% - 1200px)/2);
    background: #eee;
    position: relative;
    font-size:16px;
    color:#666;
}
/**标题**/
.center_view .section_title{
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

/**内容区**/
.center_view .usersView{
    display: block;
    width: 100%;
    margin: 20px auto;
}

/**tab总盒子**/
.center_view .usersView .usersTabView{
    width: 100%;
    background: #c3dee3;
    padding: 10px 10px 0;
    box-sizing: border-box;
    border: 1px solid #eee;
    border-bottom: none;
}
/**item**/
.center_view .usersView .usersTabView .usersTab{
    display: inline-block;
    width: auto;
    font-size: 16px;
    margin: 0px 10px;
    padding: 10px 20px 10px 10px;
    position: relative;
    cursor: pointer;
    text-align: center;
    background: var(--theme);
    color: #fff;
    border-radius: 30px 30px 0 0;
}
.center_view .usersView .usersTabView .usersTab:hover{
    background: #fff;
    color: var(--theme);
}
.center_view .usersView .usersTabView .usersTab.usersTabActive{
    display: inline-block;
    width: auto;
    font-size: 16px;
    margin: 0px 10px;
    padding: 10px 20px 10px 10px;
    position: relative;
    cursor: pointer;
    text-align: center;
    background: #fff;
    color: var(--theme);
}

/**右部 总盒子**/
.center_view .usersView .usersBox{
    width: calc(100% - 0px);
    background: #fff;
    margin: 0px;
    padding: 0px;
    box-sizing: border-box;
    box-shadow: none;
    border: 1px solid #eee;
}
/**form盒子**/
.center_view .usersView .usersBox .usersForm{
    width: 100%;
    padding: 30px;
}
.center_view .usersView .usersBox .usersForm .el-form-item{
    margin: 0px 0px 20px;
    display: flex;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__label{
    width: 150px;
    background: none;
    text-align: right;
    display: block;
    font-size: 16px;
    color: rgb(51, 51, 51);
    font-weight: 500;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-wrap: wrap;
    width: calc(100% - 120px);
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_inp{
    height: 36px;
    line-height: 36px;
    border: 1px solid rgb(221, 221, 221);
    padding: 0px 10px;
    width: 100%;
    box-sizing: border-box;
    background: rgb(255, 255, 255);
    font-size: 16px;
}

/**会员**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .vip_item{
    display: flex;
    align-items: center;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .vip_item .vip_inp{
    height: 36px;
    line-height: 36px;
    border: 1px solid rgb(221, 221, 221);
    padding: 0px 10px;
    width: 80%;
    box-sizing: border-box;
    background: rgb(255, 255, 255);
    font-size: 16px;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .vip_item .vip_btn{
    background: var(--theme);
    color: rgb(255, 255, 255);
    height: 36px;
    line-height: 36px;
    padding: 0px 20px;
    border-radius: 0px;
    margin: 0px 0px 0px 5px;
    border-color: var(--theme);
}
/**end**/

/**下拉选择**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_sel{
    line-height: 36px;
    border: 1px solid rgb(221, 221, 221);
    box-sizing: border-box;
    width: calc(100% - 120px);
    padding: 0px 10px;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    font-size: 16px;
}
/**end**/

/**日期选择**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_date{
    line-height: 36px;
    border: 1px solid rgb(221, 221, 221);
    box-sizing: border-box;
    width: 100%;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    font-size: 16px;
}
/**end**/

/**radio**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_radio{
    display: flex;
    width: calc(100% - 120px);
    align-items: center;
    flex-wrap: wrap;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_radio .el-radio{
    width: 30%;
    margin: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_radio .el-radio .el-radio__inner{
    border-color: #999;
    background: #fff;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_radio .el-radio .el-radio__label{
    color: #999;
    font-size: 16px;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_radio .el-radio.is-checked .el-radio__inner{
    border-color: var(--theme);
    background: var(--theme);
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_radio .el-radio.is-checked .el-radio__label{
    color: var(--theme);
    font-size: 16px;
}
/**end**/

/**checkbox**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_checkbox{
    display: flex;
    width: calc(100% - 120px);
    flex-wrap: wrap;
    align-items: center;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_checkbox .el-checkbox{
    width: 20%;
    margin: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_checkbox .el-checkbox .el-checkbox__inner{
    border-color: #999;
    background: #fff;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_checkbox .el-checkbox .el-checkbox__label{
    color: #999;
    font-size: 16px;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_checkbox .el-checkbox.is-checked .el-checkbox__inner{
    border-color: var(--theme);
    background: var(--theme);
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_checkbox .el-checkbox.is-checked .el-checkbox__label{
    color: var(--theme);
    font-size: 16px;
}
/**end**/

/**textarea**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_textarea{
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_textarea .el-textarea__inner{
    width: 100%;
    min-height: 150px;
    padding: 12px;
    border: 1px solid rgb(221, 221, 221);
    border-radius: 0px;
    color: #666;
    font-size: 16px;
}
/**end**/

/**图片上传**/
/* 盒子 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--picture-card{
    background-color: rgb(255, 255, 255);
    width: 100px;
    height: 90px;
    line-height: 100px;
    text-align: center;
    border: 1px solid rgb(221, 221, 221);
    border-radius: 0px;
    cursor: pointer;
}
/* 图标 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--picture-card .el-icon{
    font-size: 32px;
    color: #999;
}
/* 提示语 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .img-uploader .el-upload__tip{
    font-size: 15px;
    color: #666;
    margin: 0;
}
/**end**/

/**文件上传**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger{
    background-color: rgb(255, 255, 255);
    border: 1px solid rgb(221, 221, 221);
    border-radius: 0px;
    box-sizing: border-box;
    width: 360px;
    height: 180px;
    text-align: center;
    cursor: pointer;
    overflow: hidden;
}
/* 图标 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger .el-icon-upload{
    font-size: 67px;
    color: var(--theme);
    line-height: 50px;
}
/* 提示语 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .upload-demo .el-upload__tip{
    font-size: 15px;
    color: #666;
    margin: 0px 0 0;
    line-height:1;
}
/* 点击上传 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger em{
    color: var(--theme);
    font-size: 15px;
}
/**end**/

/**富文本**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .list_editor{
    width: 100%;
    height: auto;
    margin: 0px;
    padding: 0px;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    border: 1px solid rgb(221, 221, 221);
    min-height: 300px;
}
/**end**/

/**按钮**/
.center_view .formModel_btn_box{
    display: flex;
    align-items: center;
    justify-content:center;
    width: 100%;
    padding: 10px 0px 10px 150px;
    margin: 40px 0px 0px;
}
/**更新信息**/
.center_view .formModel_btn_box .formModel_confirm{
    margin: 0px 20px 0px 0px;
    padding: 0px 24px;
    width: auto;
    height: 40px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 8px;
    border: 0px;
    cursor: pointer;
    background: var(--theme);
}
.center_view .formModel_btn_box .formModel_confirm:hover{
    background: var(--theme);
}
/**退出登陆**/
.center_view .formModel_btn_box .formModel_cancel{
    margin: 0px 20px 0px 0px;
    padding: 0px 24px;
    width: auto;
    height: 40px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 8px;
    border: 0px;
    cursor: pointer;
    background: #8e8e8e;
}
.center_view .formModel_btn_box .formModel_cancel:hover{
    background: rgba(66, 66, 66,1);
}


</style>