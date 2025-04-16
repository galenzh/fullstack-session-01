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


import com.cl.dao.XinlijiankangxuexiDao;
import com.cl.entity.XinlijiankangxuexiEntity;
import com.cl.service.XinlijiankangxuexiService;
import com.cl.entity.view.XinlijiankangxuexiView;

@Service("xinlijiankangxuexiService")
public class XinlijiankangxuexiServiceImpl extends ServiceImpl<XinlijiankangxuexiDao, XinlijiankangxuexiEntity> implements XinlijiankangxuexiService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<XinlijiankangxuexiEntity> page = this.selectPage(
                new Query<XinlijiankangxuexiEntity>(params).getPage(),
                new EntityWrapper<XinlijiankangxuexiEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<XinlijiankangxuexiEntity> wrapper) {
		  Page<XinlijiankangxuexiView> page =new Query<XinlijiankangxuexiView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<XinlijiankangxuexiView> selectListView(Wrapper<XinlijiankangxuexiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public XinlijiankangxuexiView selectView(Wrapper<XinlijiankangxuexiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
