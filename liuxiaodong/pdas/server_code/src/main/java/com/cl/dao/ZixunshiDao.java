package com.cl.dao;

import com.cl.entity.ZixunshiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZixunshiView;


/**
 * 咨询师
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ZixunshiDao extends BaseMapper<ZixunshiEntity> {
	
	List<ZixunshiView> selectListView(@Param("ew") Wrapper<ZixunshiEntity> wrapper);

	List<ZixunshiView> selectListView(Pagination page,@Param("ew") Wrapper<ZixunshiEntity> wrapper);
	
	ZixunshiView selectView(@Param("ew") Wrapper<ZixunshiEntity> wrapper);


}
