<template>
	<div class="home_view">
		<div class="projectTitle">欢迎使用 {{projectName}}</div>
		<div class="count_list">
			<el-collapse-transition v-if="btnAuth('zixunshiyuyue','首页总数')">
				<el-card v-show="countTypeList.closezixunshiyuyueCountType" class="card_view count-item">
					<template #header>
						<div class="index_card_head">
							<div class="card_head_title">
								咨询师预约
							</div>
							<div class="card_head_right">
								<el-icon @click="countTypeClick('hiddenzixunshiyuyueCountType')" class="showIcons"
									:class="countTypeList.hiddenzixunshiyuyueCountType?'showIcons1':''">
									<ArrowUpBold />
								</el-icon>
								<el-icon @click="countTypeClick('closezixunshiyuyueCountType')" class="closeIcons">
									<CloseBold />
								</el-icon>
							</div>
						</div>
					</template>
					<el-collapse-transition>
						<div class="count_item" v-show="countTypeList.hiddenzixunshiyuyueCountType">
							<div class="count_title">咨询师预约总数</div>
							<div class="count_num">{{zixunshiyuyueCount}}</div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('ceshipingfen','首页总数')">
				<el-card v-show="countTypeList.closeceshipingfenCountType" class="card_view count-item">
					<template #header>
						<div class="index_card_head">
							<div class="card_head_title">
								测试评分
							</div>
							<div class="card_head_right">
								<el-icon @click="countTypeClick('hiddenceshipingfenCountType')" class="showIcons"
									:class="countTypeList.hiddenceshipingfenCountType?'showIcons1':''">
									<ArrowUpBold />
								</el-icon>
								<el-icon @click="countTypeClick('closeceshipingfenCountType')" class="closeIcons">
									<CloseBold />
								</el-icon>
							</div>
						</div>
					</template>
					<el-collapse-transition>
						<div class="count_item" v-show="countTypeList.hiddenceshipingfenCountType">
							<div class="count_title">测试评分总数</div>
							<div class="count_num">{{ceshipingfenCount}}</div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('forum','首页总数')">
				<el-card v-show="countTypeList.closeforumCountType" class="card_view count-item">
					<template #header>
						<div class="index_card_head">
							<div class="card_head_title">
								论坛交流
							</div>
							<div class="card_head_right">
								<el-icon @click="countTypeClick('hiddenforumCountType')" class="showIcons"
									:class="countTypeList.hiddenforumCountType?'showIcons1':''">
									<ArrowUpBold />
								</el-icon>
								<el-icon @click="countTypeClick('closeforumCountType')" class="closeIcons">
									<CloseBold />
								</el-icon>
							</div>
						</div>
					</template>
					<el-collapse-transition>
						<div class="count_item" v-show="countTypeList.hiddenforumCountType">
							<div class="count_title">论坛交流总数</div>
							<div class="count_num">{{forumCount}}</div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
		</div>
		<div class="card_list">
			<el-collapse-transition v-if="btnAuth('zixunshiyuyue','首页统计')">
				<el-card v-show="cardTypeList.closezixunshiyuyueChartType1" class="card_view chart-item">
					<template #header>
						<div class="index_card_head">
							<div class="card_head_title">
								咨询师预约
							</div>
							<div class="card_head_right">
								<el-icon @click="cardTypeClick('hiddenzixunshiyuyueChartType1')" class="showIcons"
										 :class="cardTypeList.hiddenzixunshiyuyueChartType1?'showIcons1':''">
									<ArrowUpBold />
								</el-icon>
								<el-icon @click="cardTypeClick('closezixunshiyuyueChartType1')" class="closeIcons">
									<CloseBold />
								</el-icon>
							</div>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenzixunshiyuyueChartType1">
							<div id="zixunshiyuyuezixunshizhanghaoEchart1" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('ceshipingfen','首页统计')">
				<el-card v-show="cardTypeList.closeceshipingfenChartType1" class="card_view chart-item">
					<template #header>
						<div class="index_card_head">
							<div class="card_head_title">
								测试评分
							</div>
							<div class="card_head_right">
								<el-icon @click="cardTypeClick('hiddenceshipingfenChartType1')" class="showIcons"
										 :class="cardTypeList.hiddenceshipingfenChartType1?'showIcons1':''">
									<ArrowUpBold />
								</el-icon>
								<el-icon @click="cardTypeClick('closeceshipingfenChartType1')" class="closeIcons">
									<CloseBold />
								</el-icon>
							</div>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenceshipingfenChartType1">
							<div id="ceshipingfenpingfenEchart1" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('ceshipingfen','首页统计')">
				<el-card v-show="cardTypeList.closeceshipingfenChartType2" class="card_view chart-item">
					<template #header>
						<div class="index_card_head">
							<div class="card_head_title">
								测试评分
							</div>
							<div class="card_head_right">
								<el-icon @click="cardTypeClick('hiddenceshipingfenChartType2')" class="showIcons"
										 :class="cardTypeList.hiddenceshipingfenChartType2?'showIcons2':''">
									<ArrowUpBold />
								</el-icon>
								<el-icon @click="cardTypeClick('closeceshipingfenChartType2')" class="closeIcons">
									<CloseBold />
								</el-icon>
							</div>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenceshipingfenChartType2">
							<div id="ceshipingfenzhanghaoEchart2" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('forum','首页统计')">
				<el-card v-show="cardTypeList.closeforumChartType1" class="card_view chart-item">
					<template #header>
						<div class="index_card_head">
							<div class="card_head_title">
								论坛交流
							</div>
							<div class="card_head_right">
								<el-icon @click="cardTypeClick('hiddenforumChartType1')" class="showIcons"
										 :class="cardTypeList.hiddenforumChartType1?'showIcons1':''">
									<ArrowUpBold />
								</el-icon>
								<el-icon @click="cardTypeClick('closeforumChartType1')" class="closeIcons">
									<CloseBold />
								</el-icon>
							</div>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenforumChartType1">
							<div id="forumthumbsupNumberEchart1" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
		</div>
	</div>
</template>

<script setup>
	import {
		inject,
		nextTick,
		ref,
		getCurrentInstance,
		onMounted,
		onUnmounted
	} from 'vue';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const projectName = context.$project.projectName
	const countTypeList = ref({
	})
	
	// 定时刷新相关
	const refreshInterval = ref(null)

	// 开始自动刷新
	const startAutoRefresh = () => {
		// 清除可能存在的旧定时器
		stopAutoRefresh()
		// 设置新的定时器，每60秒刷新一次数据
		refreshInterval.value = setInterval(() => {
			getCountList()
			getCardList()
		}, 60000) // 60秒刷新一次
	}

	// 停止自动刷新
	const stopAutoRefresh = () => {
		if (refreshInterval.value) {
			clearInterval(refreshInterval.value)
			refreshInterval.value = null
		}
	}

	// 组件卸载时清除定时器，防止内存泄漏
	onUnmounted(() => {
		stopAutoRefresh()
	})
	
	// 组件挂载时启动自动刷新
	onMounted(() => {
		// 立即加载一次数据
		getCountList()
		getCardList()
		// 设置定时刷新
		startAutoRefresh()
	})
	
	const getCountList=()=>{
		countTypeList.value.closezixunshiyuyueCountType = true
		countTypeList.value.hiddenzixunshiyuyueCountType = true
		if(btnAuth('zixunshiyuyue','首页总数')){
			getzixunshiyuyueCount()
		}
		countTypeList.value.closeceshipingfenCountType = true
		countTypeList.value.hiddenceshipingfenCountType = true
		if(btnAuth('ceshipingfen','首页总数')){
			getceshipingfenCount()
		}
		countTypeList.value.closeforumCountType = true
		countTypeList.value.hiddenforumCountType = true
		if(btnAuth('forum','首页总数')){
			getforumCount()
		}
	}
	const zixunshiyuyueCount = ref(0)
	const getzixunshiyuyueCount = () => {
		context?.$http({
			url:'zixunshiyuyue/count',
			method: 'get'
		}).then(res=>{
			zixunshiyuyueCount.value = res.data.data
		})
	}
	const ceshipingfenCount = ref(0)
	const getceshipingfenCount = () => {
		context?.$http({
			url:'ceshipingfen/count',
			method: 'get'
		}).then(res=>{
			if (res.data && res.data.code === 0) {
				ceshipingfenCount.value = res.data.data || 0;
			} else {
				// 设置默认值为0，确保显示
				ceshipingfenCount.value = 0;
			}
		}).catch(err => {
			// 设置默认值为0，确保显示
			ceshipingfenCount.value = 0;
		});
	}
	const forumCount = ref(0)
	const getforumCount = () => {
		context?.$http({
			url:'forum/count',
			method: 'get'
		}).then(res=>{
			forumCount.value = res.data.data
		})
	}
	const countTypeClick = (e) => {
		countTypeList.value[e] = !countTypeList.value[e]
	}
	//权限验证
	const btnAuth = (e,a)=>{
		return context?.$toolUtil.isAuth(e,a)
	}
	let echarts = inject("echarts")
	const cardTypeClick = (e) =>{
		cardTypeList.value[e] = !cardTypeList.value[e]
		setTimeout(()=>{
			getCardList()
		},1000)
	}
	const cardTypeList = ref({
		closezixunshiyuyueChartType1: true,
		hiddenzixunshiyuyueChartType1: true,
		closeceshipingfenChartType1: true,
		hiddenceshipingfenChartType1: true,
		closeceshipingfenChartType2: true,
		hiddenceshipingfenChartType2: true,
		closeforumChartType1: true,
		hiddenforumChartType1: true,
	})
	const getCardList = () => {
		if(btnAuth('zixunshiyuyue','首页统计')){
			getzixunshiyuyueChart1()
		}
		if(btnAuth('ceshipingfen','首页统计')){
			getceshipingfenChart1()
		}
		if(btnAuth('ceshipingfen','首页统计')){
			getceshipingfenChart2()
		}
		if(btnAuth('forum','首页统计')){
			getforumChart1()
		}
	}
	import '@/assets/js/echarts-theme'
	const getzixunshiyuyueChart1 = () => {
		nextTick(()=>{
			var zixunshizhanghaoEchart1 = echarts.init(document.getElementById("zixunshiyuyuezixunshizhanghaoEchart1"),'theme');
			context?.$http({
				url: "zixunshiyuyue/group/zixunshizhanghao",
				method: "get",
			}).then(obj=>{
				let res = obj.data.data
				let xAxis = [];
				let yAxis = [];
				let dataList = []
				for(let i=0;i<res.length;i++){
				    xAxis.push(res[i].zixunshizhanghao);
				    yAxis.push(parseFloat((res[i].total)));
					dataList.push({
				        value: parseFloat((res[i].total)),
				        name: res[i].zixunshizhanghao
				    })
				}
				var option = {};
				option = {
    title: {
        text: '咨询师预约统计',
        left: 'center'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    xAxis: {
        data: xAxis,
        type: 'category',
        axisLabel: {
          interval: 0,
          rotate: 30, // 旋转标签，防止重叠
          fontSize: 10 // 减小字体大小
        }
    },
    yAxis: {
        type: 'value'
    },
    series:{
        data: yAxis,
        type: 'bar',
        barWidth: 20
    }
}
                var middle = option.xAxis
                option.xAxis = option.yAxis
                option.yAxis = middle

				zixunshizhanghaoEchart1.clear()
				// 使用刚指定的配置项和数据显示图表。
				zixunshizhanghaoEchart1.setOption(option);
				//根据窗口的大小变动图表
				zixunshizhanghaoEchart1.resize();
			})
		})
	}
	const getceshipingfenChart1 = () => {
		nextTick(()=>{
			var pingfenEchart1 = echarts.init(document.getElementById("ceshipingfenpingfenEchart1"),'theme');
			context?.$http({
				url: "ceshipingfen/sectionStat/pingfen",
				method: "get",
			}).then(obj=>{
				let res = obj.data.data || [];
				
				// 确保显示所有三个级别，即使没有数据
				let xAxis = [];
				let yAxis = [];
				let dataList = [];
				
				// 检查是否包含所有必要的等级
				const requiredLevels = ["轻度抑郁", "中度抑郁", "重度抑郁"];
				const dataMap = {};
				
				// 初始化所有等级的数据映射
				requiredLevels.forEach(level => {
					dataMap[level] = 0;
				});
				
				// 填充实际数据
				for(let i=0; i<res.length; i++){
					if(res[i].pingfen && requiredLevels.includes(res[i].pingfen)) {
						dataMap[res[i].pingfen] = parseFloat((res[i].total || 0));
					}
				}
				
				// 构建最终数据
				for(let level of requiredLevels) {
					xAxis.push(level);
					yAxis.push(dataMap[level]);
					dataList.push({
						value: dataMap[level],
						name: level
					});
				}
				
				var option = {};
				option = {
    title: {
        text: '测试评分统计',
        left: 'center'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    xAxis: {
        data: xAxis,
        type: 'category',
        axisLabel: {
        interval: 0
        }
    },
    yAxis: {
        type: 'value'
    },
    series:{
        data: yAxis,
        type: 'bar',
        barWidth: 20
    }
}

				pingfenEchart1.clear();
				// 使用刚指定的配置项和数据显示图表。
				pingfenEchart1.setOption(option);
				//根据窗口的大小变动图表
				pingfenEchart1.resize();
			}).catch(err => {
				console.error("获取测试评分统计数据失败:", err);
				// 发生错误时显示空图表
				var pingfenEchart1 = echarts.init(document.getElementById("ceshipingfenpingfenEchart1"),'theme');
				
				// 创建默认数据
				let xAxis = ["轻度抑郁", "中度抑郁", "重度抑郁"];
				let yAxis = [0, 0, 0];
				
				var option = {
					title: {
						text: '测试评分统计 (无数据)',
						left: 'center'
					},
					tooltip: {
						trigger: 'item',
						formatter: '{b} : {c}'
					},
					xAxis: {
						data: xAxis,
						type: 'category',
						axisLabel: {
							interval: 0
						}
					},
					yAxis: {
						type: 'value'
					},
					series:{
						data: yAxis,
						type: 'bar',
						barWidth: 20
					}
				};
				
				pingfenEchart1.clear();
				pingfenEchart1.setOption(option);
				pingfenEchart1.resize();
			})
		})
	}
	const getceshipingfenChart2 = () => {
		nextTick(()=>{
			var zhanghaoEchart2 = echarts.init(document.getElementById("ceshipingfenzhanghaoEchart2"),'theme');
			context?.$http({
				url: "ceshipingfen/group/zhanghao",
				method: "get",
			}).then(obj=>{
				let res = obj.data.data || [];
				console.log("咨询师工作量分析数据:", res);
				
				let xAxis = [];
				let yAxis = [];
				let dataList = [];
				
				// 如果没有数据，提供默认展示
				if(res.length === 0) {
					dataList = [
						{value: 0, name: "暂无数据"}
					];
				} else {
					for(let i=0; i<res.length; i++){
						xAxis.push(res[i].zhanghao || "未知用户");
						yAxis.push(parseFloat((res[i].total || 0)));
						dataList.push({
							value: parseFloat((res[i].total || 0)),
							name: res[i].zhanghao || "未知用户"
						});
					}
				}
				
				var option = {};
				option = {
    title:{
        text: '咨询师工作量分析',
        left: 'center'
    },
    legend: {
        orient: 'vertical',
        left: 'left'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c} ({d}%)'
    },
    series: [
        {
            type: 'pie',
            radius: '55%',
            center: ['50%', '60%'],
            data: dataList,
            emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
}
				zhanghaoEchart2.clear();
				// 使用刚指定的配置项和数据显示图表。
				zhanghaoEchart2.setOption(option);
				//根据窗口的大小变动图表
				zhanghaoEchart2.resize();
			}).catch(err => {
				console.error("获取咨询师工作量分析数据失败:", err);
				// 发生错误时显示空图表
				var zhanghaoEchart2 = echarts.init(document.getElementById("ceshipingfenzhanghaoEchart2"),'theme');
				
				// 创建默认数据
				let dataList = [{value: 0, name: "暂无数据"}];
				
				var option = {
					title:{
						text: '咨询师工作量分析 (无数据)',
						left: 'center'
					},
					legend: {
						orient: 'vertical',
						left: 'left'
					},
					tooltip: {
						trigger: 'item',
						formatter: '{b} : {c} ({d}%)'
					},
					series: [
						{
							type: 'pie',
							radius: '55%',
							center: ['50%', '60%'],
							data: dataList,
							emphasis: {
								itemStyle: {
									shadowBlur: 10,
									shadowOffsetX: 0,
									shadowColor: 'rgba(0, 0, 0, 0.5)'
								}
							}
						}
					]
				};
				
				zhanghaoEchart2.clear();
				zhanghaoEchart2.setOption(option);
				zhanghaoEchart2.resize();
			})
		})
	}
	const getforumChart1 = () => {
		nextTick(()=>{
			var thumbsupNumberEchart1 = echarts.init(document.getElementById("forumthumbsupNumberEchart1"),'theme');
			context?.$http({
				url: `forum/value/title/thumbsupNumber?order=desc`,
				method: "get",
			}).then(obj=>{
				let res = obj.data.data
				let xAxis = [];
				let yAxis = [];
				let dataList = []
				for(let i=0;i<res.length;i++){
				    xAxis.push(res[i].title);
				    yAxis.push(parseFloat((res[i].total)));
					dataList.push({
				        value: parseFloat((res[i].total)),
				        name: res[i].title
				    })
				}
				var option = {};
				option = {
    title: {
        text: '热门帖子统计',
        left: 'center'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    xAxis: {
        data: xAxis,
        type: 'category',
    },
    yAxis: {
        type: 'value'
    },
    series:{
        data: yAxis,
        type: 'line'
    }
}
				thumbsupNumberEchart1.clear()
				// 使用刚指定的配置项和数据显示图表。
				thumbsupNumberEchart1.setOption(option);
				//根据窗口的大小变动图表
				thumbsupNumberEchart1.resize();
			})
		})
	}

	const init=()=>{
		getCountList()
		getCardList()
	}
	init()
</script>
<style lang="scss" scoped>
	// 首页盒子
	.home_view {
	}
	.home_view .projectTitle{
	}

	.showIcons {
		transition: transform 0.3s;
		margin-right: 10px;
	}

	.showIcons1 {
		transform: rotate(-180deg);
	}
	
	// 总数盒子
	.count_list{
		// 总数card
		.card_view {
			// card头部
			.el-card__header {
				// 头部盒子
				.index_card_head {
					// 标题
					.card_head_title {
					}
					// 按钮盒子
					.card_head_right {
						// 按钮
						.el-icon {
						}
					}
				}
			}
			// body
			.el-card__body {
				// body盒子
				.count_item{
					// 总数标题
					.count_title{
					}
					// 总数数字
					.count_num{
					}
				}
			}
		}
	}

	// 统计图盒子
	.card_list {
		// 统计图card
		.card_view {
			// 头部
			.el-card__header {
				// 头部盒子
				.index_card_head {
					// 标题
					.card_head_title {
					}
					// 按钮盒子
					.card_head_right {
						// 按钮
						.el-icon{
						}
					}
				}
			}
			// body
			.el-card__body {
				// body盒子
				.card_item{
				}
			}
		}
	}
</style>
<style>
/*总盒子*/
.home_view{
    padding: 20px 20px;
    margin: 0px;
    height: auto;
    min-height: 100vh;
    width: 100%;
}
.home_view .projectTitle{
    width: 100%;
    font-size: 28px;
    font-weight: bold;
    padding: 40px 0px 20px;
    height: auto;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0px 0px 20px;
    color: #000;
    display: none;
}

/*总数*/
/*总盒子*/
.home_view .count_list {
    display:flex;
    flex-wrap:wrap;
    justify-content:center;
    padding:0px 0px 20px;
    width:100%;
    align-items:flex-start;
    column-gap: 30px;
}
/*卡片盒子*/
.home_view .count_list .card_view {
    width:23%;
    height:auto;
    margin: 0;
    box-sizing:border-box;
    border:0px;
    border-radius:0px;
    box-shadow:0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);
    flex: 1;
    text-align: center;
}

/*head 总盒子*/
.home_view .count_list .card_view .el-card__header{
     width: 100%;
    border: 0px solid rgb(238, 238, 238);
    display: none;
}
/*item*/
.home_view .count_list .card_view .el-card__header .index_card_head{
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    height: 10px;
}
/*标题*/
.home_view .count_list .card_view .el-card__header .index_card_head .card_head_title{
    font-size: 14px;
    color: rgb(51, 51, 51);
}
/*按钮盒子*/
.home_view .count_list .card_view .el-card__header .index_card_head .card_head_right{
    display: flex;
    align-items: center;
}
/*按钮*/
.home_view .count_list .card_view .el-card__header .index_card_head .card_head_right .showIcons{
    color: rgb(102, 102, 102);
    font-size: 20px;
    cursor: pointer;
}
/*body 总盒子*/
.home_view .count_list .card_view .el-card__body{
    padding: 0px;
    background: none;
}
/*item*/
.home_view .count_list .card_view .el-card__body .count_item{
    padding: 20px;
    display: flex;
    flex-direction: column;
    text-align: center;
}
/*标题*/
.home_view .count_list .card_view .el-card__body .count_item .count_title{
    font-size: 14px;
    color: #000;
    line-height: 2;
    display: inline-block;
    margin: 0px 10px 0px 0px;
    font-weight: 400;
}
/*数字*/
.home_view .count_list .card_view .el-card__body .count_item .count_num{
    font-size: 26px;
    color: #000;
    line-height: 2;
    display: inline-block;
    font-weight: 600;
}

/*图表*/
/*总盒子*/
.home_view .card_list{
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    padding: 0px 0px 20px;
    align-items: flex-start;
    column-gap: 30px;
    row-gap: 20px;
}
/*卡片 总盒子*/
.home_view .card_list .card_view{
    min-width: 48%;
    flex:1;
    height: auto;
    margin: 0;
    box-sizing: border-box;
    border: 0px;
    border-radius: 0px;
    padding: 20px 0px 0px;
}
/*head 总盒子*/
.home_view .card_list .card_view .el-card__header{
    width: 100%;
    border: 0px solid rgb(238, 238, 238);
    background: rgb(255, 255, 255);
    display: none;
}
/*item*/
.home_view .card_list .card_view .el-card__header .index_card_head{
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    height: 10px;
}
/*标题*/
.home_view .card_list .card_view .el-card__header .index_card_head .card_head_title{
}
/*按钮盒子*/
.home_view .card_list .card_view .el-card__header .index_card_head .card_head_right{
    display: none;
}
/*按钮*/
.home_view .card_list .card_view .el-card__header .index_card_head .card_head_right .showIcons{
    color: rgb(238, 238, 238);
    font-size: 20px;
    cursor: pointer;
}

/*body 总盒子*/
.home_view .card_list .card_view .el-card__body{
    padding: 0px;
    background: rgb(255, 255, 255);
}
.home_view .card_list .card_view .el-card__body .card_item{
    padding: 10px;
    text-align: center;
}

.home-calendar{
  border: 0px solid rgb(218, 218, 218);
  box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 0px;
  margin: 0px auto 30px;
  border-radius: 0px;
  color: rgb(102, 102, 102);
  background: #fff;
  width: 100%;
  font-size: inherit;
  height: auto;
  padding:0 0 10px;
  order:2;
}
.home-calendar .header{
  padding: 17px 40px;
  border-color: rgba(126, 96, 16, 0.1);
  flex-wrap: wrap;
  background: #fff;
  border-width: 0px 0px 1px;
  display: flex;
  width: 100%;
  border-style: solid;
  justify-content: space-between;
  height: auto;
}
.home-calendar .header .btn{
  cursor: pointer;
  border: 0px solid rgb(153, 153, 153);
  padding: 0px 0px 0px 12px;
  align-items: center;
  color: var(--theme);
  border-radius: 4px;
  display: flex;
  width: auto;
  font-size: 16px;
  justify-content: center;
}
.home-calendar .header .title{
  padding: 0px 10px;
  font-size: 24px;
  align-items: center;
  justify-content: center;
  display: flex;
  color: var(--theme);
}
.home-calendar table{
  width: 100%;
  padding: 0px 0px 20px;
  height: auto;
}
.home-calendar tbody,thead{
  width: 100%;
}
.home-calendar tr{
  width: 100%;
  align-items: center;
  justify-content: center;
  display: flex;
}
.home-calendar th{
  align-items: center;
  flex: 1;
  display: flex;
  line-height: 50px;
  justify-content: center;
}
.home-calendar td{
  cursor: pointer;
  padding: 6px 12px 6px;
  flex: 1;
  display: flex;
  justify-content: center;
  text-align: center;
}
.home-calendar td.today .text{
  width: 80%;
  height: 80%;
  padding:5px 0;
  background: rgb(255 166 106 / 10%);
  color: var(--theme);
  border-radius:0px;
}
.home-calendar td.festival .text{
  width: 80%;
  height: 80%;
  padding:5px 0;
  background: #2f3f5610;
  border-radius:0px;
}

</style>
