package com.service;

import java.util.List;

import com.bean.Order;

public interface OrderService {
	int deleteByPrimaryKey(Integer id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Integer id);
    
    List<Order> selectBySellerIdOrderByFinishTime(Integer id);
    
    List<Order> selectBySellerIdOrderByFinishTimeDESC(Integer id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);
}
