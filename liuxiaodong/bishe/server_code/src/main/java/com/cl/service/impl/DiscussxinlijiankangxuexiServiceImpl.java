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


import com.cl.dao.DiscussxinlijiankangxuexiDao;
import com.cl.entity.DiscussxinlijiankangxuexiEntity;
import com.cl.service.DiscussxinlijiankangxuexiService;
import com.cl.entity.view.DiscussxinlijiankangxuexiView;

@Service("discussxinlijiankangxuexiService")
public class DiscussxinlijiankangxuexiServiceImpl extends ServiceImpl<DiscussxinlijiankangxuexiDao, DiscussxinlijiankangxuexiEntity> implements DiscussxinlijiankangxuexiService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<DiscussxinlijiankangxuexiEntity> page = this.selectPage(
                new Query<DiscussxinlijiankangxuexiEntity>(params).getPage(),
                new EntityWrapper<DiscussxinlijiankangxuexiEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<DiscussxinlijiankangxuexiEntity> wrapper) {
		  Page<DiscussxinlijiankangxuexiView> page =new Query<DiscussxinlijiankangxuexiView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<DiscussxinlijiankangxuexiView> selectListView(Wrapper<DiscussxinlijiankangxuexiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public DiscussxinlijiankangxuexiView selectView(Wrapper<DiscussxinlijiankangxuexiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
