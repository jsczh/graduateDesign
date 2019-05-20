package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Order;
import com.mapper.OrderMapper;
@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderMapper orderMapper;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return orderMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Order record) {
		// TODO Auto-generated method stub
		return orderMapper.insert(record);
	}

	@Override
	public int insertSelective(Order record) {
		// TODO Auto-generated method stub
		return orderMapper.insertSelective(record);
	}

	@Override
	public Order selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return orderMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Order record) {
		// TODO Auto-generated method stub
		return orderMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Order record) {
		// TODO Auto-generated method stub
		return orderMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Order> selectBySellerIdOrderByFinishTime(Integer id) {
		// TODO Auto-generated method stub
		return orderMapper.selectBySellerIdOrderByFinishTime(id);
	}

	@Override
	public List<Order> selectBySellerIdOrderByFinishTimeDESC(Integer id) {
		// TODO Auto-generated method stub
		return orderMapper.selectBySellerIdOrderByFinishTimeDESC(id);
	}

}
