package com.cl.entity.view;

import com.cl.entity.GaopinggongjuEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 高评工具
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-03-22 12:42:20
 */
@TableName("gaopinggongju")
public class GaopinggongjuView  extends GaopinggongjuEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public GaopinggongjuView(){
	}
 
 	public GaopinggongjuView(GaopinggongjuEntity gaopinggongjuEntity){
 	try {
			BeanUtils.copyProperties(this, gaopinggongjuEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
