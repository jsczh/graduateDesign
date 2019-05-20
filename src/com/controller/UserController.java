package com.controller;



import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bean.Address;
import com.bean.Color;
import com.bean.Commodity;
import com.bean.CommodityType;
import com.bean.Order;
import com.bean.Shop;
import com.bean.ShoppingCart;
import com.bean.ShoppingCartConcrete;
import com.bean.ShoppingCartShopSet;
import com.bean.ShoppingRecord;
import com.bean.ShowOrder;
import com.bean.ShowSellerOrder;
import com.bean.Size;
import com.bean.Transaction;
import com.bean.User;
import com.service.AddressService;
import com.service.ColorService;
import com.service.CommodityService;
import com.service.CommodityTypeService;
import com.service.OrderService;
import com.service.ShopService;
import com.service.ShoppingCartService;
import com.service.ShoppingRecordService;
import com.service.SizeService;
import com.service.TransactionService;
import com.service.UserService;

@Controller
@RequestMapping("user.action")
public class UserController {
	@Autowired
	@Qualifier("userService")
	UserService userService;
	
	@Autowired
	@Qualifier("colorService")
	ColorService colorService;
	
	@Autowired
	@Qualifier("sizeService")
	SizeService sizeService;
	
	@Autowired
	@Qualifier("commodityService")
	CommodityService commodityService;
	
	@Autowired
	@Qualifier("commodityTypeService")
	CommodityTypeService commodityTypeService;
	
	@Autowired
	@Qualifier("addressService")
	AddressService addressService;
	
	@Autowired
	@Qualifier("shopService")
	ShopService shopService;
	
	@Autowired
	@Qualifier("orderService")
	OrderService orderService;
	
	@Autowired
	@Qualifier("transactionService")
	TransactionService transactionService;
	
	@Autowired
	@Qualifier("shoppingCartService")
	ShoppingCartService shoppingCartService;
	
	@Autowired
	@Qualifier("shoppingRecordService")
	ShoppingRecordService shoppingRecordService;
	
	@RequestMapping(params="checkUsernameExist")
	@ResponseBody
	public String checkUsernameExist(String username){		
		User user = userService.selectByUsername(username);	
		if(user==null)
			return "success";
		else 
			return "error";
	}
	
	@RequestMapping(params="checkEmailExist")
	@ResponseBody
	public String checkEmailExist(String email){		
		User user = userService.selectByEmail(email);	
		if(user==null)
			return "success";
		else 
			return "error";
	}
	
	@RequestMapping(params="checkNicknameExist")
	@ResponseBody
	public String checkNicknameExist(String nickname){		
		
		User user = userService.selectByNickname(nickname);	
		if(user==null)
			return "success";
		else 
			return "error";
	}
	
	@RequestMapping(params="login")
	public String login(HttpServletRequest request){
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		
		
		User user1 = userService.login(user);
		if(user1!=null)
		{
			request.getSession().setAttribute("user",user1);
			return "forward:/commodity.action?showCommodityRandom4";
		}
		return "forward:/login.jsp";
	}
	
	@RequestMapping(params="updateEmail")
	public String updateEmail(HttpServletRequest request){
		String email = request.getParameter("email");
		User user = (User)request.getSession().getAttribute("user");
		user.setEmail(email);
		userService.updateByPrimaryKeySelective(user);
		
		return "forward:/information.jsp";
	}

	@RequestMapping(params="insertUser")
	public String insertUser(User user){
		userService.insertSelective(user);
		user = userService.selectByUsername(user.getUsername());
		return "forward:/login.jsp";
	}
	
	@RequestMapping(params="selectByNickname")
	public String selectByNickname(HttpServletRequest request){
		String nickname = request.getParameter("nickname");
		User user = userService.selectByNickname(nickname);
		if(user == null)
			return "success";
		return "error";
	}
	
	@RequestMapping(params="myOrder")
	public String myOrder(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		List<ShoppingRecord> shoppingRecord = shoppingRecordService.selectByUserIdOrderByFinishTime(user.getId());
		List<Order> order = new ArrayList<Order>();
		List<Transaction> transaction = new ArrayList<Transaction>();
		for(int i=0;i<shoppingRecord.size();i++){
			order.add(orderService.selectByPrimaryKey(shoppingRecord.get(i).getOrderid()));
		}
		for(int i=0;i<order.size();i++){
			transaction.add(transactionService.selectByPrimaryKey(order.get(i).getTransactionid()));
		}
		List<ShowOrder> showOrder = new ArrayList<ShowOrder>();
		for(int i=0;i<shoppingRecord.size();i++){
			if("已收货".equals(order.get(i).getState())){
				ShowOrder show  = new ShowOrder();
				Commodity commodity = commodityService.selectByPrimaryKey(transaction.get(i).getCommodityid());
				show.setCommodityId(commodity.getId());
				show.setCommodityname(commodity.getCommodityname());
				show.setCommoditypic(commodity.getCommoditypic());
				show.setPrice(commodity.getPrice());
				show.setNumber(transaction.get(i).getNumber());
				show.setTotalPrice(order.get(i).getTotalprice());
				show.setState(order.get(i).getState());
				show.setOrderId(order.get(i).getId());
				
				Integer id = transaction.get(i).getCommoditytypeid();
				if(id!=null){
					CommodityType type = commodityTypeService.selectByPrimaryKey(id);
					Integer colorid = type.getColorid();
					if(colorid!=null){
						String color = colorService.selectByPrimaryKey(colorid).getColor();
						show.setColor(color);
					}
					Integer sizeid = type.getSizeid();
					if(sizeid!=null){
						String size = sizeService.selectByPrimaryKey(sizeid).getSize();
						show.setSize(size);
					}
				}
				
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				show.setFinishtime(format.format(shoppingRecord.get(i).getFinishtime()));
				showOrder.add(show);
			}
		}
		request.getSession().setAttribute("showOrder", showOrder);
		return "forward:/show_order.jsp";
	}
	
	@RequestMapping(params="orderToBeSent")
	public String orderToBeSent(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		List<ShoppingRecord> shoppingRecord = shoppingRecordService.selectByUserIdOrderByFinishTime(user.getId());
		List<Order> order = new ArrayList<Order>();
		List<Transaction> transaction = new ArrayList<Transaction>();
		for(int i=0;i<shoppingRecord.size();i++){
			order.add(orderService.selectByPrimaryKey(shoppingRecord.get(i).getOrderid()));
		}
		for(int i=0;i<order.size();i++){
			transaction.add(transactionService.selectByPrimaryKey(order.get(i).getTransactionid()));
		}
		List<ShowOrder> showOrder = new ArrayList<ShowOrder>();
		for(int i=0;i<shoppingRecord.size();i++){
			if("已付款".equals(order.get(i).getState())){
				ShowOrder show  = new ShowOrder();
				Commodity commodity = commodityService.selectByPrimaryKey(transaction.get(i).getCommodityid());
				show.setCommodityId(commodity.getId());
				show.setCommodityname(commodity.getCommodityname());
				show.setCommoditypic(commodity.getCommoditypic());
				show.setPrice(commodity.getPrice());
				show.setNumber(transaction.get(i).getNumber());
				show.setTotalPrice(order.get(i).getTotalprice());
				show.setState(order.get(i).getState());
				show.setOrderId(order.get(i).getId());
				
				Integer id = transaction.get(i).getCommoditytypeid();
				if(id!=null){
					CommodityType type = commodityTypeService.selectByPrimaryKey(id);
					Integer colorid = type.getColorid();
					if(colorid!=null){
						String color = colorService.selectByPrimaryKey(colorid).getColor();
						show.setColor(color);
					}
					Integer sizeid = type.getSizeid();
					if(sizeid!=null){
						String size = sizeService.selectByPrimaryKey(sizeid).getSize();
						show.setSize(size);
					}
				}
				
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				show.setFinishtime(format.format(shoppingRecord.get(i).getFinishtime()));
				showOrder.add(show);
			}
		}
		request.getSession().setAttribute("showOrder", showOrder);
		return "forward:/show_order.jsp";
	}
	
	@RequestMapping(params="orderToBeReceived")
	public String orderToBeReceived(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		List<ShoppingRecord> shoppingRecord = shoppingRecordService.selectByUserIdOrderByFinishTime(user.getId());
		List<Order> order = new ArrayList<Order>();
		List<Transaction> transaction = new ArrayList<Transaction>();
		for(int i=0;i<shoppingRecord.size();i++){
			order.add(orderService.selectByPrimaryKey(shoppingRecord.get(i).getOrderid()));
		}
		for(int i=0;i<order.size();i++){
			transaction.add(transactionService.selectByPrimaryKey(order.get(i).getTransactionid()));
		}
		List<ShowOrder> showOrder = new ArrayList<ShowOrder>();
		for(int i=0;i<shoppingRecord.size();i++){
			if("已发货".equals(order.get(i).getState())){
				ShowOrder show  = new ShowOrder();
				Commodity commodity = commodityService.selectByPrimaryKey(transaction.get(i).getCommodityid());
				show.setCommodityId(commodity.getId());
				show.setCommodityname(commodity.getCommodityname());
				show.setCommoditypic(commodity.getCommoditypic());
				show.setPrice(commodity.getPrice());
				show.setNumber(transaction.get(i).getNumber());
				show.setTotalPrice(order.get(i).getTotalprice());
				show.setState(order.get(i).getState());
				show.setOrderId(order.get(i).getId());
				
				Integer id = transaction.get(i).getCommoditytypeid();
				if(id!=null){
					CommodityType type = commodityTypeService.selectByPrimaryKey(id);
					Integer colorid = type.getColorid();
					if(colorid!=null){
						String color = colorService.selectByPrimaryKey(colorid).getColor();
						show.setColor(color);
					}
					Integer sizeid = type.getSizeid();
					if(sizeid!=null){
						String size = sizeService.selectByPrimaryKey(sizeid).getSize();
						show.setSize(size);
					}
				}
				
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				show.setFinishtime(format.format(shoppingRecord.get(i).getFinishtime()));
				showOrder.add(show);
			}
		}
		request.getSession().setAttribute("showOrder", showOrder);
		return "forward:/show_order.jsp";
	}
	
	@RequestMapping(params="sellerOrder")
	public String sellerOrder(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		
		List<Order> order = orderService.selectBySellerIdOrderByFinishTimeDESC(user.getSellerid());
		List<Transaction> transaction = new ArrayList<Transaction>();
		
		for(int i=0;i<order.size();i++){
			transaction.add(transactionService.selectByPrimaryKey(order.get(i).getTransactionid()));
		}
		
		List<ShowSellerOrder> showSellerOrder = new ArrayList<ShowSellerOrder>();
		for(int i=0;i<order.size();i++){
			if("已收货".equals(order.get(i).getState())){
				ShowSellerOrder show  = new ShowSellerOrder();
				Commodity commodity = commodityService.selectByPrimaryKey(transaction.get(i).getCommodityid());
				show.setCommodityId(commodity.getId());
				show.setCommodityname(commodity.getCommodityname());
				show.setCommoditypic(commodity.getCommoditypic());
				show.setPrice(commodity.getPrice());
				show.setNumber(transaction.get(i).getNumber());
				show.setTotalPrice(order.get(i).getTotalprice());
				show.setState(order.get(i).getState());
				show.setOrderId(order.get(i).getId());
				
				Integer id = transaction.get(i).getCommoditytypeid();
				if(id!=null){
					CommodityType type = commodityTypeService.selectByPrimaryKey(id);
					Integer colorid = type.getColorid();
					if(colorid!=null){
						String color = colorService.selectByPrimaryKey(colorid).getColor();
						show.setColor(color);
					}
					Integer sizeid = type.getSizeid();
					if(sizeid!=null){
						String size = sizeService.selectByPrimaryKey(sizeid).getSize();
						show.setSize(size);
					}
				}
				
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				show.setFinishtime(format.format(order.get(i).getFinishtime()));
				Address address = addressService.selectByPrimaryKey(order.get(i).getAddressid());
				show.setAddress(address.getAddress());
				show.setDetailAddress(address.getDetailaddress());
				show.setRecipient(address.getRecipient());
				show.setCellphone(address.getCellphone());
				
				showSellerOrder.add(show);
			}
		}
		
		request.getSession().setAttribute("showSellerOrder", showSellerOrder);
		return "forward:/seller_order.jsp";
	}
	
	@RequestMapping(params="sellerOrderToBeSent")
	public String sellerOrderToBeSent(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		
		List<Order> order = orderService.selectBySellerIdOrderByFinishTime(user.getSellerid());
		List<Transaction> transaction = new ArrayList<Transaction>();
		
		for(int i=0;i<order.size();i++){
			transaction.add(transactionService.selectByPrimaryKey(order.get(i).getTransactionid()));
		}
		
		List<ShowSellerOrder> showSellerOrder = new ArrayList<ShowSellerOrder>();
		for(int i=0;i<order.size();i++){
			if("已付款".equals(order.get(i).getState())){
				ShowSellerOrder show  = new ShowSellerOrder();
				Commodity commodity = commodityService.selectByPrimaryKey(transaction.get(i).getCommodityid());
				show.setCommodityId(commodity.getId());
				show.setCommodityname(commodity.getCommodityname());
				show.setCommoditypic(commodity.getCommoditypic());
				show.setPrice(commodity.getPrice());
				show.setNumber(transaction.get(i).getNumber());
				show.setTotalPrice(order.get(i).getTotalprice());
				show.setState(order.get(i).getState());
				show.setOrderId(order.get(i).getId());
				
				Integer id = transaction.get(i).getCommoditytypeid();
				if(id!=null){
					CommodityType type = commodityTypeService.selectByPrimaryKey(id);
					Integer colorid = type.getColorid();
					if(colorid!=null){
						String color = colorService.selectByPrimaryKey(colorid).getColor();
						show.setColor(color);
					}
					Integer sizeid = type.getSizeid();
					if(sizeid!=null){
						String size = sizeService.selectByPrimaryKey(sizeid).getSize();
						show.setSize(size);
					}
				}
				
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				show.setFinishtime(format.format(order.get(i).getFinishtime()));
				Address address = addressService.selectByPrimaryKey(order.get(i).getAddressid());
				show.setAddress(address.getAddress());
				show.setDetailAddress(address.getDetailaddress());
				show.setRecipient(address.getRecipient());
				show.setCellphone(address.getCellphone());
				
				showSellerOrder.add(show);
			}
		}
		request.getSession().setAttribute("showSellerOrder", showSellerOrder);
		return "forward:/seller_order.jsp";
	}
	
	@RequestMapping(params="sellerOrderToBeReceived")
	public String sellerOrderToBeReceived(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		
		List<Order> order = orderService.selectBySellerIdOrderByFinishTime(user.getSellerid());
		List<Transaction> transaction = new ArrayList<Transaction>();
		
		for(int i=0;i<order.size();i++){
			transaction.add(transactionService.selectByPrimaryKey(order.get(i).getTransactionid()));
		}
		
		List<ShowSellerOrder> showSellerOrder = new ArrayList<ShowSellerOrder>();
		for(int i=0;i<order.size();i++){
			if("已发货".equals(order.get(i).getState())){
				ShowSellerOrder show  = new ShowSellerOrder();
				Commodity commodity = commodityService.selectByPrimaryKey(transaction.get(i).getCommodityid());
				show.setCommodityId(commodity.getId());
				show.setCommodityname(commodity.getCommodityname());
				show.setCommoditypic(commodity.getCommoditypic());
				show.setPrice(commodity.getPrice());
				show.setNumber(transaction.get(i).getNumber());
				show.setTotalPrice(order.get(i).getTotalprice());
				show.setState(order.get(i).getState());
				show.setOrderId(order.get(i).getId());
				
				Integer id = transaction.get(i).getCommoditytypeid();
				if(id!=null){
					CommodityType type = commodityTypeService.selectByPrimaryKey(id);
					Integer colorid = type.getColorid();
					if(colorid!=null){
						String color = colorService.selectByPrimaryKey(colorid).getColor();
						show.setColor(color);
					}
					Integer sizeid = type.getSizeid();
					if(sizeid!=null){
						String size = sizeService.selectByPrimaryKey(sizeid).getSize();
						show.setSize(size);
					}
				}
				
				DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				show.setFinishtime(format.format(order.get(i).getFinishtime()));
				Address address = addressService.selectByPrimaryKey(order.get(i).getAddressid());
				show.setAddress(address.getAddress());
				show.setDetailAddress(address.getDetailaddress());
				show.setRecipient(address.getRecipient());
				show.setCellphone(address.getCellphone());
				
				showSellerOrder.add(show);
			}
		}
		
		request.getSession().setAttribute("showSellerOrder", showSellerOrder);
		return "forward:/seller_order.jsp";
	}
	
	@RequestMapping(params="addIntoCart")
	public String addIntoCart(HttpServletRequest request){
		
		int commodityid = Integer.parseInt(request.getParameter("commodityid"));
		User user = (User)request.getSession().getAttribute("user");
		
		ShoppingCart shoppingCartIsExist = shoppingCartService.selectByCommodityIdAndUserId(commodityid,user.getId());
		
		if(shoppingCartIsExist==null){
		
			ShoppingCart shoppingCart = new ShoppingCart();
			
			//存用户ID
			shoppingCart.setUserid(user.getId());
			//存商品ID
			shoppingCart.setCommodityid(commodityid);
			//存商品价格
			Commodity commodity = commodityService.selectByPrimaryKey(commodityid);
			shoppingCart.setPrice(commodity.getPrice());
			//存店铺名
			Shop shop = shopService.selectByPrimaryKey(commodity.getShopid());
			shoppingCart.setShopname(shop.getShopname());
			
			//存购买数量
			int sale = Integer.parseInt(request.getParameter("sale"));
			shoppingCart.setNumber(sale);
					
			Integer typeid = null;
			if(request.getParameter("typeid")!=null&&!"".equals(request.getParameter("typeid")))
			{
				//存尺寸类别ID
				typeid = Integer.parseInt(request.getParameter("typeid"));
				shoppingCart.setCommoditytypeid(typeid);
			}
			
			shoppingCartService.insertSelective(shoppingCart);
		}
		else 
		{
			int sale = Integer.parseInt(request.getParameter("sale"));
			shoppingCartIsExist.setNumber(shoppingCartIsExist.getNumber()+sale);
			shoppingCartService.updateByPrimaryKey(shoppingCartIsExist);
		}	
			
		return "forward:/commodity.action?showCommodityRandom4";
	}
	
	//查询购物车
	@RequestMapping(params="selectShoppingCartByUserId")
	public String selectShoppingCartByUserId(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		List<ShoppingCart> shoppingCart = shoppingCartService.selectByUserIdOrderByShopName(user.getId());
		
		String shopname = "";
		List<ShoppingCartShopSet> shopSet = new ArrayList<ShoppingCartShopSet>();
		List<ShoppingCartConcrete> cartConcrete = new ArrayList<ShoppingCartConcrete>();
		for(int i = 0 ; i < shoppingCart.size() ; i ++){
			String nowname = shoppingCart.get(i).getShopname();
			if(!nowname.equals(shopname))
			{
				shopname = nowname;
				ShoppingCartShopSet shoppingCartShopSet = new ShoppingCartShopSet();
				shoppingCartShopSet.setShopname(shopname);
				shoppingCartShopSet.setShopid(i);
				shopSet.add(shoppingCartShopSet);
			}
			ShoppingCartConcrete shoppingCartConcrete = new ShoppingCartConcrete(); 
			Commodity commodity = commodityService.selectByPrimaryKey(shoppingCart.get(i).getCommodityid());
			shoppingCartConcrete.setCommodityname(commodity.getCommodityname());
			shoppingCartConcrete.setCommoditypic(commodity.getCommoditypic());
			shoppingCartConcrete.setNumber(shoppingCart.get(i).getNumber());
			shoppingCartConcrete.setPrice(shoppingCart.get(i).getPrice());
			shoppingCartConcrete.setShopname(shoppingCart.get(i).getShopname());
			shoppingCartConcrete.setCommodityid(commodity.getId());
			shoppingCartConcrete.setId(shoppingCart.get(i).getId());
			
			Integer type = shoppingCart.get(i).getCommoditytypeid();
			if(type!=null&&!"".equals(type))
			{
				CommodityType commodityType = commodityTypeService.selectByPrimaryKey(type);
				Color color;
				Size size = null;
				if(commodityType.getColorid()!=null)
				{
					color = colorService.selectByPrimaryKey(commodityType.getColorid());
					shoppingCartConcrete.setColor(color.getColor());
				}
				if(commodityType.getSizeid()!=null)
				{
					size = sizeService.selectByPrimaryKey(commodityType.getSizeid());
					shoppingCartConcrete.setSize(size.getSize());
				}
			}
			
			//存储购物车商品详细信息
			cartConcrete.add(shoppingCartConcrete);
			
		}
		List<Address> address = addressService.selectByUserId(user.getId());
		
		request.getSession().setAttribute("address", address);
		request.getSession().setAttribute("shopSet", shopSet);
		request.getSession().setAttribute("cartConcrete", cartConcrete);
		
		return "forward:/shopping_cart.jsp";
	}
	
	@RequestMapping(params="selectAddressAndGetOrder")
	public String selectAddressAndGetOrder(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		List<Address> address = addressService.selectByUserId(user.getId());
		request.getSession().setAttribute("address", address);
		
		int commodityid = Integer.parseInt(request.getParameter("commodityid"));
		int sale = Integer.parseInt(request.getParameter("sale"));
		Commodity commodity = commodityService.selectByPrimaryKey(commodityid);
		request.getSession().setAttribute("commodity", commodity);
		
		Integer typeid = null;
		Transaction transaction = new Transaction();
		if(request.getParameter("typeid")!=null&&!"".equals(request.getParameter("typeid")))
		{
			typeid = Integer.parseInt(request.getParameter("typeid"));
			CommodityType commodityType = commodityTypeService.selectByPrimaryKey(typeid);
			transaction.setCommoditytypeid(commodityType.getId());
			request.getSession().setAttribute("commodityType", commodityType);
			Color color = new Color();
			Size size = new Size();
			if(commodityType.getColorid()!=null)
				color = colorService.selectByPrimaryKey(commodityType.getColorid());
			if(commodityType.getSizeid()!=null)
				size = sizeService.selectByPrimaryKey(commodityType.getSizeid());
			request.getSession().setAttribute("color",color);
			request.getSession().setAttribute("size",size);
		}
		
		
		transaction.setCommodityid(commodityid);
		transaction.setNumber(sale);
		request.getSession().setAttribute("transaction", transaction);
		

		Shop shop = (Shop)shopService.selectByPrimaryKey(commodity.getShopid());
		Order order = new Order();
		order.setSellerid(shop.getSellerid());
		order.setTotalprice(commodity.getPrice().multiply(new BigDecimal(sale)));
		request.getSession().setAttribute("order", order);
		
		return "forward:/show_address_order.jsp";
	}
	
	@RequestMapping(params="checkMoneyRemain")
	@ResponseBody
	public String checkMoneyRemain(HttpServletRequest request){
		String remain  = request.getParameter("remain");
		String price = request.getParameter("price");

		if(new BigDecimal(remain).compareTo(new BigDecimal(price))>0)
			return "success";
		return "error";
	}
	
	@RequestMapping(params="checkRemain")
	@ResponseBody
	public String checkRemain(HttpServletRequest request){
		//判断库存是否足够
		Transaction transaction = (Transaction) request.getSession().getAttribute("transaction");
		Commodity commodity = (Commodity)request.getSession().getAttribute("commodity");
		CommodityType commodityType = (CommodityType)request.getSession().getAttribute("commodityType");
		if(commodityType!=null){
			if(commodityType.getRemain()<transaction.getNumber())
				return "error";
		}
		else if(commodity.getRemain()<transaction.getNumber())
			return "error";	
		return "success";		
	}
	
	
	//生成订单，更改shop成交量,更改商品库存(商品表/类型表)，更改用户余额，生成购物记录
	@RequestMapping(params="buyCommodity")
	public String buyCommodity(HttpServletRequest request){
		Transaction transaction = (Transaction) request.getSession().getAttribute("transaction");		
		transactionService.insertSelective(transaction);
		
		
		//取收货地址
		Integer addressid = Integer.parseInt(request.getParameter("addressid"));
		
		//订单存取收货地址，更改订单状态
		Order order = (Order) request.getSession().getAttribute("order");
		order.setAddressid(addressid);
		order.setState("已付款");
		int id = transaction.getId();
		order.setTransactionid(id);
		order.setFinishtime(new Timestamp(new Date().getTime()));
		orderService.insertSelective(order);
		
		//更改用户余额
		User user = (User)request.getSession().getAttribute("user");
		user.setMoney(user.getMoney().subtract(order.getTotalprice()));
		userService.updateByPrimaryKey(user);
		
		//用户确认收货后更改卖家余额
		
		
		//更改商品库存与销量
		Commodity commodity = (Commodity)request.getSession().getAttribute("commodity");
		CommodityType commodityType = (CommodityType)request.getSession().getAttribute("commodityType");
		if(commodityType!=null){
			commodityType.setRemain(commodityType.getRemain()-transaction.getNumber());
			commodityTypeService.updateByPrimaryKey(commodityType);
		}
		else
			commodity.setRemain(commodity.getRemain()-transaction.getNumber());
		commodity.setSales(commodity.getSales()+transaction.getNumber());
		commodityService.updateByPrimaryKey(commodity);
		
		//更改店铺销量及店铺升级判断
		Shop shop = shopService.selectByPrimaryKey(commodity.getShopid());
		shop.setSales(shop.getSales()+transaction.getNumber());
		if(shop.getSales()>10000)
			shop.setLevel(5);
		else if(shop.getSales()>1000)
			shop.setLevel(4);
		else if(shop.getSales()>100)
			shop.setLevel(3);
		else if(shop.getSales()>10)
			shop.setLevel(2);
		shopService.updateByPrimaryKey(shop);
		
		//生成购物记录
		ShoppingRecord shoppingRecord = new ShoppingRecord();
		shoppingRecord.setUserid(user.getId());
		shoppingRecord.setOrderid(order.getId());
		shoppingRecord.setFinishtime(new Timestamp(new Date().getTime()));
		shoppingRecord.setCommodityid(commodity.getId());
		shoppingRecordService.insertSelective(shoppingRecord);
		
		return "forward:/commodity.action?showCommodityRandom4";
	}
	
	//生成订单，更改shop成交量,更改商品库存(商品表/类型表)，更改用户余额，生成购物记录
	@RequestMapping(params="buyCommodityOverCart")
	@ResponseBody
	public String buyCommodityOverCart(HttpServletRequest request){
		
		User user = (User)request.getSession().getAttribute("user");
			
		//取收货地址
		Integer addressid = Integer.parseInt(request.getParameter("addressid"));
		
		
		int commodityid = Integer.parseInt(request.getParameter("commodityid"));
		Commodity commodity = commodityService.selectByPrimaryKey(commodityid);
		Shop shop = shopService.selectByPrimaryKey(commodity.getShopid());
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		String color1 = request.getParameter("color");
		String size1 = request.getParameter("size");
		
		
		BigDecimal cost = commodity.getPrice().multiply(new BigDecimal(num));
		
		if(num > commodity.getRemain())
			return "库存量不足";
		if(user.getMoney().compareTo(cost) < 0)
			return "用户余额不足";
		
		Transaction transaction =  new Transaction();
		//处理库存,销量
		if(color1==null&&size1==null){
			commodity.setRemain(commodity.getRemain()-num);
		}
		else{
			Integer color = null;
			Integer size = null;
			if(!"".equals(color1)&&color1!=null)
				color = colorService.selectByColor(color1).getId();
			if(!"".equals(size1)&&size1!=null)
				size = sizeService.selectBySize(size1).getId();
			
			CommodityType commodityType = 
			commodityTypeService.selectByCommodityIdAndColorIdAndSizeId(commodityid, color, size);
			
			commodityType.setRemain(commodityType.getRemain()-num);
			commodityTypeService.updateByPrimaryKey(commodityType);
			
			//交易信息存储尺寸ID
			transaction.setCommoditytypeid(commodityType.getId());
		}
		commodity.setSales(commodity.getSales()+num);
		commodityService.updateByPrimaryKey(commodity);
		
		
		transaction.setCommodityid(commodity.getId());
		transaction.setNumber(num);
		transactionService.insertSelective(transaction);
		
		//订单存取收货地址，更改订单状态
		Order order = new Order();
		order.setAddressid(addressid);
		order.setSellerid(shop.getSellerid());
		order.setState("已付款");
		order.setTotalprice(cost);
		
		order.setAddressid(addressid);
		order.setTransactionid(transaction.getId());
		order.setFinishtime(new Timestamp(new Date().getTime()));
		orderService.insertSelective(order);
			
		//更改用户余额
		user.setMoney(user.getMoney().subtract(cost));
		userService.updateByPrimaryKey(user);
		
		//用户确认收货后更改卖家余额
			
			
		//更改店铺销量及店铺升级判断
		shop.setSales(shop.getSales()+num);
		if(shop.getSales()>10000)
			shop.setLevel(5);
		else if(shop.getSales()>1000)
			shop.setLevel(4);
		else if(shop.getSales()>100)
			shop.setLevel(3);
		else if(shop.getSales()>10)
			shop.setLevel(2);
		shopService.updateByPrimaryKey(shop);
		
		//生成购物记录
		ShoppingRecord shoppingRecord = new ShoppingRecord();
		shoppingRecord.setUserid(user.getId());
		shoppingRecord.setOrderid(order.getId());
		shoppingRecord.setFinishtime(new Timestamp(new Date().getTime()));
		shoppingRecord.setCommodityid(commodity.getId());
		shoppingRecordService.insertSelective(shoppingRecord);
		
		//删除购物车商品
		shoppingCartService.deleteByCommodityIdAndUserId(commodity.getId(), user.getId());
		
		return "success";
	}
	
	
}
