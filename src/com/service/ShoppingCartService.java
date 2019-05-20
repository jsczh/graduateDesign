package com.service;

import java.util.List;

import com.bean.ShoppingCart;

public interface ShoppingCartService {
	int deleteByPrimaryKey(Integer id);
	
	int deleteByCommodityIdAndUserId(Integer commodityid,Integer userid);

    int insert(ShoppingCart record);

    int insertSelective(ShoppingCart record);

    ShoppingCart selectByPrimaryKey(Integer id);
    
    List<ShoppingCart> selectByUserIdOrderByShopName(Integer id);
    
    ShoppingCart selectByCommodityIdAndUserId(Integer commodityid,Integer userid);

    int updateByPrimaryKeySelective(ShoppingCart record);

    int updateByPrimaryKey(ShoppingCart record);
}
