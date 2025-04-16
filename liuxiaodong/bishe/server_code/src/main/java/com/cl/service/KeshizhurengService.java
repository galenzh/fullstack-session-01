package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.KeshizhurengEntity;
import java.util.List;
import java.util.Map;
import com.cl.entity.vo.KeshizhurengVO;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.KeshizhurengView;


/**
 * 科室主任
 */
public interface KeshizhurengService extends IService<KeshizhurengEntity> {

    PageUtils queryPage(Map<String, Object> params, Wrapper<KeshizhurengEntity> wrapper);
    
    List<KeshizhurengVO> selectListVO(Wrapper<KeshizhurengEntity> wrapper);
    
    KeshizhurengVO selectVO(@Param("ew") Wrapper<KeshizhurengEntity> wrapper);
    
    List<KeshizhurengView> selectListView(Wrapper<KeshizhurengEntity> wrapper);

    KeshizhurengView selectView(@Param("ew") Wrapper<KeshizhurengEntity> wrapper);
} 