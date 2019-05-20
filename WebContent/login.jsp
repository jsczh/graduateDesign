<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
    width: 340px;
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
	height: 46px;
	max-height: 60px;
	overflow: hidden;
	font-size: 16px;
	line-height: 46px;		//保证字体垂直居中
	text-align: center;
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
.log{
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
	opacity: 1;	//设置div不透明度
/*  	cursor: default;	//设置光标类型  */
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
    cursor: pointer; 
}

</style>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
function login(){
	var username = $("#username").val();
	var password = $("#password").val();
	if(username == "" || password == ""){
		$("#loginhint").css({"background-image":"none",
			"color":"red"});
		$("#loginhint").html("账号或密码不能为空");
	}
	if(username != "" && password != "")
		$("#login").submit();
}
</script>
</head>
<body>
	<form id="login" autocomplete="off" method="post" action="user.action?login">
		<div class="log">
			<div class="reg-username">
				<label for="username" class="r-label">账号:</label>
				<input type="text" id="username" name="username" class="r-input" placeholder="6-18位字母数字组合" maxlength="20" onblur="usernameCheck()">
			</div>
			<div style="clear:both;"></div>
			<div class="reg-pass">
				<label for="password" class="r-label">密码:</label>
				<input type="password" id="password" name="password" class="r-input" placeholder="6-16位密码区分大小写" maxlength="16" onblur="passwordCheck()">
			</div>
			<div style="clear:both;"></div>
			<div class="reg-button">
				<label for="submit" class="r-label"></label>
				<div class="reg-submit" id="submit" onclick="login()">登&nbsp;&nbsp;录</div>
			</div>
			<div style="clear:both;"></div>
			<div>
				<label class="r-label"></label>
				<div class="hint" id="loginhint"></div>
			</div>
		</div>
	</form>
</body>
</html>