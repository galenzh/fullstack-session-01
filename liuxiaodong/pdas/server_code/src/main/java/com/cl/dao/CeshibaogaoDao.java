package com.cl.dao;

import com.cl.entity.CeshibaogaoEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.CeshibaogaoView;


/**
 * 测试报告
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface CeshibaogaoDao extends BaseMapper<CeshibaogaoEntity> {
	
	List<CeshibaogaoView> selectListView(@Param("ew") Wrapper<CeshibaogaoEntity> wrapper);

	List<CeshibaogaoView> selectListView(Pagination page,@Param("ew") Wrapper<CeshibaogaoEntity> wrapper);
	
	CeshibaogaoView selectView(@Param("ew") Wrapper<CeshibaogaoEntity> wrapper);


}
