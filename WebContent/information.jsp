<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
	html, body{height: 100%}
	#top{
		border:1px solid #ddd;
/* 		background-color: #F7F7F7; */
		width:100%;
		height:10%;
		text-align: right;
	}
	#left{
		border:1px solid #ddd;
		width:20%;
		height:88%;
		display:inline-block;
		margin:5px;
		float:left;
		overflow: hidden;
	}
	#main{
		width:78%;
		height:90%;
		margin:0px;
		overflow: hidden;
		margin-left: 10px;
	}
	#left li{
		text-decoration:none;
		font-size: 20px;
		list-style-type:none;
		margin: 8px;
	}
	a{  
        text-decoration:none;
        color: #36c;
	} 
	#top li{
		list-style:none;
		float: left;
		text-decoration: none;
		text-align:left;
		width: 100px;
		margin: 8px;
	}
	#info{
		border-bottom: 1px solid #ddd;
	}
/* 	#info li:HOVER {
		-moz-box-shadow:
	        0 15px 30px 0 rgba(255,255,255,.15) inset,
	        0 2px 7px 0 rgba(0,0,0,.2);
	    -webkit-box-shadow:
	        0 15px 30px 0 rgba(255,255,255,.15) inset,
	        0 2px 7px 0 rgba(0,0,0,.2);
	    box-shadow:
	        0 15px 30px 0 rgba(255,255,255,.15) inset,
	        0 2px 7px 0 rgba(0,0,0,.2);
	} */
}
</style>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $("#main").load("safe_information.jsp",{"id":"${user.id}"});
    //单击 a 链接，加载 a.html
    $("#safeInformation").click(function(){
        $("#main").load("safe_information.jsp",{"id":"${user.id}"});
    });
    //单击 b 链接，加载 b.html
    $("#manageAddress").click(function(){
        $("#main").load("address.action?selectByUserId");
    });
    
    $("#sellerInformation").click(function(){
        $("#main").load("seller.action?showSellerInfo");
    });
    $("#sellerRegis").click(function(){
        /* $("#main").load("seller_regis.jsp"); */
    	$("#main").load("shop_seller_reg.jsp");
    });
})
</script>
</head>
<body>

<div id="top">
	<ul>
		<li>欢迎， ${user.nickname}</li>
		<li><a href="login.jsp">注销</a>	</li>
		<li><a href="commodity.action?showCommodityRandom4">首页</a></li>
	</ul>
</div>
<div id="left">
	<ul id="info">
    	<li><a href="#" id="safeInformation">安全信息</a></li>
    	<li><a href="#" id="manageAddress">管理收货地址</a></li>
	</ul>
	<ul>
		<li><a href="#" id="sellerInformation">我是卖家</a></li>
    	<li><a href="#" id="sellerRegis">卖家注册/店铺注册</a></li>
    	<li><a href="order_manage.jsp" id="orderManage">卖家订单管理</a></li>
    </ul>
</div>
<div id="main"></div>
</body>
</html>