package com.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bean.Address;
import com.bean.User;
import com.service.AddressService;

@Controller
@RequestMapping("address.action")
public class AddressController {
	
	@Autowired
	@Qualifier("addressService")
	AddressService addressService;
	
	@RequestMapping(params="selectByUserId")
	public String selectByUserId(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("user");
		int userId = user.getId();
		System.out.println();
		List<Address> address = addressService.selectByUserId(userId);
		request.getSession().setAttribute("address",address);
		return "forward:/address.jsp";
	}
	
	@RequestMapping(params="addAddress")
	public String addAddress(Address address,HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		address.setUserid(user.getId());
		addressService.insertSelective(address);
		return "forward:/information.jsp";
	}
	
	@RequestMapping(params="updateAddress")
	public String updateAddress(HttpServletRequest request){
		Address address = new Address();
		User user = (User)request.getSession().getAttribute("user");
		address.setId(Integer.parseInt(request.getParameter("addressid")));
		address.setUserid(user.getId());
		address.setRecipient(request.getParameter("recipient"));
		address.setCellphone(request.getParameter("cellphone"));
		address.setAddress(request.getParameter("city"));
		address.setDetailaddress(request.getParameter("detailAddress"));
		address.setZipcode(request.getParameter("zipcode"));
		addressService.updateByPrimaryKeySelective(address);
		
		return "forward:/information.jsp";
	}
	
	@RequestMapping(params="deleteByAddressId")
	public String deleteByAddressId(HttpServletRequest request){
		int id = Integer.parseInt(request.getParameter("id"));
		Address address = addressService.selectByPrimaryKey(id);
		address.setUserid(-1);
		addressService.updateByPrimaryKeySelective(address);
		return "forward:/information.jsp";
	}
	
	@RequestMapping(params="selectByAddressId")
	@ResponseBody
	public Address selectByAddressId(HttpServletRequest request){
		int id = Integer.parseInt(request.getParameter("addressid"));
		Address address = addressService.selectByPrimaryKey(id);
		return address;
	}
}
