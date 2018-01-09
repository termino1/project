<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 작가홈</title>
<link rel="shortcut icon" type="image/x-icon" href="/bachida/images/logo.png" />
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script type="text/javascript" src="/bachida/js/bootstrap.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- 
<script type="text/javascript" src="/bachida/js/materialize.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link type="text/css" rel="stylesheet" href="/bachida/css/materialize.min.css"  media="screen,projection"/>
 -->
</head>
<script>
	$(function(){
		var map = ${sessionScope.map};
		var artisan = map.artisan;
		var artisanName = artisan.artisanName;
		var artisanId = artisan.artisanId;
		$(".artisanHome").attr("data-id",artisanId);
		$(".salesList").attr("data-id",artisanId);
		$(".figuresList").attr("data-id",artisanId);

		$("#header_artisanName").text(artisanName).attr("data-id",artisanName);


		$("#infoUpdate").attr("data-id",artisanId);
		$("#header_artisanName").text(artisanName).attr("data-id",artisanId);

		var name = ${sessionScope.name};
		
		if(artisanId==name){
			console.log("작가네비!!");
			$("#allNav ul").hide();
		}else{
			$("#artisanNav ul").hide();
			$("#artisanNav").addClass("display");
			
		}
		
		/* 
		$('.dropdown-button').dropdown({
		      inDuration: 300,
		      outDuration: 225,
		      constrainWidth: false, // Does not change width of dropdown to that of the activator
		      hover: false, // Activate on hover
		      gutter: 0, // Spacing from edge
		      belowOrigin: true, // Displays dropdown below the button
		      alignment: 'left', // Displays dropdown with edge aligned to the left of button
		      stopPropagation: false // Stops event propagation
		    });
		 */
		$("#home").on("click", function(e){
			alert("홈으로");
			e.preventDefault();
			window.open("/bachida/");
		});
		
		$(".salesList").on("click",function(e){
			e.preventDefault();
			location.href="/bachida/artisan/sale/sales_list?artisanId="+$(this).attr("data-id");
		});
		 // 헤더 작가이름 클릭
		$("#header_artisanName").on("click",function(e){
			e.preventDefault();
			location.href="/bachida/artisantimeline/timeline_list?artisanId="+$(this).attr("data-id");
		});
		 
		
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
	});
	
</script>
<style>
.container{
width: 1000px !important;
}
section{
	margin: 0 auto;
	min-height: 500px;
}
a:link , a:hover{
	text-decoration: none;
}

header a{
	text-align: center;
    display: block;
    font-size: -webkit-xxx-large;
    font-weight: bolder; 
    color: blueviolet; 
    margin:20px;
    text-decoration: none;
}
a, a:link , a:hover, a:visited{
	text-decoration: none;
	color: black;
}  
.display.collapse.navbar-collapse{
	display:none !important;
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
	margin-left: 20px;
}
#logo:hover {
	cursor: pointer;
}
</style>
<body>
	<header>
		<div><a href="#"  id="header_artisanName"></a></div>
	</header>
	<div role="navigation">
		<div class="navbar-header">              
      		<!-- <a href="#" id="home" class="navbar-brand" style="font-size: xx-large; font-weight: bolder; color: blueviolet; margin:20px;">바치:다</a> -->
      		<img alt="bachida_logo" src="/bachida/images/logo.png" id="logo">
    	</div>
    	<sec:authorize access="hasRole('ROLE_MANAGER')">
    		<jsp:include page="artisanNav/artisan.jsp"></jsp:include>
    	</sec:authorize>
    	<sec:authorize access="permitAll">
    		<jsp:include page="artisanNav/user.jsp"></jsp:include>
    	</sec:authorize>
		                            
		        
	</div>
	<section class="container">
		<jsp:include page="${viewName}" />
		<!-- 탑버튼 -->
		<img alt="top_button" src="/bachida/images/top_button.PNG" id="topBtn"> 
		<!-- dropdown -->
		<!--     
		<ul id="dropdown2" class="dropdown-content">  
			<li><a href="#!">쪽지</a></li>    
			<li><a href="#!">신고</a></li>
		</ul> -->
	</section>
	<footer>
<jsp:include page="include/footer.jsp" />
</footer>
</body>
</html>