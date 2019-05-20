package com.controller;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bean.Order;
import com.bean.Seller;
import com.bean.User;
import com.service.OrderService;
import com.service.SellerService;
import com.service.UserService;

@Controller
@RequestMapping("seller.action")
public class SellerController {
	@Autowired
	@Qualifier("sellerService")
	SellerService sellerService;
	
	@Autowired
	@Qualifier("userService")
	UserService userService;
	
	@Autowired
	@Qualifier("orderService")
	OrderService orderService;
	
	@RequestMapping(params="addSeller")
	public String addSeller(HttpServletRequest request){
		Seller seller = new Seller();
		seller.setRealname(request.getParameter("realname"));
		seller.setCellphone(request.getParameter("cellphone"));
		seller.setIdcard(request.getParameter("idCard"));
		seller.setMoney(BigDecimal.valueOf(0));
		sellerService.insertSelective(seller);
		
		seller = sellerService.selectByIdCard(request.getParameter("idCard"));
		User user = (User)request.getSession().getAttribute("user");
		user.setSellerid(seller.getId());
		request.getSession().setAttribute("user", user);
		userService.updateByPrimaryKey(user);
		
		request.getSession().setAttribute("seller", seller);
		
		return "forward:/information.jsp";
	}
	
	@RequestMapping(params="showSellerInfo")
	public String showSellerInfo(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		Integer id = user.getSellerid();
		Seller seller = new Seller();
		if(id!=null)
			seller = sellerService.selectByPrimaryKey(id);
		request.getSession().setAttribute("seller", seller);
		
		return "forward:/seller.jsp";
	}
	
	@RequestMapping(params="selectByNickname")
	@ResponseBody
	public String selectByNickname(String nickname){
		
		Seller seller = sellerService.selectByNickname(nickname);
		if(seller==null)
			return "success";
		else 
			return "error";
	}
	
	@RequestMapping(params="selectByIdCard")
	@ResponseBody
	public String selectByIdCard(String idCard){
		
		Seller seller = sellerService.selectByIdCard(idCard);
		if(seller==null)
			return "success";
		else 
			return "error";
	}
	
	@RequestMapping(params="sendCommodity")
	public String senfCommodity(HttpServletRequest request){
		int orderId = Integer.parseInt(request.getParameter("orderid"));
		Order order = orderService.selectByPrimaryKey(orderId);
		order.setState("已发货");
		orderService.updateByPrimaryKeySelective(order);
		return "forward:/order_manage.jsp";
	}
	
	@RequestMapping(params="receiveConfirm")
	public String receiveConfirm(HttpServletRequest request){
		int orderId = Integer.parseInt(request.getParameter("orderid"));
		Order order = orderService.selectByPrimaryKey(orderId);
		order.setState("已收货");
		orderService.updateByPrimaryKeySelective(order);
		Seller seller = sellerService.selectByPrimaryKey(order.getSellerid());
		seller.setMoney(seller.getMoney().add(order.getTotalprice()));
		sellerService.updateByPrimaryKeySelective(seller);
		return "forward:/order_info.jsp";
	}
}
