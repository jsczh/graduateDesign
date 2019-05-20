package com.service;

import com.bean.Seller;

public interface SellerService {
	int deleteByPrimaryKey(Integer id);

    int insert(Seller record);

    int insertSelective(Seller record);

    Seller selectByPrimaryKey(Integer id);
    
    Seller selectByIdCard(String id);
    
    Seller selectByNickname(String nickname);

    int updateByPrimaryKeySelective(Seller record);

    int updateByPrimaryKey(Seller record);

    
}
