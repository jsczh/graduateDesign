package com.service;

import java.util.List;

import com.bean.Address;

public interface AddressService {
	int deleteByPrimaryKey(Integer id);

    int insert(Address record);

    int insertSelective(Address record);

    Address selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Address record);

    int updateByPrimaryKey(Address record);
    
    List<Address> selectByUserId(Integer id);
}
