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

import com.cl.entity.XinlijiankangxuexiEntity;
import com.cl.entity.view.XinlijiankangxuexiView;

import com.cl.service.XinlijiankangxuexiService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;
import com.cl.service.StoreupService;
import com.cl.entity.StoreupEntity;

/**
 * 心理健康学习
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@RestController
@RequestMapping("/xinlijiankangxuexi")
public class XinlijiankangxuexiController {
    @Autowired
    private XinlijiankangxuexiService xinlijiankangxuexiService;

    @Autowired
    private StoreupService storeupService;








    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,XinlijiankangxuexiEntity xinlijiankangxuexi,
                                                                                                                                                                                        HttpServletRequest request){
        String tableName = request.getSession().getAttribute("tableName").toString();
        String username = request.getSession().getAttribute("username").toString();
        
        // 管理员或咨询师都可以查看所有数据
        if(tableName.equals("users") || tableName.equals("zixunshi") || "管理员".equals(tableName)) {
            // 不添加任何限制条件
        } else {
            // 其他角色可能有特定限制
        }
                                                                                                                                
        EntityWrapper<XinlijiankangxuexiEntity> ew = new EntityWrapper<XinlijiankangxuexiEntity>();
        PageUtils page = xinlijiankangxuexiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xinlijiankangxuexi), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,XinlijiankangxuexiEntity xinlijiankangxuexi,
		HttpServletRequest request){
        EntityWrapper<XinlijiankangxuexiEntity> ew = new EntityWrapper<XinlijiankangxuexiEntity>();

		PageUtils page = xinlijiankangxuexiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, xinlijiankangxuexi), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( XinlijiankangxuexiEntity xinlijiankangxuexi){
       	EntityWrapper<XinlijiankangxuexiEntity> ew = new EntityWrapper<XinlijiankangxuexiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( xinlijiankangxuexi, "xinlijiankangxuexi")); 
        return R.ok().put("data", xinlijiankangxuexiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(XinlijiankangxuexiEntity xinlijiankangxuexi){
        EntityWrapper< XinlijiankangxuexiEntity> ew = new EntityWrapper< XinlijiankangxuexiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( xinlijiankangxuexi, "xinlijiankangxuexi")); 
		XinlijiankangxuexiView xinlijiankangxuexiView =  xinlijiankangxuexiService.selectView(ew);
		return R.ok("查询心理健康学习成功").put("data", xinlijiankangxuexiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        XinlijiankangxuexiEntity xinlijiankangxuexi = xinlijiankangxuexiService.selectById(id);
		xinlijiankangxuexi = xinlijiankangxuexiService.selectView(new EntityWrapper<XinlijiankangxuexiEntity>().eq("id", id));
        return R.ok().put("data", xinlijiankangxuexi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        XinlijiankangxuexiEntity xinlijiankangxuexi = xinlijiankangxuexiService.selectById(id);
		xinlijiankangxuexi = xinlijiankangxuexiService.selectView(new EntityWrapper<XinlijiankangxuexiEntity>().eq("id", id));
        return R.ok().put("data", xinlijiankangxuexi);
    }
    


    /**
     * 赞或踩
     */
    @RequestMapping("/thumbsup/{id}")
    public R vote(@PathVariable("id") String id,String type){
        XinlijiankangxuexiEntity xinlijiankangxuexi = xinlijiankangxuexiService.selectById(id);
        if(type.equals("1")) {
        	xinlijiankangxuexi.setThumbsupNumber(xinlijiankangxuexi.getThumbsupNumber()+1);
        } else {
        	xinlijiankangxuexi.setCrazilyNumber(xinlijiankangxuexi.getCrazilyNumber()+1);
        }
        xinlijiankangxuexiService.updateById(xinlijiankangxuexi);
        return R.ok("投票成功");
    }

    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody XinlijiankangxuexiEntity xinlijiankangxuexi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(xinlijiankangxuexi);
        xinlijiankangxuexiService.insert(xinlijiankangxuexi);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody XinlijiankangxuexiEntity xinlijiankangxuexi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(xinlijiankangxuexi);
        xinlijiankangxuexiService.insert(xinlijiankangxuexi);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody XinlijiankangxuexiEntity xinlijiankangxuexi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(xinlijiankangxuexi);
        xinlijiankangxuexiService.updateById(xinlijiankangxuexi);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        xinlijiankangxuexiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	









}
