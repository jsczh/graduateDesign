package com.service;

import com.bean.Size;

public interface SizeService {
	int deleteByPrimaryKey(Integer id);

    int insert(Size record);

    int insertSelective(Size record);

    Size selectByPrimaryKey(Integer id);
    
    Size selectBySize(String size);

    int updateByPrimaryKeySelective(Size record);

    int updateByPrimaryKey(Size record);
}
