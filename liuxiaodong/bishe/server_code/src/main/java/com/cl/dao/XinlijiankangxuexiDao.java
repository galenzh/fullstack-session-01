package com.cl.dao;

import com.cl.entity.XinlijiankangxuexiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.XinlijiankangxuexiView;


/**
 * 心理健康学习
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface XinlijiankangxuexiDao extends BaseMapper<XinlijiankangxuexiEntity> {
	
	List<XinlijiankangxuexiView> selectListView(@Param("ew") Wrapper<XinlijiankangxuexiEntity> wrapper);

	List<XinlijiankangxuexiView> selectListView(Pagination page,@Param("ew") Wrapper<XinlijiankangxuexiEntity> wrapper);
	
	XinlijiankangxuexiView selectView(@Param("ew") Wrapper<XinlijiankangxuexiEntity> wrapper);


}
