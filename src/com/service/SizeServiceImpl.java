package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Size;
import com.mapper.SizeMapper;

@Service("sizeService")
public class SizeServiceImpl implements SizeService {

	@Autowired
	SizeMapper sizeMapper;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return sizeMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Size record) {
		// TODO Auto-generated method stub
		return sizeMapper.insert(record);
	}

	@Override
	public int insertSelective(Size record) {
		// TODO Auto-generated method stub
		return sizeMapper.insertSelective(record);
	}

	@Override
	public Size selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return sizeMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Size record) {
		// TODO Auto-generated method stub
		return sizeMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Size record) {
		// TODO Auto-generated method stub
		return sizeMapper.updateByPrimaryKey(record);
	}

	@Override
	public Size selectBySize(String size) {
		// TODO Auto-generated method stub
		return sizeMapper.selectBySize(size);
	}

}
