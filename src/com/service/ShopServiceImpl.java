package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Shop;
import com.mapper.ShopMapper;

@Service("shopService")
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopMapper shop;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shop.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Shop record) {
		// TODO Auto-generated method stub
		return shop.insert(record);
	}

	@Override
	public int insertSelective(Shop record) {
		// TODO Auto-generated method stub
		return shop.insertSelective(record);
	}

	@Override
	public Shop selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shop.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Shop record) {
		// TODO Auto-generated method stub
		return shop.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Shop record) {
		// TODO Auto-generated method stub
		return shop.updateByPrimaryKey(record);
	}

	@Override
	public Shop selectBySellerId(Integer id) {
		// TODO Auto-generated method stub
		return shop.selectBySellerId(id);
	}

	@Override
	public Shop selectByShopName(String shopname) {
		// TODO Auto-generated method stub
		return shop.selectByShopName(shopname);
	}

	@Override
	public List<Shop> selectByVagueShopName(String shopname) {
		// TODO Auto-generated method stub
		return shop.selectByVagueShopName(shopname);
	}

}
