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
 * 测试报告
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
@TableName("ceshibaogao")
public class CeshibaogaoEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public CeshibaogaoEntity() {
		
	}
	
	public CeshibaogaoEntity(T t) {
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
	 * 测试项目
	 */
					
	private String ceshixiangmu;
	
	/**
	 * 测试时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date ceshishijian;
	
	/**
	 * 测试报告
	 */
					
	private String ceshibaogao;
	
	/**
	 * 测试成绩
	 */
					
	private String ceshichengji;
	
	/**
	 * 身体机能评估
	 */
					
	private String shentijinengpinggu;
	
	/**
	 * 账号
	 */
					
	private String zhanghao;
	
	/**
	 * 姓名
	 */
					
	private String xingming;
	
	/**
	 * 性别
	 */
					
	private String xingbie;
	
	/**
	 * 报告时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date baogaoshijian;
	
	/**
	 * 咨询师账号
	 */
					
	private String zixunshizhanghao;
	
	/**
	 * 咨询师姓名
	 */
					
	private String zixunshixingming;
	

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
	 * 设置：测试项目
	 */
	public void setCeshixiangmu(String ceshixiangmu) {
		this.ceshixiangmu = ceshixiangmu;
	}
	/**
	 * 获取：测试项目
	 */
	public String getCeshixiangmu() {
		return ceshixiangmu;
	}
	/**
	 * 设置：测试时间
	 */
	public void setCeshishijian(Date ceshishijian) {
		this.ceshishijian = ceshishijian;
	}
	/**
	 * 获取：测试时间
	 */
	public Date getCeshishijian() {
		return ceshishijian;
	}
	/**
	 * 设置：测试报告
	 */
	public void setCeshibaogao(String ceshibaogao) {
		this.ceshibaogao = ceshibaogao;
	}
	/**
	 * 获取：测试报告
	 */
	public String getCeshibaogao() {
		return ceshibaogao;
	}
	/**
	 * 设置：测试成绩
	 */
	public void setCeshichengji(String ceshichengji) {
		this.ceshichengji = ceshichengji;
	}
	/**
	 * 获取：测试成绩
	 */
	public String getCeshichengji() {
		return ceshichengji;
	}
	/**
	 * 设置：身体机能评估
	 */
	public void setShentijinengpinggu(String shentijinengpinggu) {
		this.shentijinengpinggu = shentijinengpinggu;
	}
	/**
	 * 获取：身体机能评估
	 */
	public String getShentijinengpinggu() {
		return shentijinengpinggu;
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
	 * 设置：姓名
	 */
	public void setXingming(String xingming) {
		this.xingming = xingming;
	}
	/**
	 * 获取：姓名
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
	 * 设置：报告时间
	 */
	public void setBaogaoshijian(Date baogaoshijian) {
		this.baogaoshijian = baogaoshijian;
	}
	/**
	 * 获取：报告时间
	 */
	public Date getBaogaoshijian() {
		return baogaoshijian;
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
	 * 设置：咨询师姓名
	 */
	public void setZixunshixingming(String zixunshixingming) {
		this.zixunshixingming = zixunshixingming;
	}
	/**
	 * 获取：咨询师姓名
	 */
	public String getZixunshixingming() {
		return zixunshixingming;
	}

}
