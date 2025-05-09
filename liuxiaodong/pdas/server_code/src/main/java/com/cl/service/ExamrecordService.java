package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ExamrecordEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ExamrecordView;


/**
 * 考试记录
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ExamrecordService extends IService<ExamrecordEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ExamrecordView> selectListView(Wrapper<ExamrecordEntity> wrapper);
   	
   	ExamrecordView selectView(@Param("ew") Wrapper<ExamrecordEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ExamrecordEntity> wrapper);
   	
       PageUtils queryPageGroupBy(Map<String, Object> params,Wrapper<ExamrecordEntity> wrapper);

                PageUtils queryPageOptionsNum(Map<String, Object> params,Wrapper<ExamrecordEntity> wrapper);
    
}

