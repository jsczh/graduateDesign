package com.bean;

import java.math.BigDecimal;

public class ShoppingCartConcrete {
	private Integer id;
	private Integer commodityid;
	private String commodityname;
	private String commoditypic;
	private String color;
	private String size;
	private String shopname;
	private BigDecimal price;
	private int number;
	
	
	public Integer getCommodityid() {
		return commodityid;
	}
	public void setCommodityid(Integer commodityid) {
		this.commodityid = commodityid;
	}
	public String getShopname() {
		return shopname;
	}
	public void setShopname(String shopname) {
		this.shopname = shopname;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCommodityname() {
		return commodityname;
	}
	public void setCommodityname(String commodityname) {
		this.commodityname = commodityname;
	}
	public String getCommoditypic() {
		return commoditypic;
	}
	public void setCommoditypic(String commoditypic) {
		this.commoditypic = commoditypic;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	
	
}
