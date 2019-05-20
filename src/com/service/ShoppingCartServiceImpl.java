package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.bean.ShoppingCart;
import com.mapper.ShoppingCartMapper;
@Service("shoppingCartService")
public class ShoppingCartServiceImpl implements ShoppingCartService {

	@Autowired
	ShoppingCartMapper shoppingCartMapper;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ShoppingCart record) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.insert(record);
	}

	@Override
	public int insertSelective(ShoppingCart record) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.insertSelective(record);
	}

	@Override
	public ShoppingCart selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ShoppingCart record) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ShoppingCart record) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<ShoppingCart> selectByUserIdOrderByShopName(Integer id) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.selectByUserIdOrderByShopName(id);
	}

	@Override
	public ShoppingCart selectByCommodityIdAndUserId(Integer commodityid, Integer userid) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.selectByCommodityIdAndUserId(commodityid, userid);
	}

	@Override
	public int deleteByCommodityIdAndUserId(Integer commodityid, Integer userid) {
		// TODO Auto-generated method stub
		return shoppingCartMapper.deleteByCommodityIdAndUserId(commodityid, userid);
	}

}
