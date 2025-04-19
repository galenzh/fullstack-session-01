package com.cl.dao;

import com.cl.entity.JiankangjianyiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.JiankangjianyiView;


/**
 * 健康建议
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface JiankangjianyiDao extends BaseMapper<JiankangjianyiEntity> {
	
	List<JiankangjianyiView> selectListView(@Param("ew") Wrapper<JiankangjianyiEntity> wrapper);

	List<JiankangjianyiView> selectListView(Pagination page,@Param("ew") Wrapper<JiankangjianyiEntity> wrapper);
	
	JiankangjianyiView selectView(@Param("ew") Wrapper<JiankangjianyiEntity> wrapper);


}
