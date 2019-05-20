<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
li{
	float: left;
	text-decoration: none;
	text-align:center;
	width: 150px;
	list-style: none;
}
#order{
	margin-left:200px;
	width:1000px;
	height:200px;
 	border: 1px solid #daf3ff;
	margin-top: 10px;
}
#order:HOVER{
	border: 1px solid #87CEFF
}
#head{
	width:1000px;
	height:40px;
	text-align: left;
	background-color: #daf3ff;
}
#head span{
	width:200px;
	margin-left: 20px;
	text-align: center;
	line-height: 40px;
}
#info{
	width:1000px;
}

a{
	text-decoration: none;
}
#commodityName{
	color: #000;
}
#commodityName:HOVER {
	color: #ca5252;
}
</style>
<script type="text/javascript">
function chooseCommodity(id){
	location.href="commodity.action?selectByCommodityIdUser&commodityid="+id;
}
function receiveConfirm(id){
	location.href="seller.action?receiveConfirm&orderid="+id;
}
</script>
</head>
<body>
<c:if test="${showOrder.size()==0}">
	<center>
		<h3>没有符合条件的商品，请尝试其他搜索条件。</h3>
	</center>
</c:if>
<c:if test="${showOrder.size()!=0}">
	<div id="head" style="margin-left:200px;">
	<ul style="line-height: 40px;">
		<li></li><li>商品信息</li><li>分类</li><li>数量</li><li>金额</li><li>总价</li><li>状态</li>
	</ul>
	</div>
</c:if>
<c:forEach items="${showOrder}" var="showOrder">
	<div id="order">
		<div id="head"><span>${showOrder.finishtime}</span></div>
		<div style="clear: both;"></div>
		<div id="info">
			<ul>
				<li><img alt="" src="/file/${showOrder.commoditypic}" width="90px"></li>
				<li>
					<a href="#" onclick="chooseCommodity(${showOrder.commodityId})" id="commodityName">
						${showOrder.commodityname}
						<c:if test="${showOrder.color!=null}"><br>颜色：${showOrder.color}</c:if>
						<c:if test="${showOrder.size!=null}"><br>尺寸：${showOrder.size}</c:if>
					</a>
				</li>
				<li>${showOrder.number}</li>
				<li>${showOrder.price}</li>
				<li>${showOrder.totalPrice}</li>
				<li>
					${showOrder.state}<br>
					<c:if test="${showOrder.state=='已发货'}">
						<input type="button" value="确认收货" onclick="receiveConfirm(${showOrder.orderId})">
					</c:if>
				</li>
			</ul>
		</div>
		<div style="clear: both;"></div>
	</div>
</c:forEach>
</body>
</html>