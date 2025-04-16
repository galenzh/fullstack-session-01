package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;

import com.cl.dao.KeshizhurengDao;
import com.cl.entity.KeshizhurengEntity;
import com.cl.service.KeshizhurengService;
import com.cl.entity.vo.KeshizhurengVO;
import com.cl.entity.view.KeshizhurengView;

@Service("keshizhurengService")
public class KeshizhurengServiceImpl extends ServiceImpl<KeshizhurengDao, KeshizhurengEntity> implements KeshizhurengService {

    @Override
    public PageUtils queryPage(Map<String, Object> params, Wrapper<KeshizhurengEntity> wrapper) {
        Page<KeshizhurengEntity> page = this.selectPage(
                new Query<KeshizhurengEntity>(params).getPage(),
                wrapper
        );
        return new PageUtils(page);
    }
    
    @Override
    public List<KeshizhurengVO> selectListVO(Wrapper<KeshizhurengEntity> wrapper) {
        return baseMapper.selectListVO(wrapper);
    }
    
    @Override
    public KeshizhurengVO selectVO(Wrapper<KeshizhurengEntity> wrapper) {
        return baseMapper.selectVO(wrapper);
    }
    
    @Override
    public List<KeshizhurengView> selectListView(Wrapper<KeshizhurengEntity> wrapper) {
        return baseMapper.selectListView(wrapper);
    }

    @Override
    public KeshizhurengView selectView(Wrapper<KeshizhurengEntity> wrapper) {
        return baseMapper.selectView(wrapper);
    }
} 