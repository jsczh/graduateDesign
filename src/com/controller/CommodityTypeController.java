package com.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bean.Color;
import com.bean.CommodityType;
import com.bean.Size;
import com.service.ColorService;
import com.service.CommodityTypeService;
import com.service.SizeService;

@Controller
@RequestMapping("commodityType.action")
public class CommodityTypeController {
	@Autowired
	@Qualifier("colorService")
	ColorService colorService;
	
	@Autowired
	@Qualifier("sizeService")
	SizeService sizeService;
	
	@Autowired
	@Qualifier("commodityTypeService")
	CommodityTypeService commodityTypeService;
	
	@RequestMapping(params="deleteCommodityType")
	public String deleteCommodityType(HttpServletRequest request){
		String id = request.getParameter("id");
		commodityTypeService.deleteByPrimaryKey(Integer.parseInt(id));
		return "forward:/information.jsp";
	}
	
	@RequestMapping(params="addCommodityType")
	public String addCommodityType(HttpServletRequest request){
		String commodityid = request.getParameter("commodityid");
		String color = request.getParameter("color");
		String size = request.getParameter("size");
		String remain = request.getParameter("remain");
		
		CommodityType type = new CommodityType();
		if(color!=null){
			Color color1 = new Color();
			color1.setColor(color);
			colorService.insertSelective(color1);
			type.setColorid(color1.getId());
		}
		
		if(size!=null){
			Size size1 = new Size();
			size1.setSize(size);
			sizeService.insertSelective(size1);
			type.setSizeid(size1.getId());
		}
			
		type.setCommodityid(Integer.parseInt(commodityid));
		type.setRemain(Integer.parseInt(remain));
		commodityTypeService.insertSelective(type);
		
		
		return "forward:/information.jsp";
	}
}
