<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/buy_commodity.css">
<script src="js/jquery-1.8.2.min.js"></script>
	<script>
		$(document).ready(function(){
			$(".Xcontent33").click(function(){
				var value=parseInt($('.input').val())+1;
				$('.input').val(value);
			})

			$(".Xcontent32").click(function(){	
				var num = $(".input").val()
				if(num>0){
					$(".input").val(num-1);
				}			
			})
		})
		function selectSize(id,remain){
			$(".size").css({"border":"1px solid #ddd"});
			$("#"+id).css({"border":"1px solid red"});
			$("#sizeSelected").val(id);
			$("#sizeRemain").val(remain);
		}
		function buy(){
			if($("#userid").val()=="")
			{
				alert("请先登录");
				location.href="commodity.action?showCommodityRandom4";
				return;
			}
			var input = $(".input").val();
			var remain = $("#sizeRemain").val();
			var typeid = $("#sizeSelected").val();
			if(typeid=="")
				alert("请选择尺寸");
			else if(parseInt(input)>parseInt(remain))
				alert("库存不足，请重新选择数量");
			else
			{
				if("empty"!=typeid)
					location.href="user.action?selectAddressAndGetOrder&commodityid="+$("#commodityid").val()+
					"&sale="+input+"&typeid="+typeid;
				else
					location.href="user.action?selectAddressAndGetOrder&commodityid="+$("#commodityid").val()+
					"&sale="+input;
			}
						
		}
		function addIntoCart(){
			if($("#userid").val()=="")
			{
				alert("请先登录");
				location.href="commodity.action?showCommodityRandom4";
				return;
			}
			var input = $(".input").val();
			var remain = $("#sizeRemain").val();
			var typeid = $("#sizeSelected").val();
			if(typeid=="")
				alert("请选择尺寸");
			else if(parseInt(input)>parseInt(remain))
				alert("库存不足，请重新选择数量");
			else
			{
				alert("商品已成功加入购物车");
				if("empty"!=typeid)
					location.href="user.action?addIntoCart&commodityid="+$("#commodityid").val()+
					"&sale="+input+"&typeid="+typeid;
				else
					location.href="user.action?addIntoCart&commodityid="+$("#commodityid").val()+
					"&sale="+input;
			}
						
		}
	</script>
<style type="text/css">
.size{
	float:left;
	width:240px;
	height:50px;
	border: 1px solid #ddd;
	margin: 3px;
	text-align:center;
}
.size:HOVER{
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
.size>a{
	line-height:50px;
	text-align:center;
}
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
	list-style:none;
	text-decoration: none;
	text-align:center;
	width: 100px;
	margin-left: 10px;
	line-height: 50px;
	font-size:15px;
	font-family:"微软雅黑";
}
#top li a{
	font-size:15px;
	font-family:"微软雅黑";
}
#top ul{
	padding: 0px;
	margin: 0px;
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
<input type="hidden" id="userid" value="${user.id}">
<div class="Xcontent">
	<div class="Xcontent01">
		<div class="Xcontent06"><img src="/file/${commodity.commoditypic}"></div>
		<div class="Xcontent13">
			<div class="Xcontent14"><a>${commodity.commodityname}</a></div>
			<div class="Xcontent16"><p>${commodity.category}</p></div>
			<div class="Xcontent17">
				<p class="Xcontent18">售价</p>
				<p class="Xcontent19">￥<span>${commodity.price }</span></p>
				<div class="Xcontent20">
				</div>
				<div class="Xcontent23">
					<p class="Xcontent24">销量</p>
					<p class="Xcontent25">${commodity.sales} &nbsp;&nbsp;&nbsp;&nbsp;件</p>
				</div>
			</div>
			<div class="Xcontent26">

				<c:if test="${commodityTypeConcrete.size()!=0}">
					<c:forEach items="${commodityTypeConcrete}" var="type">
						<div id="${type.commodityTypeId}" class="size" style="cursor: pointer;" onclick="selectSize(${type.commodityTypeId},${type.remain})">
							<a>
							<c:if test="${type.color!=null}">颜色：${type.color} / </c:if>
							<c:if test="${type.size!=null}">尺寸：${type.size}&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
							库存：&nbsp;&nbsp;${type.remain}&nbsp;&nbsp;件<br>
							</a>
						</div>
					</c:forEach>
					<input type="hidden" id="sizeSelected">
					<input type="hidden" id="sizeRemain">
				</c:if>
				<c:if test="${commodityTypeConcrete.size()==0}">
					<input type="hidden" id="sizeSelected" value="empty">
				</c:if>
			</div>
			<div class="Xcontent30">
				<p class="Xcontent31">数量</p>
				<div class="Xcontent32"><img src="img/X15.png"></div>
				<form>	
					<input type="hidden" id="commodityid" value="${commodity.id}">
					<input class="input" value="1">
				</form>
				<div class="Xcontent33"><img src="img/16.png"></div>
				<c:if test="${commodityTypeConcrete.size()==0}">
					<p class="Xcontent31">库存${commodity.remain}件</p>
				</c:if>
			</div>
			<div class="Xcontent34"><a href="#" onclick="buy()"><img src="img/X17.png"></a></div><!-- 立即购买 -->
			<div class="Xcontent35"><a href="#" onclick="addIntoCart()"><img src="img/X18.png"></a></div><!-- 购物车 -->
				
		</div>
		
			
			
		</div>
		
	</div>
</body>
</html>