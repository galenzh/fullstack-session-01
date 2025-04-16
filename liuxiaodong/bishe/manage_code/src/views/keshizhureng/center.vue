<template>
  <div class="center_view">
    <div class="user_info">
      <div class="avatar">
        <img :src="$toolUtil.getImgUrl(user.touxiang)" v-if="user.touxiang">
        <img src="@/assets/img/avatar.png" v-else>
      </div>
      <div class="info">
        <div class="name">{{user.xingming}}</div>
        <div class="role">科室主任</div>
        <div class="keshi">科室：{{user.keshi}}</div>
      </div>
    </div>
    
    <div class="info_card">
      <el-card class="box-card">
        <template #header>
          <div class="card-header">
            <span>个人信息</span>
            <el-button class="button" type="text" @click="editInfo">修改信息</el-button>
          </div>
        </template>
        <div class="info_item">
          <span class="label">账号：</span>
          <span class="value">{{user.zhanghao}}</span>
        </div>
        <div class="info_item">
          <span class="label">姓名：</span>
          <span class="value">{{user.xingming}}</span>
        </div>
        <div class="info_item">
          <span class="label">性别：</span>
          <span class="value">{{user.xingbie}}</span>
        </div>
        <div class="info_item">
          <span class="label">手机：</span>
          <span class="value">{{user.shouji}}</span>
        </div>
        <div class="info_item">
          <span class="label">邮箱：</span>
          <span class="value">{{user.youxiang}}</span>
        </div>
        <div class="info_item">
          <span class="label">科室：</span>
          <span class="value">{{user.keshi}}</span>
        </div>
      </el-card>
    </div>
    
    <el-dialog v-model="editDialogVisible" title="修改个人信息" width="50%">
      <el-form :model="editForm" :rules="editRules" ref="editFormRef" label-width="100px">
        <el-form-item label="账号" prop="zhanghao">
          <el-input v-model="editForm.zhanghao" disabled></el-input>
        </el-form-item>
        <el-form-item label="姓名" prop="xingming">
          <el-input v-model="editForm.xingming"></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="xingbie">
          <el-select v-model="editForm.xingbie" placeholder="请选择性别" style="width: 100%;">
            <el-option label="男" value="男"></el-option>
            <el-option label="女" value="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="头像" prop="touxiang">
          <upload v-model="editForm.touxiang" type="img"></upload>
        </el-form-item>
        <el-form-item label="手机" prop="shouji">
          <el-input v-model="editForm.shouji"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="youxiang">
          <el-input v-model="editForm.youxiang"></el-input>
        </el-form-item>
        <el-form-item label="科室" prop="keshi">
          <el-input v-model="editForm.keshi"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="mima">
          <el-input v-model="editForm.mima" type="password" placeholder="不修改密码请留空"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="editDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="submitEdit">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import http from '@/utils/http'
import toolUtil from '@/utils/toolUtil'

const user = ref({})
const editDialogVisible = ref(false)
const editForm = reactive({
  id: '',
  zhanghao: '',
  mima: '',
  xingming: '',
  xingbie: '',
  touxiang: '',
  shouji: '',
  youxiang: '',
  keshi: ''
})
const editFormRef = ref(null)
const editRules = reactive({
  xingming: [{ required: true, message: '姓名不能为空', trigger: 'blur' }],
  xingbie: [{ required: true, message: '性别不能为空', trigger: 'blur' }],
  keshi: [{ required: true, message: '科室不能为空', trigger: 'blur' }]
})

onMounted(() => {
  getUserInfo()
})

// 获取用户信息
const getUserInfo = () => {
  http.get('keshizhureng/session').then(({data}) => {
    if (data && data.code === 0) {
      user.value = data.data
    }
  })
}

// 编辑信息
const editInfo = () => {
  editDialogVisible.value = true
  Object.assign(editForm, user.value)
  editForm.mima = '' // 清空密码
}

// 提交编辑
const submitEdit = () => {
  editFormRef.value.validate((valid) => {
    if (valid) {
      http.post('keshizhureng/update', editForm).then(({data}) => {
        if (data && data.code === 0) {
          ElMessage({
            message: '修改成功',
            type: 'success',
            duration: 1500,
            onClose: () => {
              editDialogVisible.value = false
              getUserInfo()
            }
          })
        } else {
          ElMessage.error(data.msg)
        }
      })
    }
  })
}
</script>

<style scoped>
.center_view {
  padding: 20px;
}
.user_info {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}
.avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  overflow: hidden;
  margin-right: 20px;
}
.avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.info .name {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 5px;
}
.info .role {
  color: #666;
  margin-bottom: 5px;
}
.info .keshi {
  color: #666;
}
.info_card {
  margin-top: 20px;
}
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.info_item {
  margin-bottom: 10px;
  line-height: 24px;
}
.info_item .label {
  display: inline-block;
  width: 80px;
  color: #666;
}
</style> 