<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>购物车</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/carts.css">
<script type="text/javascript">
function selectAddress(id){
	$(".address").css({"background-image":"url(img/address_unchecked.png)"});
	$("#"+id).css({"background-image":"url(img/address.png)"});
	$("#addressSelected").val(id);
}
function calculate(){
	var address = $("#addressSelected").val();
	if(address=="")
	{
		alert("请选择收货地址");
		return ;
	}
	$sonCheckBox = $('.son_check');
	$sonCheckBox.each(function () {
        if ($(this).is(':checked')) {
        	var commodityid = $(this).parents('.order_lists').find('#commodityid').val();
        	var color = $(this).parents('.order_lists').find('#color').html();
        	var realColor = color.replace("颜色：","");
        	var size = $(this).parents('.order_lists').find('#size').html();
        	var realSize = size.replace("尺寸：","");
        	var num = $(this).parents('.order_lists').find('.sum').val();
/*          	alert(commodityid);
        	alert(realColor);
        	alert(realSize);
        	alert(num);  */
      
        	$.post("user.action?buyCommodityOverCart",
        	{commodityid:commodityid,color:realColor,size:realSize,num:num,addressid:address},
        	function(data){
        		if(data!="success")
        		{
        			alert(data);
        			return;
        		}
        	});
        }
    });
	location.href="commodity.action?showCommodityRandom4"; 
}
</script>

<style type="text/css">
#addressSet{
	float:left;
	width:100%;
	height: 150px;
/* 	margin-left: 200px; */
	margin-top: 100px;
	text-align: left;
}
.address{
	float:left;
	margin-right:8px;
	margin-top:5px;
	width:237px;
	height:106px;
	text-align: center;
	vertical-align: middle;
	border: 1px solid #ddd;
	background: url(img/address_unchecked.png) no-repeat;
	font-size: 14px;
}
.address:HOVER{
	-moz-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    -webkit-box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    box-shadow:
        0 15px 30px 0 rgba(255,255,255,.15) inset,
        0 2px 7px 0 rgba(0,0,0,.2);
    background: url(img/address.png) no-repeat;
}
.address ul{
	width:237px;
	padding:5px;
	float:left;
	list-style: none;
	text-align: left;
	overflow: hidden;
	word-break: break-all;
    word-wrap: break-word;
}
.address li{
	width:227px;
	overflow: hidden;
	font-size: 15px;
	font-family: "微软雅黑";
	margin: 3px;
}
#top {
    border: 1px solid #F7F7F7;
    /* background-color: #F7F7F7; */
    width: 100%;
    height: 50px;
    text-align: right;
    list-style: none;
}
#top li {
	float: left;
	font-size:15px;
	font-family:"微软雅黑";
	text-decoration: none;
	text-align:center;
	width: 100px;
	margin-left: 10px;
	line-height: 50px;
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
    <section class="cartMain">
    	<div id="addressSet">
			<h2>选择收货地址</h2>
			<c:if test="${address==null}">
				您还未填写地址，<a href="address.jsp">添加地址</a>
			</c:if>
			<c:if test="${shopSet.size()!=0}">
				<c:if test="${address!=null}">
					<c:forEach items="${address}" var="address">
						<div class="address" id="${address.id}" onclick="selectAddress(${address.id})">
							<ul>
								<li style="border-bottom: 1px solid #ddd;">${address.address}(${address.recipient} 收)</li>
								<li><span>${address.detailaddress}(${address.cellphone})</span></li>
							</ul>
						</div>
					</c:forEach>
					<input type="hidden" id="addressSelected">
				</c:if>
			</c:if>
		</div>
        <div style="clear: both;"></div>
        <div class="cartMain_hd">
            <ul class="order_lists cartTop">
                <li class="list_chk">
                    <!--所有商品全选-->
                    <input type="checkbox" id="all" class="whole_check">
                    <label for="all"></label>
                    全选
                </li>
                <li class="list_con">商品信息</li>
                <li class="list_info">商品参数</li>
                <li class="list_price">单价</li>
                <li class="list_amount">数量</li>
                <li class="list_sum">金额</li>
                <li class="list_op">操作</li>
            </ul>
        </div>
        
        <c:if test="${shopSet.size()==0}">
        	您的购物车空空如也，请前往购物。
        </c:if>
		
		<c:forEach items="${shopSet}" var="shopSet">
		<div class="cartBox">
            <div class="shop_info">
                <div class="all_check">
                    <!--店铺全选-->
                    <input type="checkbox" id="${shopSet.shopid}" class="shopChoice">
                    <label for="${shopSet.shopid}" class="shop"></label>
                </div>
                <div class="shop_name">
                   	 店铺：<a href="javascript:;">${shopSet.shopname}</a>
                </div>
            </div>
            <div class="order_content">
	            <c:forEach items="${cartConcrete}" var="cartConcrete">
	            <c:if test="${cartConcrete.shopname==shopSet.shopname}">
	            	<ul class="order_lists">
	                    <li class="list_chk">
	                        <input type="checkbox" id="${cartConcrete.commodityid}" class="son_check">
	                        <label for="${cartConcrete.commodityid}"></label>
	                        <input type="hidden" id="commodityid" value="${cartConcrete.commodityid}">
	                    </li>
	                    <li class="list_con">
	                        <div class="list_img"><a href="javascript:;"><img src="/file/${cartConcrete.commoditypic}"></a></div>
	                        <div class="list_text"><a href="javascript:;">${cartConcrete.commodityname}</a></div>
	                    </li>
	                    <li class="list_info">
	                        <p id="color">颜色：${cartConcrete.color}</p>
	                        <p id="size">尺寸：${cartConcrete.size}</p>
	                    </li>
	                    <li class="list_price">
	                        <p class="price">￥${cartConcrete.price}</p>
	                    </li>
	                    <li class="list_amount">
	                        <div class="amount_box">
	                            <a href="javascript:;" class="reduce reSty">-</a>
	                            <input type="text" value="${cartConcrete.number}" class="sum">
	                            <a href="javascript:;" class="plus">+</a>
	                        </div>
	                    </li>
	                    <li class="list_sum">
	                        <p class="sum_price">￥${cartConcrete.price*cartConcrete.number}</p>
	                    </li>
	                    <li class="list_op">
	                        <p class="del"><a href="javascript:;" class="delBtn">移除商品</a></p>
	                    </li>
	                </ul>
	            </c:if>
	            </c:forEach>  
            </div>   
        </div>        
		</c:forEach>
		
		<div class="bar-wrapper">
            <div class="bar-right">
                <div class="piece">已选商品<strong class="piece_num">0</strong>件</div>
                <div class="totalMoney">共计: <strong class="total_text">0.00</strong></div>
                <div class="calBtn"><a href="javascript:;" onclick="calculate()">结算</a></div>
            </div>
        </div>
    </section>
    <section class="model_bg"></section>
    <section class="my_model">
        <p class="title">删除宝贝<span class="closeModel">X</span></p>
        <p>您确认要删除该宝贝吗？</p>
        <div class="opBtn"><a href="javascript:;" class="dialog-sure">确定</a><a href="javascript:;" class="dialog-close">关闭</a></div>
    </section>

    <script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
    <script src="js/carts.js"></script>
</body>
</html>