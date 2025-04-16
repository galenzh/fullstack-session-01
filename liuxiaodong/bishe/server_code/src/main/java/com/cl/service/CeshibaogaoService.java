package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.CeshibaogaoEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.CeshibaogaoView;


/**
 * 测试报告
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface CeshibaogaoService extends IService<CeshibaogaoEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<CeshibaogaoView> selectListView(Wrapper<CeshibaogaoEntity> wrapper);
   	
   	CeshibaogaoView selectView(@Param("ew") Wrapper<CeshibaogaoEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<CeshibaogaoEntity> wrapper);
   	
   
}

