<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="/bachida/images/logo.png" />
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script type="text/javascript" src="/bachida/js/bootstrap.js"></script>
<script>
	function getForm(addr) {
		var $form = $("<form></form>").appendTo("body");
		$form.attr("action", addr);
		$form.attr("method", "post");
		var $input = $("<input>").attr("type","hidden").attr("name", "${_csrf.parameterName}").val("${_csrf.token}").appendTo($form);
		return $form;
	}
	
	$(function(){
		$("#logo").on("click", function() {
			location.href="/bachida/";
		});
		$("#logoutBtn").on("click",function(e){
			e.preventDefault();
			var $form = getForm("/bachida/user/logout");
			$form.submit();
		})
		
		$("#msgBtn").on("click",function(e){
			e.preventDefault();
			window.open("/bachida/user/receiveMsgList","쪽지함","width=850,height=500");
		})
	})
</script>
<style>
	#logo {
	width: 180px;
	margin-top: 20px;
	margin-left: 20px;
	}
	a, a:link , a:hover, a:visited{
	text-decoration: none;
	color: black;
	}  
</style>
</head>
<body>
	<header>
		<img alt="bachida_logo" src="/bachida/images/logo.png" id="logo">
		
		<div class="pull-right">
		<div role="navigation">
		<ul class='nav nav-pills'>
			<li role="presentation"><a href="/bachida/admin/userList">관리자페이지</a></li>
			<li role="presentation"><a id="msgBtn" href="#">쪽지</a></li>
			<li role="presentation"><a id="logoutBtn" href="#">로그아웃</a></li>
		</ul>
		</div> 
		</div>
	</header>
	
	<div  role="navigation">
		<div class="clearfix" style="margin-bottom: 30px;"> 
			<ul class='nav nav-pills' id="mainNav">
				<li role="presentation"><a href="/bachida/admin/userList">회원목록</a></li>                           
				<li role="presentation"><a href="/bachida/admin/applyList">작가신청내역</a></li>
				<li role="presentation"><a href="/bachida/admin/reportList" >신고글목록</a></li>
				<li role="presentation"><a href="/bachida/admin/orderProductList" >주문관리</a></li>
				<li role="presentation"><a href="/bachida/admin/productCommentList" >상품평관리</a></li>
			</ul>           
		</div>
	</div>
	<section>  
		<jsp:include page="${viewName}" />          
	</section>
	<footer>footer</footer>
</body>
</html>