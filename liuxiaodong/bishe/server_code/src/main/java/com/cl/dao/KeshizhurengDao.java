package com.cl.dao;

import com.cl.entity.KeshizhurengEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.vo.KeshizhurengVO;
import com.cl.entity.view.KeshizhurengView;


/**
 * 科室主任
 */
public interface KeshizhurengDao extends BaseMapper<KeshizhurengEntity> {
    
    List<KeshizhurengVO> selectListVO(@Param("ew") Wrapper<KeshizhurengEntity> wrapper);
    
    KeshizhurengVO selectVO(@Param("ew") Wrapper<KeshizhurengEntity> wrapper);
    
    List<KeshizhurengView> selectListView(@Param("ew") Wrapper<KeshizhurengEntity> wrapper);

    List<KeshizhurengView> selectListView(Pagination page, @Param("ew") Wrapper<KeshizhurengEntity> wrapper);
    
    KeshizhurengView selectView(@Param("ew") Wrapper<KeshizhurengEntity> wrapper);
} 