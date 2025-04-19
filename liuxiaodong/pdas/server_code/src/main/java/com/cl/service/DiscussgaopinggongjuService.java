package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.DiscussgaopinggongjuEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DiscussgaopinggongjuView;


/**
 * 高评工具评论表
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface DiscussgaopinggongjuService extends IService<DiscussgaopinggongjuEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DiscussgaopinggongjuView> selectListView(Wrapper<DiscussgaopinggongjuEntity> wrapper);
   	
   	DiscussgaopinggongjuView selectView(@Param("ew") Wrapper<DiscussgaopinggongjuEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<DiscussgaopinggongjuEntity> wrapper);
   	
   
}

