<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收货地址</title>
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/Popt.js"></script>
<script src="js/cityJson.js"></script>
<script src="js/citySet.js"></script>
<style type="text/css">
	a{text-decoration:none;} 
	table.hovertable {
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
	.address{
		width:100%;
		height:100%;
	}
	.addressTit{
		margin-top:10px;
		font-size: 14px;
	    color: #014d7f;
	    background-color: #f3f8fe;
	    height: 30px;
	    width: 800px;
	    line-height: 30px;
	}
	.addAddress, .a-recipient, .a-area, .a-detailAddress{
		margin-top: 10px;
	}
	.a-label{
		float:left;
		text-align:right;
		width: 100px;
		height: 30px;
	}
	.a-input{
		width: 200px;
		height: 30px;
	}
* { -ms-word-wrap: break-word; word-wrap: break-word; }
html { -webkit-text-size-adjust: none; text-size-adjust: none; }
html, h1, h2, h3, h4, h5, h6, ol, li, dl, dt, dd, iframe, textarea, button, p, strong, b, i, span, del, pre, form, fieldset, .pr, .pc { margin: 0; padding: 0; word-wrap: break-word; font-family: verdana,Microsoft YaHei,Tahoma,sans-serif; *font-family: Microsoft YaHei,verdana,Tahoma,sans-serif; }
body, ul, ol, dl, dd, p, h1, h2, h3, h4, h5, h6, form, fieldset, .pr, .pc, em, del { font-style: normal; font-size: 100%; }
ul, ol, dl { list-style: none; }
._citys { width: 450px; display: inline-block; border: 2px solid #eee; padding: 5px; position: relative; }
._citys span { color: #56b4f8; height: 15px; width: 15px; line-height: 15px; text-align: center; border-radius: 3px; position: absolute; right: 10px; top: 10px; border: 1px solid #56b4f8; cursor: pointer; }
._citys0 { width: 100%; height: 34px; display: inline-block; border-bottom: 2px solid #56b4f8; padding: 0; margin: 0; }
._citys0 li { display: inline-block; line-height: 34px; font-size: 15px; color: #888; width: 80px; text-align: center; cursor: pointer; }
.citySel { background-color: #56b4f8; color: #fff !important; }
._citys1 { width: 100%; display: inline-block; padding: 10px 0; }
._citys1 a { width: 83px; height: 35px; display: inline-block; background-color: #f5f5f5; color: #666; margin-left: 6px; margin-top: 3px; line-height: 35px; text-align: center; cursor: pointer; font-size: 13px; overflow: hidden; }
._citys1 a:hover { color: #fff; background-color: #56b4f8; }
.AreaS { background-color: #56b4f8 !important; color: #fff !important; }

#addressButton input { width: 200px; height: 36px; border: 1px solid #ed7f5a; -webkit-border-radius: 2px; -moz-border-radius: 2px; border-radius: 2px; background-color: #ed7f5a; color: #fff; float: left;margin-left: 100px;}
#addressButton input:hover { border-color: #d95459; background-color: #d95459; }

#upd{display:none;}
</style>

<script type="text/javascript">

function upd(id){
	$.post("address.action?selectByAddressId",{addressid:id},function(data){

			$("#addressid").val(id)
			$("#recipient").val(data.recipient);
			$("#city").val(data.address);
			$("#detailAddress").val(data.detailaddress);
			$("#cellphone").val(data.cellphone);
			$("#zipcode").val(data.zipcode);
			var style = $("#upd").css("display");
			if(style=="none")
			{
				$("#upd").css({"display":"block"});
				$("#sav").css({"display":"none"});
			}
	});
}
$(document).ready(function(){
	$("#sav").click(function(){
		$("#addressForm").attr({"action":"address.action?addAddress"});
		$("#addressForm").submit();
	});
	$("#upd").click(function(){
		$("#addressForm").attr({"action":"address.action?updateAddress"});
		$("#addressForm").submit();
	});
});
</script>
</head>
<body>
	<div class="address">
		<c:if test="${empty address}">
			您尚未设置收货地址
		</c:if>
		<c:if test="${!empty address}">
			<table class="hovertable">
				<tr><th width="64.8">收货人</th><th width="140">所在地区</th>
					<th width="200">详细地址</th><th width="60">邮编</th>
					<th width="129.6">电话/手机</th><th width="102.4">操作</th>
				</tr>
				<c:forEach items="${address}" var="address">
					<tr onmouseover="this.style.backgroundColor='#DEDEDE';" onmouseout="this.style.backgroundColor='#F7F7F7';">
						<td>${address.recipient}</td><td>${address.address}</td>
						<td>${address.detailaddress}</td>
						<td>${address.zipcode}</td><td>${address.cellphone}</td>
						<td><a href="address.action?deleteByAddressId&id=${address.id}">删除</a>|<a href="#" onclick="upd(${address.id})">修改</a></td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
			<div class="addAddress">
				<div class="addressTit">收货地址</div>
				<div style="margin: 5px; margin-left: 0px;">新增收货地址　收件人，手机号，地址为必填项</div>
				<form action="" method="post" id="addressForm">
					<input type="hidden" id="addressid" name="addressid">
					<div class="a-recipient">
						<label class="a-label" for="recipient">收件人:</label>
						<input type="text" class="a-input" id="recipient" name="recipient" placeholder="长度不超过十个字">
					</div>
					<div style="clear: both;"></div>
					<div class="a-area">
						<label class="a-label" for="city">所在地区:</label>
						<select style="width: 100px;height: 30px;">
							<option>中国大陆</option>
						</select>
						<input type="text" id="city" class="a-input" placeholder="请选择地址所在地" name="address">
					</div>
					<div style="clear: both;"></div>
					<div class="a-detailAddress">
						<label for="detailAddress" class="a-label" style="vertical-align: top;">详细地址:</label>
						<textarea rows="4" cols="40" id="detailAddress" maxlength="100"  name="detailaddress"></textarea>
					</div>
					<div class="a-detailAddress">
						<label for="cellphone" class="a-label">手机号码:</label>
						<input type="text" class="a-input" id="cellphone" name="cellphone">
					</div>
					<div class="a-detailAddress">
						<label for="zipcode" class="a-label">邮编:</label>
						<input type="text" class="a-input" id="zipcode" name="zipcode" placeholder="若不清楚可填000000">
					</div>
					<div id="addressButton" style="margin-top: 5px;">
						<input type="button" id="sav" value="保存">
						<input type="button" id="upd" value="修改">
					</div>
				</form>
			</div>
		
	</div>
	
	<script type="text/javascript">
		$("#city").click(function (e) {
			SelCity(this,e);
		    console.log("inout",$(this).val(),new Date())
		});
	</script>
</body>
</html>