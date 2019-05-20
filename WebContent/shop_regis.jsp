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
.addShopTit{
	margin-top:10px;
	font-size: 14px;
	color: #014d7f;
	background-color: #f3f8fe;
    height: 30px;
    width: 800px;
    line-height: 30px;
}
.r-input{
	float: left;
    height: 44px;
    width: 320px;
    margin-top: 12px;
    border: solid 1px #ddd;
}

.r-label {
    float: left;
    width: 15%;
    text-align: right;
    margin-top: 12px;
    font-size: 16px;
    line-height: 45px;
    color: #333;
    padding-right: 10px;
}
.hint{
	margin-top: 12px;
	float: left;
	margin-left: 10px;
	width: 20%;
	height: 46px;
	max-height: 60px;
	overflow: hidden;
	font-size: 16px;
	line-height: 46px;		//保证字体垂直居中
}
input {
    padding-left: 10px;
    color: #333;
    border: none;
    font-size: 16px;	//字体大小
    font-weight: bold;  //字体粗细
    line-height: 30px;	//行间距
/*  -o-transition: all .2s;
    -moz-transition: all .2s;
    -webkit-transition: all .2s;
    -ms-transition: all .2s;*/
}

input:focus {
    outline: none;
    -moz-box-shadow:
        0 2px 3px 0 rgba(0,0,0,.1) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    -webkit-box-shadow:
        0 2px 3px 0 rgba(0,0,0,.1) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    box-shadow:
        0 2px 3px 0 rgba(0,0,0,.1) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
}
.reg{
	margin:0 auto;
	position: relative;
	padding-bottom: 55px;
	width:1000px;
	height: 600px;
	box-shadow: 0 3px 3px #cbc9c9;	//box-shadow: h-shadow v-shadow blur spread color inset;
	border-radius: 6px;
	background-color: #fff;
}
.reg-submit{
	opacity: 0.6;	//设置div不透明度
 	cursor: default;	//设置光标类型 
	display:inline-block;
	float: left;
    border: 0;
    width: 330px;
    height: 44px;
    margin-top: 12px;
    background-color: #ca5252;
    text-align: center;
    font-size: 18px;
    color: #fff;
    line-height: 46px;
/*     cursor: pointer; */
}
.reg-shopname,.reg-sellerNickname,{
	width: 60%;
}
</style>
<script type="text/javascript">
var shop_reg = new Array("0","0");
function shopnameCheck(){
	var shopname = $("#shopname").val();
	if(shopname!=""){
		$.post("shop.action?selectByShopName",
				{shopname:shopname},function(data){
					if("success"==data){
						$("#shopnamehint").html("");
						$("#shopnamehint").css({"background-image":"url(img/right.png)",
							"background-position":"left","background-repeat":"no-repeat"});
						shop_reg[0] = 1;
						buttonCheck();
					}
					else 
					{
						$("#shopnamehint").css({"background-image":"none","color":"red"});
						$("#shopnamehint").html("店铺名已存在");
						shop_reg[0] = 0;
					}
		});
	}
	else
	{
		$("#shopnamehint").css({"background-image":"none","color":"red"});
		$("#shopnamehint").html("店铺名不能为空");
		shop_reg[0] = 0;
	}
}
function sellerNicknameCheck(){
	var nickname = $("#nickname").val();
	if(nickname!=""){
		$.post("seller.action?selectByNickname",
				{nickname:nickname},function(data){
					if("success"==data){
						$("#nicknamehint").html("");
						$("#nicknamehint").css({"background-image":"url(img/right.png)",
							"background-position":"left","background-repeat":"no-repeat"});
						shop_reg[1] = 1;
						buttonCheck();
					}
					else 
					{
						$("#nicknamehint").css({"background-image":"none","color":"red"});
						$("#nicknamehint").html("卖家昵称已存在");
						shop_reg[1] = 0;
					}
		});
	}
	else
	{
		$("#nicknamehint").css({"background-image":"none","color":"red"});
		$("#nicknamehint").html("卖家昵称不能为空");
		shop_reg[1] = 0;
	}
	
}
function buttonCheck(){
	if(shop_reg[0] == 1 && shop_reg[1] == 1)
		$("#submit").css({
			"opacity":"1",
			"cursor":"pointer"
		});
	else 
		$("#submit").css({
			"opacity":"0.6",
			"cursor":"default"
		});
}
function unitTest(){
	if(shop_reg[0] == 1 && shop_reg[1] == 1)
	{
		$("#regis").submit();
		alert("注册成功");
	}
	else 
		alert("fail");
}
</script>
</head>
<body>
<c:if test="${shop!=null}"><div style="margin-left: 100px;">您已经注册店铺无需重复注册</div></c:if>
<c:if test="${shop==null}">
<div class="addShopTit">店铺信息</div>
<form id="regis" autocomplete="off" method="post" action="shop.action?addShop">
		<div>
			<div class="reg-shopname">
				<label for="shopname" class="r-label">店铺名称:</label>
				<input type="text" id="shopname" name="shopname" class="r-input" placeholder="请尽量填写与主打商品相关的店名" maxlength="20" onblur="shopnameCheck()">
				<div class="hint" id="shopnamehint"></div>
			</div>
			<div style="clear:both;"></div>
			<div class="reg-sellerNickname">
				<label for="nickname" class="r-label">卖家昵称:</label>
				<input type="text" id="nickname" name="nickname" class="r-input" placeholder="请填写卖家昵称" maxlength="20" onblur="sellerNicknameCheck()">
				<div class="hint" id="nicknamehint"></div>
			</div>
			<div style="clear:both;"></div>
			<div class="reg-button">
				<label for="submit" class="r-label"></label>
				<div class="reg-submit" id="submit" onclick="unitTest()">注&nbsp;&nbsp;册</div>
			</div>
		</div>	
</form>	
</c:if>
</body>
</html>