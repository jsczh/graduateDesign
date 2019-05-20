<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
table{
	margin-left: 5%;
}

.frame{
	width: 800px;
	height: 100%;
	border: 1px  solid #F7F7F7;
}	
.sellerInfoTit{
	margin-top:10px;
	font-size: 14px;
	color: #014d7f;
	background-color: #f3f8fe;
    height: 30px;
    width: 800px;
    line-height: 30px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
    $("#addSeller").click(function(){
        $("#main").load("seller_regis.jsp");
    });
    $("#myShop").click(function(){
        $("#main").load("shop.action?selectBySellerId&url="+"shop_information.jsp");
    });
})

</script>
<body>
	<div class="frame">
		<div class="sellerInfoTit">卖家信息</div>
		<c:if test="${user.sellerid==null}">
			您尚未成为卖家，<a href="#" id="addSeller">成为卖家</a>
		</c:if>
		<c:if test="${user.sellerid!=null}">
			<table>
				<tr><th>真实姓名：</th><td>${seller.realname}</td></tr>
				<tr><th>电话号码：</th><td>${seller.cellphone}</td></tr>
				<tr><th>身份证号：</th><td>${seller.idcard}</td></tr>
				<tr><th>账号余额：</th><td>${seller.money}</td></tr>
				<tr>
					<td><a href="#" id="myShop">我的店铺</a></td>
					<td><a href="order_manage.jsp" id="orderManage">卖家订单管理</a></td>
				</tr>
			</table>
		</c:if>
	</div>
</body>
</html>