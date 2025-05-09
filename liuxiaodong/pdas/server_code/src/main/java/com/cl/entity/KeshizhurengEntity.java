package com.cl.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 科室主任
 * 数据库通用操作实体类（普通增删改查）
 */
@TableName("keshizhureng")
public class KeshizhurengEntity<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    public KeshizhurengEntity() {
    }

    public KeshizhurengEntity(T t) {
        try {
            BeanUtils.copyProperties(this, t);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    /**
     * 主键id
     */
    @TableId(type = IdType.AUTO)
    private Long id;
    /**
     * 账号
     */
    private String zhanghao;
    /**
     * 密码
     */
    private String mima;
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
     * 设置：密码
     */
    public void setMima(String mima) {
        this.mima = mima;
    }
    /**
     * 获取：密码
     */
    public String getMima() {
        return mima;
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