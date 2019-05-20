<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>

<style type="text/css">
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
</style>
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript">
var sizeCheck = 0;
function Inputcheck(){
	var commodityname = $("#commodityname").val();
	var price = $("#price").val();
	var remain = $("#remain").val();
	var commoditypic = $("#commoditypic").val();
	var flag = 1;
	
	if(commodityname == "" || price == "" || commoditypic == "" || remain == "")
	{
		alert("请完整填写商品信息(包括商品图片)");
		flag=0;
	}else{
		if(!/^([\u4E00-\u9FA5]|[0-9A-Za-z])([\u4E00-\u9FA5]|[0-9A-Za-z]|\s|\/|\*|\+){1,49}$/.test(commodityname)){//商品名验证
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
			alert("发布成功！")
			$("#form1").submit();
		}
	}
}



function addSize(){
	var style = $("#showSize").css("display");
	if(style=="block")
	{
		$("#showSize").css({"display":"none"});
	}
	else 
		$("#showSize").css({"display":"block"});
}


</script>
</head>
<body>

<form id="form1" method="post" enctype="multipart/form-data"  action="commodity.action?addCommodity">
<div class="contains">
	<div class="crumbNav" style="margin-left: 100px;">
		<a href="demo.html">首页</a>
		<font>&gt;</font>
		<a href="choose_type.jsp">选择商品所在分类</a>
		<font>&gt;</font>
		发布商品
	</div>
	<div class="c-left" style="border:1px solid #F7F7F7;">
		<div class="c-commodityName">
	    	<label class="r-label">商品名:</label>
	    	<input type="text" class="r-input" id="commodityname" name="commodityname" placeholder="请填写商品名  1-25个字" maxlength="30">
	    	<div style="clear: both;"></div>
	    	<div id="commodityNameHint"><a></a></div>
	    </div>
		<div class="c-price">
	    	<label class="r-label">价格:</label>
	    	<input type="text" class="r-input" id="price" name="price" placeholder="请填写价格 小数点左最高7位，小数点右最高两位" maxlength="9">
	    	<div style="clear: both;"></div>
	    	<div id="priceHint"><a></a></div>
	    </div> 
	    <div class="c-remains">
	    	<label class="r-label">库存量:</label>
	    	<input type="text" class="r-input" id="remain" name="remain" placeholder="请填写库存量  最高为9999" maxlength="4">
	    	<div style="clear: both;"></div>
	    	<div id="remainHint"><a></a></div>
	    </div>
	    <div class="SKU">
			<input id="addCom" type="button" value="尺寸&nbsp;/&nbsp;颜色" onclick="addSize()" >
		</div>
		<div style="clear: both;"></div>
		<div id="showSize">
			<h4>不用可以不填，想多添加尺寸请到商品管理页</h4>
			<div style="border-bottom: 1px solid #ddd;">
				尺寸1：<input type="text" placeholder="请输入尺寸1" id="size1" name="size1"><br>
				颜色1：<input type="text" placeholder="请输入颜色1" id="color1" name="color1"><br>
				库存1：<input type="text" placeholder="请输入库存1" id="remain1" name="remain1"><br>
			</div>
			<div style="border-bottom: 1px solid #ddd;">
				尺寸2：<input type="text" placeholder="请输入尺寸2" id="size2" name="size2"><br>
				颜色2：<input type="text" placeholder="请输入颜色2" id="color2" name="color2"><br>
				库存2：<input type="text" placeholder="请输入库存2" id="remain2" name="remain2"><br>
			</div>
			<div style="border-bottom: 1px solid #ddd;">
				尺寸3：<input type="text" placeholder="请输入尺寸3" id="size3" name="size3"><br>
				颜色3：<input type="text" placeholder="请输入颜色3" id="color3" name="color3"><br>
				库存3：<input type="text" placeholder="请输入库存3" id="remain3" name="remain3"><br>	
			</div>
			<input type="hidden" id="SKUCheck" name="SKUCheck" value="0">
			<input type="button" id="left_info_submit" value="完成" onclick="sizeCheck()">
		</div>
	</div>
	<div class="c-showPic" style="border:1px solid #F7F7F7;">
		<label class="r-label">商品图片:</label>
		<input type="file" name="commoditypic" id="commoditypic" multiple="multiple"/>
    	<br><br><img src="" id="showpic" width="244px" height="" name="showpic">
	</div>
	<input type="hidden" name="category" value="${param.category}">
	<div class="wareSortBtn">
		<input id="addCom" type="button" value="发&nbsp;&nbsp;&nbsp;&nbsp;布" onclick="Inputcheck()"  style="margin-top: 20px;">
	</div>
</div>
</form>
<script>
    $("#commoditypic").change(function(){
        var objUrl = getObjectURL(this.files[0]) ;
        console.log("objUrl = "+objUrl) ;
        if (objUrl) 
        {
            $("#showpic").attr("src", objUrl);
          /*   $("#img").removeClass("hide"); */
        }
    }) ;
    //建立一個可存取到該file的url
    function getObjectURL(file) 
    {
        var url = null ;
        if (window.createObjectURL!=undefined) 
        { // basic
            url = window.createObjectURL(file) ;
        }
        else if (window.URL!=undefined) 
        {
            // mozilla(firefox)
            url = window.URL.createObjectURL(file) ;
        } 
        else if (window.webkitURL!=undefined) {
            // webkit or chrome
            url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
    }
    function sizeCheck(){
    	var size1 = $("#size1").val();
    	var color1 = $("#color1").val();
    	var remain1 = $("#remain1").val();
    	var flag = 0;
    	if(size1!=""||color1!="")
    	{
    		if(remain1=="")
    		{
    			alert("请填写库存量");
    			$("#size1").val("");
    			$("#color1").val("");
    			$("#SKUCheck").val("0")
    			flag = 1;
    		}
    	}
    	else if(size1==""&&color1=="")
    	{
    		if(remain1!="")
    		{
    			alert("没有尺寸颜色，无需填写库存");
    			$("#remain1").val("");
    			$("#SKUCheck").val("0")
    			flag = 1;
    		}
    	}
    	var size2 = $("#size2").val();
    	var color2 = $("#color2").val();
    	var remain2 = $("#remain2").val();
    	if(size2!=""||color2!="")
    	{
    		if(remain2=="")
    		{
    			alert("请填写库存量");
    			$("#size2").val("");
    			$("#color2").val("");
    			$("#SKUCheck").val("0")
    			flag = 1;
    		}
    	}
    	else if(size2==""&&color2=="")
    	{
    		if(remain2!="")
    		{
    			alert("没有尺寸颜色，无需填写库存");
    			$("#remain2").val("");
    			$("#SKUCheck").val("0")
    			flag = 1;
    		}
    	}
    	var size3 = $("#size3").val();
    	var color3 = $("#color3").val();
    	var remain3 = $("#remain3").val();
    	if(size3!=""||color3!="")
    	{
    		if(remain3=="")
    		{
    			alert("请填写库存量");
    			$("#size3").val("");
    			$("#color3").val("");
    			$("#SKUCheck").val("0")
    			flag = 1;
    		}
    	}
    	else if(size3==""&&color3=="")
    	{
    		if(remain3!="")
    		{
    			alert("没有尺寸颜色，无需填写库存");
    			$("#remain3").val("");
    			$("#SKUCheck").val("0")
    			flag = 1;
    		}
    	}
    	
    	if(flag==0){
    		alert("设置尺寸/颜色成功");
    		$("#showSize").css({"display":"none"})
    		$("#SKUCheck").val("1")
    	}
    }
</script>
</body>
</html>