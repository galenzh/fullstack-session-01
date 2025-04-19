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


import com.cl.dao.GaopinggongjuDao;
import com.cl.entity.GaopinggongjuEntity;
import com.cl.service.GaopinggongjuService;
import com.cl.entity.view.GaopinggongjuView;

@Service("gaopinggongjuService")
public class GaopinggongjuServiceImpl extends ServiceImpl<GaopinggongjuDao, GaopinggongjuEntity> implements GaopinggongjuService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<GaopinggongjuEntity> page = this.selectPage(
                new Query<GaopinggongjuEntity>(params).getPage(),
                new EntityWrapper<GaopinggongjuEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<GaopinggongjuEntity> wrapper) {
		  Page<GaopinggongjuView> page =new Query<GaopinggongjuView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<GaopinggongjuView> selectListView(Wrapper<GaopinggongjuEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public GaopinggongjuView selectView(Wrapper<GaopinggongjuEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
