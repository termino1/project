<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script type="text/javascript" src="/bachida/js/bootstrap.js"></script>
<style>
.asideNav{border:1px solid #ccc;list-style: none;padding:10px;}
.asideNav .title {background-color: #666;color:#fff;font-weight: bold;border-radius: 4px;padding:5px 10px;font-size: 18px}
.asideNav>li>ul>li{list-style: none}
.asideNav>li>ul{padding:10px;}
.asideNav>li>ul>li{margin-bottom: 3px}
.asideNav>li>ul>li:before{content:"-";float:left;padding-right:5px}
.asideNav>li>ul>li>a{display: block;color:#666}

#mypageSection .container{
	width: auto;
}

</style>
</head>

<body>
	<div class="clearfix">
		<div class="col-sm-3">
			<ul class="asideNav">
				<li><div class="title">쇼핑내역</div>
					<ul>
						<li><a href="/bachida/user/myOrderList">주문내역</a></li>
						<li><a href="/bachida/product/choose_product">찜한작품</a></li>
						<li><a href="/bachida/bookmarkArtisan/bookmark_list">찜한작가</a></li>
						<li><a href="/bachida/user/myCustom">제작요청내역</a></li>
						<li><a href="/bachida/user/myPcustom">1:1제작요청내역</a></li>
					</ul>
				</li>
				<li><div class="title">바치다 활동</div>
					<ul>
						<li><a href="/bachida/user/applyList">작가신청내역</a></li>
						<li><a href="/bachida/user/listReport">신고내역</a></li>
						<li><a href="/bachida/user/cashList">캐쉬내역</a></li>
						<li><a href="/bachida/user/cashCharge">캐쉬충전</a></li>
						<!-- <li><a href="#">제작요청</a></li>
						<li><a href="#">1:1제작요청</a></li> -->
					</ul>
				</li>
				<li><div class="title">회원정보</div>
					<ul>
						<li><a href="/bachida/user/updateUser">정보수정</a></li>
						<li><a href="/bachida/user/resign">회원탈퇴</a></li>
					</ul>
				</li>
			</ul>
		</div>
	
	<!-- 	
	<ul>
		<li><a href="/bachida/user/updateUser" >정보수정</a></li>
		<li><a href="/bachida/user/applyList" >작가</a></li>
		<li><a href="/bachida/user/listReport" >신고</a></li>
		<li><a href="/bachida/user/resign" >탈퇴</a></li>
		<li><a href="/bachida/user/cashList" >캐쉬내역</a></li>
		<li><a href="/bachida/user/myOrderList" >주문내역</a></li>
		<li><a href="/bachida/user/myCustom" >제작요청</a></li>
		<li><a href="/bachida/user/myPcustom" >1:1제작요청</a></li>
	</ul>  -->
	
	<div class="col-sm-9">
			<section id="mypageSection">
				<jsp:include page="${mypage}" />
			</section>
	</div>
	</div>
</body>
</html>