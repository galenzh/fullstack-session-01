package com.cl.dao;

import com.cl.entity.ZixunshiyuyueEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZixunshiyuyueView;


/**
 * 咨询师预约
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ZixunshiyuyueDao extends BaseMapper<ZixunshiyuyueEntity> {
	
	List<ZixunshiyuyueView> selectListView(@Param("ew") Wrapper<ZixunshiyuyueEntity> wrapper);

	List<ZixunshiyuyueView> selectListView(Pagination page,@Param("ew") Wrapper<ZixunshiyuyueEntity> wrapper);
	
	ZixunshiyuyueView selectView(@Param("ew") Wrapper<ZixunshiyuyueEntity> wrapper);


    List<Map<String, Object>> selectValue(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ZixunshiyuyueEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ZixunshiyuyueEntity> wrapper);

    List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ZixunshiyuyueEntity> wrapper);



}
