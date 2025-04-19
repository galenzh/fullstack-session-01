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

import com.cl.entity.GaopinggongjuEntity;
import com.cl.entity.view.GaopinggongjuView;

import com.cl.service.GaopinggongjuService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;

/**
 * 高评工具
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@RestController
@RequestMapping("/gaopinggongju")
public class GaopinggongjuController {
    @Autowired
    private GaopinggongjuService gaopinggongjuService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,GaopinggongjuEntity gaopinggongju,
                                                                                                        HttpServletRequest request){
                                    EntityWrapper<GaopinggongjuEntity> ew = new EntityWrapper<GaopinggongjuEntity>();
                                                                                                                                                            
        
        
        PageUtils page = gaopinggongjuService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, gaopinggongju), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,GaopinggongjuEntity gaopinggongju,
		HttpServletRequest request){
        EntityWrapper<GaopinggongjuEntity> ew = new EntityWrapper<GaopinggongjuEntity>();

		PageUtils page = gaopinggongjuService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, gaopinggongju), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( GaopinggongjuEntity gaopinggongju){
       	EntityWrapper<GaopinggongjuEntity> ew = new EntityWrapper<GaopinggongjuEntity>();
      	ew.allEq(MPUtil.allEQMapPre( gaopinggongju, "gaopinggongju")); 
        return R.ok().put("data", gaopinggongjuService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(GaopinggongjuEntity gaopinggongju){
        EntityWrapper< GaopinggongjuEntity> ew = new EntityWrapper< GaopinggongjuEntity>();
 		ew.allEq(MPUtil.allEQMapPre( gaopinggongju, "gaopinggongju")); 
		GaopinggongjuView gaopinggongjuView =  gaopinggongjuService.selectView(ew);
		return R.ok("查询高评工具成功").put("data", gaopinggongjuView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        GaopinggongjuEntity gaopinggongju = gaopinggongjuService.selectById(id);
		gaopinggongju = gaopinggongjuService.selectView(new EntityWrapper<GaopinggongjuEntity>().eq("id", id));
        return R.ok().put("data", gaopinggongju);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        GaopinggongjuEntity gaopinggongju = gaopinggongjuService.selectById(id);
		gaopinggongju = gaopinggongjuService.selectView(new EntityWrapper<GaopinggongjuEntity>().eq("id", id));
        return R.ok().put("data", gaopinggongju);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody GaopinggongjuEntity gaopinggongju, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(gaopinggongju);
        gaopinggongjuService.insert(gaopinggongju);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody GaopinggongjuEntity gaopinggongju, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(gaopinggongju);
        gaopinggongjuService.insert(gaopinggongju);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody GaopinggongjuEntity gaopinggongju, HttpServletRequest request){
        //ValidatorUtils.validateEntity(gaopinggongju);
        gaopinggongjuService.updateById(gaopinggongju);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        gaopinggongjuService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	









}
