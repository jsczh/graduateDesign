package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.CommodityType;
import com.mapper.CommodityTypeMapper;

@Service("commodityTypeService")
public class CommodityTypeServiceImpl implements CommodityTypeService {

	@Autowired
	CommodityTypeMapper commodityType;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commodityType.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(CommodityType record) {
		// TODO Auto-generated method stub
		return commodityType.insert(record);
	}

	@Override
	public int insertSelective(CommodityType record) {
		// TODO Auto-generated method stub
		return commodityType.insertSelective(record);
	}

	@Override
	public CommodityType selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commodityType.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(CommodityType record) {
		// TODO Auto-generated method stub
		return commodityType.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(CommodityType record) {
		// TODO Auto-generated method stub
		return commodityType.updateByPrimaryKey(record);
	}

	@Override
	public CommodityType selectByCommodityIdAndColorIdAndSizeId(Integer commodityId, Integer colorId, Integer sizeId) {
		// TODO Auto-generated method stub
		return commodityType.selectByCommodityIdAndColorIdAndSizeId(commodityId, colorId, sizeId);
	}

	@Override
	public List<CommodityType> selectByCommodityId(Integer id) {
		// TODO Auto-generated method stub
		return commodityType.selectByCommodityId(id);
	}

}
