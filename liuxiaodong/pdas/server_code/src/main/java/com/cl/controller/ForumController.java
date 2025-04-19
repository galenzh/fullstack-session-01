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

import com.cl.entity.ForumEntity;
import com.cl.entity.view.ForumView;

import com.cl.service.ForumService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;

/**
 * 论坛交流
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@RestController
@RequestMapping("/forum")
public class ForumController {
    @Autowired
    private ForumService forumService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ForumEntity forum,
                                                                                                                                                                                        HttpServletRequest request){
                                    if(!request.getSession().getAttribute("role").toString().equals("管理员")) {
                    forum.setUserid((Long)request.getSession().getAttribute("userId"));
                }
                            EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
                                                                                                                                                                                                                                                                                            
        
        
        PageUtils page = forumService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, forum), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ForumEntity forum,
		HttpServletRequest request){
    	if(!request.getSession().getAttribute("role").toString().equals("管理员")) {
    		forum.setUserid((Long)request.getSession().getAttribute("userId"));
    	}
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();

		PageUtils page = forumService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, forum), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @IgnoreAuth
    @RequestMapping("/flist")
    public R flist(@RequestParam Map<String, Object> params,ForumEntity forum, HttpServletRequest request){
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
    	PageUtils page = forumService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, forum), params), params));
        return R.ok().put("data", page);
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ForumEntity forum){
        EntityWrapper< ForumEntity> ew = new EntityWrapper< ForumEntity>();
 		ew.allEq(MPUtil.allEQMapPre( forum, "forum")); 
		ForumView forumView =  forumService.selectView(ew);
		return R.ok("查询论坛交流成功").put("data", forumView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ForumEntity forum = forumService.selectById(id);
		forum = forumService.selectView(new EntityWrapper<ForumEntity>().eq("id", id));
        return R.ok().put("data", forum);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ForumEntity forum = forumService.selectById(id);
		forum = forumService.selectView(new EntityWrapper<ForumEntity>().eq("id", id));
        return R.ok().put("data", forum);
    }
    
	/**
     * 论坛详情
     */
	@IgnoreAuth
    @RequestMapping("/list/{id}")
    public R list(@PathVariable("id") String id){
        ForumEntity forum = forumService.selectById(id);
        getChilds(forum);
        return R.ok().put("data", forum);
    }
    
	private ForumEntity getChilds(ForumEntity forum) {
    	List<ForumEntity> childs = new ArrayList<ForumEntity>();
    	childs = forumService.selectList(new EntityWrapper<ForumEntity>().eq("parentid", forum.getId()));
    	if(childs == null || childs.size()==0) {
    		return null;
    	}
    	forum.setChilds(childs);
    	for(ForumEntity forumEntity : childs) {
    		getChilds(forumEntity);
    	}
    	return forum;
    }


    /**
     * 赞或踩
     */
    @RequestMapping("/thumbsup/{id}")
    public R vote(@PathVariable("id") String id,String type){
        ForumEntity forum = forumService.selectById(id);
        if(type.equals("1")) {
        	forum.setThumbsupNumber(forum.getThumbsupNumber()+1);
        } else {
        	forum.setCrazilyNumber(forum.getCrazilyNumber()+1);
        }
        forumService.updateById(forum);
        return R.ok("投票成功");
    }

    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ForumEntity forum, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(forum);
    	forum.setUserid((Long)request.getSession().getAttribute("userId"));
        forumService.insert(forum);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody ForumEntity forum, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(forum);
    	forum.setUserid((Long)request.getSession().getAttribute("userId"));
        forumService.insert(forum);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody ForumEntity forum, HttpServletRequest request){
        //ValidatorUtils.validateEntity(forum);
        forumService.updateById(forum);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        forumService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	





    /**
     * （按值统计）
     */
    @RequestMapping("/value/{xColumnName}/{yColumnName}")
    public R value(@PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName,HttpServletRequest request) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", MPUtil.camelToSnake(xColumnName));
        params.put("yColumn", MPUtil.camelToSnake(yColumnName));
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(forumService.selectValue(params, ew));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Map<String, Object> m : result) {
            for(String k : m.keySet()) {
                if(m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date)m.get(k)));
                }
            }
        }

        Collections.sort(result, (map1, map2) -> {
            // 假设 total 总是存在并且是数值类型
            Number total1 = (Number) map1.get("total");
            Number total2 = (Number) map2.get("total");
            if(total1==null)
            {
                total1 = 0;
            }
            if(total2==null)
            {
                total2 = 0;
            }
            String order = request.getParameter("order");
            if(StringUtils.isNotBlank(order)&&order.equals("desc")){
                return Double.compare(total2.doubleValue(), total1.doubleValue());
            }
            return Double.compare(total1.doubleValue(), total2.doubleValue());
        });

        return R.ok().put("data", result);
    }

    /**
     * （按值统计(多)）
     */
    @RequestMapping("/valueMul/{xColumnName}")
    public R valueMul(@PathVariable("xColumnName") String xColumnName,@RequestParam String yColumnNameMul, HttpServletRequest request) {
        String[] yColumnNames = MPUtil.camelToSnake(yColumnNameMul).split(",");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", MPUtil.camelToSnake(xColumnName));
        List<List<Map<String, Object>>> result2 = new ArrayList<List<Map<String,Object>>>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(forumService.selectValue(params, ew));
            for(Map<String, Object> m : result) {
                for(String k : m.keySet()) {
                    if(m.get(k) instanceof Date) {
                        m.put(k, sdf.format((Date)m.get(k)));
                    }
                }
            }
            result2.add(result);
        }
        return R.ok().put("data", result2);
    }

    /**
     * （按值统计）时间统计类型
     */
    @RequestMapping("/value/{xColumnName}/{yColumnName}/{timeStatType}")
    public R valueDay(@PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName, @PathVariable("timeStatType") String timeStatType,HttpServletRequest request) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", MPUtil.camelToSnake(xColumnName));
        params.put("yColumn", MPUtil.camelToSnake(yColumnName));
        params.put("timeStatType", timeStatType);
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(forumService.selectTimeStatValue(params, ew));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Map<String, Object> m : result) {
            for(String k : m.keySet()) {
                if(m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date)m.get(k)));
                }
            }
        }
        return R.ok().put("data", result);
    }

    /**
     * （按值统计）时间统计类型(多)
     */
    @RequestMapping("/valueMul/{xColumnName}/{timeStatType}")
    public R valueMulDay(@PathVariable("xColumnName") String xColumnName, @PathVariable("timeStatType") String timeStatType,@RequestParam String yColumnNameMul,HttpServletRequest request) {
        String[] yColumnNames = MPUtil.camelToSnake(yColumnNameMul).split(",");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", xColumnName);
        params.put("timeStatType", timeStatType);
        List<List<Map<String, Object>>> result2 = new ArrayList<List<Map<String,Object>>>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(forumService.selectTimeStatValue(params, ew));
            for(Map<String, Object> m : result) {
                for(String k : m.keySet()) {
                    if(m.get(k) instanceof Date) {
                        m.put(k, sdf.format((Date)m.get(k)));
                    }
                }
            }
            result2.add(result);
        }
        return R.ok().put("data", result2);
    }

    /**
     * 分组统计
     */
    @RequestMapping("/group/{columnName}")
    public R group(@PathVariable("columnName") String columnName,HttpServletRequest request) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("column", MPUtil.camelToSnake(columnName));
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(forumService.selectGroup(params, ew));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Map<String, Object> m : result) {
            for(String k : m.keySet()) {
                if(m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date)m.get(k)));
                }
            }
        }
        return R.ok().put("data", result);
    }




    /**
     * 总数量
     */
    @RequestMapping("/count")
    public R count(@RequestParam Map<String, Object> params,ForumEntity forum, HttpServletRequest request){
        EntityWrapper<ForumEntity> ew = new EntityWrapper<ForumEntity>();
        int count = forumService.selectCount(MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, forum), params), params));
        return R.ok().put("data", count);
    }



}
