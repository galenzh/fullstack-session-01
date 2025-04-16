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
 * 高评工具
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@TableName("gaopinggongju")
public class GaopinggongjuEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public GaopinggongjuEntity() {
		
	}
	
	public GaopinggongjuEntity(T t) {
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
	 * 工具名称
	 */
					
	private String gongjumingcheng;
	
	/**
	 * 图片
	 */
					
	private String tupian;
	
	/**
	 * 详情
	 */
					
	private String xiangqing;
	
	/**
	 * 使用方法
	 */
					
	private String shiyongfangfa;
	
	/**
	 * 价格
	 */
					
	private Double price;
	
	/**
	 * 评论数
	 */
					
	private Integer discussNumber;
	

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
	 * 设置：工具名称
	 */
	public void setGongjumingcheng(String gongjumingcheng) {
		this.gongjumingcheng = gongjumingcheng;
	}
	/**
	 * 获取：工具名称
	 */
	public String getGongjumingcheng() {
		return gongjumingcheng;
	}
	/**
	 * 设置：图片
	 */
	public void setTupian(String tupian) {
		this.tupian = tupian;
	}
	/**
	 * 获取：图片
	 */
	public String getTupian() {
		return tupian;
	}
	/**
	 * 设置：详情
	 */
	public void setXiangqing(String xiangqing) {
		this.xiangqing = xiangqing;
	}
	/**
	 * 获取：详情
	 */
	public String getXiangqing() {
		return xiangqing;
	}
	/**
	 * 设置：使用方法
	 */
	public void setShiyongfangfa(String shiyongfangfa) {
		this.shiyongfangfa = shiyongfangfa;
	}
	/**
	 * 获取：使用方法
	 */
	public String getShiyongfangfa() {
		return shiyongfangfa;
	}
	/**
	 * 设置：价格
	 */
	public void setPrice(Double price) {
		this.price = price;
	}
	/**
	 * 获取：价格
	 */
	public Double getPrice() {
		return price;
	}
	/**
	 * 设置：评论数
	 */
	public void setDiscussNumber(Integer discussNumber) {
		this.discussNumber = discussNumber;
	}
	/**
	 * 获取：评论数
	 */
	public Integer getDiscussNumber() {
		return discussNumber;
	}

}
