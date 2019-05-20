package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Store;
import com.mapper.StoreMapper;
@Service("storeService")
public class StoreServiceImpl implements StoreService {

	@Autowired
	StoreMapper store;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return store.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Store record) {
		// TODO Auto-generated method stub
		return store.insert(record);
	}

	@Override
	public int insertSelective(Store record) {
		// TODO Auto-generated method stub
		return store.insertSelective(record);
	}

	@Override
	public Store selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return store.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Store record) {
		// TODO Auto-generated method stub
		return store.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Store record) {
		// TODO Auto-generated method stub
		return store.updateByPrimaryKey(record);
	}

}
