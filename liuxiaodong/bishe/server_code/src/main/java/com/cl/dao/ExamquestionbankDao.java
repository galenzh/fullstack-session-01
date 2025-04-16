package com.cl.dao;

import com.cl.entity.ExamquestionbankEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ExamquestionbankView;


/**
 * 试题库管理
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ExamquestionbankDao extends BaseMapper<ExamquestionbankEntity> {
	
	List<ExamquestionbankView> selectListView(@Param("ew") Wrapper<ExamquestionbankEntity> wrapper);

	List<ExamquestionbankView> selectListView(Pagination page,@Param("ew") Wrapper<ExamquestionbankEntity> wrapper);
	
	ExamquestionbankView selectView(@Param("ew") Wrapper<ExamquestionbankEntity> wrapper);


}
