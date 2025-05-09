package com.cl.dao;

import com.cl.entity.KechengxinxiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.KechengxinxiView;


/**
 * 课程信息
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface KechengxinxiDao extends BaseMapper<KechengxinxiEntity> {
	
	List<KechengxinxiView> selectListView(@Param("ew") Wrapper<KechengxinxiEntity> wrapper);

	List<KechengxinxiView> selectListView(Pagination page,@Param("ew") Wrapper<KechengxinxiEntity> wrapper);
	
	KechengxinxiView selectView(@Param("ew") Wrapper<KechengxinxiEntity> wrapper);


}
