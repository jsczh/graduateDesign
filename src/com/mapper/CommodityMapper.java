package com.mapper;

import java.util.List;

import com.bean.Commodity;

public interface CommodityMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Commodity record);

    int insertSelective(Commodity record);
    
    int selectCommodityNum(Integer id);

    Commodity selectByPrimaryKey(Integer id);
    
    Commodity selectByCommodityNameAndShopId(String commodityname,int shopid);
    
    List<Integer> selectAllCommodityId();
    
    List<Commodity> selectCommodityByType(String type);
    
    List<Commodity> selectCommodityByTypeRandom4(String type);
    
    List<Commodity> selectAllCommodityByShopId(Integer id);
    
    List<Commodity> selectCommodityPartly(Integer start,Integer count);
    
    List<Commodity> selectCommodityByVagueName(String name);
    
    List<Commodity> selectCommodityPartlyByShopId(Integer start,Integer count,Integer id);
    
    List<Commodity> selectCommodityPartlyByVagueName(Integer start,Integer count,String name);
    
    List<Commodity> selectCommodityByShopId(Integer id);

    int updateByPrimaryKeySelective(Commodity record);

    int updateByPrimaryKey(Commodity record);
}