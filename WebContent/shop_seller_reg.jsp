<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#seller-button{
	width: 200px;
	height: 100px;
	background-color: #33CCFF;
	float: left;
	margin-left: 100px;
	text-align: center;
	line-height: 100px;
	cursor: pointer;
}
#seller-button:HOVER{
	background-color: #66CCFF;
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
#shop-button{
	width: 200px;
	height: 100px;
	background-color: #33CCFF;
	float: left;
	margin-left: 100px;
	text-align: center;
	line-height: 100px;
	cursor: default;
	opacity: 0.6;
}
/* #shop-button:HOVER{
	background-color: #66CCFF;
	-moz-box-shadow:
        0 2px 3px 0 rgba(0,0,0,.1) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    -webkit-box-shadow:
        0 2px 3px 0 rgba(0,0,0,.1) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    box-shadow:
        0 2px 3px 0 rgba(0,0,0,.1) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
} */
#reg-show{
	margin-top: 30px;
	width: 100%;
	height: 80%;
}
#shop-reghint{
	height: 100px;
	line-height: 100px;
	margin-left: 100px;
}
</style>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#seller-button").click(function(){
		$("#reg-show").load("seller_regis.jsp");
	})
	
	if(${user.sellerid!=null}){
		$("#shop-button").click(function(){
			$("#reg-show").load("shop.action?selectBySellerId&url="+"shop_regis.jsp");
		})
		$("#shop-button").css({"opacity":"1","cursor":"pointer"});
		$("#shop-button").hover(function(){
			$("#shop-button").css({
				"background-color": "#66CCFF",
				"-moz-box-shadow": "0 2px 3px 0 rgba(0,0,0,.1) inset,0 2px 7px 0 rgba(0,0,0,.2)",
		    	"-webkit-box-shadow": "0 2px 3px 0 rgba(0,0,0,.1) inset,0 2px 7px 0 rgba(0,0,0,.2)",
		    	"box-shadow": "0 2px 3px 0 rgba(0,0,0,.1) inset,0 2px 7px 0 rgba(0,0,0,.2)"
			});
			},function(){
			$("#shop-button").css({
				"background-color": "#33CCFF","box-shadow":"0 0 0"});
		})
	}
	else{
		$("#shop-button").css({"opacity":"0.6","cursor":"default"});
	}
		
})
</script>
</head>
<body>
	<div id="shop-reghint">*只有完成卖家注册才能注册店铺</div>
	<div id="seller-button">卖家注册</div>
	<div id="shop-button">店铺注册</div>
	<div style="clear:both;"></div>
	<div id="reg-show"></div>
</body>
</html>