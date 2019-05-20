<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<style type="text/css">
a{text-decoration: none;}
#top {
    border: 1px solid #F7F7F7;
    width: 100%;
    height: 50px;
    text-align: right;
    list-style: none;
}
#top li{
	float: left;
	font-size:15px;
	text-decoration: none;
	text-align:center;
	width: 100px;
	margin-left: 10px;
	line-height: 50px;
	list-style: none;
}
#top ul{
	padding: 0px;
	margin: 0px;
}
#addressSet{
	width:1000px;
	height: 100px;
	margin-left: 200px;
	margin-top: 100px;
}
.address{
	float:left;
	margin-right:8px;
	width:237px;
	height:106px;
	text-align: center;
	vertical-align: middle;
	border: 1px solid #ddd;
	background: url(img/address_unchecked.png) no-repeat;
	font-size: 14px;
}
.address:HOVER{
	-moz-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    -webkit-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    background: url(img/address.png) no-repeat;
}
.address ul{
	width:237px;
	padding:5px;
	float:left;
	list-style: none;
	text-align: left;
	overflow: hidden;
	word-break: break-all;
    word-wrap: break-word;
}
.address li{
	width:227px;
	overflow: hidden;
}
#order{
	margin-top:100px;
	margin-left: 200px;
}
#commodityname{
	float:left;width:275px;height:120px;display: table;
}
#tableTop{
	width:1000px;
	text-align: center;
}
#tableTop>td{
	border-bottom: 3px solid #b2d1ff;
}
td{
	text-align: center;
	vertical-align: middle;
}

#submitorder{
	width:1000px;
	margin-left:200px;
}
#submitorder>input{
	float: right;
    border: 0;
    width: 230px;
    height: 44px;
    margin-top: 12px;
    background-color: #ca5252;
    text-align: center;
    font-size: 18px;
    color: #fff;
    line-height: 46px;
    cursor: pointer;
}
</style>
<script type="text/javascript">
function selectAddress(id){
	$(".address").css({"background-image":"url(img/address_unchecked.png)"});
	$("#"+id).css({"background-image":"url(img/address.png)"});
	$("#addressSelected").val(id);
}
function submitOrder(){
	var id = $("#addressSelected").val();
	var remain = $("#remain").val();
	var price = ${order.totalprice};

	if(id==""||id==null)
	{
		alert("请选择收货地址");
		return;
	}
	$.post("user.action?checkMoneyRemain",{remain:remain,price:price},function(data){
		if("success"==data)
		{
			$.post("user.action?checkRemain",function(data){
				if("success"==data)
				{
					alert("订单提交成功，请等待卖家发货");
					location.href="user.action?buyCommodity&addressid="+id;
				}
				else
				{
					alert("商品库存不足，请重新选择数目");
					/* location.href="commodity.action?selectByCommodityIdUser&commodityid="+$("#commodityid").val(); */
				}
			});
		}
		else 
		{
			alert("余额不足");
		}
	});
	

}
</script>
</head>
<body>
<div id="top">
	<c:if test="${user==null}">
		<ul style="float: right;">
			<li><a href="login.jsp">请登录</a></li>
			<li><a href="user_reg.jsp">注册</a></li>	
		</ul>
	</c:if>
	<c:if test="${user!=null}">
		<ul>
			<li>欢迎,${user.nickname}</li>
			<li><a href="commodity.action?showCommodityRandom4">首页</a></li>
			<li><a href="information.jsp">我的信息</a></li>
			<li><a href="user.action?selectShoppingCartByUserId">我的购物车</a></li>
			<li><a href="order_info.jsp">我的订单</a></li>
			<li><a href="login.jsp">注销</a></li>
		</ul>
	</c:if>
</div>
<div id="addressSet">
	<h3>选择地址</h3>
	<c:if test="${address.size()==0}">
		您还未填写地址，<a href="information.jsp">前往个人信息页添加地址</a>
	</c:if>
	<c:if test="${address.size()!=0}">
		<c:forEach items="${address}" var="address">
			<div class="address" id="${address.id}" onclick="selectAddress(${address.id})">
				<ul>
					<li style="border-bottom: 1px solid #ddd;">${address.address}(${address.recipient} 收)</li>
					<li><span>${address.detailaddress}(${address.cellphone})</span></li>
				</ul>
			</div>
		</c:forEach>
		<input type="hidden" id="addressSelected">
	</c:if>
</div>
<div id="order">
	<h3>确认订单信息</h3>
	<input type="hidden" id="commodityid" value="${commodity.id}">
	<table>
		<tr id="tableTop">
			<td width="375px">商品</td><td width="180px">商品属性</td>
			<td width="120px">单价</td><td width="120px">数量</td><td width="130px">小计</td>
		</tr>
		<tr height="150px;">
			<td onclick="">
				<img width="100px;" src="/file/${commodity.commoditypic}" style="float: left;">
				<div id="commodityname">
					<span style="vertical-align: middle;display:table-cell;">${commodity.commodityname}</span>
				</div>
			</td>
			<td>
				<c:if test="${color!=null}">颜色：${color.color}<br></c:if>
				<c:if test="${size!=null}">尺码：${size.size}<br></c:if>
			</td>
			<td>
				${commodity.price}
			</td>
			<td>
				${transaction.number}
			</td>
			<td>
				${order.totalprice}
			</td>
		</tr>
	</table>
</div>
	<div style="width:1000px;margin-left:200px;text-align:right;">
		<a style="font-size:18px;">您的余额：</a>${user.money}
		<input type="hidden" id="remain" value="${user.money}">
	</div>
	<div id="submitorder"><input type="button" value="提交订单" onclick="submitOrder()"></div>
</body>
</html>