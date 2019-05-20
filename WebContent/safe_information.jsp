<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.title{
	margin-top:10px;
	font-size: 14px;
    color: #014d7f;
    background-color: #f3f8fe;
    height: 30px;
    width: 800px;
    line-height: 30px;
}
table{
	margin-left: 5%;
}

.frame{
	width: 800px;
	height: 100%;
	border: 1px  solid #F7F7F7;
}
#emailUpdate{
	display: none;
	margin-left: 5%;
}
</style>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
function emailUpdate(){
	var style = $("#emailUpdate").css("display");
	if(style=="none")
		$("#emailUpdate").css({"display":"block"});
	else 
		$("#emailUpdate").css({"display":"none"});
}
function update(){
	var email = $("#email").val();
	var emailTest = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
	if(emailTest.test(email))
	{
		alert("修改成功");
		location.href="user.action?updateEmail&email="+email;
	}
	else 
		alert("邮箱格式错误");
}
</script>
</head>
<body>
	<div class="title">您的基础安全信息:</div>
	<div class="frame">
		<table>
			<tr><th>昵称:</th><td>${user.nickname}</td></tr>
			<tr><th>邮箱:</th><td>${user.email}</td><td><a href="#" onclick="emailUpdate()">修改邮箱</a></td></tr>		
		</table>
		<div id="emailUpdate">
			<input type="text" id="email" value="${user.email}">
			<input type="button" value="修改" onclick="update()">
		</div>
	</div>
</body>
</html>