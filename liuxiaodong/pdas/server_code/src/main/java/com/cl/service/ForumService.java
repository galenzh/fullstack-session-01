package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ForumEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ForumView;


/**
 * 论坛交流
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ForumService extends IService<ForumEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ForumView> selectListView(Wrapper<ForumEntity> wrapper);
   	
   	ForumView selectView(@Param("ew") Wrapper<ForumEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ForumEntity> wrapper);
   	
   
    List<Map<String, Object>> selectValue(Map<String, Object> params,Wrapper<ForumEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params,Wrapper<ForumEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params,Wrapper<ForumEntity> wrapper);



}

