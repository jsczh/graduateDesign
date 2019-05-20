package com.tool;

public class Divide {
	private int nowpage = 1;//当前页
	private int startCommodity;//商品开始数
	private int CommodityNum;//商品数
	private int pageNum;//页数
	private int count;//偏移量
	
	public Divide() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Divide(int CommodityNum,int count,int nowpage){
		this.CommodityNum = CommodityNum;
		this.count = count;
		this.nowpage = nowpage;
		pageNum();
		getStartCommo();
	}

	public void pageNum(){
		if(CommodityNum % count == 0)
			pageNum = CommodityNum / count;
		else
			pageNum = CommodityNum / count + 1;
	}
	
	public void getStartCommo(){
		startCommodity = (nowpage-1)*count;
	}
	

	public int getCommodityNum() {
		return CommodityNum;
	}

	public void setCommodityNum(int CommodityNum) {
		this.CommodityNum = CommodityNum;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}


	public int getNowpage() {
		return nowpage;
	}

	public void setNowpage(int nowpage) {
		this.nowpage = nowpage;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	
	public int getStartCommodity() {
		return startCommodity;
	}

	public void setStartCommodity(int startCommodity) {
		this.startCommodity = startCommodity;
	}
}
