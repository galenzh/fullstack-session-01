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


import com.cl.dao.DiscussgaopinggongjuDao;
import com.cl.entity.DiscussgaopinggongjuEntity;
import com.cl.service.DiscussgaopinggongjuService;
import com.cl.entity.view.DiscussgaopinggongjuView;

@Service("discussgaopinggongjuService")
public class DiscussgaopinggongjuServiceImpl extends ServiceImpl<DiscussgaopinggongjuDao, DiscussgaopinggongjuEntity> implements DiscussgaopinggongjuService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<DiscussgaopinggongjuEntity> page = this.selectPage(
                new Query<DiscussgaopinggongjuEntity>(params).getPage(),
                new EntityWrapper<DiscussgaopinggongjuEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<DiscussgaopinggongjuEntity> wrapper) {
		  Page<DiscussgaopinggongjuView> page =new Query<DiscussgaopinggongjuView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<DiscussgaopinggongjuView> selectListView(Wrapper<DiscussgaopinggongjuEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public DiscussgaopinggongjuView selectView(Wrapper<DiscussgaopinggongjuEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
