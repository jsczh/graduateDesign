<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<meta name="renderer" content="webkit" />
<meta name="author" content="PR" />
<meta name="copyright" content="PR" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<title>商品发布-选择分类</title>
<link rel="shortcut icon" href="img/public/favicon.ico" />
<link rel="stylesheet" href="css/style.css"/>
<script src="js/jquery-1.8.2.min.js"></script>
</head>
<body>
<div class="contains">
	<!--面包屑导航-->
	<div class="crumbNav">
		<a href="demo.html">首页</a>
		<font>&gt;</font>
		选择商品所在分类
	</div>
	<!--商品分类-->
    <div class="wareSort clearfix">
		<ul id="sort1"></ul>
		<ul id="sort2" style="display: none;"></ul>
		<ul id="sort3" style="display: none;"></ul>
	</div>
	<div class="selectedSort"><b>您当前选择的商品类别是：</b><i id="selectedSort"></i></div>
	<div class="wareSortBtn">
		<input id="releaseBtn" type="button" value="下一步" disabled="disabled"/>
	</div>
	<script src="js/jquery.sort.js"></script>
</div>
</body>
</html>