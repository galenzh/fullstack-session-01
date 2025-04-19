package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ExamquestionbankEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ExamquestionbankView;


/**
 * 试题库管理
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ExamquestionbankService extends IService<ExamquestionbankEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ExamquestionbankView> selectListView(Wrapper<ExamquestionbankEntity> wrapper);
   	
   	ExamquestionbankView selectView(@Param("ew") Wrapper<ExamquestionbankEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ExamquestionbankEntity> wrapper);
   	
   
}

