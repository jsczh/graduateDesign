package com.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.bean.Color;
import com.bean.Commodity;
import com.bean.CommodityType;
import com.bean.CommodityTypeConcrete;
import com.bean.Shop;
import com.bean.ShoppingRecord;
import com.bean.Size;
import com.bean.Store;
import com.bean.User;
import com.bean.UserCFSort;
import com.service.ColorService;
import com.service.CommodityService;
import com.service.CommodityTypeService;
import com.service.ShoppingRecordService;
import com.service.SizeService;
import com.service.StoreService;
import com.service.UserService;
import com.tool.Divide;

@Controller
@RequestMapping("commodity.action")
public class CommodityController {
	@Autowired
	@Qualifier("commodityService")
	CommodityService commodityService;
	
	@Autowired
	@Qualifier("shoppingRecordService")
	ShoppingRecordService shoppingRecordService;
	
	@Autowired
	@Qualifier("userService")
	UserService userService;
	
	@Autowired
	@Qualifier("sizeService")
	SizeService sizeService;
	
	@Autowired
	@Qualifier("colorService")
	ColorService colorService;
	
	@Autowired
	@Qualifier("storeService")
	StoreService storeService;
	
	@Autowired
	@Qualifier("commodityTypeService")
	CommodityTypeService commodityTypeService;
	
	@RequestMapping(params="selectByCommodityId")
	public String selectByCommodityId(HttpServletRequest request){
		int commodityid = Integer.parseInt(request.getParameter("commodityid"));
		Commodity commodity = commodityService.selectByPrimaryKey(commodityid);
		request.getSession().setAttribute("commodity", commodity);
		return "forward:/commodity_manage.jsp";
	}

	
	@RequestMapping(params="selectByCommodityIdUser")
	public String selectByCommodityIdUser(HttpServletRequest request){
		int commodityid = Integer.parseInt(request.getParameter("commodityid"));
		Commodity commodity = commodityService.selectByPrimaryKey(commodityid);
		request.getSession().setAttribute("commodity", commodity);
		
		List<CommodityType> commodityType = commodityTypeService.selectByCommodityId(commodityid);
		if(commodityType!=null){
			List<CommodityTypeConcrete> commodityTypeConcrete = new ArrayList<CommodityTypeConcrete>();
			for(int i = 0 ; i < commodityType.size() ; i++ )
			{		
				CommodityTypeConcrete concrete = new CommodityTypeConcrete();
				CommodityType type = commodityType.get(i);
				concrete.setRemain(type.getRemain());
				concrete.setCommodityTypeId(commodityType.get(i).getId());
				if(type.getColorid()!=null)
					concrete.setColor(colorService.selectByPrimaryKey(type.getColorid()).getColor());
				if(type.getSizeid()!=null)
					concrete.setSize(sizeService.selectByPrimaryKey(type.getSizeid()).getSize());
				commodityTypeConcrete.add(concrete);
			}
			request.getSession().setAttribute("commodityTypeConcrete", commodityTypeConcrete);
		}
		return "forward:/commodity_buy.jsp";
	}
	
	@RequestMapping(params="showCommodityRandom4")
	public String showCommodityRandom4(HttpServletRequest request){
		List<Commodity> clothes = commodityService.selectCommodityByTypeRandom4("%服装%");
		List<Commodity> book = commodityService.selectCommodityByTypeRandom4("%科技%");;
		List<Commodity> food = commodityService.selectCommodityByTypeRandom4("%美食%");
		
		request.getSession().setAttribute("clothes", clothes);
		request.getSession().setAttribute("book", book);
		request.getSession().setAttribute("food", food);
		
		if(request.getSession().getAttribute("user")!=null)
			return recommendByUserCF(request);
		
		return "forward:/first_page.jsp";
	}
	
	@RequestMapping(params="recommendByUserCF")
	public String recommendByUserCF(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		List<Integer> allUser = userService.selectAllUserId();
		List<ShoppingRecord> shoppingRecords = shoppingRecordService.selectAllRecord();
		
		//用户相似度矩阵
		int userSimilarity[][] = new int[allUser.size()][allUser.size()];
		for(int i=0;i<allUser.size();i++){
			userSimilarity[i][i] = -1;
		}
		
		List<Integer> allCommodityId = commodityService.selectAllCommodityId();
		
		//用户商品购买表
		int UserBuyCommodity[][] = new int[allUser.size()+1][allCommodityId.size()+1];
/*		System.out.println("-------------------------");
		System.out.println(allUser.size());
		for(int i=0;i<allUser.size();i++)
		{
			System.out.println(allUser.get(i));
		}
		System.out.println("--------------------------");*/
		for(int i=0;i<shoppingRecords.size();i++){
			UserBuyCommodity[allUser.indexOf(shoppingRecords.get(i).getUserid())]
					[allCommodityId.indexOf(shoppingRecords.get(i).getCommodityid())] = 1;
			for(int j=0;j<shoppingRecords.size();j++){
				int userIdA = shoppingRecords.get(i).getUserid();
				int userIdB = shoppingRecords.get(j).getUserid();
				if(shoppingRecords.get(i).getCommodityid()==shoppingRecords.get(j).getCommodityid()
				&& userIdA!=userIdB){
					int a = allUser.indexOf(userIdA);
					int b = allUser.indexOf(userIdB);
					userSimilarity[a][b] = userSimilarity[a][b] + 1;
					userSimilarity[b][a] = userSimilarity[b][a] + 1;
				}	
			}
		}
		
		int nowUserIndex = allUser.indexOf(user.getId());
		List<UserCFSort> userSort = new ArrayList<UserCFSort>();
		for(int i=0;i<allUser.size();i++){
			UserCFSort ucfs = new UserCFSort();
			ucfs.setIndex(i);
			ucfs.setSimilarity(userSimilarity[nowUserIndex][i]);
			userSort.add(ucfs);
		}
		
		Collections.sort(userSort);
		for(int i=0;i<userSort.size();i++){
			System.out.println("---------------------------");
			System.out.println("index:"+userSort.get(i).getIndex());
			System.out.println("similarity:"+userSort.get(i).getSimilarity());
			System.out.println("---------------------------");
		}
		
		int user1Index = userSort.get(0).getIndex();
		int user2Index = userSort.get(1).getIndex();
		
		List<Commodity> commodityRecommend = new ArrayList<Commodity>();;
		for(int i=0;i<allCommodityId.size();i++){
			if(UserBuyCommodity[nowUserIndex][i]==0&&UserBuyCommodity[user1Index][i]!=0)
				commodityRecommend.add(commodityService.selectByPrimaryKey(allCommodityId.get(i)));
			if(UserBuyCommodity[nowUserIndex][i]==0&&UserBuyCommodity[user2Index][i]!=0)
				commodityRecommend.add(commodityService.selectByPrimaryKey(allCommodityId.get(i)));
		}
		
		request.getSession().setAttribute("commodityRecommend", commodityRecommend);
		return "forward:/first_page.jsp";
	}
	
	@RequestMapping(params="showConcreteCommodityInfo")
	public String showConcreteCommodityInfo(HttpServletRequest request){
		int commodityid = Integer.parseInt(request.getParameter("commodityid"));
		Commodity commodity = commodityService.selectByPrimaryKey(commodityid);
		request.getSession().setAttribute("commodity", commodity);
		List<CommodityType> commodityType = commodityTypeService.selectByCommodityId(commodity.getId());	
		List<CommodityTypeConcrete> commodityTypeConcrete = new ArrayList<CommodityTypeConcrete>();
		for(int i = 0 ; i < commodityType.size() ; i++ )
		{		
			CommodityTypeConcrete concrete = new CommodityTypeConcrete();
			CommodityType type = commodityType.get(i);
			concrete.setRemain(type.getRemain());
			concrete.setCommodityTypeId(commodityType.get(i).getId());
			if(type.getColorid()!=null)
				concrete.setColor(colorService.selectByPrimaryKey(type.getColorid()).getColor());
			if(type.getSizeid()!=null)
				concrete.setSize(sizeService.selectByPrimaryKey(type.getSizeid()).getSize());
			commodityTypeConcrete.add(concrete);
		}
		
		request.getSession().setAttribute("commodityTypeConcrete", commodityTypeConcrete);
		return "forward:/commodity_manage.jsp";
	}
	
	@RequestMapping(params="selectCommodityByVagueNamePartly16")
	public String selectCommodityByVagueNamePartly16(HttpServletRequest request){
		String nowpage = request.getParameter("nowpage");
		String VagueName = request.getParameter("VagueName");
		
		request.getSession().setAttribute("VagueName", VagueName);
		
		List<Commodity> commodity = commodityService.selectCommodityByVagueName("%"+VagueName+"%");
		
		int num = commodity.size();
		
		Divide divide = new Divide(num,16,1);
		divide.setCommodityNum(num);
		
		if(nowpage!=null)
		{
			divide = new Divide(num,16,Integer.parseInt(nowpage));
			divide.setCommodityNum(num);
		}
		
		List<Commodity> commodity1 = 
		commodityService.selectCommodityPartlyByVagueName(divide.getStartCommodity(),16,"%"+VagueName+"%");
		
		request.getSession().setAttribute("commodity", commodity1);
		request.getSession().setAttribute("pageNum", divide.getPageNum());
		request.getSession().setAttribute("nowPage", divide.getNowpage());
		return "forward:/search_page.jsp";
	}
	
	@RequestMapping(params="selectCommodityPartly8")
	public String selectCommodityPartly8(HttpServletRequest request){
		
		String nowpage = request.getParameter("nowpage");
		Shop shop = (Shop)request.getSession().getAttribute("shop");
		int num = commodityService.selectCommodityNum(shop.getId());
		
		Divide divide = new Divide(num,8,1);
		divide.setCommodityNum(num);
		
		if(nowpage!=null)
		{
			divide = new Divide(num,8,Integer.parseInt(nowpage));
			divide.setCommodityNum(num);
		}
				
		List<Commodity> commodity = 
		commodityService.selectCommodityPartlyByShopId(divide.getStartCommodity(), 8,shop.getId());
		
		request.getSession().setAttribute("commodity", commodity);
		request.getSession().setAttribute("pageNum", divide.getPageNum());
		request.getSession().setAttribute("nowPage", divide.getNowpage());
		return "forward:/shop_manage.jsp";
	}
	
	//更新商品
	@RequestMapping(params="updateCommodity")
	public String updateCommodity(HttpServletRequest request,MultipartFile commoditypic){
		Commodity commodity = new Commodity();
		String originalFilename = commoditypic.getOriginalFilename();
		if(originalFilename!=null&&!"".equals(originalFilename)){
			String path = "C:/Users/56590/Desktop/projectInChinaSoftware/eclipse/workspace/graduateDesign/WebContent/file";
			//生成一个uuid 的文件名
			UUID randomUUID = UUID.randomUUID();
			
			//获取文件的后缀名
			String fileName = commoditypic.getOriginalFilename();
			int i = fileName.lastIndexOf(".");
			String uuidName = randomUUID.toString()+fileName.substring(i);
			
			try {
				commoditypic.transferTo(new File(path+"/"+uuidName));
			} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			}
			commodity.setCommoditypic(uuidName);
		}
	
		Shop shop = (Shop)request.getSession().getAttribute("shop");
		commodity.setCommodityname(request.getParameter("commodityname"));
		commodity.setPrice(new BigDecimal(request.getParameter("price")));
		
		String remain = request.getParameter("remain");
		commodity.setRemain(Integer.parseInt(remain));
		
		commodity.setSales(0);
		commodity.setShopid(shop.getId());
		
		String commodityid = request.getParameter("commodityid");
		commodity.setId(Integer.parseInt(commodityid));

		commodityService.updateByPrimaryKeySelective(commodity);
		
		commodity = commodityService.selectByCommodityNameAndShopId(request.getParameter("commodityname"), shop.getId());
		
		return selectCommodityPartly8(request);
	}
	
	//发布商品
	@RequestMapping(params="addCommodity")
	public String addCommodity(HttpServletRequest request,MultipartFile commoditypic){
		
		Commodity commodity = new Commodity();
		
		String path = "C:/Users/56590/Desktop/projectInChinaSoftware/eclipse/workspace/graduateDesign/WebContent/file";
		//生成一个uuid 的文件名
		UUID randomUUID = UUID.randomUUID();
		
		//获取文件的后缀名
		String fileName = commoditypic.getOriginalFilename();
		int i = fileName.lastIndexOf(".");
		String uuidName = randomUUID.toString()+fileName.substring(i);
		
		try {
			commoditypic.transferTo(new File(path+"/"+uuidName));
		} catch (IllegalStateException e) {
		// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
		// TODO Auto-generated catch block
			e.printStackTrace();
		}
/*		
		System.err.println("-----存放图片的路径地址为：:"+path);
		System.err.println("-----图片名称为：:"+fileName);
		System.err.println("-----图片新名称为：:"+uuidName);
		System.err.println("-----图片新路径为：:"+path+"/"+uuidName);*/
		
		String category = request.getParameter("category").replaceAll("<font>></font>",">");
	
		Shop shop = (Shop)request.getSession().getAttribute("shop");
		
		commodity.setCommodityname(request.getParameter("commodityname"));
		commodity.setCommoditypic(uuidName);
		commodity.setPrice(new BigDecimal(request.getParameter("price")));
		String remain = request.getParameter("remain");
		
		commodity.setRemain(Integer.parseInt(remain));
		commodity.setSales(0);
		commodity.setShopid(shop.getId());
		commodity.setCategory(category);
		commodityService.insertSelective(commodity);
		
		commodity = commodityService.selectByCommodityNameAndShopId(request.getParameter("commodityname"), shop.getId());
		
		Store store = new Store();
		store.setCommodityid(commodity.getId());
		store.setShopid(shop.getId());
		storeService.insertSelective(store);
		
		
		if("1".equals(request.getParameter("SKUCheck")))
		{
			String size1 = request.getParameter("size1");
			String color1 =  request.getParameter("color1");
			String remain1 = request.getParameter("remain1");
			
			String size2 = request.getParameter("size2");
			String color2 =  request.getParameter("color2");
			String remain2 = request.getParameter("remain2");
			
			String size3 = request.getParameter("size3");
			String color3 =  request.getParameter("color3");
			String remain3 = request.getParameter("remain3");
			
			Integer colorId = null,sizeId = null;
			
			CommodityType commodityType = new CommodityType();
			if(size1!=null&&!"".equals(size1))
			{
				Size size = new Size();
				Size tempSize = sizeService.selectBySize(size1);
				if(tempSize==null)
				{
					size.setSize(size1);
					sizeService.insertSelective(size);
					size = sizeService.selectBySize(size1);
					sizeId = size.getId();

				}
				else 
					sizeId = tempSize.getId();
				
				commodityType.setSizeid(sizeId);
			}
			if(color1!=null&&!"".equals(color1))
			{
				Color color = new Color();
				Color tempColor = colorService.selectByColor(color1);
				if(tempColor==null)
				{
					color.setColor(color1);
					colorService.insertSelective(color);
					color = colorService.selectByColor(color1);
					colorId = color.getId();
				}
				else  
					colorId = tempColor.getId();
				commodityType.setColorid(colorId);
			}
			
			if((size1!=null&&!"".equals(size1))||(color1!=null&&!"".equals(color1)))
			{
				commodityType.setCommodityid(commodity.getId());
				commodityType.setRemain(Integer.parseInt(remain1));
				commodityTypeService.insertSelective(commodityType);
			}
			
			commodityType = new CommodityType();
			if(size2!=null&&!"".equals(size2))
			{
				Size size = new Size();
				Size tempSize = sizeService.selectBySize(size2);
				if(tempSize==null)
				{
					size.setSize(size2);
					sizeService.insertSelective(size);
					size = sizeService.selectBySize(size2);
					sizeId = size.getId();
				}
				else 
					sizeId = tempSize.getId();
				commodityType.setSizeid(size.getId());
			}
			if(color2!=null&&!"".equals(color2))
			{
				Color color = new Color();
				Color tempColor = colorService.selectByColor(color2);
				if(tempColor==null)
				{
					color.setColor(color2);
					colorService.insertSelective(color);
					color = colorService.selectByColor(color2);
					colorId = color.getId();
				}
				else  
					colorId = tempColor.getId();
				commodityType.setColorid(colorId);
			}

			if((size2!=null&&!"".equals(size2))||(color2!=null&&!"".equals(color2)))
			{
				commodityType.setCommodityid(commodity.getId());
				commodityType.setRemain(Integer.parseInt(remain2));
				commodityTypeService.insertSelective(commodityType);
			}
			
			commodityType = new CommodityType();
			if(size3!=null&&!"".equals(size3))
			{
				Size size = new Size();
				Size tempSize = sizeService.selectBySize(size3);
				if(tempSize==null)
				{
					size.setSize(size3);
					sizeService.insertSelective(size);
					size = sizeService.selectBySize(size3);
					sizeId = size.getId();
				}
				else 
					sizeId = tempSize.getId();
				commodityType.setSizeid(size.getId());
			}
			if(color3!=null&&!"".equals(color3))
			{
				Color color = new Color();
				Color tempColor = colorService.selectByColor(color3);
				if(tempColor==null)
				{
					color.setColor(color3);
					colorService.insertSelective(color);
					color = colorService.selectByColor(color3);
					colorId = color.getId();
				}
				else  
					colorId = tempColor.getId();
				commodityType.setColorid(color.getId());
			}
			
			if((size3!=null&&!"".equals(size3))||(color3!=null&&!"".equals(color3)))
			{
				commodityType.setCommodityid(commodity.getId());
				commodityType.setRemain(Integer.parseInt(remain3));
				commodityTypeService.insertSelective(commodityType);		
			}
		}
		return selectCommodityPartly8(request);
	}
}
