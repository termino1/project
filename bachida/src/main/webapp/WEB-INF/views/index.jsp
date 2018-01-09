<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다</title>
<link rel="shortcut icon" type="image/x-icon" href="/bachida/images/logo.png" />
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script type="text/javascript" src="/bachida/js/bootstrap.js"></script>

<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script> -->
</head>
<script>
	function getForm(addr) {
		var $form = $("<form></form>").appendTo("body");
		$form.attr("action", addr);
		$form.attr("method", "post");
		var $input = $("<input>").attr("type","hidden").attr("name", "${_csrf.parameterName}").val("${_csrf.token}").appendTo($form);
		return $form;
	}
	
	$(function(){
		var mainList;
		var metaList = "";
		var sessionUser = ${sessionScope.user};
		var authorities = sessionUser.authorities;
		if(authorities!=null){
			if(authorities.length>=3){
				$("#myPageLi").hide();
				$("#cartLi").hide();
				$("#managerHeader").hide();
				$("#userInfo").hide();
			}
		}
		$.ajax({
			url : "/bachida/userInfo",
			data : "${_csrf.parameterName}=${_csrf.token}",
			type : "post",
			success: function(userInfo){
				console.log(userInfo);
				if(userInfo.id != "guest"){
					var userId = userInfo.id;
					$("#artisanHome").attr("data-id",userId);
					
					// 쪽지 정보 가져오기 -> 배지 추가
					$.ajax({
						url:"/bachida/getUnreadMessage",
						type:"post",
						data:{"id" : userId,'${_csrf.parameterName}':'${_csrf.token}'},
						success:function(result){
							if(result>0)
								$("<span class='badge'></span>").text(result).css({"background-color":"white","color":"red"}).appendTo($("#msgBtn"));
							//<span class="badge">4</span>
						}
					});
				}else{
					$("#userInfo").hide();
				}
				$("#userId").text(userInfo.name).css("color","rgb(245, 89, 128)");
				$("#userPoint").text(userInfo.cash).css("color","darkblue");
			}
		});
		
		
		function getCategoryList(){
			$.ajax({
				url : "/bachida/init",
				success:function(map){
					mainList = JSON.parse(map.mainList);
					metaList = JSON.parse(map.metaList);
					 var navUl = $("#mainNav");
					  $.each(mainList,function(i, main){
						  var navLi = $("<li role='presentation' class='dropdown'></li>");
						  var navLink = $("<a class='dropdown-toggle' data-toggle='dropdown' data-target='#' aria-haspopup='true' aria-expanded='false' href='#' ></a>");
						  navLink.attr("id","main"+main.mainCategoryIdx).text(main.mainCategoryName).attr("data-idx",main.mainCategoryIdx);
						  navLi.html(navLink);
						  navUl.prepend(navLi);
						  
						  var dropdownUl = $("<ul class='dropdown-menu' role='menu'></ul>").appendTo(navLi);
						  $.each(metaList,function(i,meta){
							  
							  if(navLink.attr("data-idx")==meta.mainCategoryIdx){
								dropdownUl.attr("aria-labelledby","main"+meta.mainCategoryIdx);  
								var dropdownLi = $("<li role='presentation'></li>").appendTo(dropdownUl);
								var dropdownLink = $("<a role='menuitem'></a>").attr("href","/bachida/product/"+meta.mainCategoryIdx+"/"+meta.metaCategoryIdx).text(meta.metaCategoryName);
								dropdownLi.html(dropdownLink);
							  }  
						  })
					  }); 
				}
			});
		}
/* 
		 $("ul#mainNav").on("hover","li.dropbox",function(){
			  alert($(this));
			$(this).find(".dropdown-menu").stop(true, true).delay(100).fadeIn(500);
		  },function(){
			$(this).find(".dropdown-menu").stop(true, true).delay(100).fadeOut(500);
		  });
		 */
		getCategoryList();
		
		$("#apply").on("click",function(e){
			e.preventDefault();
			if(sessionUser != "guest" && authorities.length>=2){
				alert("이미 작가회원입니다");
			}else{
				window.open("/bachida/user/artisanApply","작가신청","width=900,height=450");
			}
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
			
		
		
		/* $(".report").on("click",function(e){
			e.preventDefault();
			var id = $(this).attr("href");
			//window.open("/bachida/user/writeReport","작가신청","width=900,height=450");
		}); */
		
		$("#artisanHome").on("click",function(e){
			e.preventDefault();
			window.open("/bachida/artisantimeline/timeline_list?artisanId="+$(this).attr("data-id"));
		});
		
		/* $('.dropdown-button').dropdown({
		      inDuration: 300,
		      outDuration: 225,
		      constrainWidth: false, // Does not change width of dropdown to that of the activator
		      hover: false, // Activate on hover
		      gutter: 0, // Spacing from edge
		      belowOrigin: true, // Displays dropdown below the button
		      alignment: 'left', // Displays dropdown with edge aligned to the left of button
		      stopPropagation: false // Stops event propagation
		    }
		  ); */
		 
		 

		// 탑버튼
		$(window).scroll(function() {
			if($(this).scrollTop() > 500) {	// 스크롤함수
				$("#topBtn").fadeIn();	
			} else {
				$("#topBtn").fadeOut();
			}
		});
		$("#topBtn").on("click", function() {	// 탑버튼 이미지 클릭
			$('html, body').animate({	// animation으로 화면 맨 위로 올라가도록 설정
				scrollTop : 0
			}, 400);
			return false;
		});
		
		// 바치다 로고
		$("#logo").on("click", function() {
			location.href="/bachida/";
		});
		
		// 통합검색
		$("#searchBtn1").on("click", function() {	// 검색버튼 클릭할 때
			var $form = $("<form></form>");
			$form.attr("action", "/bachida/pcustom/search_list_pcustom1");
			$form.attr("method", "get");
			$("#search").wrap($form);
		});
		$("#keyword1").on("keydown", function(e) {	// 검색 인풋창에서 엔터 누를 때
			if(e.keyCode == 13) {
				//console.log($("#keyword").val());	// 파란
				var $form = $("<form></form>").appendTo("body");
				$form.attr("action", "/bachida/pcustom/search_list_pcustom1");
				$form.attr("method", "get");
				$("<input>").attr("type", "hidden").attr("name", "keyword1").val($("#keyword1").val()).appendTo($form);
				$form.submit();
			}
		});
	});
</script>
<style>

a, a:link , a:hover, a:visited{
	text-decoration: none;
	color: black;
}  
/* nav ul li {
float: left;
list-style: none;
margin-right: 20px;
} */
header{
	min-height: 80px;position: relative;
}
#topBtn {
    position: fixed;	/* 화면에 고정 */
    right: 2%;			/* 버튼 위치 설정 */
    bottom: 50px;
    display: none;		/* 화면에서 숨김 */
    z-index: 999;		/* 다른 태그들보다 위로 오도록 설정 */
}
#logo {
	width: 180px;
	margin-top: 20px;
	margin-left: 20px;
}
#logo:hover {
	cursor: pointer;
}

.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
}
#search {position: absolute;left:230px;top:30px}
#search .form-control.input-lg{font-size: 17px}
</style>
<body>
	<header>
		<img alt="bachida_logo" src="/bachida/images/logo.png" id="logo">
		<!-- <a href="/bachida/" style="font-size: -webkit-xxx-large; font-weight: bolder; color: blueviolet; margin:20px;">바치:다</a> -->
		
			<sec:authorize access="isAnonymous()">
				<jsp:include page="header/anonymous.jsp"/>
			</sec:authorize>               
			<sec:authorize access="hasRole('ROLE_USER')">
				<jsp:include page="header/user.jsp"/>                  
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_MANAGER')">
				<jsp:include page="header/manager.jsp"/>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<jsp:include page="header/admin.jsp"/>
			</sec:authorize>
		<div class="pull-right" style="display: inline-grid; margin-top: 5px;" id="userInfo">
		<span><span id="userId"></span> 님 안녕하세요!</span>
		<span>캐쉬 : <span id="userPoint"></span>원</span>
		</div>
		
		
		<!-- 검색바 -->
	<div id="search" class="form-inline">
		<input type="text" id="keyword1" name="keyword1" class="form-control input-lg" placeholder="핸드메이드 플랫폼 바치:다">
		<button type="submit" id="searchBtn1" class="glyphicon glyphicon-search btn btn-default btn-lg">검색</button>
	</div>
	</header>
	
	<div  role="navigation">
	<hr style="margin-bottom: 0px;">
			<!-- <a href="/bachida/" class="brand-logo center">바치:다</a> -->
		 <div class="clearfix" style="margin-bottom: 30px;"> 
		<ul class='nav nav-tabs' id="mainNav">
		<!-- 
			<li role="presentation" class="dropdown">
				<a id="main1" class="dropdown-toggle" data-toggle="dropdown" data-target="#" aria-haspopup="true" aria-expanded="false" href="/bachida/product/1/1">악세사리</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="main1">
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/1/1">반지</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/1/2">귀걸이</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/1/3">목걸이</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/1/4">팔찌</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/1/5">기타</a></li>
		  		</ul>     
			</li>                    
			<li role="presentation" class="dropdown">
				<a id="main2" class="dropdown-toggle" data-toggle="dropdown" data-target="#" aria-haspopup="true" aria-expanded="false" href="/bachida/product/2/1">패션소품</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="main2">
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/2/6">의류</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/2/7">가방</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/2/8">지갑</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/2/9">파우치</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/2/10">폰케이스</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/2/11">키즈</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/2/12">기타</a></li>
		  		</ul>
			</li>                                                 
			<li role="presentation" class="dropdown">
				<a id="main3" class="dropdown-toggle" data-toggle="dropdown" data-target="#" aria-haspopup="true" aria-expanded="false" href="/bachida/product/3/1">생활</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="main3">
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/3/13">인테리어</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/3/14">주방</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/3/15">플라워가든</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/3/16">캔들</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/3/17">디퓨저</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/3/18">비누</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/3/19">기타</a></li>
				</ul>
			</li>
			<li role="presentation" class="dropdown">
				<a id="main4" class="dropdown-toggle" data-toggle="dropdown" data-target="#" aria-haspopup="true" aria-expanded="false" href="/bachida/product/4/1">디자인문구</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="main4">
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/4/20">엽서</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/4/21">필기도구</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/4/22">피규어</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/4/23">캐릭터</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/4/24">아트</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/4/25">기타</a></li>
				</ul>
			</li>
			<li role="presentation" class="dropdown">
				<a id="main5" class="dropdown-toggle" data-toggle="dropdown" data-target="#" aria-haspopup="true" aria-expanded="false" href="/bachida/product/5/1">반려동물</a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="main5">
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/5/26">소품</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/5/27">악세사리</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/5/28">간식</a></li>
				    <li role="presentation"><a role="menuitem"  href="/bachida/product/5/29">기타</a></li>
				</ul>
			</li> -->
			<li role="presentation" class="pull-right"><a href="#" id="apply">작가신청</a></li>
			<li role="presentation" class="pull-right"><a href="#" >공지사항</a></li>
			<li role="presentation" class="pull-right"><a href="#" >QnA</a></li>
			<li role="presentation" class="pull-right"><a href="/bachida/custom/list">제작요청</a></li>
		</ul>           
		 </div>   
		   
	<!-- 	<hr>
		이부분 완성되면 지워야함
		<div class="clearfix">                                       
			<ul class='nav nav-tabs'>
			<li><a href="/bachida/custom/list">제작요청</a></li>
			<li><a href="/bachida/pcustom/list_pcustom">1:1제작요청</a></li>
			<li><a href="/bachida/user/join">회원가입</a></li>
			<li><a href="#" id="apply">작가신청</a></li>    
			<li><a href="#" id="artisanHome">작가홈</a></li>
			<li><a href="/bachida/user/writeReport/canon90" class="report">신고</a></li>
			<li><a href="/bachida/user/listReport">신고내역 보기</a></li>
			<li><a href="/bachida/product/1/1">상품목록</a></li>
			<li><a href="/bachida/product/view_cart">장바구니</a></li>
			<li><a href="/bachida/product/choose_product">찜상품</a></li>
			                                    
			</ul>
		</div>   -->
		                              
		</div>
		
	<section style="min-height:600px;">  
		<jsp:include page="${viewName}" /> 
		<!-- 탑버튼 -->
		<img alt="top_button" src="/bachida/images/top_button.PNG" id="topBtn">         
	</section>
	<footer>
		<jsp:include page="include/footer.jsp" />          
	</footer>
</body>
</html>