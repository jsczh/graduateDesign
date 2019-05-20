package com.service;

import java.util.List;

import com.bean.ShoppingRecord;

public interface ShoppingRecordService {
	int deleteByPrimaryKey(Integer id);

    int insert(ShoppingRecord record);

    int insertSelective(ShoppingRecord record);

    ShoppingRecord selectByPrimaryKey(Integer id);
    
    List<ShoppingRecord> selectByUserIdOrderByFinishTime(Integer id);
    
    List<ShoppingRecord> selectByUserId(Integer id);
    
    List<ShoppingRecord> selectAllRecord();

    int updateByPrimaryKeySelective(ShoppingRecord record);

    int updateByPrimaryKey(ShoppingRecord record);
}
