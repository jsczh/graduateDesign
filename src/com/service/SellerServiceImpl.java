package com.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Seller;
import com.mapper.SellerMapper;

@Service("sellerService")
public class SellerServiceImpl implements SellerService {

	@Autowired
	SellerMapper seller;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return seller.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Seller record) {
		// TODO Auto-generated method stub
		return seller.insert(record);
	}

	@Override
	public int insertSelective(Seller record) {
		// TODO Auto-generated method stub
		return seller.insertSelective(record);
	}

	@Override
	public Seller selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return seller.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Seller record) {
		// TODO Auto-generated method stub
		return seller.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Seller record) {
		// TODO Auto-generated method stub
		return seller.updateByPrimaryKey(record);
	}

	@Override
	public Seller selectByIdCard(String id) {
		// TODO Auto-generated method stub
		return seller.selectByIdCard(id);
	}

	@Override
	public Seller selectByNickname(String nickname) {
		// TODO Auto-generated method stub
		return seller.selectByNickname(nickname);
	}

}
