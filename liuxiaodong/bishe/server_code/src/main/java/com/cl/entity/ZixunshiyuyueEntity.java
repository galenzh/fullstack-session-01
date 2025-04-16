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
 * 咨询师预约
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@TableName("zixunshiyuyue")
public class ZixunshiyuyueEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public ZixunshiyuyueEntity() {
		
	}
	
	public ZixunshiyuyueEntity(T t) {
		try {
			BeanUtils.copyProperties(this, t);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 主键id
	 */
	@TableId(type = IdType.AUTO)
	private Long id;
	/**
	 * 预约编号
	 */
					
	private String yuyuebianhao;
	
	/**
	 * 咨询师账号
	 */
					
	private String zixunshizhanghao;
	
	/**
	 * 联系方式
	 */
					
	private String lianxifangshi;
	
	/**
	 * 预约时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date yuyueshijian;
	
	/**
	 * 账号
	 */
					
	private String zhanghao;
	
	/**
	 * 手机
	 */
					
	private String shouji;
	
	/**
	 * 预约咨询时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat 		
	private Date yuyuezixunshijian;
	
	/**
	 * 预约备注
	 */
					
	private String yuyuebeizhu;
	
	/**
	 * 是否审核
	 */
					
	private String sfsh;
	
	/**
	 * 回复内容
	 */
					
	private String shhf;
	
	/**
	 * 预约时间段
	 */
	@TableField(value = "time_slot")
	private String timeSlot;
	
	/**
	 * 咨询时长(分钟)
	 */
	@TableField(value = "duration")
	private Integer duration;
	
	/**
	 * 预约状态(待确认/已确认/已完成/已取消)
	 */
	@TableField(value = "status")
	private String status;
	

	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * 设置：预约编号
	 */
	public void setYuyuebianhao(String yuyuebianhao) {
		this.yuyuebianhao = yuyuebianhao;
	}
	/**
	 * 获取：预约编号
	 */
	public String getYuyuebianhao() {
		return yuyuebianhao;
	}
	/**
	 * 设置：咨询师账号
	 */
	public void setZixunshizhanghao(String zixunshizhanghao) {
		this.zixunshizhanghao = zixunshizhanghao;
	}
	/**
	 * 获取：咨询师账号
	 */
	public String getZixunshizhanghao() {
		return zixunshizhanghao;
	}
	/**
	 * 设置：联系方式
	 */
	public void setLianxifangshi(String lianxifangshi) {
		this.lianxifangshi = lianxifangshi;
	}
	/**
	 * 获取：联系方式
	 */
	public String getLianxifangshi() {
		return lianxifangshi;
	}
	/**
	 * 设置：预约时间
	 */
	public void setYuyueshijian(Date yuyueshijian) {
		this.yuyueshijian = yuyueshijian;
	}
	/**
	 * 获取：预约时间
	 */
	public Date getYuyueshijian() {
		return yuyueshijian;
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
	 * 设置：预约咨询时间
	 */
	public void setYuyuezixunshijian(Date yuyuezixunshijian) {
		this.yuyuezixunshijian = yuyuezixunshijian;
	}
	/**
	 * 获取：预约咨询时间
	 */
	public Date getYuyuezixunshijian() {
		return yuyuezixunshijian;
	}
	/**
	 * 设置：预约备注
	 */
	public void setYuyuebeizhu(String yuyuebeizhu) {
		this.yuyuebeizhu = yuyuebeizhu;
	}
	/**
	 * 获取：预约备注
	 */
	public String getYuyuebeizhu() {
		return yuyuebeizhu;
	}
	/**
	 * 设置：是否审核
	 */
	public void setSfsh(String sfsh) {
		this.sfsh = sfsh;
	}
	/**
	 * 获取：是否审核
	 */
	public String getSfsh() {
		return sfsh;
	}
	/**
	 * 设置：回复内容
	 */
	public void setShhf(String shhf) {
		this.shhf = shhf;
	}
	/**
	 * 获取：回复内容
	 */
	public String getShhf() {
		return shhf;
	}

	/**
	 * 设置：预约时间段
	 */
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	/**
	 * 获取：预约时间段
	 */
	public String getTimeSlot() {
		return timeSlot;
	}
	
	/**
	 * 设置：咨询时长
	 */
	public void setDuration(Integer duration) {
		this.duration = duration;
	}
	/**
	 * 获取：咨询时长
	 */
	public Integer getDuration() {
		return duration;
	}
	
	/**
	 * 设置：预约状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * 获取：预约状态
	 */
	public String getStatus() {
		return status;
	}
	
	/**
	 * 设置：备注
	 */
	public void setBeizhu(String beizhu) {
		this.yuyuebeizhu = beizhu;
	}
	/**
	 * 获取：备注
	 */
	public String getBeizhu() {
		return yuyuebeizhu;
	}

}
