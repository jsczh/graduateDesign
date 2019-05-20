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
    /* background-color: #F7F7F7; */
    width: 100%;
    height: 50px;
    text-align: right;
    list-style: none;
}
#top li{
	float: left;
	text-decoration: none;
	text-align:left;
	width: 100px;
	margin: 10px;
	list-style: none;
}
#top ul{
	padding: 0px;
	margin: 0px;
}
#commoditySet{
	width:1000px;
	height:800px;
	float:left;
	margin-left: 170px;
}
#commodity{
	float:left;
	width:235px;
	height:400px;
	border: 1px solid #ddd;
	margin:5px;
	cursor: pointer;
}
#commodity_pic{
	float:none;
	width:235px;
	height:333px;
	vertical-align: middle;
    text-align: center;
    display:table-cell;
}
#commodity_info{
	width: auto;
	height: auto;
	text-align: center;
	vertical-align: middle;
	margin-bottom: 20px;
	font-size: 14px;
}
#commodity:HOVER{
	-moz-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    -webkit-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
}
img{
	width:200px;
	vertical-align:middle;
}
</style>
<script type="text/javascript">
function manage(commodityid){
	location.href="commodity.action?showConcreteCommodityInfo&commodityid="+commodityid;
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
			<!-- <li><a href="user.action?myOrder">我的订单</a></li> -->
			<li><a href="order_info.jsp">我的订单</a></li>
			<li><a href="login.jsp">注销</a></li>
		</ul>
	</c:if>
</div>
<c:if test="${!empty commodity}">
	<div style="float: left;">
		<a href="choose_type.jsp" style="text-decoration: none;">上架商品</a>
	</div>
	<div id="commoditySet">
		<c:forEach items="${commodity}" var="commodity">
			<div id="commodity" onclick="manage(${commodity.id})">
				<div id="commodity_pic"><img src="/file/${commodity.commoditypic}"></div>
				<div id="commodity_info">
					<div>${commodity.commodityname}</div>
					<div>库存：${commodity.remain}&nbsp;&nbsp;&nbsp;&nbsp;价格：${commodity.price}</div>
				</div>
				<input type="hidden" id="commodityid" value="${commodity.id}">
			</div>	
		</c:forEach>
	</div>
	<div style="float: left;">
		<c:if test="${nowPage!=1}">
			<a href="commodity.action?selectCommodityPartly8&nowpage=${nowPage-1}">上一页</a>
		</c:if>
		<c:if test="${nowPage!=pageNum}">
			<a href="commodity.action?selectCommodityPartly8&nowpage=${nowPage+1}">下一页</a>
		</c:if>
	</div>
</c:if>
<c:if test="${empty commodity}">
	您尚未上架任何商品,<a href="choose_type.jsp" style="text-decoration: none;">上架商品</a>
</c:if>
</body>
</html>