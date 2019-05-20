package com.mapper;

import java.util.List;

import com.bean.CommodityType;

public interface CommodityTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(CommodityType record);

    int insertSelective(CommodityType record);

    CommodityType selectByPrimaryKey(Integer id);
    
    CommodityType selectByCommodityIdAndColorIdAndSizeId(Integer commodityId,Integer colorId,Integer sizeId);

    List<CommodityType> selectByCommodityId(Integer id);
    
    int updateByPrimaryKeySelective(CommodityType record);

    int updateByPrimaryKey(CommodityType record);
}