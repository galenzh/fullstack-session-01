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


import com.cl.dao.ZixunshiDao;
import com.cl.entity.ZixunshiEntity;
import com.cl.service.ZixunshiService;
import com.cl.entity.view.ZixunshiView;

@Service("zixunshiService")
public class ZixunshiServiceImpl extends ServiceImpl<ZixunshiDao, ZixunshiEntity> implements ZixunshiService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ZixunshiEntity> page = this.selectPage(
                new Query<ZixunshiEntity>(params).getPage(),
                new EntityWrapper<ZixunshiEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ZixunshiEntity> wrapper) {
		  Page<ZixunshiView> page =new Query<ZixunshiView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<ZixunshiView> selectListView(Wrapper<ZixunshiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ZixunshiView selectView(Wrapper<ZixunshiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
