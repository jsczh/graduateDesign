package com.mapper;

import com.bean.Color;

public interface ColorMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Color record);

    int insertSelective(Color record);

    Color selectByPrimaryKey(Integer id);
    
    Color selectByColor(String color);

    int updateByPrimaryKeySelective(Color record);

    int updateByPrimaryKey(Color record);
}