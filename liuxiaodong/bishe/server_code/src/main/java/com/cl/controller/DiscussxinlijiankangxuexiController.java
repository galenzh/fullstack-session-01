package com.cl.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

import com.cl.utils.ValidatorUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.cl.annotation.IgnoreAuth;

import com.cl.entity.DiscussxinlijiankangxuexiEntity;
import com.cl.entity.view.DiscussxinlijiankangxuexiView;

import com.cl.service.DiscussxinlijiankangxuexiService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;

/**
 * 心理健康学习评论表
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
@RestController
@RequestMapping("/discussxinlijiankangxuexi")
public class DiscussxinlijiankangxuexiController {
    @Autowired
    private DiscussxinlijiankangxuexiService discussxinlijiankangxuexiService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi,
                                                                                                                            HttpServletRequest request){
                                    EntityWrapper<DiscussxinlijiankangxuexiEntity> ew = new EntityWrapper<DiscussxinlijiankangxuexiEntity>();
                                                                                                                                                                                        
        
        
        PageUtils page = discussxinlijiankangxuexiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, discussxinlijiankangxuexi), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi,
		HttpServletRequest request){
        EntityWrapper<DiscussxinlijiankangxuexiEntity> ew = new EntityWrapper<DiscussxinlijiankangxuexiEntity>();

		PageUtils page = discussxinlijiankangxuexiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, discussxinlijiankangxuexi), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi){
       	EntityWrapper<DiscussxinlijiankangxuexiEntity> ew = new EntityWrapper<DiscussxinlijiankangxuexiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( discussxinlijiankangxuexi, "discussxinlijiankangxuexi")); 
        return R.ok().put("data", discussxinlijiankangxuexiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi){
        EntityWrapper< DiscussxinlijiankangxuexiEntity> ew = new EntityWrapper< DiscussxinlijiankangxuexiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( discussxinlijiankangxuexi, "discussxinlijiankangxuexi")); 
		DiscussxinlijiankangxuexiView discussxinlijiankangxuexiView =  discussxinlijiankangxuexiService.selectView(ew);
		return R.ok("查询心理健康学习评论表成功").put("data", discussxinlijiankangxuexiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi = discussxinlijiankangxuexiService.selectById(id);
		discussxinlijiankangxuexi = discussxinlijiankangxuexiService.selectView(new EntityWrapper<DiscussxinlijiankangxuexiEntity>().eq("id", id));
        return R.ok().put("data", discussxinlijiankangxuexi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi = discussxinlijiankangxuexiService.selectById(id);
		discussxinlijiankangxuexi = discussxinlijiankangxuexiService.selectView(new EntityWrapper<DiscussxinlijiankangxuexiEntity>().eq("id", id));
        return R.ok().put("data", discussxinlijiankangxuexi);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(discussxinlijiankangxuexi);
        discussxinlijiankangxuexiService.insert(discussxinlijiankangxuexi);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(discussxinlijiankangxuexi);
        discussxinlijiankangxuexiService.insert(discussxinlijiankangxuexi);
        return R.ok();
    }

     /**
     * 获取用户密保
     */
    @RequestMapping("/security")
    @IgnoreAuth
    public R security(@RequestParam String username){
        DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi = discussxinlijiankangxuexiService.selectOne(new EntityWrapper<DiscussxinlijiankangxuexiEntity>().eq("", username));
        return R.ok().put("data", discussxinlijiankangxuexi);
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @IgnoreAuth
    public R update(@RequestBody DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(discussxinlijiankangxuexi);
        discussxinlijiankangxuexiService.updateById(discussxinlijiankangxuexi);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        discussxinlijiankangxuexiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	
	/**
     * 前端智能排序
     */
	@IgnoreAuth
    @RequestMapping("/autoSort")
    public R autoSort(@RequestParam Map<String, Object> params,DiscussxinlijiankangxuexiEntity discussxinlijiankangxuexi, HttpServletRequest request,String pre){
        EntityWrapper<DiscussxinlijiankangxuexiEntity> ew = new EntityWrapper<DiscussxinlijiankangxuexiEntity>();
        Map<String, Object> newMap = new HashMap<String, Object>();
        Map<String, Object> param = new HashMap<String, Object>();
		Iterator<Map.Entry<String, Object>> it = param.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String key = entry.getKey();
			String newKey = entry.getKey();
			if (pre.endsWith(".")) {
				newMap.put(pre + newKey, entry.getValue());
			} else if (StringUtils.isEmpty(pre)) {
				newMap.put(newKey, entry.getValue());
			} else {
				newMap.put(pre + "." + newKey, entry.getValue());
			}
		}
		params.put("sort", "clicktime");
        params.put("order", "desc");
		PageUtils page = discussxinlijiankangxuexiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, discussxinlijiankangxuexi), params), params));
        return R.ok().put("data", page);
    }









}
