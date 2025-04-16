package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.XinlijiankangxuexiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.XinlijiankangxuexiView;


/**
 * 心理健康学习
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface XinlijiankangxuexiService extends IService<XinlijiankangxuexiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<XinlijiankangxuexiView> selectListView(Wrapper<XinlijiankangxuexiEntity> wrapper);
   	
   	XinlijiankangxuexiView selectView(@Param("ew") Wrapper<XinlijiankangxuexiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<XinlijiankangxuexiEntity> wrapper);
   	
   
}

