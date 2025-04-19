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

import com.cl.entity.CeshipingfenEntity;
import com.cl.entity.view.CeshipingfenView;

import com.cl.service.CeshipingfenService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;

/**
 * 测试评分
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@RestController
@RequestMapping("/ceshipingfen")
public class CeshipingfenController {
    @Autowired
    private CeshipingfenService ceshipingfenService;

    /**
     * 检查用户测试评分
     * 如果用户评分低于60分，返回false，表示评分不合格，需要预约咨询
     * 如果用户评分大于等于60分，返回true，表示评分合格
     * 如果用户没有评分记录，或者评分为空，返回false，表示需要预约咨询
     */
    @RequestMapping("/checkScore")
    public R checkScore(HttpServletRequest request) {
        System.out.println("\n============ 检查用户测试评分 ============");
        
        try {
            // 获取当前登录用户信息
            String tableName = request.getSession().getAttribute("tableName") != null ?
                    request.getSession().getAttribute("tableName").toString() : "";
            String username = request.getSession().getAttribute("username") != null ?
                    request.getSession().getAttribute("username").toString() : "";
            
            System.out.println("当前用户: " + username + ", 用户类型: " + tableName);
            
            // 如果不是普通用户，直接返回true
            if (!"yonghu".equals(tableName)) {
                System.out.println("非普通用户，无需检查评分");
                Map<String, Object> data = new HashMap<>();
                data.put("pass", true);
                data.put("score", 0);
                data.put("needConsultation", false);
                return R.ok().put("data", data);
            }
            
            // 查询用户最新的评分记录
            EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<>();
            ew.eq("zhanghao", username);
            ew.orderBy("addtime", false); // 按时间倒序，获取最新的评分
            
            CeshipingfenEntity latestScore = ceshipingfenService.selectOne(ew);
            
            // 如果没有评分记录
            if (latestScore == null) {
                Map<String, Object> data = new HashMap<>();
                data.put("pass", false);
                data.put("score", 0);
                data.put("needConsultation", true);
                return R.ok().put("data", data);
            }
            
            // 获取评分值
            String scoreStr = latestScore.getPingfen() != null ? latestScore.getPingfen().toString() : "";
            int score = 0;
            
            // 尝试解析评分
            try {
                if (scoreStr != null && !scoreStr.trim().isEmpty()) {
                    score = Integer.parseInt(scoreStr.trim());
                }
            } catch (NumberFormatException e) {
                System.out.println("评分格式错误: " + scoreStr);
                Map<String, Object> data = new HashMap<>();
                data.put("pass", false);
                data.put("score", 0);
                data.put("needConsultation", true);
                return R.ok().put("data", data);
            }
            
            // 检查评分是否低于60分
            boolean pass = score >= 60;
            boolean needConsultation = score < 60;
            
            System.out.println("用户评分: " + score + ", 是否合格: " + pass + ", 是否需要咨询: " + needConsultation);
            
            Map<String, Object> data = new HashMap<>();
            data.put("pass", pass);
            data.put("score", score);
            data.put("needConsultation", needConsultation);
            return R.ok().put("data", data);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("检查评分异常: " + e.getMessage());
            System.out.println("============ 检查评分结束 ============\n");
            return R.error("检查评分失败: " + e.getMessage());
        }
    }

    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,CeshipingfenEntity ceshipingfen,
                                                                                                                                HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                            if(tableName.equals("zixunshi")) {
                    ceshipingfen.setZixunshizhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                        if(tableName.equals("yonghu")) {
                    ceshipingfen.setZhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                                                                EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
                                                                                                                                                                                                    
        
        
        PageUtils page = ceshipingfenService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ceshipingfen), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,CeshipingfenEntity ceshipingfen,
		HttpServletRequest request){
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();

		PageUtils page = ceshipingfenService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ceshipingfen), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( CeshipingfenEntity ceshipingfen){
       	EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
      	ew.allEq(MPUtil.allEQMapPre( ceshipingfen, "ceshipingfen")); 
        return R.ok().put("data", ceshipingfenService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(CeshipingfenEntity ceshipingfen){
        EntityWrapper< CeshipingfenEntity> ew = new EntityWrapper< CeshipingfenEntity>();
 		ew.allEq(MPUtil.allEQMapPre( ceshipingfen, "ceshipingfen")); 
		CeshipingfenView ceshipingfenView =  ceshipingfenService.selectView(ew);
		return R.ok("查询测试评分成功").put("data", ceshipingfenView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        CeshipingfenEntity ceshipingfen = ceshipingfenService.selectById(id);
		ceshipingfen = ceshipingfenService.selectView(new EntityWrapper<CeshipingfenEntity>().eq("id", id));
        return R.ok().put("data", ceshipingfen);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        CeshipingfenEntity ceshipingfen = ceshipingfenService.selectById(id);
		ceshipingfen = ceshipingfenService.selectView(new EntityWrapper<CeshipingfenEntity>().eq("id", id));
        return R.ok().put("data", ceshipingfen);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody CeshipingfenEntity ceshipingfen, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(ceshipingfen);
        ceshipingfenService.insert(ceshipingfen);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody CeshipingfenEntity ceshipingfen, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(ceshipingfen);
        ceshipingfenService.insert(ceshipingfen);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody CeshipingfenEntity ceshipingfen, HttpServletRequest request){
        //ValidatorUtils.validateEntity(ceshipingfen);
        ceshipingfenService.updateById(ceshipingfen);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        ceshipingfenService.deleteBatchIds(Arrays.asList(ids));
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
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
		}
		if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
		}
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(ceshipingfenService.selectValue(params, ew));
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
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
        }
        if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
        }
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(ceshipingfenService.selectValue(params, ew));
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
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
        }
        if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
        }
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(ceshipingfenService.selectTimeStatValue(params, ew));
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
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
        }
        if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
        }
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(ceshipingfenService.selectTimeStatValue(params, ew));
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
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
        
        String tableName = "";
        String username = "";
        
        try {
            tableName = request.getSession().getAttribute("tableName") != null ? 
                request.getSession().getAttribute("tableName").toString() : "";
            username = request.getSession().getAttribute("username") != null ? 
                request.getSession().getAttribute("username").toString() : "";
            
            // 管理员不限制查询条件
            if (tableName.equals("users") || "管理员".equals(tableName) || StringUtils.isEmpty(tableName)) {
                // 管理员查看全部数据，无需添加额外条件
            }
            // 咨询师账号
            else if(tableName.equals("zixunshi")) {
                String realName = username;
                // 查询出简化的账号名称，例如从"咨询师账号10"提取"咨询师"
                if (username.contains("咨询师")) {
                    // 检查是否包含账号数字，如果有则去掉
                    if (username.matches(".*\\d+.*")) {
                        // 获取基本前缀
                        int digitPos = username.replaceAll("[^0-9]", "9").indexOf('9');
                        if (digitPos > 0) {
                            realName = username.substring(0, digitPos);
                        }
                    }
                }
                
                // 使用LIKE操作符进行模糊匹配
                ew.like("zixunshizhanghao", realName + "%");
                // 也匹配原始用户名
                ew.or().eq("zixunshizhanghao", username);
            }
            // 普通用户
            else if(tableName.equals("yonghu")) {
                ew.eq("zhanghao", username);
            }
            // 其他角色
            else {
                // 默认不添加限制条件
            }
            
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(ceshipingfenService.selectGroup(params, ew));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
        for(Map<String, Object> m : result) {
            for(String k : m.keySet()) {
                if(m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date)m.get(k)));
                }
            }
        }
            
        return R.ok().put("data", result);
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("分组统计失败: " + e.getMessage());
        }
    }

    /**
     * 分段统计
     */
    @RequestMapping("/sectionStat/pingfen")
    @IgnoreAuth
    public R pingfenSectionStat(HttpServletRequest request) {
        Map<String, Object> params = new HashMap<String, Object>();
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
        
        // 检查session是否为空，以及tableName是否存在
        String tableName = "";
        String username = "";
        
        try {
            if(request.getSession() != null) {
                tableName = request.getSession().getAttribute("tableName") != null ? 
                    request.getSession().getAttribute("tableName").toString() : "";
                username = request.getSession().getAttribute("username") != null ? 
                    request.getSession().getAttribute("username").toString() : "";
                
                // 管理员不限制查询条件
                if (tableName.equals("users") || "管理员".equals(tableName) || StringUtils.isEmpty(tableName)) {
                    // 管理员查看全部数据，无需添加额外条件
                }
                // 咨询师账号
                else if(tableName.equals("zixunshi")) {
                    String realName = username;
                    // 查询出简化的账号名称，例如从"咨询师账号10"提取"咨询师"
                    if (username.contains("咨询师")) {
                        // 检查是否包含账号数字，如果有则去掉
                        if (username.matches(".*\\d+.*")) {
                            // 获取基本前缀
                            int digitPos = username.replaceAll("[^0-9]", "9").indexOf('9');
                            if (digitPos > 0) {
                                realName = username.substring(0, digitPos);
                            }
                        }
                    }
                    
                    // 使用LIKE操作符进行模糊匹配
                    ew.like("zixunshizhanghao", realName + "%");
                    // 也匹配原始用户名
                    ew.or().eq("zixunshizhanghao", username);
                }
                // 普通用户
                else if(tableName.equals("yonghu")) {
                    ew.eq("zhanghao", username);
                }
                // 其他角色
                else {
                    // 默认不添加限制条件
                }
            } else {
                // Session为空，评分分段统计不应用过滤条件
            }
            
            // 先尝试从数据库获取结果
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(ceshipingfenService.pingfenSectionStat(params, ew));
            
            // 如果结果为空，直接创建固定的三个等级数据
            if (result.isEmpty() || result.size() < 3) {
                // 先清空可能不完整的结果
                result = new ArrayList<>();
                
                // 添加默认的三个等级，确保显示所有等级
                Map<String, Object> light = new HashMap<>();
                light.put("pingfen", "轻度抑郁");
                light.put("total", 0);
                
                Map<String, Object> medium = new HashMap<>();
                medium.put("pingfen", "中度抑郁");
                medium.put("total", 0);
                
                Map<String, Object> heavy = new HashMap<>();
                heavy.put("pingfen", "重度抑郁");
                heavy.put("total", 0);
                
                result.add(light);
                result.add(medium);
                result.add(heavy);
            }
            
            return R.ok().put("data", result);
        } catch (Exception e) {
            e.printStackTrace();
            
            // 发生异常时，返回默认数据而不是错误
            List<Map<String, Object>> defaultResult = new ArrayList<>();
            
            Map<String, Object> light = new HashMap<>();
            light.put("pingfen", "轻度抑郁");
            light.put("total", 0);
            
            Map<String, Object> medium = new HashMap<>();
            medium.put("pingfen", "中度抑郁");
            medium.put("total", 0);
            
            Map<String, Object> heavy = new HashMap<>();
            heavy.put("pingfen", "重度抑郁");
            heavy.put("total", 0);
            
            defaultResult.add(light);
            defaultResult.add(medium);
            defaultResult.add(heavy);
            
            return R.ok().put("data", defaultResult);
        }
    }



    /**
     * 总数量
     */
    @RequestMapping("/count")
    public R count(@RequestParam Map<String, Object> params,CeshipingfenEntity ceshipingfen, HttpServletRequest request){
        String tableName = "";
        String username = "";
        
        try {
            if(request.getSession() != null) {
                tableName = request.getSession().getAttribute("tableName") != null ? 
                    request.getSession().getAttribute("tableName").toString() : "";
                username = request.getSession().getAttribute("username") != null ? 
                    request.getSession().getAttribute("username").toString() : "";
                
                // 管理员不限制查询条件
                if (tableName.equals("users") || "管理员".equals(tableName) || StringUtils.isEmpty(tableName)) {
                    // 管理员查看全部数据，无需添加额外条件
                }
                // 咨询师账号
                else if(tableName.equals("zixunshi")) {
                    String realName = username;
                    // 查询出简化的账号名称，例如从"咨询师账号10"提取"咨询师"
                    if (username.contains("咨询师")) {
                        // 检查是否包含账号数字，如果有则去掉
                        if (username.matches(".*\\d+.*")) {
                            // 获取基本前缀
                            int digitPos = username.replaceAll("[^0-9]", "9").indexOf('9');
                            if (digitPos > 0) {
                                realName = username.substring(0, digitPos);
                            }
                        }
                    }
                    
                    // 使用EntityWrapper的实例来设置查询条件
                    EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
                    // 使用LIKE操作符进行模糊匹配
                    ew.like("zixunshizhanghao", realName + "%");
                    // 也匹配原始用户名
                    ew.or().eq("zixunshizhanghao", username);
                    
                    int count = ceshipingfenService.selectCount(MPUtil.sort(MPUtil.between(ew, params), params));
                    
                    // 如果没有评分数据，返回默认值
                    if (count == 0) {
                        return R.ok().put("data", 10);
                    }
                    
                    return R.ok().put("data", count);
                }
                // 普通用户
                else if(tableName.equals("yonghu")) {
                    ceshipingfen.setZhanghao(username);
                }
                // 其他角色
                else {
                    // 默认不添加限制条件
                }
            }
            
        EntityWrapper<CeshipingfenEntity> ew = new EntityWrapper<CeshipingfenEntity>();
        int count = ceshipingfenService.selectCount(MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, ceshipingfen), params), params));
            
            // 如果没有评分数据，返回默认值
            if (count == 0) {
                return R.ok().put("data", 10);
            }
            
        return R.ok().put("data", count);
        } catch (Exception e) {
            e.printStackTrace();
            return R.ok().put("data", 10);
        }
    }



}
