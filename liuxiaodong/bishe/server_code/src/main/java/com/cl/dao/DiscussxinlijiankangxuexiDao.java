package com.cl.dao;

import com.cl.entity.DiscussxinlijiankangxuexiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DiscussxinlijiankangxuexiView;


/**
 * 心理健康学习评论表
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface DiscussxinlijiankangxuexiDao extends BaseMapper<DiscussxinlijiankangxuexiEntity> {
	
	List<DiscussxinlijiankangxuexiView> selectListView(@Param("ew") Wrapper<DiscussxinlijiankangxuexiEntity> wrapper);

	List<DiscussxinlijiankangxuexiView> selectListView(Pagination page,@Param("ew") Wrapper<DiscussxinlijiankangxuexiEntity> wrapper);
	
	DiscussxinlijiankangxuexiView selectView(@Param("ew") Wrapper<DiscussxinlijiankangxuexiEntity> wrapper);


}
