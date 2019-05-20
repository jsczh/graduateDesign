<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
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
	font-size: 15px;
}
#top ul{
	padding: 0px;
	margin: 0px;
}
.r-input{
	float: left;
    height: 40px;
    width: 320px;
    margin-top: 12px;
    border: solid 1px #ddd;
}

.r-label {
    float: left;
    text-align:right;
    width: 100px;
    margin-top: 12px;
    font-size: 16px;
    line-height: 40px;
    color: #333;
    padding-right: 10px;
}
.c-commodityName,.c-price,.c-remains{
	float:left;
	width:600px;
	height:90px;
	margin-left: 70px;
}
.c-showPic{
	float:left;
	width:244px;
	height:420px;
	margin-left: 10px;
}
.c-left{
	float:left;
	width:600px;
	height:420px;
}

#commodityNameHint,#priceHint,#remainHint{
	margin-left: 100px;
}
.SKU input { width: 200px; height: 36px; border: 1px solid #ed7f5a; -webkit-border-radius: 2px; -moz-border-radius: 2px; border-radius: 2px; background-color: #ed7f5a; color: #fff; float: left;margin-left: 120px;}
.SKU input:hover { border-color: #d95459; background-color: #d95459; }

#showSize{
	width:244px;
	height:420px;
	top:55px;
	left: 10px;
	border: solid 1px #ddd;
	position: absolute;
	z-index: 1001;
	display: none;
}

#showSize input{
	margin:10px;
	position: relative;
}
#left_info_submit{
	float: right;
	width:50px;
	border: 1px solid #ed7f5a;
	border-radius:2px;
	background-color: #ed7f5a;
}
table.hovertable {
		float:left;
		font-family: verdana,arial,sans-serif;
		font-size:11px;
		color:#333333;
		border-width: 1px;
		border-color: #999999;
		border-collapse: collapse;
	}
	table.hovertable th {
		background-color:#DEDEDE;
		border: 0px;
		padding: 8px;
		border-style: solid;
		text-align: left;
	}
	table.hovertable tr {
		background-color:#F7F7F7;
		border: 1px;
		border-style: solid;
		border-color:#F7F7F7;
	}
	table.hovertable td {
		border: 1px;
		padding: 8px;
	}
</style>
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript">
function Inputcheck(){
	var commodityname = $("#commodityname").val();
	var price = $("#price").val();
	var remain = $("#remain").val();
	var commoditypic = $("#commoditypic").val();
	var flag = 1;	
	if(commodityname == "" || price == "" || remain == "")
	{
		alert("请完整填写商品信息");
		flag=0;
	}else{
		if(!/^([\u4E00-\u9FA5]|[0-9A-Za-z])([\u4E00-\u9FA5]|[0-9A-Za-z]|\s){1,30}$/.test(commodityname)){//商品名验证
			$("#commodityNameHint").html("请填写正确的商品名");
			$("#commodityname").val("");
			flag=0;
		}
		else  
			$("#commodityNameHint").html("");
		if(!/^(0|[1-9][0-9]{0,6})(\.[0-9]{1,2})?$/.test(price)){//商品价格验证
			$("#priceHint").html("请填写正确的商品价格");
			$("#price").val("");
			flag=0;
		}
		else  
			$("#priceHint").html("");
		if(!/^(0|[1-9])[0-9]{0,3}$/.test(remain)){//商品库存验证
			$("#remainHint").html("请填写正确的库存量");
			$("#remain").val("");
			flag=0;
		}
		else  
			$("#remainHint").html("");
		if(flag==1){
			alert("修改成功！")
			$("#form1").submit();
		}
	}
}

function showSize(){
	var style = $("#size").css("display");
	if(style=="none")
		$("#size").css({"display":"block"});
	else
		$("#size").css({"display":"none"});
}

function addTyp(id){
	var color = $("#s_color").val();
	var size = $("#s_size").val();
	var remain = $("#s_remain").val();
	if(color!=""||size!="")
	{
		if(remain!="")
			location.href="commodityType.action?addCommodityType&commodityid="+id+"&color="+color+
			"&size="+size+"&remain="+remain;
		else
			alert("请输入库存");
	}
	else
		alert("请输入商品尺寸或颜色");
}

function deleteType(id){
	location.href="commodityType.action?deleteCommodityType&id="+id;
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
<form id="form1" method="post" enctype="multipart/form-data"  action="commodity.action?updateCommodity">
<div class="contains">
	<input type="hidden" name="commodityid" value="${commodity.id}">
	<div class="c-left" style="border:1px solid #F7F7F7;">
		<div class="c-commodityName">
	    	<label class="r-label">商品名:</label>
	    	<input type="text" class="r-input" id="commodityname" name="commodityname" placeholder="请填写商品名  1-15个字" maxlength="30" value="${commodity.commodityname}">
	    	<div style="clear: both;"></div>
	    	<div id="commodityNameHint"><a></a></div>
	    </div>
		<div class="c-price">
	    	<label class="r-label">价格:</label>
	    	<input type="text" class="r-input" id="price" name="price" placeholder="请填写价格 小数点左最高7位，小数点右最高两位" maxlength="9" value="${commodity.price}">
	    	<div style="clear: both;"></div>
	    	<div id="priceHint"><a></a></div>
	    </div> 
	    <div class="c-remains">
	    	<label class="r-label">库存量:</label>
	    	<input type="text" class="r-input" id="remain" name="remain" placeholder="请填写库存量  最高为9999" maxlength="4" value="${commodity.remain}">
	    	<div style="clear: both;"></div>
	    	<div id="remainHint"><a></a></div>
	    </div>
	    <table class="hovertable">
	    	<tr><th>颜色</th><th>尺寸</th><th>库存</th><th>修改</th></tr>
		    <c:forEach items="${commodityTypeConcrete}" var="type">
		    	<tr onmouseover="this.style.backgroundColor='#DEDEDE';" onmouseout="this.style.backgroundColor='#F7F7F7';">
		    		<td>${type.color}</td><td>${type.size}</td>
		    		<td>${type.remain}</td>
		    		<td><input type="hidden" value="${type.commodityTypeId}">
		    		<input type="button" value="下架" onclick="deleteType(${type.commodityTypeId})"></td>
		    	</tr>
			</c:forEach>
			<tr><td colspan="4"><input type="button" value="增加" onclick="showSize()"></td></tr>
		</table>
		<table class="hovertable" style="margin-left: 10px;display: none;" id="size">
			<tr><td>颜色：</td><td><input type="text" placeholder="请输入颜色" id="s_color"></td></tr>
			<tr><td>尺寸：</td><td><input type="text" placeholder="请输入尺寸" id="s_size"></td></tr>		
			<tr><td>库存：</td><td><input type="text" placeholder="请输入库存" id="s_remain"></td></tr>
			<tr><td colspan="2"><input type="button" id="addType" value="添加" onclick="addTyp(${commodity.id})"></td></tr>
		</table>
	</div>
	<div class="c-showPic" style="border:1px solid #F7F7F7;">
		<label class="r-label">商品图片:</label>
		<input type="file" name="commoditypic" id="commoditypic" multiple="multiple" value="${commodity.commoditypic}"/>
    	<br><br><img src="/file/${commodity.commoditypic}" id="showpic" width="244px" height="" name="showpic">
	</div>
	<input type="hidden" name="category" value="${param.category}">
	<div class="wareSortBtn">
		<input id="addCom" type="button" value="修&nbsp;&nbsp;&nbsp;&nbsp;改" onclick="Inputcheck()"  style="margin-top: 20px;">
	</div>
</div>
</form>
</body>
</html>