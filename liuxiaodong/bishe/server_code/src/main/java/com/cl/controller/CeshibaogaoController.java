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

import com.cl.entity.CeshibaogaoEntity;
import com.cl.entity.view.CeshibaogaoView;

import com.cl.service.CeshibaogaoService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;

/**
 * 测试报告
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
@RestController
@RequestMapping("/ceshibaogao")
public class CeshibaogaoController {
    @Autowired
    private CeshibaogaoService ceshibaogaoService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,CeshibaogaoEntity ceshibaogao,
                                                                                                                                                                    HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                                                                                                                        if(tableName.equals("yonghu")) {
                    ceshibaogao.setZhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                                                    if(tableName.equals("zixunshi")) {
                    ceshibaogao.setZixunshizhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                            EntityWrapper<CeshibaogaoEntity> ew = new EntityWrapper<CeshibaogaoEntity>();
                                                                                                                                                                                                                                                                
        
        
        PageUtils page = ceshibaogaoService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ceshibaogao), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,CeshibaogaoEntity ceshibaogao,
		HttpServletRequest request){
        EntityWrapper<CeshibaogaoEntity> ew = new EntityWrapper<CeshibaogaoEntity>();

		PageUtils page = ceshibaogaoService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ceshibaogao), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( CeshibaogaoEntity ceshibaogao){
       	EntityWrapper<CeshibaogaoEntity> ew = new EntityWrapper<CeshibaogaoEntity>();
      	ew.allEq(MPUtil.allEQMapPre( ceshibaogao, "ceshibaogao")); 
        return R.ok().put("data", ceshibaogaoService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(CeshibaogaoEntity ceshibaogao){
        EntityWrapper< CeshibaogaoEntity> ew = new EntityWrapper< CeshibaogaoEntity>();
 		ew.allEq(MPUtil.allEQMapPre( ceshibaogao, "ceshibaogao")); 
		CeshibaogaoView ceshibaogaoView =  ceshibaogaoService.selectView(ew);
		return R.ok("查询测试报告成功").put("data", ceshibaogaoView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        CeshibaogaoEntity ceshibaogao = ceshibaogaoService.selectById(id);
		ceshibaogao = ceshibaogaoService.selectView(new EntityWrapper<CeshibaogaoEntity>().eq("id", id));
        return R.ok().put("data", ceshibaogao);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        CeshibaogaoEntity ceshibaogao = ceshibaogaoService.selectById(id);
		ceshibaogao = ceshibaogaoService.selectView(new EntityWrapper<CeshibaogaoEntity>().eq("id", id));
        return R.ok().put("data", ceshibaogao);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody CeshibaogaoEntity ceshibaogao, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(ceshibaogao);
        ceshibaogaoService.insert(ceshibaogao);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody CeshibaogaoEntity ceshibaogao, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(ceshibaogao);
        ceshibaogaoService.insert(ceshibaogao);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody CeshibaogaoEntity ceshibaogao, HttpServletRequest request){
        //ValidatorUtils.validateEntity(ceshibaogao);
        ceshibaogaoService.updateById(ceshibaogao);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        ceshibaogaoService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	









}
