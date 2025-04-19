package com.cl.entity.view;

import com.cl.entity.KeshizhurengEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
 
/**
 * 科室主任
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 */
@TableName("keshizhureng")
public class KeshizhurengView extends KeshizhurengEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    public KeshizhurengView(){
    }
 
    public KeshizhurengView(KeshizhurengEntity keshizhurengEntity){
        try {
            BeanUtils.copyProperties(this, keshizhurengEntity);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }
} 