package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Commodity;
import com.mapper.CommodityMapper;

@Service("commodityService")
public class CommodityServiceImpl implements CommodityService {

	@Autowired
	CommodityMapper commodity;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commodity.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Commodity record) {
		// TODO Auto-generated method stub
		return commodity.insert(record);
	}

	@Override
	public int insertSelective(Commodity record) {
		// TODO Auto-generated method stub
		return commodity.insertSelective(record);
	}

	@Override
	public Commodity selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return commodity.selectByPrimaryKey(id);
	}

	@Override
	public List<Commodity> selectAllCommodityByShopId(Integer id) {
		// TODO Auto-generated method stub
		return commodity.selectAllCommodityByShopId(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Commodity record) {
		// TODO Auto-generated method stub
		return commodity.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Commodity record) {
		// TODO Auto-generated method stub
		return commodity.updateByPrimaryKey(record);
	}

	@Override
	public Commodity selectByCommodityNameAndShopId(String commodityname, int shopid) {
		// TODO Auto-generated method stub
		return commodity.selectByCommodityNameAndShopId(commodityname, shopid);
	}

	@Override
	public List<Commodity> selectCommodityPartly(Integer start, Integer count) {
		// TODO Auto-generated method stub
		return commodity.selectCommodityPartly(start, count);
	}

	@Override
	public int selectCommodityNum(Integer id) {
		// TODO Auto-generated method stub
		return commodity.selectCommodityNum(id);
	}

	@Override
	public List<Commodity> selectCommodityPartlyByShopId(Integer start, Integer count, Integer id) {
		// TODO Auto-generated method stub
		return commodity.selectCommodityPartlyByShopId(start, count, id);
	}

	@Override
	public List<Commodity> selectCommodityByType(String type) {
		// TODO Auto-generated method stub
		return commodity.selectCommodityByType(type);
	}

	@Override
	public List<Commodity> selectCommodityByTypeRandom4(String type) {
		// TODO Auto-generated method stub
		return commodity.selectCommodityByTypeRandom4(type);
	}

	@Override
	public List<Commodity> selectCommodityByVagueName(String name) {
		// TODO Auto-generated method stub
		return commodity.selectCommodityByVagueName(name);
	}

	@Override
	public List<Commodity> selectCommodityPartlyByVagueName(Integer start, Integer count, String name) {
		// TODO Auto-generated method stub
		return commodity.selectCommodityPartlyByVagueName(start, count, name);
	}

	@Override
	public List<Integer> selectAllCommodityId() {
		// TODO Auto-generated method stub
		return commodity.selectAllCommodityId();
	}

}
