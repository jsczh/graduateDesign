<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户注册</title>
<link rel="stylesheet" type="text/css" href="css/register.css"/>
<script src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
	var shop_reg = new Array("0","0","0","0","0");
	function usernameCheck(){
		var username = $("#username").val();
		var startcheck = /^[A-Za-z][A-Za-z0-9]*$/;
		var formcheck = /^[A-Za-z0-9]{6,18}$/;
		if(username=="")
		{
			$("#usernamehint").css({"background-image":"none",
							"color":"red"});
			$("#usernamehint").html("账号不能为空");
			shop_reg[0] = 0;
		}
		else if(!startcheck.test(username))
		{
			$("#usernamehint").css({"background-image":"none",
							"color":"red"});
			$("#usernamehint").html("账号必须以英文字母开头");
			shop_reg[0] = 0;
		}
		else if(!formcheck.test(username))
		{
			$("#usernamehint").css({"background-image":"none",
							"color":"red"});
			$("#usernamehint").html("账号必须由6-18位字母或者数字组成");
			shop_reg[0] = 0;
		}
		else
		{
			$.post("user.action?checkUsernameExist",{
				username:username
			},function(data){
		    	if("success"==data)
		    	{
		    		$("#usernamehint").html("");
					$("#usernamehint").css({"background-image":"url(img/right.png)",
									"background-position":"left",
									"background-repeat":"no-repeat"});
					shop_reg[0] = 1;
					buttonCheck();
		    	}
		    	else
		    	{
		    		
					$("#usernamehint").css({"background-image":"none",
						"color":"red"});
					$("#usernamehint").html("用户名已存在");
					shop_reg[0] = 0;
		    	}
		    });
			
		}
		buttonCheck();
	}
	function passwordCheck(){
		var password = $("#password").val();
		if(password=="")
		{
			$("#passhint").css({"background-image":"none",
							"color":"red"});
			$("#passhint").html("密码不能为空");
			shop_reg[1] = 0;
		}
		else if(password.length<6)
		{
			$("#passhint").css({"background-image":"none",
							"color":"red"});
			$("#passhint").html("密码过短");
			shop_reg[1] = 0;
		}
		else
		{
			$("#passhint").html("");
			$("#passhint").css({"background-image":"url(img/right.png)",
							"background-position":"left",
							"background-repeat":"no-repeat"});
			shop_reg[1] = 1;
			buttonCheck();
		}
		buttonCheck();
		if($("#confirmpass").val()!= "")
			passwordConfirm();
	}
	function passwordConfirm(){
		var password = $("#password").val();
		var confirmpass = $("#confirmpass").val();
		if(confirmpass=="")
		{
			$("#confirmpasshint").css({"background-image":"none",
							"color":"red"});
			$("#confirmpasshint").html("请再次输入密码");
			shop_reg[2] = 0;
		}
		else if(password!=confirmpass)
		{
			$("#confirmpasshint").css({"background-image":"none",
							"color":"red"});
			$("#confirmpasshint").html("两次输入的密码不一致");
			shop_reg[2] = 0;
		}
		else
		{
			$("#confirmpasshint").html("");
			$("#confirmpasshint").css({"background-image":"url(img/right.png)",
							"background-position":"left",
							"background-repeat":"no-repeat"});
			shop_reg[2] = 1;
			buttonCheck();
		}
		buttonCheck();
	}
	function emailCheck(){
		var emailTest = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
		var email = $("#email").val();
		if(emailTest.test(email))
		{
			$.post("user.action?checkEmailExist",{
				email:email
			},function(data){
		    	if("success"==data)
		    	{
		    		$("#emailhint").html("");
					$("#emailhint").css({"background-image":"url(img/right.png)",
									"background-position":"left",
									"background-repeat":"no-repeat"});
					shop_reg[3] = 1;
					buttonCheck();
		    	}
		    	else
		    	{
					$("#emailhint").css({"background-image":"none",
						"color":"red"});
					$("#emailhint").html("该邮箱已注册");
					shop_reg[3] = 0;
		    	}
		    });
		}
		else 
		{
			$("#emailhint").css({"background-image":"none",
				"color":"red"});
			$("#emailhint").html("邮箱格式不规范");
			shop_reg[3] = 0;
		}
	}
	function nicknameCheck(){
		var nickname = $("#nickname").val();
		if(nickname!=""){
			$.post("user.action?checkNicknameExist",
					{nickname:nickname},function(data){
						if("success"==data){
							$("#nicknamehint").html("");
							$("#nicknamehint").css({"background-image":"url(img/right.png)",
								"background-position":"left","background-repeat":"no-repeat"});
							shop_reg[4] = 1;
							buttonCheck();
						}
						else 
						{
							$("#nicknamehint").css({"background-image":"none","color":"red"});
							$("#nicknamehint").html("昵称已存在");
							shop_reg[4] = 0;
						}
			});
		}
		else
		{
			$("#nicknamehint").css({"background-image":"none","color":"red"});
			$("#nicknamehint").html("昵称不能为空");
			shop_reg[4] = 0;
		}
		
	}
	
	function buttonCheck(){
		if(shop_reg[0] == 1 && shop_reg[1] == 1 && shop_reg[2] == 1 && shop_reg[3] == 1 && shop_reg[4] == 1)
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
		if(shop_reg[0] == 1 && shop_reg[1] == 1 && shop_reg[2] == 1 && shop_reg[3] == 1 && shop_reg[4] == 1)
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
	<form id="regis" autocomplete="off" method="post" action="user.action?insertUser">
		<div class="reg">
			<div class="reg-username">
				<label for="username" class="r-label">账号:</label>
				<input type="text" id="username" name="username" class="r-input" placeholder="6-18位字母数字组合" maxlength="20" onblur="usernameCheck()">
				<div class="hint" id="usernamehint"></div>
			</div>
			<div class="reg-pass">
				<label for="password" class="r-label">密码:</label>
				<input type="password" id="password" name="password" class="r-input" placeholder="6-16位密码区分大小写" maxlength="16" onblur="passwordCheck()">
				<div class="hint" id="passhint"></div>
			</div>
			<div class="reg-confirmpass">
				<label for="confirmpass" class="r-label">确认密码:</label>
				<input type="password" id="confirmpass" name="" class="r-input" placeholder="再次输入密码" maxlength="20" onblur="passwordConfirm()">
				<div class="hint" id="confirmpasshint"></div>
			</div>
			<div class="reg-email">
				<label for="phone" class="r-label">邮箱:</label>
				<input type="text" id="email" name="email" class="r-input" placeholder="邮箱号" maxlength="20" onblur="emailCheck()">
				<div class="hint" id="emailhint"></div>
			</div>
			<div class="reg-nickname">
				<label for="phone" class="r-label">昵称:</label>
				<input type="text" id="nickname" name="nickname" class="r-input" placeholder="昵称仅能使用汉字，字母，数字" maxlength="10" onblur="nicknameCheck()">
				<div class="hint" id="nicknamehint"></div>
			</div>
			<div class="reg-button">
				<label for="submit" class="r-label"></label>
				<div class="reg-submit" id="submit" onclick="unitTest()">注&nbsp;&nbsp;册</div>
			</div>
		</div>
			
	</form>
</body>
</html>