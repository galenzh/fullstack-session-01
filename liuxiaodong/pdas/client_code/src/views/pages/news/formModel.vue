<template>
	<div>
		<el-dialog v-model="formVisible" :title="formTitle" width="60%" custom-class="news-detail-dialog" destroy-on-close>
			<div class="news_detail">
				<div class="news_detail_title" style="text-align: center;">{{detail.title}}</div>
				<div class="news_detail_time">发布时间：{{detail.addtime}}</div>
                <div class="news_detail_img" v-if="detail.picture">
                    <img v-for="src in detail.picture.split(',')" :src="$config.url+src">
                </div>
				<div class="news_detail_content" v-html="detail.content"></div>
			</div>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="formVisible=false">关闭</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>
<script setup>
	import {
		ref,
		nextTick,
		getCurrentInstance,
		defineEmits
	} from 'vue';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const id = ref(0)
	const detail = ref({})
	const formRef = ref(null)
	const formVisible = ref(false)
	const formTitle = ref('')
	//初始化
	const init = (refid=null) => {
        detail.value = {}
		if(refid){
			id.value = refid
			getInfo()
		}
		formTitle.value = '心理资讯'
		formVisible.value = true
	}
	//声明父级调用
	defineExpose({
		init
	})
	//回调父级方法
	const getInfo = () => {
		context?.$http({
			url: `news/detail/${id.value}`,
			method: 'get'
		}).then(res => {
			detail.value = res.data.data
			formVisible.value = true
		})
	}
</script>
<style lang="scss">
	.news_detail {
		.news_detail_title {
		}
	
		.news_detail_time {
		}
	
		.news_detail_content {
		}
	}
    .news_detail_img{
        text-align: center;
        margin: 20px;
        img{
            max-width: 100%;
            height: 300px;
        }
    }

.news_detail{
    width: 100%;
}
.news_detail .news_detail_title{
    font-size: 18px;
    font-weight: 500;
    color: rgb(0, 0, 0);
    text-align: center;
}
.news_detail .news_detail_time{
    text-align: right;
    font-size: 15px;
    color: #888;
    padding: 20px 0px 0px;
}
.news_detail .news_detail_content{
    margin-top:20px;
    text-align: left;
    font-size: 15px;
    color: #888;
    line-height:1.8;
    text-indent:2em;
}

</style>