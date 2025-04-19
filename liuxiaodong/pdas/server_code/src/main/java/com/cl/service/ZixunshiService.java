package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ZixunshiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZixunshiView;


/**
 * 咨询师
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ZixunshiService extends IService<ZixunshiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ZixunshiView> selectListView(Wrapper<ZixunshiEntity> wrapper);
   	
   	ZixunshiView selectView(@Param("ew") Wrapper<ZixunshiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ZixunshiEntity> wrapper);
   	
   
}

