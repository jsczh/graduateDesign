package com.service;

import com.bean.Color;

public interface ColorService {
	int deleteByPrimaryKey(Integer id);

    int insert(Color record);

    int insertSelective(Color record);

    Color selectByPrimaryKey(Integer id);
    
    Color selectByColor(String color);

    int updateByPrimaryKeySelective(Color record);

    int updateByPrimaryKey(Color record);
}
