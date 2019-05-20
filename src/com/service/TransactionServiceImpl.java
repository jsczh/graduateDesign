package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Transaction;
import com.mapper.TransactionMapper;
@Service("transactionService")
public class TransactionServiceImpl implements TransactionService {

	@Autowired
	TransactionMapper transactionMapper;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return transactionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Transaction record) {
		// TODO Auto-generated method stub
		return transactionMapper.insert(record);
	}

	@Override
	public int insertSelective(Transaction record) {
		// TODO Auto-generated method stub
		return transactionMapper.insertSelective(record);
	}

	@Override
	public Transaction selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return transactionMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Transaction record) {
		// TODO Auto-generated method stub
		return transactionMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Transaction record) {
		// TODO Auto-generated method stub
		return transactionMapper.updateByPrimaryKey(record);
	}

}
