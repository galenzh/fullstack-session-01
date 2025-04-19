<template>
	<div class="exam-view">
		<div class="exam_top">
			<div class="examTopBox examTopLeft">
				{{examDetail.name}} (共{{questionList.length}}题)
			</div>
			<div class="examTopBox examTopCenter">
				剩余时间：{{times}}
			</div>
			<div class="examTopBox examTopRight">
				<el-button type="danger" @click="leaveExam">退出考试</el-button>
			</div>
		</div>
		<!-- 答题进度条 -->
		<div class="progress-container">
			<div class="progress-info">
				<span>已答: {{answeredCount}}/{{questionList.length}}</span>
				<span>进度: {{progressPercentage}}%</span>
			</div>
			<div class="progress-bar">
				<div class="progress-fill" :style="{ width: progressPercentage + '%' }"></div>
			</div>
		</div>
		<div class="exam_top_kong"></div>
		<el-card v-if="endType" class="score_view">
			<div v-if="id == 3" class="personality-result">
				<h3 class="personality-title">性格测试结果分析</h3>
				<div class="personality-type">
					<span class="type-label">您的主导性格类型：</span>
					<span class="type-value">{{personalityTypes[personalityResult.type] || '多元型'}}</span>
				</div>
				<div class="personality-description">
					<p>{{personalityResult.description}}</p>
				</div>
				<div class="personality-suggestion">
					<h4>个性化建议：</h4>
					<p>{{personalityResult.suggestion}}</p>
				</div>
			</div>
			<div class="score_item" v-else-if="ismark">
				考试成绩：<span class="score_num">{{scoreChange()}}</span>
			</div>
            <div class="score_item" v-else>
                已完成，等待批阅
            </div>
			<div class="diagnosis_item" v-if="needDiagnosis">
				<el-alert
					title="您的得分较低，建议进行医生诊断"
					type="warning"
					description="根据您的测试结果，我们建议您咨询专业医生获取进一步的诊断和治疗方案。"
					show-icon
					:closable="false">
				</el-alert>
				<div class="diagnosis_btn_view">
					<el-button type="primary" @click="goDiagnosis">前往预约</el-button>
				</div>
            </div>
			<div class="btn_view">
				<el-button class="analysis" v-if="!analysisType && id != 3" type="primary" @click="viewAnalysis">查看解析</el-button>
				<el-button class="end" type="danger" @click="endExam">结束{{id == 3 ? '测试' : '考试'}}</el-button>
			</div>
		</el-card>
		<el-card class="question_list" v-if="(!submitType&&!analysisType)||(submitType&&analysisType)">
			<div class="question" v-for="(item,index) in questionList" :key="index">
				<div class="questionTitle">
					{{index + 1}}、{{item.questionname}}
				</div>
				<div class="optionList" v-if="!submitType">
					<div class="option" 
						v-for="(items,indexs) in item.optionList" 
						:key="indexs"
						:class="{ 'option-selected': item.myanswer === codeChange(indexs) }"
						@click="selectAnswer(item, codeChange(indexs))">
						<span class="option-prefix">{{codeChange(indexs)}}</span>
						<span class="option-text">{{items.text}}</span>
						<span class="option-check" v-if="item.myanswer === codeChange(indexs)">✓</span>
					</div>
				</div>
				<div class="optionList" v-else>
					<div class="option" 
						v-for="(items,indexs) in item.optionList" 
						:key="indexs"
						:class="{ 
							'option-selected': item.myanswer === codeChange(indexs),
							'option-correct': codeChange(indexs) === item.answer,
							'option-wrong': item.myanswer === codeChange(indexs) && codeChange(indexs) !== item.answer
						}">
						<span class="option-prefix">{{codeChange(indexs)}}</span>
						<span class="option-text">{{items.text}}</span>
						<span class="option-check option-correct-icon" v-if="codeChange(indexs) === item.answer">✓</span>
						<span class="option-check option-wrong-icon" v-if="item.myanswer === codeChange(indexs) && codeChange(indexs) !== item.answer">✗</span>
					</div>
				</div>
				<div class="answer" v-if="!submitType" style="display: none;">
					<el-select v-model="item.myanswer"
						placeholder="输入答案">
						<el-option v-for="(items,indexs) in item.optionList"
							:label="codeChange(indexs)" :value="codeChange(indexs)" :key="indexs"></el-option>
					</el-select>
				</div>
				<div class="answer" v-if="submitType">
					<div>我的答案：{{item.myanswer}}</div>
					<div>得分：{{item.myscore}}</div>
				</div>
				<el-collapse v-if="submitType" model-value="1" class="analysis_view">
					<el-collapse-item title="查看解析" name="1">
						<div class="analysis">解析：{{item.analysis}}</div>
					</el-collapse-item>
				</el-collapse>
				<el-divider v-if="questionList.length - 1!=index" />
			</div>
			<div class="btn_view" v-if="!submitType">
				<el-button class="submit" type="success" @click="save">立即交卷</el-button>
			</div>
		</el-card>
		<!-- 添加题目导航器 - 固定在右侧 -->
		<div class="question-navigator">
			<div class="navigator-title">答题导航</div>
			<div class="navigator-buttons">
				<div 
					v-for="(item, index) in questionList" 
					:key="index"
					class="navigator-button"
					:class="{
						'answered': item.myanswer,
						'current': currentQuestionIndex === index
					}"
					@click="scrollToQuestion(index)"
				>
					{{ index + 1 }}
				</div>
			</div>
			<div class="navigator-info">
				<div class="info-item">
					<span class="info-dot answered"></span>
					<span>已答题</span>
				</div>
				<div class="info-item">
					<span class="info-dot"></span>
					<span>未答题</span>
				</div>
			</div>
		</div>
	</div>
</template>

<script setup>
	import {
		ref,
		nextTick,
		getCurrentInstance,
		computed,
        onUnmounted,
        onMounted
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	import {
		ElMessageBox
	} from 'element-plus'
    import moment from 'moment'
	const route = useRoute()
	const router = useRouter()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//初始化
	const id = ref(0)
	
	// 性格类型映射
	const personalityTypes = {
		'A': '理性思考型',
		'B': '平衡适应型',
		'C': '内省谨慎型',
		'D': '情感社交型'
	}
	
	const init = () => {
		if (route.query.id) {
			id.value = route.query.id
			getSession()
			getExamination()
			getQuestionList()
		}
	}
	//获取用户信息
	const user = ref({})
	const getSession = () => {
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			user.value = res.data.data
		})
	}
	//获取试卷详情
	const examDetail = ref({})
	const examTime = ref(0)
	const timeInter = ref(null)
	const getExamination = () => {
		context?.$http({
			url: `exampaper/info/${id.value}`,
			method: 'get'
		}).then(res => {
			examDetail.value = res.data.data
			examTime.value = Number(res.data.data.time * 60)
			timeInter.value = setInterval(() => {
				examTime.value--
			}, 1000)
		})
	}
    const times = computed(() => {
      if(!examTime.value)return "0秒"
      let time = examTime.value
      if (time) {
        if (time > 60 && time < 3600) {
          time =`${parseInt(time / 60)}分钟${parseInt(time % 60)}秒`
        } else if (time >= 3600 && time < 3600 * 24) {
          time = `${parseInt(time / 3600)}小时${parseInt((time%3600)/60)}分钟${parseInt(time % 60)}秒`
        } else if (time >= 3600 * 24) {
          time = `${parseInt(time / 3600*24)}天${parseInt( (time%3600*24)/3600 )}小时${ parseInt((time%3600)/60) }分${parseInt(time%60)}秒`
        } else {
          if (parseInt(time) <= 0) {
              time = "0秒";
              //自动交卷
              submitType.value = true
              endType.value = true
              clearInterval(timeInter.value)
              for(let x in questionList.value){
                  saverecord(questionList.value[x])
              }
              // 检查是否需要医生诊断
              checkNeedDiagnosis()
          } else {
            time = parseInt(time) + "秒";
          }
        }
      }
      return time;
    })
	//交卷状态
	const submitType = ref(false)
	const endType = ref(false)
	//是否查看解析
	const analysisType = ref(false)
	//试题
	const questionList = ref([])
    const ismark = ref(1)
	const getQuestionList = () => {
		context?.$http({
			url: 'examquestion/page',
			method: 'get',
			params: {
				page: 1,
				limit: 1000,
				sort: 'sequence',
				paperid: id.value
			}
		}).then(res => {
          // 如果是性格测试（ID=3）且没有返回题目，提供默认题目
          if (id.value == 3 && (!res.data.data.list || res.data.data.list.length === 0)) {
            // 添加默认的性格测试题目
            const personalityTestQuestions = [
              {
                id: 10001,
                questionname: "当我感到压力时，我通常会选择：",
                type: 1,
                score: 10,
                answer: "A",
                analysis: "选择A反映了您的冷静思考能力；选择B反映了您的情感依赖倾向；选择C反映了您的回避性格；选择D反映了您的社交依赖性。",
                options: JSON.stringify([
                  { text: "静下心来思考解决方案" },
                  { text: "向亲近的人倾诉" },
                  { text: "转移注意力，做其他事情" },
                  { text: "寻求专业帮助" }
                ]),
                optionList: [
                  { text: "静下心来思考解决方案" },
                  { text: "向亲近的人倾诉" },
                  { text: "转移注意力，做其他事情" },
                  { text: "寻求专业帮助" }
                ],
                myanswer: '',
                myscore: 0
              },
              {
                id: 10002,
                questionname: "在面对挑战时，我通常会：",
                type: 1,
                score: 10,
                answer: "A",
                analysis: "选择A表明您具有积极面对困难的态度；选择B反映了您的谨慎性格；选择C可能表明您有些缺乏自信；选择D表明您注重团队协作。",
                options: JSON.stringify([
                  { text: "勇敢面对，迎难而上" },
                  { text: "先评估风险，再决定行动" },
                  { text: "担心自己无法应对" },
                  { text: "寻求他人帮助或合作" }
                ]),
                optionList: [
                  { text: "勇敢面对，迎难而上" },
                  { text: "先评估风险，再决定行动" },
                  { text: "担心自己无法应对" },
                  { text: "寻求他人帮助或合作" }
                ],
                myanswer: '',
                myscore: 0
              },
              {
                id: 10003,
                questionname: "当我遇到矛盾和冲突时，我倾向于：",
                type: 1,
                score: 10,
                answer: "B",
                analysis: "选择A可能表明您有些强势；选择B反映了您善于妥协和寻求共识的能力；选择C表明您可能有回避冲突的倾向；选择D表明您重视关系胜过解决问题。",
                options: JSON.stringify([
                  { text: "坚持自己的立场，直到对方妥协" },
                  { text: "寻找双方都能接受的解决方案" },
                  { text: "避免冲突，保持沉默" },
                  { text: "顺从对方，以维持关系" }
                ]),
                optionList: [
                  { text: "坚持自己的立场，直到对方妥协" },
                  { text: "寻找双方都能接受的解决方案" },
                  { text: "避免冲突，保持沉默" },
                  { text: "顺从对方，以维持关系" }
                ],
                myanswer: '',
                myscore: 0
              },
              {
                id: 10004,
                questionname: "当我犯错误时，我通常会：",
                type: 1,
                score: 10,
                answer: "A",
                analysis: "选择A表明您具有良好的自我认知和责任感；选择B反映出您可能过于在意他人评价；选择C表明您可能有自我防御的倾向；选择D反映出您有学习和成长的意愿。",
                options: JSON.stringify([
                  { text: "坦然接受并承担责任" },
                  { text: "感到羞愧和尴尬" },
                  { text: "为自己辩解或找借口" },
                  { text: "思考如何避免再次犯同样的错误" }
                ]),
                optionList: [
                  { text: "坦然接受并承担责任" },
                  { text: "感到羞愧和尴尬" },
                  { text: "为自己辩解或找借口" },
                  { text: "思考如何避免再次犯同样的错误" }
                ],
                myanswer: '',
                myscore: 0
              },
              {
                id: 10005,
                questionname: "在社交场合中，我通常是：",
                type: 1,
                score: 10,
                answer: "C",
                analysis: "选择A表明您可能是外向型性格；选择B反映出您可能是社交型性格；选择C表明您可能偏向内向；选择D表明您可能有社交焦虑。",
                options: JSON.stringify([
                  { text: "活跃的中心人物" },
                  { text: "积极与他人交流互动" },
                  { text: "安静地观察他人" },
                  { text: "感到不自在，希望尽快离开" }
                ]),
                optionList: [
                  { text: "活跃的中心人物" },
                  { text: "积极与他人交流互动" },
                  { text: "安静地观察他人" },
                  { text: "感到不自在，希望尽快离开" }
                ],
                myanswer: '',
                myscore: 0
              },
              {
                id: 10006,
                questionname: "面对重大决策时，我更倾向于：",
                type: 1,
                score: 10,
                answer: "B",
                analysis: "选择A表明您可能重视理性思考；选择B表明您可能关注情感和价值观；选择C反映出您可能依赖他人决策；选择D表明您可能有决策焦虑。",
                options: JSON.stringify([
                  { text: "分析利弊得失，逻辑决策" },
                  { text: "根据自己的感受和价值观决定" },
                  { text: "参考他人意见后再做决定" },
                  { text: "推迟决定，担心做出错误选择" }
                ]),
                optionList: [
                  { text: "分析利弊得失，逻辑决策" },
                  { text: "根据自己的感受和价值观决定" },
                  { text: "参考他人意见后再做决定" },
                  { text: "推迟决定，担心做出错误选择" }
                ],
                myanswer: '',
                myscore: 0
              },
              {
                id: 10007,
                questionname: "当我完成一项艰巨任务后，我通常会：",
                type: 1,
                score: 10,
                answer: "D",
                analysis: "选择A反映出您可能追求完美；选择B表明您可能注重成果；选择C表明您可能注重外界认可；选择D反映您有良好的自我激励能力。",
                options: JSON.stringify([
                  { text: "立即关注任何需要改进的地方" },
                  { text: "专注于所取得的成果" },
                  { text: "希望得到他人的认可和赞赏" },
                  { text: "感到自豪和满足" }
                ]),
                optionList: [
                  { text: "立即关注任何需要改进的地方" },
                  { text: "专注于所取得的成果" },
                  { text: "希望得到他人的认可和赞赏" },
                  { text: "感到自豪和满足" }
                ],
                myanswer: '',
                myscore: 0
              },
              {
                id: 10008,
                questionname: "当我的计划被打乱时，我通常会：",
                type: 1,
                score: 10,
                answer: "B",
                analysis: "选择A表明您可能有控制欲和固执倾向；选择B反映出您的适应能力和灵活性；选择C表明您可能容易沮丧；选择D反映您可能有回避应对的倾向。",
                options: JSON.stringify([
                  { text: "坚持原计划，尽量按原定方式进行" },
                  { text: "灵活调整，制定新计划" },
                  { text: "感到失落和沮丧" },
                  { text: "放弃原计划，等待时机" }
                ]),
                optionList: [
                  { text: "坚持原计划，尽量按原定方式进行" },
                  { text: "灵活调整，制定新计划" },
                  { text: "感到失落和沮丧" },
                  { text: "放弃原计划，等待时机" }
                ],
                myanswer: '',
                myscore: 0
              }
            ];
            res.data.data.list = personalityTestQuestions;
            res.data.data.total = personalityTestQuestions.length;
          }
          
          res.data.data.list.forEach(item=>{
              if (item.options) {
                try {
                  // 确保选项正确解析为数组
                item.optionList = JSON.parse(item.options)
                  // 确保每个选项都有正确的属性
                  if (!Array.isArray(item.optionList)) {
                    item.optionList = []
                  }
                } catch (e) {
                  console.error("解析选项出错:", e)
                  item.optionList = []
                }
              } else {
                item.optionList = []
              }
              // 初始化答案
              item.myanswer = ''
              item.myscore = 0
          })
          console.log("题目列表:", res.data.data.list)
			questionList.value = res.data.data.list
		})
	}
	//获取选项
	const codeChange = (type) => {
		let arr = ['A', 'B', 'C', 'D']
		return arr[type]
	}

	//退出考试
	const leaveExam = () => {
		ElMessageBox.confirm(`是否退出考试？`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
			history.back()
		}).catch(_ => {})
	}
	//结束考试
	const endExam = () => {
		history.back()
	}
	//提交考试记录
	const saverecord = (row) => {
		let arr = {
			userid: user.value.id,
			username: user.value.xingming,
			paperid: examDetail.value.id,
			papername: examDetail.value.name,
			questionid: parseInt(row.id),
			questionname: row.questionname,
			options: row.options ? row.options : '[]',
			score: row.score,
			answer: row.answer,
			analysis: row.analysis,
			myanswer: row.myanswer,
			myscore:row.myscore,
            type:row.type,
            ismark:ismark.value,
		}
		context?.$http({
			url: 'examrecord/save',
			method: 'POST',
			data: arr
		}).then(res => {})
	}
	//查看解析
	const viewAnalysis = () => {
		analysisType.value = true
	}
	
	// 定义性格分析结果
	const personalityResult = ref({
		type: '',
		description: '',
		suggestion: ''
	})

	// 检查是否需要医生诊断
	const needDiagnosis = ref(false)
	const checkNeedDiagnosis = () => {
		const score = scoreChange()
		// 设置阈值，低于60分需要医生诊断
		const threshold = 60
		// 性格测试不需要显示医生诊断提示
		if(id.value == 3) {
			needDiagnosis.value = false
			// 分析性格测试结果
			analyzePersonalityTest()
		} else {
			needDiagnosis.value = score < threshold
		}
	}
	
	// 分析性格测试结果
	const analyzePersonalityTest = () => {
		// 统计各个选项的选择情况
		let countA = 0, countB = 0, countC = 0, countD = 0
		
		for(let x in questionList.value) {
			const answer = questionList.value[x].myanswer
			if(answer === 'A') countA++
			else if(answer === 'B') countB++
			else if(answer === 'C') countC++
			else if(answer === 'D') countD++
		}
		
		// 判断主导性格类型
		let maxCount = Math.max(countA, countB, countC, countD)
		let type = ''
		
		if(maxCount === countA) type = 'A'
		else if(maxCount === countB) type = 'B'
		else if(maxCount === countC) type = 'C'
		else if(maxCount === countD) type = 'D'
		
		// 设置性格分析结果
		personalityResult.value.type = type
		
		switch(type) {
			case 'A':
				personalityResult.value.description = '您是一个理性思考型的人，在面对压力和挑战时，倾向于冷静分析问题并积极寻找解决方案。您具有较强的自我掌控能力和解决问题的能力。'
				personalityResult.value.suggestion = '建议您在重要决策时，适当考虑情感因素，增强情感表达能力，培养与他人的共情能力。'
				break
			case 'B':
				personalityResult.value.description = '您是一个平衡适应型的人，善于在不同情境中调整自己，寻找平衡点。您重视人际关系，同时也能保持自我的独立性。'
				personalityResult.value.suggestion = '建议您在面对挑战时，可以更加果断一些，不要过度追求完美或平衡，有时需要做出明确的选择和决定。'
				break
			case 'C':
				personalityResult.value.description = '您是一个内省谨慎型的人，倾向于深入思考问题并谨慎行动。您通常具有较强的观察力和分析能力，但可能有回避冲突的倾向。'
				personalityResult.value.suggestion = '建议您适当增强自信心，主动参与社交活动，学会在必要时表达自己的观点和需求，不要过度回避问题和冲突。'
				break
			case 'D':
				personalityResult.value.description = '您是一个情感社交型的人，重视人际关系和情感连接。您通常善于与他人合作，乐于寻求和提供帮助，但可能过度依赖外界反馈。'
				personalityResult.value.suggestion = '建议您培养独立思考和决策的能力，学会在没有他人支持的情况下自信地解决问题，建立更强的自我认同感。'
				break
			default:
				personalityResult.value.description = '您的测试结果显示出多元化的性格特点，没有明显的单一倾向。'
				personalityResult.value.suggestion = '建议您继续保持这种灵活多样的性格特点，根据不同情境灵活调整自己的行为方式。'
		}
	}
	
	// 前往预约医生
	const goDiagnosis = () => {
		// 跳转到预约页面
		router.push('/index/zixunshiyuyueAdd')
	}
	
	//交卷
	const save = () => {
		ElMessageBox.confirm(`是否完成${id.value == 3 ? '测试' : '考试'}？`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
			for(let x in questionList.value){
				// 初始化得分为0
				questionList.value[x].myscore = 0
				
				// 如果用户选择了答案
				if(questionList.value[x].myanswer) {
					// 性格测试不计算对错，给予固定分数
					if(id.value == 3) {
						questionList.value[x].myscore = parseFloat(questionList.value[x].score || 0)
					} else {
						// 判断答案是否正确
						if(questionList.value[x].myanswer === questionList.value[x].answer) {
							// 答案正确，得到满分
							questionList.value[x].myscore = parseFloat(questionList.value[x].score || 0)
						}
					}
				}
				
				// 保存记录
				saverecord(questionList.value[x])
			}
			clearInterval(timeInter.value)
			submitType.value = true
			endType.value = true
			
			// 检查是否需要医生诊断
			checkNeedDiagnosis()
		}).catch(_ => {})
	}
	const encodeChange = (index) => {
		let arr = ['A', 'B', 'C', 'D']
		for(let x in arr){
			if(arr[x] == index){
				return x
			}
		}
		return undefined
	}
	//分数统计
	const scoreChange = () => {
		let score = 0
		for (let x in questionList.value) {
			score += parseFloat(questionList.value[x].myscore || 0)
		}
		
		// 性格测试不显示分数，返回百分比
		if(id.value == 3) {
			const totalQuestions = questionList.value.length
			const answeredQuestions = questionList.value.filter(q => q.myanswer).length
			if(totalQuestions > 0) {
				return Math.round((answeredQuestions / totalQuestions) * 100) + '%'
			}
			return '0%'
		}
		
		return score
	}
	
	// 组件卸载时清除定时器
	onUnmounted(() => {
		if(timeInter.value) {
			clearInterval(timeInter.value)
		}
	})
	
	// 计算已答题数量和进度
	const answeredCount = computed(() => {
		return questionList.value.filter(q => q.myanswer).length
	})

	const progressPercentage = computed(() => {
		if (questionList.value.length === 0) return 0
		return Math.floor((answeredCount.value / questionList.value.length) * 100)
	})
	
	// 当前题目索引
	const currentQuestionIndex = ref(0)

	// 监听滚动确定当前题目
	onMounted(() => {
		window.addEventListener('scroll', updateCurrentQuestion)
	})

	onUnmounted(() => {
		window.removeEventListener('scroll', updateCurrentQuestion)
	})

	const updateCurrentQuestion = () => {
		const questionElements = document.querySelectorAll('.question')
		if (questionElements.length === 0) return
		
		const windowHeight = window.innerHeight
		let closestQuestion = 0
		let closestDistance = Infinity
		
		questionElements.forEach((element, index) => {
			const rect = element.getBoundingClientRect()
			const distance = Math.abs(rect.top + rect.height / 2 - windowHeight / 2)
			
			if (distance < closestDistance) {
				closestDistance = distance
				closestQuestion = index
			}
		})
		
		currentQuestionIndex.value = closestQuestion
	}

	// 滚动到指定题目
	const scrollToQuestion = (index) => {
		const questionElements = document.querySelectorAll('.question')
		if (questionElements[index]) {
			questionElements[index].scrollIntoView({ behavior: 'smooth', block: 'center' })
			currentQuestionIndex.value = index
		}
	}

	// 用户点击选项时选择答案
	const selectAnswer = (question, answer) => {
		question.myanswer = answer;
		// 选择答案后自动滚动到下一题
		setTimeout(() => {
			const currentIndex = questionList.value.findIndex(q => q.id === question.id);
			if (currentIndex < questionList.value.length - 1) {
				scrollToQuestion(currentIndex + 1)
			}
		}, 300);
	}
	
	init()
</script>

<style lang="scss" scoped>
	.exam_top {
		
		// 考试名称
		.examTopLeft {
		}
		//时间
		.examTopCenter {
		}
		// 退出考试盒子
		.examTopRight {
			// 按钮
			:deep(.el-button--danger) {
			}
			// 按钮悬浮
			:deep(.el-button--danger:hover) {
			}
		}
	}

	// 答题区域
	.question_list {
		// 答题盒子
		.question {
			// 分割线
			:deep(.el-divider) {
				margin: 24px 0;
				display: block;
				width: 100%;
				height: 0;
			}
			// 题目
			.questionTitle {
				// 单选题
				:deep(.el-tag--success) {
					background-color: #f0f9eb;
					color: #67c23a;
					font-size: inherit;
					border-color: #e1f3d8;
				}
				// 判断题
				:deep(.el-tag--danger) {
					background-color: #fef0f0;
					color: #f56c6c;
					font-size: inherit;
					border-color: #fde2e2;
				}
				// 填空题
				:deep(.el-tag--info) {
					background-color: #f4f4f5;
					color: #909399;
					font-size: inherit;
					border-color: #e9e9eb;
				}
				// 多选题
				:deep(.el-tag--warning) {
					background-color: #fdf6ec;
					color: #e6a23c;
					font-size: inherit;
					border-color: #faecd8;
				}
			}
			// 选项列表
			.optionList {
				padding: 15px 0;
				text-indent: 0;
				margin-top: 5px;
			}
			.optionList .option {
				padding: 15px 20px;
				transition: all 0.3s;
				border-radius: 8px;
				margin-bottom: 12px;
				cursor: pointer;
				background-color: #f9f9f9;
				border: 1px solid #f0f0f0;
				position: relative;
				overflow: hidden;
				display: flex;
				align-items: center;
				
				&:hover {
					background-color: #f0f7ff;
					border-color: #d9ecff;
					box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
					transform: translateY(-2px);
				}
				
				&::before {
					content: '';
					position: absolute;
					left: 0;
					top: 0;
					height: 100%;
					width: 4px;
					background: linear-gradient(to bottom, var(--theme), #409EFF);
					opacity: 0;
					transition: all 0.3s;
				}
				
				&:hover::before {
					opacity: 1;
				}
				
				.option-prefix {
					font-weight: bold;
					color: var(--theme);
					margin-right: 15px;
					background: rgba(64, 158, 255, 0.1);
					width: 28px;
					height: 28px;
					border-radius: 50%;
					display: flex;
					align-items: center;
					justify-content: center;
					transition: all 0.3s;
				}
				
				.option-text {
					flex: 1;
				}
				
				.option-check {
					display: flex;
					align-items: center;
					justify-content: center;
					width: 24px;
					height: 24px;
					border-radius: 50%;
					background: var(--theme);
					color: white;
					font-weight: bold;
					margin-left: 10px;
					animation: fadeIn 0.3s ease-out;
				}
				
				.option-correct-icon {
					background: #67c23a;
				}
				
				.option-wrong-icon {
					background: #f56c6c;
				}
			}
			.optionList .option-selected {
				background-color: #ecf5ff;
				border-color: #b3d8ff;
				box-shadow: 0 2px 12px rgba(64, 158, 255, 0.1);
				
				&::before {
					opacity: 1;
				}
				
				.option-prefix {
					color: white;
					background: var(--theme);
				}
			}
			.optionList .option-correct {
				background-color: #f0f9eb;
				border-color: #c2e7b0;
				
				&::before {
					background: linear-gradient(to bottom, #67c23a, #85ce61);
					opacity: 1;
				}
				
				.option-prefix {
					color: white;
					background: #67c23a;
				}
			}
			.optionList .option-wrong {
				background-color: #fef0f0;
				border-color: #fac6c6;
				
				&::before {
					background: linear-gradient(to bottom, #f56c6c, #fc9999);
					opacity: 1;
				}
				
				.option-prefix {
					color: white;
					background: #f56c6c;
				}
			}
			// 答案盒子
			.answer {
				padding: 20px 0 10px;
			}
			.answer :deep(.el-select) {
				border: 1px solid #e0e0e0;
				border-radius: 6px;
				padding: 0 15px;
					width: calc(100% - 120px);
				line-height: 42px;
					box-sizing: border-box;
				box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
				transition: all 0.3s;
			}
			.answer :deep(.el-select:hover) {
				border-color: #409EFF;
				box-shadow: 0 4px 12px rgba(64, 158, 255, 0.15);
			}
			.answer :deep(.el-select .el-input__wrapper) {
				box-shadow: none !important;
				padding: 0;
			}
			.answer :deep(.el-select .el-input__wrapper:hover) {
				box-shadow: none !important;
			}
			.answer :deep(.el-select .el-input__wrapper .el-input__inner) {
				height: 40px;
				font-size: 15px;
			}
			.answer > div {
				margin-bottom: 8px;
				font-size: 15px;
				padding: 5px 0;
				color: #333;
			}
			// 解析盒子
			:deep(.analysis_view) {
				border: 1px solid #eee;
				padding: 5px 15px;
				border-radius: 6px;
				margin-top: 10px;
				background: #fafafa;
			}
			:deep(.analysis_view .el-collapse-item__header) {
				font-size: 15px;
				color: #409EFF;
				font-weight: 500;
				height: 48px;
			}
			:deep(.analysis_view .analysis) {
				color: #666;
				line-height: 1.8;
				text-indent: 1rem;
				padding: 5px 0 10px;
			}
		}
		// 按钮盒子
		.btn_view{
			width: 100%;
			margin: 40px 0px 30px;
			padding: 15px 0;
			text-align: center;
			position: relative;
		}
		.btn_view::before {
			content: '';
			position: absolute;
			top: 0;
			left: 50%;
			transform: translateX(-50%);
			width: 100px;
			height: 2px;
			background: linear-gradient(to right, transparent, rgba(0, 0, 0, 0.1), transparent);
		}
		.btn_view .el-button--success {
			margin: 0px 10px;
			padding: 0px 30px;
			height: 48px;
			font-size: 16px;
			font-weight: 500;
			color: #fff;
			border-radius: 6px;
			border: 0px;
			background: linear-gradient(to right, #00ca0e, #09d751);
			cursor: pointer;
			transition: all 0.3s;
			box-shadow: 0 4px 10px rgba(0, 202, 14, 0.2);
		}
		.btn_view .el-button--success:hover {
			transform: translateY(-2px);
			box-shadow: 0 6px 15px rgba(0, 202, 14, 0.3);
		}
		.btn_view .el-button--primary {
			margin: 0px 10px;
			padding: 0px 30px;
			height: 48px;
			font-size: 16px;
			font-weight: 500;
			color: #fff;
			border-radius: 6px;
			border: 0px;
			background: linear-gradient(to right, var(--theme), #409EFF);
			cursor: pointer;
			transition: all 0.3s;
			box-shadow: 0 4px 10px rgba(64, 158, 255, 0.2);
		}
		.btn_view .el-button--primary:hover {
			transform: translateY(-2px);
			box-shadow: 0 6px 15px rgba(64, 158, 255, 0.3);
		}
		.btn_view .el-button--danger {
			margin: 0px 10px;
			padding: 0px 30px;
			height: 48px;
			font-size: 16px;
			font-weight: 500;
			color: #fff;
			border-radius: 6px;
			border: 0px;
			background: linear-gradient(to right, rgb(240, 110, 110), #f56c6c);
			cursor: pointer;
			transition: all 0.3s;
			box-shadow: 0 4px 10px rgba(245, 108, 108, 0.2);
		}
		.btn_view .el-button--danger:hover {
			transform: translateY(-2px);
			box-shadow: 0 6px 15px rgba(245, 108, 108, 0.3);
		}
	}
	// 成绩盒子
	.score_view {
		.score_item {
			padding: 20px;
			text-align: center;
			font-size: 26px;
			color: #333;
		}
		.score_item .score_num {
			font-size: 36px;
			font-weight: bold;
			color: #f56c6c;
			text-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
			animation: scoreShow 0.8s ease-out;
		}
		@keyframes scoreShow {
			0% { transform: scale(0.6); opacity: 0; }
			70% { transform: scale(1.1); }
			100% { transform: scale(1); opacity: 1; }
		}
	}
	
	// 添加医生诊断相关样式
	.diagnosis_item {
		margin: 25px 0;
		padding: 20px;
		border-radius: 8px;
		background-color: #fff9f4;
		border: 1px solid #ffe1c2;
		box-shadow: 0 3px 8px rgba(255, 152, 0, 0.1);
		animation: fadeInUp 0.8s ease-out;
		
		:deep(.el-alert) {
			background-color: transparent;
			padding: 0;
			border: none;
			
			.el-alert__title {
				font-size: 18px;
				color: #e6a23c;
				font-weight: 600;
			}
			
			.el-alert__description {
				color: #bd7b18;
				margin: 10px 0;
				line-height: 1.6;
				font-size: 15px;
			}
			
			.el-alert__icon {
				color: #e6a23c;
				font-size: 20px;
			}
		}
		
		.diagnosis_btn_view {
			margin-top: 20px;
			text-align: center;
			
			.el-button--primary {
				background: linear-gradient(to right, #e6a23c, #f3b760);
				border: none;
				box-shadow: 0 4px 8px rgba(230, 162, 60, 0.25);
				padding: 10px 25px;
				font-size: 15px;
				transition: all 0.3s;
			}
			
			.el-button--primary:hover {
				transform: translateY(-2px);
				box-shadow: 0 6px 12px rgba(230, 162, 60, 0.35);
			}
		}
	}

	// 性格测试结果样式
	.personality-result {
		padding: 30px;
		background-color: #f5f9ff;
		border-radius: 10px;
		margin-bottom: 25px;
		border: 1px solid #d1e3ff;
		box-shadow: 0 4px 15px rgba(64, 158, 255, 0.08);
		animation: fadeIn 1s ease-out;
		
		.personality-title {
			color: #409EFF;
			text-align: center;
			margin-bottom: 25px;
			font-size: 28px;
			font-weight: bold;
			text-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
			position: relative;
			
			&::after {
				content: '';
				position: absolute;
				bottom: -10px;
				left: 50%;
				transform: translateX(-50%);
				width: 80px;
				height: 3px;
				background: linear-gradient(to right, #409EFF, #85c0ff);
				border-radius: 3px;
			}
		}
		
		.personality-type {
			font-size: 20px;
			margin-bottom: 20px;
			text-align: center;
			
			.type-label {
				font-weight: bold;
				color: #666;
			}
			
			.type-value {
				color: #409EFF;
				font-weight: bold;
				margin-left: 8px;
				font-size: 24px;
				display: inline-block;
				position: relative;
				
				&::after {
					content: '';
					position: absolute;
					bottom: 0;
					left: 0;
					width: 100%;
					height: 6px;
					background-color: rgba(64, 158, 255, 0.2);
					border-radius: 3px;
					z-index: -1;
				}
			}
		}
		
		.personality-description {
			margin-bottom: 25px;
			line-height: 1.8;
			text-align: justify;
			color: #333;
			padding: 20px;
			background-color: white;
			border-radius: 8px;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
			
			p {
				margin: 0;
			}
		}
		
		.personality-suggestion {
			background: linear-gradient(to right, #ecf5ff, #f5f9ff);
			padding: 20px;
			border-radius: 8px;
			border-left: 5px solid #409EFF;
			box-shadow: 0 3px 10px rgba(0, 0, 0, 0.03);
			
			h4 {
				color: #409EFF;
				margin-top: 0;
				margin-bottom: 15px;
				font-size: 18px;
				display: inline-block;
				position: relative;
				
				&::after {
					content: '';
					position: absolute;
					bottom: -2px;
					left: 0;
					width: 100%;
					height: 2px;
					background-color: #409EFF;
				}
			}
			
			p {
				margin: 0;
				line-height: 1.8;
				color: #333;
			}
		}
	}
	
	@keyframes fadeIn {
		0% { opacity: 0; }
		100% { opacity: 1; }
	}
	
	@keyframes fadeInUp {
		0% { 
			opacity: 0;
			transform: translateY(20px);
		}
		100% { 
			opacity: 1;
			transform: translateY(0);
		}
	}

	// 题目导航器样式
	.question-navigator {
		position: fixed;
		right: 20px;
		top: 50%;
		transform: translateY(-50%);
		width: 200px;
		background: white;
		border-radius: 10px;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
		padding: 15px;
		z-index: 990;
		transition: all 0.3s;
		
		@media screen and (max-width: 1500px) {
			width: 180px;
		}
		
		@media screen and (max-width: 1400px) {
			right: 10px;
			width: 60px;
			padding: 10px;
			
			.navigator-title {
				font-size: 12px;
			}
			
			.navigator-info {
				display: none;
			}
		}
		
		@media screen and (max-width: 768px) {
			display: none;
		}
		
		.navigator-title {
			text-align: center;
			font-weight: bold;
			color: #333;
			margin-bottom: 10px;
			padding-bottom: 10px;
			border-bottom: 1px solid #f0f0f0;
		}
		
		.navigator-buttons {
			display: flex;
			flex-wrap: wrap;
			gap: 8px;
			
			.navigator-button {
				width: 30px;
				height: 30px;
				display: flex;
				align-items: center;
				justify-content: center;
				background: #f5f5f5;
				border-radius: 6px;
				color: #666;
				font-weight: 500;
				cursor: pointer;
				transition: all 0.3s;
				position: relative;
				
				&:hover {
					background: #e0e0e0;
					transform: translateY(-2px);
				}
				
				&.answered {
					background: rgba(64, 158, 255, 0.15);
					color: var(--theme);
					
					&::after {
						content: '';
						position: absolute;
						width: 6px;
						height: 6px;
						background: var(--theme);
						border-radius: 50%;
						right: 2px;
						top: 2px;
					}
				}
				
				&.current {
					background: var(--theme);
					color: white;
					transform: scale(1.1);
					
					&::after {
						background: white;
					}
				}
			}
		}
		
		.navigator-info {
			margin-top: 15px;
			padding-top: 10px;
			border-top: 1px solid #f0f0f0;
			
			.info-item {
				display: flex;
				align-items: center;
				font-size: 12px;
				color: #666;
				margin-bottom: 5px;
				
				.info-dot {
					width: 12px;
					height: 12px;
					border-radius: 50%;
					background: #f5f5f5;
					margin-right: 5px;
					
					&.answered {
						background: rgba(64, 158, 255, 0.15);
					}
				}
			}
		}
	}

	// 在小屏幕设备上调整卡片宽度
	@media screen and (max-width: 1500px) {
		.exam-view .question_list,
		.exam-view .score_view {
			width: 1000px;
		}
	}
</style>
<style>
/*总盒子*/
.exam-view {
    background: linear-gradient(to bottom, #f5f7fa, #fff);
    min-height: 100vh;
    position: relative;
    overflow-x: hidden;
}
/*头部 盒子*/
.exam-view .exam_top{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 64px;
    background: linear-gradient(135deg, var(--theme) 0%, #409EFF 100%) !important;
    z-index: 999;
    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.15);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0px calc((100% - 1180px) / 2) !important;
    box-sizing: border-box;
    font-size: 16px;
    color: #fff;
    transition: all 0.3s ease;
}
/*顶部占位空间，防止内容被固定头部覆盖*/
.exam-view .exam_top_kong{
    width: 100%;
    height: 84px;
}
/*顶部盒子*/
.exam-view .exam_top .examTopBox{
    width: calc(33.3333%) !important;
    text-align: center;
    transition: all 0.3s;
}
/*试卷名称*/
.exam-view .exam_top .examTopLeft{
    text-align: left;
    font-weight: bold;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    font-size: 18px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 400px;
    padding-right: 20px;
}
/*时间*/
.exam-view .exam_top .examTopCenter{
    text-align: center;
    font-size: 18px;
    font-weight: 500;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    background: rgba(255, 255, 255, 0.15);
    padding: 6px 20px 6px 40px;
    border-radius: 20px;
    transition: all 0.3s;
    animation: pulsate 2s infinite;
    position: relative;
}

.exam-view .exam_top .examTopCenter::before {
    content: '';
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    width: 16px;
    height: 16px;
    border: 2px solid rgba(255, 255, 255, 0.8);
    border-radius: 50%;
}

.exam-view .exam_top .examTopCenter::after {
    content: '';
    position: absolute;
    left: 25px;
    top: 50%;
    width: 6px;
    height: 2px;
    background-color: rgba(255, 255, 255, 0.8);
    transform-origin: 0 50%;
    transform: rotate(90deg) translateX(-50%);
    animation: timeRotate 60s linear infinite;
}

@keyframes timeRotate {
    0% { transform: rotate(90deg) translateX(-50%); }
    100% { transform: rotate(450deg) translateX(-50%); }
}

@keyframes pulsate {
    0% { box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.4); }
    70% { box-shadow: 0 0 0 6px rgba(255, 255, 255, 0); }
    100% { box-shadow: 0 0 0 0 rgba(255, 255, 255, 0); }
}

/*按钮 盒子*/
.exam-view .exam_top .examTopRight{
    text-align: right;
}
/*按钮*/
.exam-view .exam_top .examTopRight .el-button--danger {
    border: none;
    background: rgba(255, 255, 255, 0.2);
    color: #fff;
    padding: 8px 20px;
    font-size: 14px;
    transition: all 0.3s;
    border-radius: 20px;
    position: relative;
    overflow: hidden;
}

.exam-view .exam_top .examTopRight .el-button--danger::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: all 0.6s;
}

.exam-view .exam_top .examTopRight .el-button--danger:hover {
    background: rgba(255, 255, 255, 0.3);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    transform: translateY(-2px);
}

.exam-view .exam_top .examTopRight .el-button--danger:hover::before {
    left: 100%;
}

/*响应式调整*/
@media screen and (max-width: 1200px) {
    .exam-view .question_list,
    .exam-view .score_view {
        width: 95%;
    }
    
    .exam-view .exam_top {
        padding: 0 15px !important;
    }
    
    .exam-view .exam_top .examTopLeft {
        font-size: 16px;
        max-width: 300px;
    }
    
    .exam-view .exam_top .examTopCenter {
        font-size: 16px;
        padding: 5px 12px;
    }
}

@media screen and (max-width: 768px) {
    .exam-view .exam_top .examTopLeft {
        font-size: 14px;
        max-width: 200px;
    }
    
    .exam-view .exam_top .examTopCenter {
        font-size: 14px;
        padding: 4px 10px;
    }
    
    .exam-view .question_list .question {
        padding: 20px 15px;
    }
    
    .exam-view .btn_view .el-button--success,
    .exam-view .btn_view .el-button--primary,
    .exam-view .btn_view .el-button--danger {
        padding: 0 20px;
        height: 42px;
        font-size: 15px;
    }
}

/*试卷内容 盒子*/
.exam-view .question_list{
    width: 1200px;
    margin: 30px auto 0px;
    padding: 20px 0;
    border: none;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
    font-size: 15px;
    color: rgb(102, 102, 102);
    background: none;
    border-radius: 8px;
}
.exam-view .question_list .el-card__body{
    padding: 0;
}
/*题目 盒子*/
.exam-view .question_list .question{
    width: 100%;
    display: block;
    padding: 25px;
    background: #fff;
    border: 1px solid #eee;
    border-radius: 8px;
    margin: 0px 0px 40px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
    transition: all 0.3s;
}
.exam-view .question_list .question:hover {
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    transform: translateY(-2px);
}
/*标题*/
.exam-view .question_list .question .questionTitle{
    width: 100%;
    font-size: 18px;
    color: #333;
    font-weight: 600;
    margin-bottom: 15px;
}

/*按钮 盒子*/
.exam-view .btn_view{
    width: 100%;
    margin: 30px 0px 20px;
    padding: 0px;
    clear: both;
    text-align: center;
}
/*查看解析*/
.exam-view .btn_view .el-button--primary{
    margin: 0px 10px 0px 0px;
    padding: 0px 20px;
    width: auto;
    height: 44px;
    font-size: 15px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: var(--theme);
    cursor: pointer;
}
.exam-view .btn_view .el-button--primary:hover{
}
/*下一题*/
.exam-view .btn_view .el-button--warning{
    margin: 0px 10px 0px 0px;
    padding: 0px 20px;
    width: auto;
    height: 44px;
    font-size: 15px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: rgba(80, 200, 160,1);
    cursor: pointer;
}
.exam-view .btn_view .el-button--warning:hover{
}
/*提交*/
.exam-view .btn_view .el-button--success{
    margin: 0px 10px 0px 0px;
    padding: 0px 20px;
    width: auto;
    height: 44px;
    font-size: 15px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: #00ca0e;
    cursor: pointer;
}
.exam-view .btn_view .el-button--success:hover{
}
/*结束考试*/
.exam-view .btn_view .el-button--danger{
    margin: 0px 10px 0px 0px;
    padding: 0px 20px;
    width: auto;
    height: 44px;
    font-size: 15px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: rgb(240, 110, 110);
    cursor: pointer;
}
.exam-view .btn_view .el-button--danger:hover{
}

/*成绩盒子*/
.exam-view .score_view{
    width: 1200px;
    margin: 30px auto 30px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
    border: 1px solid rgba(205, 205, 205, 0.5);
    border-radius: 8px;
    background: #fff;
    padding: 10px 0;
}
/*item*/
.exam-view .score_view .score_item{
    padding: 10px 20px;
    text-align: center;
    font-size: 26px;
    color: rgb(51, 51, 51);
}
/*分数*/
.exam-view .score_view .score_item .score_num{
    font-size: 30px;
    color: rgb(255, 0, 0);
}

/* 进度条样式 */
.progress-container {
    position: fixed;
    top: 64px;
    left: 0;
    width: 100%;
    background: rgba(255, 255, 255, 0.95);
    padding: 12px 0 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
    z-index: 998;
    transition: all 0.3s;
    backdrop-filter: blur(5px);
}

.progress-info {
    width: 1180px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #555;
    font-size: 14px;
    padding: 0 15px 8px;
    font-weight: 500;
}

.progress-info span:first-child {
    color: var(--theme);
    position: relative;
    padding-left: 22px;
}

.progress-info span:first-child::before {
    content: "✓";
    position: absolute;
    left: 0;
    top: 0;
    width: 18px;
    height: 18px;
    font-size: 12px;
    color: #fff;
    background: var(--theme);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.progress-info span:last-child {
    background: rgba(64, 158, 255, 0.1);
    padding: 3px 10px;
    border-radius: 12px;
    color: #409EFF;
    font-weight: bold;
}

.progress-bar {
    width: 1180px;
    height: 8px;
    background: #f0f0f0;
    border-radius: 4px;
    margin: 0 auto;
    overflow: hidden;
    box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
}

.progress-fill {
    height: 100%;
    background: linear-gradient(to right, var(--theme), #10c0ff);
    border-radius: 4px;
    transition: width 0.8s cubic-bezier(0.22, 0.61, 0.36, 1);
    position: relative;
    overflow: hidden;
    box-shadow: 0 1px 5px rgba(64, 158, 255, 0.3);
}

.progress-fill::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(
        45deg,
        rgba(255, 255, 255, 0.2) 25%,
        transparent 25%,
        transparent 50%,
        rgba(255, 255, 255, 0.2) 50%,
        rgba(255, 255, 255, 0.2) 75%,
        transparent 75%
    );
    background-size: 20px 20px;
    animation: progressAnimation 1.5s linear infinite;
}

@keyframes progressAnimation {
    0% { background-position: 0 0; }
    100% { background-position: 20px 0; }
}

/* 调整顶部空间，为进度条腾出位置 */
.exam-view .exam_top_kong {
    height: 135px;
}

/* 响应式调整 */
@media screen and (max-width: 1200px) {
    .progress-bar,
    .progress-info {
        width: 95%;
    }
}

@media screen and (max-width: 768px) {
    .progress-container {
        padding: 8px 0 6px;
    }
    
    .progress-info {
        padding: 0 10px 6px;
        font-size: 12px;
    }
    
    .progress-info span:first-child {
        padding-left: 18px;
    }
    
    .progress-info span:first-child::before {
        width: 14px;
        height: 14px;
        font-size: 10px;
    }
    
    .progress-bar {
        height: 6px;
    }
    
    .exam-view .exam_top_kong {
        height: 118px;
    }
}
</style>