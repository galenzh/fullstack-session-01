package com.cl.entity.vo;

import com.cl.entity.KeshizhurengEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
 
/**
 * 科室主任
 * 手机端接口返回实体辅助类 
 * （主要作用去除一些不必要的字段）
 */
public class KeshizhurengVO  implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    private Long id;
    
    /**
     * 账号
     */
    private String zhanghao;
    
    /**
     * 科室主任姓名
     */
    private String xingming;
    
    /**
     * 性别
     */
    private String xingbie;
    
    /**
     * 头像
     */
    private String touxiang;
    
    /**
     * 手机
     */
    private String shouji;
    
    /**
     * 邮箱
     */
    private String youxiang;
    
    /**
     * 科室
     */
    private String keshi;

    /**
     * 设置：主键id
     */
    public void setId(Long id) {
        this.id = id;
    }
    /**
     * 获取：主键id
     */
    public Long getId() {
        return id;
    }

    /**
     * 设置：账号
     */
    public void setZhanghao(String zhanghao) {
        this.zhanghao = zhanghao;
    }
    /**
     * 获取：账号
     */
    public String getZhanghao() {
        return zhanghao;
    }

    /**
     * 设置：科室主任姓名
     */
    public void setXingming(String xingming) {
        this.xingming = xingming;
    }
    /**
     * 获取：科室主任姓名
     */
    public String getXingming() {
        return xingming;
    }

    /**
     * 设置：性别
     */
    public void setXingbie(String xingbie) {
        this.xingbie = xingbie;
    }
    /**
     * 获取：性别
     */
    public String getXingbie() {
        return xingbie;
    }

    /**
     * 设置：头像
     */
    public void setTouxiang(String touxiang) {
        this.touxiang = touxiang;
    }
    /**
     * 获取：头像
     */
    public String getTouxiang() {
        return touxiang;
    }

    /**
     * 设置：手机
     */
    public void setShouji(String shouji) {
        this.shouji = shouji;
    }
    /**
     * 获取：手机
     */
    public String getShouji() {
        return shouji;
    }

    /**
     * 设置：邮箱
     */
    public void setYouxiang(String youxiang) {
        this.youxiang = youxiang;
    }
    /**
     * 获取：邮箱
     */
    public String getYouxiang() {
        return youxiang;
    }

    /**
     * 设置：科室
     */
    public void setKeshi(String keshi) {
        this.keshi = keshi;
    }
    /**
     * 获取：科室
     */
    public String getKeshi() {
        return keshi;
    }
} 