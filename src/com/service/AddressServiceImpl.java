package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Address;
import com.mapper.AddressMapper;

@Service("addressService")
public class AddressServiceImpl implements AddressService {

	@Autowired
	AddressMapper address;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return address.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Address record) {
		// TODO Auto-generated method stub
		return address.insert(record);
	}

	@Override
	public int insertSelective(Address record) {
		// TODO Auto-generated method stub
		return address.insertSelective(record);
	}

	@Override
	public Address selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return address.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Address record) {
		// TODO Auto-generated method stub
		return address.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Address record) {
		// TODO Auto-generated method stub
		return address.updateByPrimaryKey(record);
	}
	
	public List<Address> selectByUserId(Integer id){
		return address.selectByUserId(id);
	}
}
