package com.cl.entity.view;

import com.cl.entity.CeshibaogaoEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 测试报告
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
@TableName("ceshibaogao")
public class CeshibaogaoView  extends CeshibaogaoEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public CeshibaogaoView(){
	}
 
 	public CeshibaogaoView(CeshibaogaoEntity ceshibaogaoEntity){
 	try {
			BeanUtils.copyProperties(this, ceshibaogaoEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
