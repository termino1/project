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
		   jQuery(document).on('click', '.mainMenu > a', function() {
		        jQuery('.mainMenu > ul').stop(true, false).slideUp(300);
		        jQuery(this).parent().find('ul').stop(true, false).slideToggle(300);
		    });
		   
	})
	
</script>
 <style>
 .nav_inner{border-top:1px solid #ccc;border-bottom:1px solid #ccc;position: relative;z-index: 9999;margin-bottom:30px}
 .mainMenu{display:inline-block;list-style: none;position: relative;width:13.8%}
 .mainMenu>a{display:block;padding:15px 0;text-align: center;font-size: 18px}
 .metaMenu{border:1px solid #ccc;width:150px;display:none;position: absolute;}
 .metaMenu.sel{display:block}
 .metaMenu>li{border-bottom:1px solid #ccc;list-style: none;background-color: #fff;}
 .metaMenu>li:last-child{border-bottom:none}
 .metaMenu>li>a{display:block;padding:7px;text-align: center}
 </style>
</head>
<body>
<div class="nav_inner">
	<div class="container">
		<ul class="row">
			<li class="mainMenu"><a href="#">악세사리</a>
			<ul class="metaMenu">
				<li><a href="${pageContext.request.contextPath}/user/1/1">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
			</ul>
			</li>
			<li class="mainMenu"><a href="#">패션소품</a>
			<ul class="metaMenu">
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
			</ul>
			</li>
			<li class="mainMenu"><a href="#">생활</a>
			<ul class="metaMenu">
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
			</ul>
			</li>
			<li class="mainMenu"><a href="#">디자인문구</a>
			<ul class="metaMenu">
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
			</ul>
			</li>
			<li class="mainMenu"><a href="#">반려동물</a>
			<ul class="metaMenu">
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
				<li><a href="#">서브메뉴</a></li>
			</ul>
			</li>
			<li class="mainMenu"><a href="#">제작요청</a>	</li>
			<li class="mainMenu"><a href="#">작가등록</a>	</li>
			
		</ul>
	</div>
	</div>
</body>
	</html>