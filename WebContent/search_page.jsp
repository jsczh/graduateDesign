<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
a{
	text-decoration: none;
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
	font-size:15px;
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
#show_commodity{
	width:1200px;
	margin-left: 400px;
	text-align: center;
}
#commoditySet{
	width:900px;
}

img{
	width:150px;
	text-align:center;
	vertical-align:middle;
}
#commodity{
	float:left;
	width:180px;
	height:300px;
	border: 1px solid #ddd;
	margin:5px;
	cursor: pointer;
	overflow: hidden;
}
#commodity_pic{
	float:none;
	width:220px;
	height:250px;
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
	font-size: 12px;
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
</style>
<style>
    *{margin:0;padding:0;list-style:none;}
    .search{width:575px;margin:60px auto;overflow: hidden;}
    .search .search-bd{height: 25px;}
    .search .search-bd li{font-size:12px;width:60px;height: 25px;line-height: 25px;text-align:center;float: left;cursor: pointer;background-color: #eee;color: #666;}
    .search .search-bd li.selected{color: #fff;font-weight: 700;background-color: #B61D1D;}
    .search .search-hd{height:34px;background-color: #B61D1D;padding: 3px;position: relative;}
    .search .search-hd .search-input{width: 490px;height: 22px;line-height: 22px;padding: 6px 0;background: none;text-indent: 10px;border: 0;outline: none;position: relative;left: 3px;top: 0;z-index: 5;#margin-left:-10px;}
    .search .search-hd .btn-search{width: 70px;height: 34px;line-height:34px;position: absolute;right: 3px;top: 3px;border: 0;z-index: 6;cursor: pointer;font-size: 12px;color: #fff;font-weight: 700;background: none;outline: none;}
    .search .search-hd .pholder{display: inline-block;padding: 2px 0;font-size: 12px;color: #999;position: absolute;left: 13px;top: 11px;z-index: 4;background: url(images/zoom.jpg) no-repeat 0 0;padding-left:25px;#top:11px;}
    .search .search-hd .s2,.search .search-hd #s2{display: none;}
    .search .search-bg{width: 495px;height: 34px;background-color: #fff;position: absolute;left: 3px;top: 3px;z-index: 1;}
</style>
<script src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
function chooseCommodity(id){
	location.href="commodity.action?selectByCommodityIdUser&commodityid="+id;
}
$(document).ready(function(){
	$("#submit").click(function(){
		var s1 = $("#s1").val();
		var s2 = $("#s2").val();
		if(s1!="")
			location.href="commodity.action?selectCommodityByVagueNamePartly16&VagueName="+s1; 
		if(s2!="")
			location.href="shop.action?selectCommodityByShopname&name="+s2;
	});
})

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
			<li><a href="order_info.jsp">我的订单</a></li>
			<li><a href="login.jsp">注销</a></li>
		</ul>
	</c:if>
</div>
<div class="search">
    <div id="search-bd" class="search-bd">
        <ul>
            <li class="selected">找商品</li>
            <li>找商家</li>
        </ul>
    </div>
    <div id="search-hd" class="search-hd">
        <div class="search-bg"></div>
        <input type="text" id="s1" class="search-input">
        <input type="text" id="s2" class="search-input">
        <span class="s1 pholder">请输入商品名</span>
        <span class="s2 pholder">搜商家名称</span>
        <button id="submit" class="btn-search" value="搜索">搜索</button>
    </div>
</div>
    <!-- <script src="js/jquery-1.8.2.min.js"></script> -->
    <script>
        $(function(){
            //通用头部搜索切换
            $('#search-hd .search-input').on('input propertychange',function(){
                var val = $(this).val();
                if(val.length > 0){
                    $('#search-hd .pholder').hide(0);
                }else{
                    var index = $('#search-bd li.selected').index();
                    $('#search-hd .pholder').eq(index).show().siblings('.pholder').hide(0);
                }
            })
            $('#search-bd li').click(function(){
                var index = $(this).index();
                $('#search-hd .pholder').eq(index).show().siblings('.pholder').hide(0);
                $('#search-hd .search-input').eq(index).show().siblings('.search-input').hide(0);
                $(this).addClass('selected').siblings().removeClass('selected');
                $('#search-hd .search-input').val('');
            });
        })
	</script>
<div id="show_commodity">
	<c:if test="${commodity.size()!=0}">
		<div id="commoditySet">
			<c:forEach items="${commodity}" var="commodity">
				<div id="commodity" onclick="chooseCommodity(${commodity.id})">
					<div id="commodity_pic">
						<img src="/file/${commodity.commoditypic}">
					</div>
					<div id="commodity_info">
						<div>${commodity.commodityname}</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div> <!-- style="float: left;" -->
			<c:if test="${nowPage!=1&&nowPage!=null}">
				<a href="commodity.action?selectCommodityByVagueNamePartly16&nowpage=${nowPage-1}&VagueName=${VagueName}">上一页</a>
			</c:if>
			<c:if test="${nowPage!=pageNum&&nowPage!=null}">
				<a href="commodity.action?selectCommodityByVagueNamePartly16&nowpage=${nowPage+1}&VagueName=${VagueName}">下一页</a>
			</c:if>
		</div>
	</c:if>
	<c:if test="${commodity.size()==0}">
		没有找到相关的宝贝
	</c:if>
</div>
</body>
</html>