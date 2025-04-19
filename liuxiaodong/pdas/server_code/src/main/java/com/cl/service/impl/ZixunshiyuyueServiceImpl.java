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


import com.cl.dao.ZixunshiyuyueDao;
import com.cl.entity.ZixunshiyuyueEntity;
import com.cl.service.ZixunshiyuyueService;
import com.cl.entity.view.ZixunshiyuyueView;

@Service("zixunshiyuyueService")
public class ZixunshiyuyueServiceImpl extends ServiceImpl<ZixunshiyuyueDao, ZixunshiyuyueEntity> implements ZixunshiyuyueService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ZixunshiyuyueEntity> page = this.selectPage(
                new Query<ZixunshiyuyueEntity>(params).getPage(),
                new EntityWrapper<ZixunshiyuyueEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ZixunshiyuyueEntity> wrapper) {
		  Page<ZixunshiyuyueView> page =new Query<ZixunshiyuyueView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<ZixunshiyuyueView> selectListView(Wrapper<ZixunshiyuyueEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ZixunshiyuyueView selectView(Wrapper<ZixunshiyuyueEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, Wrapper<ZixunshiyuyueEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, Wrapper<ZixunshiyuyueEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, Wrapper<ZixunshiyuyueEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }




}
