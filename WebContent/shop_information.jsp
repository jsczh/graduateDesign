<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
    $("#addShop").click(function(){
        $("#main").load("shop_regis.jsp");
    });
})

</script>
<style type="text/css">
.shopInfoTit{
	margin-top:10px;
	font-size: 14px;
	color: #014d7f;
	background-color: #f3f8fe;
    height: 30px;
    width: 800px;
    line-height: 30px;
}
</style>
</head>
<body>
	<div class="shopInfoTit">店铺信息</div>
	<c:if test="${shop==null}">您尚未建立自己的店铺，<a href="#" id="addShop">建立店铺</a></c:if>
	<c:if test="${shop!=null}">
		<table>
			<tr><th>店铺名:</th><td>${shop.shopname}</td></tr>
			<tr><th>成交量:</th><td>${shop.sales}</td></tr>
			<tr><th>店铺等级:</th><td>${shop.level}</td></tr>
		</table>
		<a href="commodity.action?selectCommodityPartly8">管理店铺</a>
	</c:if>
</body>
</html>