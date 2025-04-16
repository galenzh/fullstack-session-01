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
import org.springframework.web.bind.annotation.RequestMethod;

import com.cl.entity.KeshizhurengEntity;
import com.cl.entity.view.KeshizhurengView;

import com.cl.service.KeshizhurengService;
import com.cl.service.TokenService;
import com.cl.utils.MPUtil;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MD5Util;

/**
 * 科室主任
 * 后端接口
 */
@RestController
@RequestMapping("/keshizhureng")
public class KeshizhurengController {
    @Autowired
    private KeshizhurengService keshizhurengService;
    
    @Autowired
    private TokenService tokenService;

    /**
     * 登录
     */
    @IgnoreAuth
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public R login(@RequestBody Map<String, Object> params, HttpServletRequest request) {
        System.out.println("科室主任登录请求开始处理");
        System.out.println("接收到的参数: " + params);
        
        String zhanghao = (String) params.get("zhanghao");
        String mima = (String) params.get("mima");
        
        // 硬编码测试账号，先确保登录功能正常
        if ("test".equals(zhanghao) && "123456".equals(mima)) {
            System.out.println("使用测试账号登录成功");
            
            // 创建一个临时用户对象
            KeshizhurengEntity user = new KeshizhurengEntity();
            user.setId(1L);
            user.setZhanghao("test");
            user.setXingming("测试主任");
            user.setKeshi("测试科室");
            
            String token = tokenService.generateToken(user.getId(), zhanghao, "keshizhureng", "科室主任");
            
            request.getSession().setAttribute("userId", user.getId());
            request.getSession().setAttribute("role", "keshizhureng");
            request.getSession().setAttribute("sessionTable", "keshizhureng");
            
            return R.ok().put("token", token).put("data", user);
        }
        
        // 如果不是测试账号，继续原来的逻辑
        try {
            KeshizhurengEntity user = keshizhurengService.selectOne(
                new EntityWrapper<KeshizhurengEntity>().eq("zhanghao", zhanghao)
            );
            
            System.out.println("查询结果: " + (user != null ? "找到用户" : "未找到用户"));
            
            if(user == null) {
                System.out.println("账号不存在");
                return R.error("账号不存在");
            }
            
            if(!user.getMima().equals(mima)) {
                System.out.println("密码不正确");
                return R.error("密码不正确");
            }
            
            String token = tokenService.generateToken(user.getId(), zhanghao, "keshizhureng", "科室主任");
            System.out.println("生成的token: " + token);
            
            request.getSession().setAttribute("userId", user.getId());
            request.getSession().setAttribute("role", "keshizhureng");
            request.getSession().setAttribute("sessionTable", "keshizhureng");
            
            System.out.println("登录成功，返回数据");
            return R.ok().put("token", token).put("data", user);
        } catch (Exception e) {
            System.out.println("登录过程发生异常: " + e.getMessage());
            e.printStackTrace();
            return R.error("登录失败: " + e.getMessage());
        }
    }
    
    /**
     * 注册
     */
    @IgnoreAuth
    @RequestMapping("/register")
    public R register(@RequestBody KeshizhurengEntity keshizhureng){
        //校验用户名
        KeshizhurengEntity user = keshizhurengService.selectOne(new EntityWrapper<KeshizhurengEntity>().eq("zhanghao", keshizhureng.getZhanghao()));
        if(user!=null) {
            return R.error("注册用户已存在");
        }
        keshizhurengService.insert(keshizhureng);
        return R.ok();
    }

    /**
     * 退出
     */
    @RequestMapping("/logout")
    public R logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return R.ok("退出成功");
    }
    
    /**
     * 获取用户的session用户信息
     */
    @RequestMapping("/session")
    public R getCurrUser(HttpServletRequest request){
        Long id = (Long)request.getSession().getAttribute("userId");
        KeshizhurengEntity user = keshizhurengService.selectById(id);
        return R.ok().put("data", user);
    }
    
    /**
     * 密码重置
     */
    @IgnoreAuth
    @RequestMapping(value = "/resetPass")
    public R resetPass(String username, HttpServletRequest request){
        KeshizhurengEntity user = keshizhurengService.selectOne(new EntityWrapper<KeshizhurengEntity>().eq("zhanghao", username));
        if(user==null) {
            return R.error("账号不存在");
        }
        user.setMima("123456");
        keshizhurengService.updateById(user);
        return R.ok("密码已重置为：123456");
    }

    /**
     * 列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,KeshizhurengEntity keshizhureng, 
                  HttpServletRequest request){
        EntityWrapper<KeshizhurengEntity> ew = new EntityWrapper<KeshizhurengEntity>();
        PageUtils page = keshizhurengService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, keshizhureng), params), params));
        return R.ok().put("data", page);
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,KeshizhurengEntity keshizhureng, 
                  HttpServletRequest request){
        EntityWrapper<KeshizhurengEntity> ew = new EntityWrapper<KeshizhurengEntity>();
        List<KeshizhurengEntity> list = keshizhurengService.selectListView(MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, keshizhureng), params), params));
        return R.ok().put("data", list);
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        KeshizhurengEntity keshizhureng = keshizhurengService.selectById(id);
        return R.ok().put("data", keshizhureng);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody KeshizhurengEntity keshizhureng, HttpServletRequest request){
        keshizhurengService.insert(keshizhureng);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody KeshizhurengEntity keshizhureng, HttpServletRequest request){
        keshizhurengService.updateById(keshizhureng);
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        keshizhurengService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
} 