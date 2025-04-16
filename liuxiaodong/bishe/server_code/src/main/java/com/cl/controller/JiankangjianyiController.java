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

import com.cl.entity.JiankangjianyiEntity;
import com.cl.entity.view.JiankangjianyiView;

import com.cl.service.JiankangjianyiService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;

/**
 * 健康建议
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@RestController
@RequestMapping("/jiankangjianyi")
public class JiankangjianyiController {
    @Autowired
    private JiankangjianyiService jiankangjianyiService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,JiankangjianyiEntity jiankangjianyi,
                                                                                                                                        HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                                                        if(tableName.equals("zixunshi")) {
                    jiankangjianyi.setZixunshizhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                        if(tableName.equals("yonghu")) {
                    jiankangjianyi.setZhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                        EntityWrapper<JiankangjianyiEntity> ew = new EntityWrapper<JiankangjianyiEntity>();
                                                                                                                                                                                                            
        
        
        PageUtils page = jiankangjianyiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, jiankangjianyi), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,JiankangjianyiEntity jiankangjianyi,
		HttpServletRequest request){
        EntityWrapper<JiankangjianyiEntity> ew = new EntityWrapper<JiankangjianyiEntity>();

		PageUtils page = jiankangjianyiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, jiankangjianyi), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( JiankangjianyiEntity jiankangjianyi){
       	EntityWrapper<JiankangjianyiEntity> ew = new EntityWrapper<JiankangjianyiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( jiankangjianyi, "jiankangjianyi")); 
        return R.ok().put("data", jiankangjianyiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(JiankangjianyiEntity jiankangjianyi){
        EntityWrapper< JiankangjianyiEntity> ew = new EntityWrapper< JiankangjianyiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( jiankangjianyi, "jiankangjianyi")); 
		JiankangjianyiView jiankangjianyiView =  jiankangjianyiService.selectView(ew);
		return R.ok("查询健康建议成功").put("data", jiankangjianyiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        JiankangjianyiEntity jiankangjianyi = jiankangjianyiService.selectById(id);
		jiankangjianyi = jiankangjianyiService.selectView(new EntityWrapper<JiankangjianyiEntity>().eq("id", id));
        return R.ok().put("data", jiankangjianyi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        JiankangjianyiEntity jiankangjianyi = jiankangjianyiService.selectById(id);
		jiankangjianyi = jiankangjianyiService.selectView(new EntityWrapper<JiankangjianyiEntity>().eq("id", id));
        return R.ok().put("data", jiankangjianyi);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody JiankangjianyiEntity jiankangjianyi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(jiankangjianyi);
        jiankangjianyiService.insert(jiankangjianyi);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody JiankangjianyiEntity jiankangjianyi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(jiankangjianyi);
        jiankangjianyiService.insert(jiankangjianyi);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody JiankangjianyiEntity jiankangjianyi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(jiankangjianyi);
        jiankangjianyiService.updateById(jiankangjianyi);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        jiankangjianyiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	









}
