package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.GaopinggongjuEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.GaopinggongjuView;


/**
 * 高评工具
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface GaopinggongjuService extends IService<GaopinggongjuEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<GaopinggongjuView> selectListView(Wrapper<GaopinggongjuEntity> wrapper);
   	
   	GaopinggongjuView selectView(@Param("ew") Wrapper<GaopinggongjuEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<GaopinggongjuEntity> wrapper);
   	
   
}

