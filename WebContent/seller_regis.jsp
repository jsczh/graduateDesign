<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
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
.reg-realname,.reg-phone,.reg-button,.reg-idCard{
	width: 60%;
}
</style>
<script type="text/javascript">
var seller_reg = new Array("0","0","0");
function cellphoneCheck(){
	var userphone = $("#cellphone").val();
	var phonecheck = /^(01|1)[3578][0-9]{9}$/;
	if(userphone=="")
	{
		$("#telehint").css({"background-image":"none",
						"color":"red"});
		$("#telehint").html("请输入电话号码");
		seller_reg[0] = 0;
	}
	else if(!phonecheck.test(userphone))
	{
		$("#telehint").css({"background-image":"none",
						"color":"red"});
		$("#telehint").html("电话的格式错误");
		seller_reg[0] = 0;
	}
	else 
	{
		$("#telehint").html("");
		$("#telehint").css({"background-image":"url(img/right.png)",
						"background-position":"left",
						"background-repeat":"no-repeat"});
		seller_reg[0] = 1;
	}
	buttonCheck();
}
function idCardCheck(){
	var len = $("#idCard").val().length;
	var useridcard = $("#idCard").val();
	if(len==15)
	{
		var idtest1 = /^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$/;
		if(!idtest1.test(useridcard))
		{
			$("#idcardhint").css({"background-image":"none",
				"color":"red"});
			$("#idcardhint").html("请输入正确的身份证号");
			seller_reg[1] = 0;
		}
		else 
			idCardExistCheck();
	}
	else if(len==18)
	{
		var idtest2 = /^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
		if(!idtest2.test(useridcard))
		{
			$("#idcardhint").css({"background-image":"none",
				"color":"red"});
			$("#idcardhint").html("请输入正确的身份证号");
			seller_reg[1] = 0;
		}
		else 
			idCardExistCheck();	
	}
	else if(len!=15||len!=18)
	{
		$("#idcardhint").css({"background-image":"none",
			"color":"red"});
		$("#idcardhint").html("请输入正确的身份证号");
		seller_reg[1] = 0;
	}
}
function idCardExistCheck(){
	var idCard = $("#idCard").val();
	$.post("seller.action?selectByIdCard",{idCard:idCard},function(data){
		if("success"==data)
		{
			$("#idcardhint").html("");
			$("#idcardhint").css({"background-image":"url(img/right.png)",
							"background-position":"left",
							"background-repeat":"no-repeat"});
			seller_reg[1] = 1;
			buttonCheck();
		}
		else
		{
			$("#idcardhint").css({"background-image":"none",
				"color":"red"});
			$("#idcardhint").html("该身份证号已注册");
			seller_reg[1] = 0;
		}
	});
}
function realnameCheck(){
	var realnameCheck = /^[\u4E00-\u9FA5]{2,10}$/;
	var realname = $("#realname").val();
	if(!realnameCheck.test(realname))
	{
		$("#realnamehint").css({"background-image":"none",
			"color":"red"});
		$("#realnamehint").html("请填写正确姓名");
		seller_reg[2] = 0;
	}
	else 
	{
		$("#realnamehint").html("");
		$("#realnamehint").css({"background-image":"url(img/right.png)",
						"background-position":"left",
						"background-repeat":"no-repeat"});
		seller_reg[2] = 1;
	}
	buttonCheck();
}

function buttonCheck(){
	if(seller_reg[0] == 1 && seller_reg[1] == 1 && seller_reg[2] == 1)
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
	if(seller_reg[0] == 1 && seller_reg[1] == 1 && seller_reg[2] == 1)
	{
		alert("注册成功");
		$("#regis").submit();
	}
}
</script>
<body>
<c:if test="${user.sellerid!=null}"><div style="margin-left: 100px;">您已经成为卖家无需重复注册</div></c:if>
<c:if test="${user.sellerid==null}">
	<form id="regis" autocomplete="off" method="post" action="seller.action?addSeller">
		<div>
			<div class="reg-realname">
				<label for="realname" class="r-label">真实姓名:</label>
				<input type="text" id="realname" name="realname" class="r-input" placeholder="请填写真实姓名以便于结算收益" maxlength="20" onblur="realnameCheck()">
				<div class="hint" id="realnamehint"></div>
			</div>
			<div style="clear:both;"></div>
			<div class="reg-phone">
				<label for="cellphone" class="r-label">手机号:</label>
				<input type="text" id="cellphone" name="cellphone" class="r-input" placeholder="11位手机号" maxlength="20" onblur="cellphoneCheck()">
				<div class="hint" id="telehint"></div>
			</div>
			<div style="clear:both;"></div>
			<div class="reg-idCard">
				<label for="idCard" class="r-label">身份证号:</label>
				<input type="text" id="idCard" name="idCard" class="r-input" placeholder="身份证号" maxlength="20" onblur="idCardCheck()">
				<div class="hint" id="idcardhint"></div>
			</div>
			<div style="clear:both;"></div>
			<div class="reg-button">
				<label for="phone" class="r-label"></label>
				<div class="reg-submit" id="submit" onclick="unitTest()">注&nbsp;&nbsp;册</div>
			</div>	
		</div>	
	</form>	
</c:if>
</body>
</html>