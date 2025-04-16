package com.cl.dao;

import com.cl.entity.ChathelperEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ChathelperView;


/**
 * 聊天助手
 * 
 * @author 
 * @email 
 * @date 2025-03-22 12:42:21
 */
public interface ChathelperDao extends BaseMapper<ChathelperEntity> {
	
	List<ChathelperView> selectListView(@Param("ew") Wrapper<ChathelperEntity> wrapper);

	List<ChathelperView> selectListView(Pagination page,@Param("ew") Wrapper<ChathelperEntity> wrapper);
	
	ChathelperView selectView(@Param("ew") Wrapper<ChathelperEntity> wrapper);


}
