package com.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bean.Commodity;
import com.bean.Seller;
import com.bean.Shop;
import com.bean.User;
import com.service.CommodityService;
import com.service.SellerService;
import com.service.ShopService;

@Controller
@RequestMapping("shop.action")
public class ShopController {
	@Autowired
	@Qualifier("shopService")
	ShopService shopService;
	
	@Autowired
	@Qualifier("sellerService")
	SellerService sellerService;
	
	@Autowired
	@Qualifier("commodityService")
	CommodityService commodityService;
	
	@RequestMapping(params="selectBySellerId")
	public String selectBySellerId(HttpServletRequest request,String url){
		User user = (User)request.getSession().getAttribute("user");

		Shop shop = (Shop)shopService.selectBySellerId(user.getSellerid());
		request.getSession().setAttribute("shop", shop);
		return "forward:/"+url;
	}
	
	@RequestMapping(params="addShop")
	public String addShop(Shop shop,HttpServletRequest request){
		shop.setSales(0);
		shop.setLevel(1);
		User user = (User)request.getSession().getAttribute("user");
		Seller seller = (Seller)sellerService.selectByPrimaryKey(user.getSellerid());
		seller.setNickname(request.getParameter("nickname"));
		shop.setSellerid(seller.getId());
		shopService.insertSelective(shop);
		sellerService.updateByPrimaryKey(seller);
		shop =  shopService.selectBySellerId(seller.getId());
		request.getSession().setAttribute("shop", shop);
		return "forward:/information.jsp";
	}
	
	@RequestMapping(params="selectAllCommodityByShopId")
	public String selectAllCommodityByShopId(HttpServletRequest request){
		Shop shop = (Shop)request.getSession().getAttribute("shop");
		List<Commodity> commodity = commodityService.selectAllCommodityByShopId(shop.getId());
		request.getSession().setAttribute("commodity", commodity);
		return "forward:/shop_manage.jsp";
	}
	@RequestMapping(params="selectByShopName")
	@ResponseBody
	public String selectByShopName(String shopname){
		
		Shop shop = shopService.selectByShopName(shopname);
		
		if(shop==null)
			return "success";
		else 
			return "error";
	}
	
	@RequestMapping(params="selectCommodityByShopname")
	public String selectCommodityByShopname(HttpServletRequest request){
		String name = request.getParameter("name");
		
		request.getSession().setAttribute("name", name);
		
		List<Shop> shop = shopService.selectByVagueShopName("%"+name+"%");
		
		List<Commodity> commoditySet = new ArrayList<Commodity>();
		for(int i = 0; i<shop.size(); i++)
		{
			List<Commodity> commodity = commodityService.selectAllCommodityByShopId(shop.get(i).getId());
			for(int j = 0; j<commodity.size(); j++)
				commoditySet.add(commodity.get(j));
		}

		request.getSession().setAttribute("commodity", commoditySet);
		return "forward:/search_page.jsp";
	}
}
