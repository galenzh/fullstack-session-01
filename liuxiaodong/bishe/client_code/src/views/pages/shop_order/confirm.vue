<template>
	<div class="list-page" :style='{"width":"1200px","padding":"40px 0 0","margin":"20px auto 40px","fontSize":"16px","position":"relative","background":"#fff"}'>
		<div class="section_title">
            <span>{{formName}}</span>
		</div>
		<el-card style="width: 100%">
            <el-button @click="backClick">返回</el-button>
			<el-divider content-position="center">地址</el-divider>
			<el-table :stripe='true' :data="addressList">
				<el-table-column label="选择"  :resizable='true' align="left" header-align="left">
					<template #default="scope">
						<el-radio :label="scope.$index" v-model="addressIndex">&nbsp;</el-radio>
					</template>
				</el-table-column>
				<el-table-column label="联系人" :resizable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.name}}
					</template>
				</el-table-column>
				<el-table-column label="联系电话" :resizable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.phone}}
					</template>
				</el-table-column>
				<el-table-column label="地址" :resizable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.address}}
					</template>
				</el-table-column>
			</el-table>
			<br>
			<div class="add_view">
				<el-button class="addressAdd_btn" @click="addressAdd" type="success">新增地址</el-button>
			</div>
			
			<el-divider content-position="center">商品清单</el-divider>
			<el-table :data="list" :stripe='true'>
				<el-table-column label="商品名称" :resizable='true' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.goodname}}
					</template>
				</el-table-column>
				<el-table-column label="商品图片" :resizable='true' align="left" header-align="left">
					<template #default="scope">
						<img :src="scope.row.picture?($config.url + scope.row.picture):''" alt=""
							style="width: 150px;height: 150px;">
					</template>
				</el-table-column>
				<el-table-column label="价格" :resizable='true' align="left" header-align="left">
					<template #default="scope">
						<span style="font-size: 12px;" v-if="payType!=2">￥</span>{{scope.row.realPrice}} 
                        <span v-if="payType==2">积分</span>
					</template>
				</el-table-column>
				<el-table-column label="数量" :resizable='true' align="left" header-align="left">
					<template #default="scope">{{scope.row.buynumber}}
					</template>
				</el-table-column>
				<el-table-column label="总价" :resizable='true' align="left" header-align="left">
					<template #default="scope">
						<span style="font-size: 12px;" v-if="payType!=2">￥</span>{{(scope.row.realPrice * scope.row.buynumber).toFixed(2)}} 
                        <span v-if="payType==2">积分</span>
					</template>
				</el-table-column>
			</el-table>
			<el-divider content-position="center">备注</el-divider>
			
			<el-input v-model="remark" placeholder="请输入备注" type="textarea"></el-input>
			<div class="order_confirm_btn" >
				<div class="order_confirm_price">
					总价：<span v-if="payType!=2">￥</span>{{allPrice}}
                    <span v-if="payType==2">积分</span>
				</div>
				<el-button class="pay_btn" v-if="payType!=2" @click="payClick" type="success">余额支付</el-button>
				<el-button class="jf_btn" v-if="payType==2" @click="jfPayClick" type="success">积分兑换</el-button>
			</div>
		</el-card>
		<br>
		<formModel ref="formModelRef" @formModelChange="formModelChange"></formModel>
	</div>
</template>

<script setup>
	import formModel from '../shop_address/formModel'
	import {
		ref,
		getCurrentInstance,
		nextTick,
		computed,
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	import moment from 'moment'
    import {
        useStore
    } from 'vuex';
    const store = useStore()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	//基础信息
	const tableName = 'orders'
	const formName = '订单提交'
	//基础信息
    // 返回
    const backClick = () =>{
        history.back()
    }
	const list = ref([])
	const remark = ref('')
    //付款类型
    const payType = ref(1)
	//获取收货地址
	const addressIndex = ref(-1)
	const addressList = ref([])
	const getAddressList = () => {
		context.$http.get('address/page?limit=99').then(res => {
			for (let x in res.data.data.list) {
				if (res.data.data.list[x].isdefault == '是') {
					addressIndex.value = Number(x)
				}
			}
			addressList.value = res.data.data.list
		})
	}
	//新增收货地址
	const formModelRef = ref(null)
	const addressAdd = () => {
		formModelRef.value.init(null, '新增收货地址')
	}
	const formModelChange = () => {
		getAddressList()
	}
	//统计总价
	const allPrice = computed(() => {
		let price = 0
		list.value.forEach(item=>{
			price += item.realPrice * item.buynumber
		})
		return Number(price).toFixed(2)
	})
	//获取订单id
	const createOrder = () => {
		return moment().format('YYYYMMDDHHmmssSSS')+Math.random().toString().slice(2, 5);
	}
	//正常支付
	const payClick = async () => {
		//是否选择收货地址
		if (addressIndex.value == -1) {
			context.$toolUtil.message('请选择收货地址', 'error')
			return false
		}
        let orders = []
        for(let i in list.value){
            let item = list.value[i]
            let res = await context.$http.get(`${item.tablename}/info/${item.goodid}`)
            let data = res.data.data
            let orderid = createOrder()
            orders.push({
                orderid: orderid,
                tablename: item.tablename,
                userid: user.value.id,
                role: context.$toolUtil.storageGet('frontSessionTable'),
                goodid: item.goodid,
                goodname: item.goodname,
                goodtype: item.goodtype,
                picture: item.picture,
                buynumber: item.buynumber,
                discountprice: item.realPrice,
                discounttotal: Number(item.realPay.toFixed(2)),
                price: item.realPrice,
                total: Number(item.realPay.toFixed(2)),
                type: payType.value,
                //收货地址
                address: addressList.value[addressIndex.value].address,
                tel: addressList.value[addressIndex.value].phone,
                consignee: addressList.value[addressIndex.value].name,
                remark: remark.value,
                status: '未支付',
                goods:data
            })
        }
        //新增订单
        Promise.all(orders.map(order=>{ //批量下单，返回primise数组，等待所有请求都完成
            return context.$http.post('orders/add',order)
        })).then(resArr=>{
            let total = 0
            orders.forEach(order=>{
                total+=Number(order.total)
            })
            //判断用户余额是否充足
            if(Number(user.value.money) < Number(total.toFixed(2))){
                context.$toolUtil.message(`余额不足，请先充值`,'error',()=>{
                    router.push(`/index/${context.$toolUtil.storageGet('frontSessionTable')}Center`)
                })
                return false
            }
            //如果商品存在积分，则累加用户积分
            if(orders[0].goods.jf){
                user.value.jf = parseInt(user.value.jf) + parseInt(total)
            }
            //减去用户余额
            user.value.money = (parseFloat(user.value.money) - parseFloat(total)).toFixed(2)
            context.$http.post(`${context.$toolUtil.storageGet('frontSessionTable')}/update`,user.value)

            orders.forEach(order=>{
                //如果商品有库存 减去商品库存
                if(order.goods.hasOwnProperty('alllimittimes')){
                    order.goods.alllimittimes = order.goods.alllimittimes - order.buynumber
                }
                context.$http.post(`${order.tablename}/update`,order.goods)
                //更新订单状态
                context.$http.get('orders/list',{
                    params:{
                        page:1,
                        limit:1,
                        orderid: order.orderid
                    }
                }).then(res=>{
                    res.data.data.list[0].status = '已支付'
                    context.$http.post('orders/update',res.data.data.list[0])
                })
            })
            //如果存在id。说明从购物车跳转,需要删除已下单的商品
            list.value.forEach(item=>{
                if(item.id){
                    context.$http({url:'cart/delete',method:'post',data:[item.id]})
                }
            })
            //下单完成，跳转订单
            context.$toolUtil.message('购买成功','success',()=>{
                router.push('/index/ordersList')
            })
        })
	}

	//积分兑换
	const jfPayClick = () => {
		//是否选择收货地址
		if (addressIndex.value == -1) {
			context.$toolUtil.message('请选择收货地址', 'error')
			return false
		}
		list.value.forEach(item => {
			context.$http({
				url: `${item.tablename}/info/${item.goodid}`,
				method: 'get'
			}).then(res => {
				//判断用户积分是否充足
				if(Number(user.value.jf) < Number(item.realPay.toFixed(2))){
					context.$toolUtil.message(`积分不足，兑换失败`,'error')
					return false
				}
				var orderId = createOrder()
				var data = res.data.data
				//添加订单
				let order = {
					orderid: orderId,
					tablename: item.tablename,
					userid: user.value.id,
                    role: context?.$toolUtil.storageGet('frontSessionTable'),
					goodid: item.goodid,
					goodname: item.goodname,
                    goodtype: item.goodtype,
					picture: item.picture,
					buynumber: item.buynumber,
					discountprice: item.realPrice,
					discounttotal: Number(item.realPay.toFixed(2)),
					price: item.realPrice,
					total: Number(item.realPay.toFixed(2)),
					type: payType.value,
					//收货地址
					address: addressList.value[addressIndex.value].address,
					tel: addressList.value[addressIndex.value].phone,
					consignee: addressList.value[addressIndex.value].name,
					remark: remark.value,
					status: '已支付'
				}
				//新增订单
				context.$http({
					url: 'orders/add',
					method: 'post',
					data: order
				}).then(obj1 => {
					//更新用户积分
					user.value.jf = parseInt(user.value.jf) - parseInt(item.realPay)
					context.$http({
						url: `${context.$toolUtil.storageGet('frontSessionTable')}/update`,
						method:'post',
						data: user.value
					}).then(obj2=>{})
					//如果商品有库存 减去商品库存
					if (data.hasOwnProperty('alllimittimes')) {
						data.alllimittimes = data.alllimittimes - item.buynumber
					}
					context.$http({
						url: `${item.tablename}/update`,
						method: 'post',
						data: data
					})
					//下单完成，跳转订单
					context.$toolUtil.message('兑换成功','success',()=>{
						router.push('/index/ordersList')
					})
				})
			})
		})
	}
	//获取个人信息
	const user = ref({})
	//初始化
	const init = () => {
		getAddressList()
		if (route.query.type) {
			payType.value = route.query.type
		}
        store.dispatch('user/getSession').then(res=>{
            user.value = res.data.data
            list.value = JSON.parse(context.$toolUtil.storageGet('orders_good'))
            list.value.forEach(item=>{
                item.realPrice = item.price
                item.realPay=Number(item.realPrice*item.buynumber)
            })
        })
	}
	init()
</script>

<style lang="scss" scoped>
    .section_title{
        span{
        }
    }
	// 表格样式
	.el-table {
		padding: 0;
		margin: 20px 0 0;
		background: #fff;
		width: 100%;
		font-size: 15px;
		border-color: var(--theme);
		border-width: 1px 1px 1px 1px;
		border-style: solid;
		:deep(.el-table__header-wrapper) {
			thead {
				color: #333;
				font-weight: 500;
				width: 100%;
				tr {
					background: #fff;
					th {
						padding: 8px 0;
						background: #c3dee3;
						border-color: #eee;
						border-width: 0 0px 0px 0;
						border-style: solid;
						text-align: left;
						.cell {
							padding: 0 10px;
							word-wrap: normal;
							color: var(--theme);
							white-space: nowrap;
							font-weight: bold;
							display: flex;
							vertical-align: middle;
							line-height: 24px;
							text-overflow: ellipsis;
							word-break: break-all;
							width: 100%;
							align-items: center;
							position: relative;
							min-width: 110px;
						}
					}
				}
			}
		}
		:deep(.el-table__body-wrapper) {
			tbody {
				width: 100%;
				tr {
					background: #fff;
					td {
						padding: 12px 0;
						color: #666;
						background: #fff;
						border-color: var(--theme);
						border-width: 0 0px 1px 0;
						border-style: solid;
						text-align: left;
						.cell {
							padding: 0 10px;
							overflow: hidden;
							word-break: break-all;
							white-space: normal;
							line-height: 24px;
							text-overflow: ellipsis;
							// 单选框
							// 未选中样式
							.el-radio {
								//单选框
								.el-radio__inner {
									background: #fff;
									border-color: #999;
								}
							}
							//选中样式
							.is-checked {
								//单选框
								.el-radio__inner {
									background: var(--theme);
									border-color: var(--theme);
								}
							}
						}
					}
				}
				tr.el-table__row--striped {
					td {
						background: #FAFAFA !important;
					}
				}
				tr:hover {
					td {
						padding: 12px 0;
						color: #333;
						background: rgba(245, 245, 245, 1);
						border-color: var(--theme);
						border-width: 0 0px 1px 0;
						border-style: solid;
						text-align: left;
					}
				}
			}
		}
	}
	// 新增地址盒子
	.add_view {
		margin: 20px 0 0;
		width: 100%;
		// 新增地址按钮
		.addressAdd_btn {
			border: 0;
			cursor: pointer;
			border-radius: 4px;
			padding: 0 24px;
			margin: 0 10px 0 0;
			color: #fff;
			background: var(--theme);
			width: auto;
			font-size: 16px;
			height: 40px;
		}
		// 新增地址按钮-悬浮
		.addressAdd_btn:hover {
		}
	}
	// 分割线样式
	:deep(.el-divider) {
		border: none;
		background: #dcdfe6;
		// 分割线文字样式
		.el-divider__text {
			font-weight: 600;
			font-size: 18px;
		}
	}
	// 底部盒子
	.order_confirm_btn {
		padding: 0;
		margin: 30px 0;
		background: #fff;
		display: flex;
		width: 100%;
		justify-content: center;
		align-items: center;
		box-sizing: border-box;
		// 总价
		.order_confirm_price {
			margin: 0 20px 0 0;
			color: #f00;
			font-weight: bold;
			font-size: 18px;
		}
		// 余额支付
		.pay_btn {
			border: 0;
			cursor: pointer;
			border-radius: 4px;
			padding: 0 24px;
			margin: 0 10px 0 0;
			color: #fff;
			background: var(--theme);
			width: auto;
			font-size: 14px;
			height: 40px;
		}
		// 余额支付-悬浮
		.pay_btn:hover {
			background: var(--theme);
		}
		// 积分兑换
		.jf_btn {
			border: 0;
			cursor: pointer;
			border-radius: 4px;
			padding: 0 24px;
			margin: 0 10px 0 0;
			outline: none;
			color: #fff;
			background: rgba(223,126,28,1);
			width: auto;
			font-size: 14px;
			height: 40px;
		}
		// 积分兑换-悬浮
		.jf_btn:hover {
		}
	}
</style>