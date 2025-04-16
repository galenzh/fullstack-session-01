package com.cl.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import java.util.stream.Collectors;
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

import com.cl.entity.ZixunshiyuyueEntity;
import com.cl.entity.view.ZixunshiyuyueView;

import com.cl.service.ZixunshiyuyueService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;

/**
 * 咨询师预约
 * 后端接口
 */
@RestController
@RequestMapping("/zixunshiyuyue")
public class ZixunshiyuyueController {
    @Autowired
    private ZixunshiyuyueService zixunshiyuyueService;

    /**
     * 获取可用时间段
     */
    @RequestMapping("/getAvailableTimeSlots")
    public R getAvailableTimeSlots(@RequestParam String date, @RequestParam String zixunshizhanghao) {
        try {
            if (StringUtils.isBlank(zixunshizhanghao)) {
                return R.error("请提供咨询师账号");
            }
            
            if (StringUtils.isBlank(date)) {
                return R.error("请提供预约日期");
            }
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date queryDate;
            try {
                queryDate = sdf.parse(date);
            } catch (ParseException e) {
                return R.error("日期格式错误，请使用yyyy-MM-dd格式");
            }
            
            // 定义所有可能的时间段
            List<String> allTimeSlots = Arrays.asList(
                "09:00-10:00", "10:00-11:00", "11:00-12:00",
                "14:00-15:00", "15:00-16:00", "16:00-17:00"
            );
            
            // 查询该咨询师在指定日期已经被预约的时间段
            EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<>();
            
            // 使用日期字符串进行相等比较
            ew.eq("zixunshizhanghao", zixunshizhanghao)
              .like("yuyueshijian", date + "%")  // 使用like匹配日期前缀
              .ne("status", "已取消"); // 排除已取消的预约
            
            List<ZixunshiyuyueEntity> bookedAppointments = zixunshiyuyueService.selectList(ew);
            
            // 获取已预约的时间段
            Set<String> bookedTimeSlots = new HashSet<>();
            for (ZixunshiyuyueEntity appointment : bookedAppointments) {
                if (appointment.getTimeSlot() != null) {
                    bookedTimeSlots.add(appointment.getTimeSlot());
                }
            }
            
            // 过滤出可用的时间段
            List<String> availableTimeSlots = new ArrayList<>();
            for (String slot : allTimeSlots) {
                if (!bookedTimeSlots.contains(slot)) {
                    availableTimeSlots.add(slot);
                }
            }
            
            return R.ok().put("data", availableTimeSlots);
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("获取可用时间段失败: " + e.getMessage());
        }
    }

    /**
     * 检查时间冲突
     */
    private boolean checkTimeConflict(ZixunshiyuyueEntity zixunshiyuyue) {
        EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<>();
        ew.eq("zixunshizhanghao", zixunshiyuyue.getZixunshizhanghao())
          .eq("yuyuezixunshijian", zixunshiyuyue.getYuyuezixunshijian())
          .eq("time_slot", zixunshiyuyue.getTimeSlot())
          .ne("status", "已取消");
        
        if (zixunshiyuyue.getId() != null) {
            ew.ne("id", zixunshiyuyue.getId()); // 排除当前预约
        }
        
        return zixunshiyuyueService.selectCount(ew) > 0;
    }

    /**
     * 生成预约编号
     */
    private String generateAppointmentNumber() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        return "YY" + sdf.format(new Date()) + String.format("%04d", new Random().nextInt(10000));
    }

    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ZixunshiyuyueEntity zixunshiyuyue, HttpServletRequest request){
        try {
            // 必须提供时间段
            if (StringUtils.isBlank(zixunshiyuyue.getTimeSlot())) {
                return R.error("请选择预约时间段");
            }
            
            // 必须提供咨询师账号
            if (StringUtils.isBlank(zixunshiyuyue.getZixunshizhanghao())) {
                return R.error("请选择咨询师");
            }
            
            // 如果预约日期为null，返回错误
            if (zixunshiyuyue.getYuyueshijian() == null) {
                return R.error("请选择预约日期");
            }
            
            // 将日期转换为字符串，用于查询
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String dateStr = sdf.format(zixunshiyuyue.getYuyueshijian());
            
            // 检查该咨询师在指定日期和时间段是否已有预约
            EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<>();
            ew.eq("zixunshizhanghao", zixunshiyuyue.getZixunshizhanghao())
              .like("yuyueshijian", dateStr + "%")  // 使用like匹配日期前缀
              .eq("time_slot", zixunshiyuyue.getTimeSlot())
              .ne("status", "已取消");
            
            List<ZixunshiyuyueEntity> existingAppointments = zixunshiyuyueService.selectList(ew);
            int count = existingAppointments.size();
            
            if (count > 0) {
                return R.error("该咨询师在该时间段已有预约，请选择其他时间段");
            }
            
            // 设置默认值
            zixunshiyuyue.setYuyuebianhao(generateAppointmentNumber());
            zixunshiyuyue.setStatus("待确认");
            if (zixunshiyuyue.getDuration() == null) {
                zixunshiyuyue.setDuration(60);
            }
            
            // 设置用户信息
            String username = request.getSession().getAttribute("username") != null ? 
                request.getSession().getAttribute("username").toString() : "";
            if (StringUtils.isBlank(zixunshiyuyue.getZhanghao()) && StringUtils.isNotBlank(username)) {
                zixunshiyuyue.setZhanghao(username);
            }
            
            // 保存到数据库
            zixunshiyuyueService.insert(zixunshiyuyue);
            return R.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("保存失败: " + e.getMessage());
        }
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody ZixunshiyuyueEntity zixunshiyuyue, HttpServletRequest request){
        // 检查ID是否存在
        if (zixunshiyuyue.getId() == null) {
            return R.error("ID不能为空");
        }
        
        // 获取原记录
        ZixunshiyuyueEntity existingEntity = zixunshiyuyueService.selectById(zixunshiyuyue.getId());
        if (existingEntity == null) {
            return R.error("记录不存在");
        }
        
        // 处理审核状态
        if (zixunshiyuyue.getSfsh() != null) {
            existingEntity.setSfsh(zixunshiyuyue.getSfsh());
            
            // 如果有回复内容，更新回复
            if (zixunshiyuyue.getShhf() != null) {
                existingEntity.setShhf(zixunshiyuyue.getShhf());
            }
            
            // 如果提供了状态，更新状态
            if (zixunshiyuyue.getStatus() != null) {
                existingEntity.setStatus(zixunshiyuyue.getStatus());
            } else {
                // 根据审核状态自动设置预约状态
                if ("是".equals(zixunshiyuyue.getSfsh())) {
                    existingEntity.setStatus("已确认");
                } else if ("否".equals(zixunshiyuyue.getSfsh())) {
                    existingEntity.setStatus("已取消");
                }
            }
        }
        
        // 更新记录
        boolean result = zixunshiyuyueService.updateById(existingEntity);
        return R.ok();
    }

    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, ZixunshiyuyueEntity zixunshiyuyue, HttpServletRequest request) {
        try {
            String tableName = "";
            String username = "";
            
            if (request.getSession() != null) {
                tableName = request.getSession().getAttribute("tableName") != null ?
                        request.getSession().getAttribute("tableName").toString() : "";
                username = request.getSession().getAttribute("username") != null ?
                        request.getSession().getAttribute("username").toString() : "";

                // 管理员不限制查询条件
                if (tableName.equals("users") || "管理员".equals(tableName) || StringUtils.isEmpty(tableName)) {
                    // 管理员查看全部数据，无需添加额外条件
                }
                // 咨询师只能查看自己的预约
                else if (tableName.equals("zixunshi")) {
                    // 清空原来的条件
                    zixunshiyuyue.setZixunshizhanghao(null);
                    
                    // 使用EntityWrapper的实例来设置查询条件
                    EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
                    
                    // 咨询师查询条件：匹配自己的账号
                    // 增强的咨询师账号匹配逻辑
                    if (username.contains("咨询师")) {
                        // 基本咨询师前缀
                        String basePrefix = "咨询师";
                        
                        // 主要匹配模式：精确匹配咨询师账号
                        ew.eq("zixunshizhanghao", username);
                        
                        // 如果用户名包含"账号"，也尝试匹配简化版本
                        if (username.contains("账号")) {
                            String[] parts = username.split("账号");
                            if (parts.length > 1 && !parts[1].isEmpty()) {
                                // 如果是纯数字
                                if (parts[1].matches("\\d+")) {
                                    ew.or().eq("zixunshizhanghao", basePrefix + parts[1]); // 匹配咨询师+数字
                                }
                            }
                        }
                    } else {
                        // 如果不包含"咨询师"，则使用精确匹配
                        ew.eq("zixunshizhanghao", username);
                    }
                    
                    PageUtils page = zixunshiyuyueService.queryPage(params, MPUtil.sort(MPUtil.between(ew, params), params));
                    return R.ok().put("data", page);
                }
                else if (tableName.equals("yonghu")) {
                    zixunshiyuyue.setZhanghao(username);
                }
            }

            EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
            PageUtils page = zixunshiyuyueService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zixunshiyuyue), params), params));
            return R.ok().put("data", page);
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("查询列表失败");
        }
    }

    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ZixunshiyuyueEntity zixunshiyuyue,
		HttpServletRequest request){
        EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();

		PageUtils page = zixunshiyuyueService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zixunshiyuyue), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ZixunshiyuyueEntity zixunshiyuyue){
       	EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
      	ew.allEq(MPUtil.allEQMapPre( zixunshiyuyue, "zixunshiyuyue")); 
        return R.ok().put("data", zixunshiyuyueService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ZixunshiyuyueEntity zixunshiyuyue){
        EntityWrapper< ZixunshiyuyueEntity> ew = new EntityWrapper< ZixunshiyuyueEntity>();
 		ew.allEq(MPUtil.allEQMapPre( zixunshiyuyue, "zixunshiyuyue")); 
		ZixunshiyuyueView zixunshiyuyueView =  zixunshiyuyueService.selectView(ew);
		return R.ok("查询咨询师预约成功").put("data", zixunshiyuyueView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ZixunshiyuyueEntity zixunshiyuyue = zixunshiyuyueService.selectById(id);
		zixunshiyuyue = zixunshiyuyueService.selectView(new EntityWrapper<ZixunshiyuyueEntity>().eq("id", id));
        return R.ok().put("data", zixunshiyuyue);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ZixunshiyuyueEntity zixunshiyuyue = zixunshiyuyueService.selectById(id);
		zixunshiyuyue = zixunshiyuyueService.selectView(new EntityWrapper<ZixunshiyuyueEntity>().eq("id", id));
        return R.ok().put("data", zixunshiyuyue);
    }


    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        zixunshiyuyueService.deleteBatchIds(Arrays.asList(ids));
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
        EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
		}
		if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
		}
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(zixunshiyuyueService.selectValue(params, ew));
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
        EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
        }
        if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
        }
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(zixunshiyuyueService.selectValue(params, ew));
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
        EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
        }
        if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
        }
        List<Map<String, Object>> result = MPUtil.snakeListToCamel(zixunshiyuyueService.selectTimeStatValue(params, ew));
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
        EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("zixunshi")) {
            ew.eq("zixunshizhanghao", (String)request.getSession().getAttribute("username"));
        }
        if(tableName.equals("yonghu")) {
            ew.eq("zhanghao", (String)request.getSession().getAttribute("username"));
        }
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(zixunshiyuyueService.selectTimeStatValue(params, ew));
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
     * （按值分组统计）
     */
    @RequestMapping("/group/{columnName}")
    public R group(@PathVariable("columnName") String columnName, HttpServletRequest request) {
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("column", MPUtil.camelToSnake(columnName));
            EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
            
            String tableName = "";
            String username = "";
            
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
                // 增强的咨询师账号匹配逻辑
                if (username.contains("咨询师")) {
                    // 主要匹配模式：精确匹配咨询师账号
                    ew.eq("zixunshizhanghao", username);
                    
                    // 如果用户名包含"账号"，也尝试匹配简化版本
                    if (username.contains("账号")) {
                        String[] parts = username.split("账号");
                        if (parts.length > 1 && !parts[1].isEmpty()) {
                            // 如果是纯数字
                            if (parts[1].matches("\\d+")) {
                                String basePrefix = "咨询师";
                                ew.or().eq("zixunshizhanghao", basePrefix + parts[1]); // 匹配咨询师+数字
                            }
                        }
                    }
                } else {
                    // 如果不包含"咨询师"，则使用精确匹配
                    ew.eq("zixunshizhanghao", username);
                }
            }
            // a普通用户
            else if(tableName.equals("yonghu")) {
                ew.eq("zhanghao", username);
            }
            // 其他角色
            else {
                // 默认不添加限制条件
            }
            
            List<Map<String, Object>> result = MPUtil.snakeListToCamel(zixunshiyuyueService.selectGroup(params, ew));
            
            // 对咨询师账号进行美化显示处理
            if ("zixunshizhanghao".equals(columnName)) {
                for (Map<String, Object> map : result) {
                    String account = (String) map.get("zixunshizhanghao");
                    if (account != null && account.contains("咨询师")) {
                        map.put("zixunshizhanghao", account);
                    }
                }
            }
            
            // 对日期字段进行格式化处理
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            for (Map<String, Object> map : result) {
                for (String key : map.keySet()) {
                    if (map.get(key) instanceof Date) {
                        map.put(key, sdf.format((Date) map.get(key)));
                    }
                }
            }
            
            return R.ok().put("data", result);
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("分组统计失败");
        }
    }

    /**
     * 总数量
     */
    @RequestMapping("/count")
    public R count(@RequestParam Map<String, Object> params, ZixunshiyuyueEntity zixunshiyuyue, HttpServletRequest request) {
        try {
            String tableName = "";
            String username = "";

            if (request.getSession() != null) {
                tableName = request.getSession().getAttribute("tableName") != null ?
                        request.getSession().getAttribute("tableName").toString() : "";
                username = request.getSession().getAttribute("username") != null ?
                        request.getSession().getAttribute("username").toString() : "";

                // 管理员不限制查询条件
                if (tableName.equals("users") || "管理员".equals(tableName) || StringUtils.isEmpty(tableName)) {
                    // 管理员查看全部数据，无需添加额外条件
                }
                // 咨询师账号
                else if (tableName.equals("zixunshi")) {
                    // 清空原来的条件
                    zixunshiyuyue.setZixunshizhanghao(null);
                    
                    // 使用EntityWrapper的实例来设置查询条件
                    EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
                    
                    // 增强的咨询师账号匹配逻辑
                    if (username.contains("咨询师")) {
                        // 主要匹配模式：精确匹配咨询师账号
                        ew.eq("zixunshizhanghao", username);
                        
                        // 如果用户名包含"账号"，也尝试匹配简化版本
                        if (username.contains("账号")) {
                            String[] parts = username.split("账号");
                            if (parts.length > 1 && !parts[1].isEmpty()) {
                                // 如果是纯数字
                                if (parts[1].matches("\\d+")) {
                                    String basePrefix = "咨询师";
                                    ew.or().eq("zixunshizhanghao", basePrefix + parts[1]); // 匹配咨询师+数字
                                }
                            }
                        }
                    } else {
                        // 如果不包含"咨询师"，则使用精确匹配
                        ew.eq("zixunshizhanghao", username);
                    }
                    
                    int count = zixunshiyuyueService.selectCount(MPUtil.sort(MPUtil.between(ew, params), params));
                    return R.ok().put("data", count);
                }
                // 普通用户
                else if (tableName.equals("yonghu")) {
                    zixunshiyuyue.setZhanghao(username);
                }
                // 其他角色
                else {
                    // 默认不添加限制条件
                }
            }

            EntityWrapper<ZixunshiyuyueEntity> ew = new EntityWrapper<ZixunshiyuyueEntity>();
            int count = zixunshiyuyueService.selectCount(MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zixunshiyuyue), params), params));
            return R.ok().put("data", count);
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("查询数量失败");
        }
    }



}
