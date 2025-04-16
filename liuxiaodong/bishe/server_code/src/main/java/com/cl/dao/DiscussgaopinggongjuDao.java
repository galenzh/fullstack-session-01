package com.cl.dao;

import com.cl.entity.DiscussgaopinggongjuEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DiscussgaopinggongjuView;


/**
 * 高评工具评论表
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface DiscussgaopinggongjuDao extends BaseMapper<DiscussgaopinggongjuEntity> {
	
	List<DiscussgaopinggongjuView> selectListView(@Param("ew") Wrapper<DiscussgaopinggongjuEntity> wrapper);

	List<DiscussgaopinggongjuView> selectListView(Pagination page,@Param("ew") Wrapper<DiscussgaopinggongjuEntity> wrapper);
	
	DiscussgaopinggongjuView selectView(@Param("ew") Wrapper<DiscussgaopinggongjuEntity> wrapper);


}
