package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.ShoppingRecord;
import com.mapper.ShoppingRecordMapper;

@Service("shoppingRecordService")
public class ShoppingRecordServiceImpl implements ShoppingRecordService {

	@Autowired
	ShoppingRecordMapper shoppingRecordMapper;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ShoppingRecord record) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.insert(record);
	}

	@Override
	public int insertSelective(ShoppingRecord record) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.insertSelective(record);
	}

	@Override
	public ShoppingRecord selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ShoppingRecord record) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ShoppingRecord record) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<ShoppingRecord> selectByUserIdOrderByFinishTime(Integer id) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.selectByUserIdOrderByFinishTime(id);
	}

	@Override
	public List<ShoppingRecord> selectByUserId(Integer id) {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.selectByUserId(id);
	}

	@Override
	public List<ShoppingRecord> selectAllRecord() {
		// TODO Auto-generated method stub
		return shoppingRecordMapper.selectAllRecord();
	}

}
