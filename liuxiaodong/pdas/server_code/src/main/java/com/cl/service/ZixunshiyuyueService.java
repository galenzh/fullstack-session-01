package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ZixunshiyuyueEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZixunshiyuyueView;


/**
 * 咨询师预约
 *
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
public interface ZixunshiyuyueService extends IService<ZixunshiyuyueEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ZixunshiyuyueView> selectListView(Wrapper<ZixunshiyuyueEntity> wrapper);
   	
   	ZixunshiyuyueView selectView(@Param("ew") Wrapper<ZixunshiyuyueEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ZixunshiyuyueEntity> wrapper);
   	
   
    List<Map<String, Object>> selectValue(Map<String, Object> params,Wrapper<ZixunshiyuyueEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params,Wrapper<ZixunshiyuyueEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params,Wrapper<ZixunshiyuyueEntity> wrapper);



}

