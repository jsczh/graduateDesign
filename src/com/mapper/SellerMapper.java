package com.mapper;

import com.bean.Seller;

public interface SellerMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Seller record);

    int insertSelective(Seller record);

    Seller selectByPrimaryKey(Integer id);
    
    Seller selectByIdCard(String id);
    
    Seller selectByNickname(String nickname);

    int updateByPrimaryKeySelective(Seller record);

    int updateByPrimaryKey(Seller record);
}