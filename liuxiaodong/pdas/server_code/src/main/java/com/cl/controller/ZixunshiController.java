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

import com.cl.entity.ZixunshiEntity;
import com.cl.entity.view.ZixunshiView;

import com.cl.service.ZixunshiService;
import com.cl.service.TokenService;
import com.cl.utils.PageUtils;
import com.cl.utils.R;
import com.cl.utils.MPUtil;
import com.cl.utils.MapUtils;
import com.cl.utils.CommonUtil;
import com.cl.service.StoreupService;
import com.cl.entity.StoreupEntity;

/**
 * 咨询师
 * 后端接口
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@RestController
@RequestMapping("/zixunshi")
public class ZixunshiController {
    @Autowired
    private ZixunshiService zixunshiService;

    @Autowired
    private StoreupService storeupService;


	@Autowired
	private TokenService tokenService;
	
	/**
	 * 登录
	 */
	@IgnoreAuth
	@RequestMapping(value = "/login")
	public R login(String username, String password, String captcha, HttpServletRequest request) {
		ZixunshiEntity u = zixunshiService.selectOne(new EntityWrapper<ZixunshiEntity>().eq("zixunshizhanghao", username));
        if(u==null || !u.getMima().equals(password)) {
            return R.error("账号或密码不正确");
        }
        if(!"是".equals(u.getSfsh())) return R.error("账号已锁定，请联系管理员审核。");
		String token = tokenService.generateToken(u.getId(), username,"zixunshi",  "管理员" );
		return R.ok().put("token", token);
	}


	
	/**
     * 注册
     */
	@IgnoreAuth
    @RequestMapping("/register")
    public R register(@RequestBody ZixunshiEntity zixunshi){
    	//ValidatorUtils.validateEntity(zixunshi);
                            ZixunshiEntity u = zixunshiService.selectOne(new EntityWrapper<ZixunshiEntity>().eq("zixunshizhanghao", zixunshi.getZixunshizhanghao()));
                                                                                                                                                		if(u!=null) {
			return R.error("注册用户已存在");
		}
		Long uId = new Date().getTime();
		zixunshi.setId(uId);
        zixunshiService.insert(zixunshi);
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
        return R.ok().put("data", zixunshiService.selectView(new EntityWrapper<ZixunshiEntity>().eq("id", id)));
    }
    
    /**
     * 密码重置
     */
    @IgnoreAuth
	@RequestMapping(value = "/resetPass")
    public R resetPass(String username, HttpServletRequest request){
    	ZixunshiEntity u = zixunshiService.selectOne(new EntityWrapper<ZixunshiEntity>().eq("zixunshizhanghao", username));
    	if(u==null) {
    		return R.error("账号不存在");
    	}
        u.setMima("123456");
        zixunshiService.updateById(u);
        return R.ok("密码已重置为：123456");
    }






    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ZixunshiEntity zixunshi,
                                                                                                                                                                                                    HttpServletRequest request){
                                    EntityWrapper<ZixunshiEntity> ew = new EntityWrapper<ZixunshiEntity>();
                                                                                                                                                                                                                                                                                                                
        
        
        PageUtils page = zixunshiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zixunshi), params), params));
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ZixunshiEntity zixunshi,
		HttpServletRequest request){
        EntityWrapper<ZixunshiEntity> ew = new EntityWrapper<ZixunshiEntity>();

		PageUtils page = zixunshiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zixunshi), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ZixunshiEntity zixunshi){
       	EntityWrapper<ZixunshiEntity> ew = new EntityWrapper<ZixunshiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( zixunshi, "zixunshi")); 
        return R.ok().put("data", zixunshiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ZixunshiEntity zixunshi){
        EntityWrapper< ZixunshiEntity> ew = new EntityWrapper< ZixunshiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( zixunshi, "zixunshi")); 
		ZixunshiView zixunshiView =  zixunshiService.selectView(ew);
		return R.ok("查询咨询师成功").put("data", zixunshiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ZixunshiEntity zixunshi = zixunshiService.selectById(id);
		zixunshi = zixunshiService.selectView(new EntityWrapper<ZixunshiEntity>().eq("id", id));
        return R.ok().put("data", zixunshi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ZixunshiEntity zixunshi = zixunshiService.selectById(id);
		zixunshi = zixunshiService.selectView(new EntityWrapper<ZixunshiEntity>().eq("id", id));
        return R.ok().put("data", zixunshi);
    }
    


    /**
     * 赞或踩
     */
    @RequestMapping("/thumbsup/{id}")
    public R vote(@PathVariable("id") String id,String type){
        ZixunshiEntity zixunshi = zixunshiService.selectById(id);
        if(type.equals("1")) {
        	zixunshi.setThumbsupNumber(zixunshi.getThumbsupNumber()+1);
        } else {
        	zixunshi.setCrazilyNumber(zixunshi.getCrazilyNumber()+1);
        }
        zixunshiService.updateById(zixunshi);
        return R.ok("投票成功");
    }

    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody ZixunshiEntity zixunshi, HttpServletRequest request){
        if(zixunshiService.selectCount(new EntityWrapper<ZixunshiEntity>().eq("zixunshizhanghao", zixunshi.getZixunshizhanghao()))>0) {
            return R.error("咨询师账号已存在");
        }
    	zixunshi.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(zixunshi);
        ZixunshiEntity u = zixunshiService.selectOne(new EntityWrapper<ZixunshiEntity>().eq("zixunshizhanghao", zixunshi.getZixunshizhanghao()));
		if(u!=null) {
			return R.error("用户已存在");
		}
		zixunshi.setId(new Date().getTime());
        zixunshiService.insert(zixunshi);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody ZixunshiEntity zixunshi, HttpServletRequest request){
        if(zixunshiService.selectCount(new EntityWrapper<ZixunshiEntity>().eq("zixunshizhanghao", zixunshi.getZixunshizhanghao()))>0) {
            return R.error("咨询师账号已存在");
        }
    	zixunshi.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(zixunshi);
        ZixunshiEntity u = zixunshiService.selectOne(new EntityWrapper<ZixunshiEntity>().eq("zixunshizhanghao", zixunshi.getZixunshizhanghao()));
		if(u!=null) {
			return R.error("用户已存在");
		}
		zixunshi.setId(new Date().getTime());
        zixunshiService.insert(zixunshi);
        return R.ok();
    }



    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    public R update(@RequestBody ZixunshiEntity zixunshi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(zixunshi);
        zixunshiService.updateById(zixunshi);//全部更新
        return R.ok();
    }

    /**
     * 审核
     */
    @RequestMapping("/shBatch")
    @Transactional
    public R update(@RequestBody Long[] ids, @RequestParam String sfsh, @RequestParam String shhf){
        List<ZixunshiEntity> list = new ArrayList<ZixunshiEntity>();
        for(Long id : ids) {
            ZixunshiEntity zixunshi = zixunshiService.selectById(id);
            zixunshi.setSfsh(sfsh);
            zixunshi.setShhf(shhf);
            list.add(zixunshi);
        }
        zixunshiService.updateBatchById(list);
        return R.ok();
    }


    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        zixunshiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
	









}
