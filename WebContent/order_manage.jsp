<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#order_show").load("user.action?sellerOrder");
	$("#allOrder").css({"border-bottom":"2px solid #ca5252"});
	$("#allOrder").click(function(){
		$("#order_choose div").css({"border-bottom":"2px solid #FFF"});
		$("#allOrder").css({"border-bottom":"2px solid #ca5252"});
		$("#order_show").load("user.action?sellerOrder");
	});
	$("#orderToBeSent").click(function(){
		$("#order_choose div").css({"border-bottom":"2px solid #FFF"});
		$("#orderToBeSent").css({"border-bottom":"2px solid #ca5252"});
		$("#order_show").load("user.action?sellerOrderToBeSent");
	});
	$("#orderToBeReceived").click(function(){
		$("#order_choose div").css({"border-bottom":"2px solid #FFF"});
		$("#orderToBeReceived").css({"border-bottom":"2px solid #ca5252"});
		$("#order_show").load("user.action?sellerOrderToBeReceived");
	});
})
</script>
<style type="text/css">
a{text-decoration: none;}
#top {
    border: 1px solid #F7F7F7;
    /* background-color: #F7F7F7; */
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
#order_choose{
	margin-top:20px;
	margin-left:200px;
	width:1000px;
	height:30px;
}
#order_show{
	width:1000px;
	height:100%;
}
#allOrder,#orderToBeSent,#orderToBeReceived{
	width:300px;
	height:30px;
	float: left;
	text-align:center;
	border-right: 1px solid #ddd;
}
</style>
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
<div id="order_choose">
	<div id="allOrder">
		<a href="#">已收货</a>
	</div>
	<div id="orderToBeSent">
		<a href="#">待发货</a>
	</div>
	<div id="orderToBeReceived">
		<a href="#">待收货</a>
	</div>
</div>
<div id="order_show">
	
</div>
</body>
</html>