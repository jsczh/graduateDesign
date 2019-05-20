package com.mapper;

import java.util.List;

import com.bean.Shop;

public interface ShopMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Shop record);

    int insertSelective(Shop record);

    Shop selectByPrimaryKey(Integer id);
    
    Shop selectBySellerId(Integer id);
    
    Shop selectByShopName(String shopname);
    
    List<Shop> selectByVagueShopName(String shopname);

    int updateByPrimaryKeySelective(Shop record);

    int updateByPrimaryKey(Shop record);
}