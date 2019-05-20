package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Color;
import com.mapper.ColorMapper;
@Service("colorService")
public class ColorServiceImpl implements ColorService {

	@Autowired
	ColorMapper colorMapper;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return colorMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Color record) {
		// TODO Auto-generated method stub
		return colorMapper.insert(record);
	}

	@Override
	public int insertSelective(Color record) {
		// TODO Auto-generated method stub
		return colorMapper.insertSelective(record);
	}

	@Override
	public Color selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return colorMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Color record) {
		// TODO Auto-generated method stub
		return colorMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Color record) {
		// TODO Auto-generated method stub
		return colorMapper.updateByPrimaryKey(record);
	}

	@Override
	public Color selectByColor(String color) {
		// TODO Auto-generated method stub
		return colorMapper.selectByColor(color);
	}

}
