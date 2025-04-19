package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.JiankangjianyiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.JiankangjianyiView;


/**
 * 健康建议
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface JiankangjianyiService extends IService<JiankangjianyiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<JiankangjianyiView> selectListView(Wrapper<JiankangjianyiEntity> wrapper);
   	
   	JiankangjianyiView selectView(@Param("ew") Wrapper<JiankangjianyiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<JiankangjianyiEntity> wrapper);
   	
   
}

