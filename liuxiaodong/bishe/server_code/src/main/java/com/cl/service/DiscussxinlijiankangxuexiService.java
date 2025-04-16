package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.DiscussxinlijiankangxuexiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DiscussxinlijiankangxuexiView;


/**
 * 心理健康学习评论表
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface DiscussxinlijiankangxuexiService extends IService<DiscussxinlijiankangxuexiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DiscussxinlijiankangxuexiView> selectListView(Wrapper<DiscussxinlijiankangxuexiEntity> wrapper);
   	
   	DiscussxinlijiankangxuexiView selectView(@Param("ew") Wrapper<DiscussxinlijiankangxuexiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<DiscussxinlijiankangxuexiEntity> wrapper);
   	
   
}

