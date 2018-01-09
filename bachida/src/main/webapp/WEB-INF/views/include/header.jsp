<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<script>
	$(function() {
		
		   
	})
	
</script>
 <style>
 .container{position: relative;}
 .navbar-brand {height: auto;padding:25px 10px;margin-right:20px}
 .navbar-brand img{width:100px}
 .topSearchArea {margin-top:22px}
 .topSearchArea input{line-height: 40px;border-radius: 4px 0 0 4px !important;height:40px;}
 .topSearchArea button.btn{line-height: 39px;padding:0 15px;width:auto;border-radius:  0 4px 4px 0 !important;margin-left:-5px}
 .top_link{position: absolute;right:10px;top:32px}
 .top_link>li{list-style: none;display: inline-block;margin:0 11px;position: relative;}
 .top_link>li>a{display: block;}
 .top_link>li:after{content:"|";color:#ccc;position: absolute;right:-15px;top:-1px}
 .top_link>li:last-child:after{content:""}
 .chartIcon{font-size: 24px;color:#999;vertical-align: middle}
 .chartIcon:hover{color:#f55980}
 .navbar-form .form-control{width:250px}
 </style>
</head>
<body>
	<div class="container">
		<a class="navbar-brand" href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/images/logo.png" alt="" /></a> 
		<form class="navbar-form topSearchArea" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-pink"><i class="glyphicon glyphicon-search"></i></button>
      </form>
      <ul class="top_link">
      	<li><a href="#">로그인</a></li>
      	<li><a href="#">회원가입</a></li>
      	<li><a href="${pageContext.request.contextPath}/user/view_cart"><i class="glyphicon glyphicon-shopping-cart chartIcon"></i></a></li>
      </ul>
	</div>

</body>
	</html>