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
<script>
	$(function(){
		var $map = ${map};
		var $list = $map.list;
		var $user = $map.userInfo;
		var $interest = $user.interests;
		var $auth = $user.authorities;
		var $tbody = $("#tbody");
		if($list.length==0){
			var $tr = $("<tr></tr>").appendTo($tbody);
			$("<td colspan='5'></td>").text("해당 내역이 없습니다.").css({"text-align": "center","font-weight": "bold"}).appendTo($tr);
		}
		$.each($list, function(i, order) {
			var $tr = $("<tr>").appendTo($tbody);
			$("<td>").text(i+1).appendTo($tr);
			$("<td>").text(order.ORDERSIDX).appendTo($tr);
			var $orderProduct = $("<td>").appendTo($tr);
			var $div = $("<div>").appendTo($orderProduct);
			$("<img>").attr("src","/bachida/user/displayFile/"+order.PRODUCTIDX).addClass("pull-left").appendTo($div);
			var $p = $("<p>").text(order.PRODUCTNAME).appendTo($div);
			$("<small>").text(" 외 "+(order.ORDERQUANTITY-1)+"상품").appendTo($p);
			var $link = $("<a>").attr("href", "/bachida/user/orderView/"+order.ORDERSIDX);
			$orderProduct.wrapInner($link);
			$("<td>").text(order.TOTALPRICE+"원").appendTo($tr);
			$("<td>").text(order.ORDERDATE).appendTo($tr);
		});
		
		
		console.log($auth.length)
		if($user.enable==true){
			$("#enable").text("활동회원 ");
		}else if($user.enable==false){
			$("#enable").text("차단회원 ");
		}
		$("#id").text($user.id);
		$("#name").text($user.name);
		$("#cash").text($user.cash+"원");
		$("#joinDate").text($user.joinDate);
		$("#tel").text($user.tel);
		$("#email").text($user.email);
		$("#birthDate").text($user.birthDate);
		$("#warningCnt").text($user.warningCnt+"회");
		if($interest.length!=0){
			var interestCol = "";
			$.each($interest, function(i, interest) {
				if(interest.mainCategoryIdx==1)
					interestCol += "악세사리 ";
				else if(interest.mainCategoryIdx==2)
					interestCol += "패션소품 ";
				else if(interest.mainCategoryIdx==3)
					interestCol += "생활 ";
				else if(interest.mainCategoryIdx==4)
					interestCol += "디자인문구 ";
				else if(interest.mainCategoryIdx==5)
					interestCol += "반려동물 ";
			})
			console.log(interestCol);
			$("#interest").text(interestCol);
		}else
			$("#interest").text("없음");
	});
</script>
<style>
	img{
		width:100%; 
		height : 60px;
		max-width:100px;
	}
	#moreLink{
		color : rgb(245, 89, 128);
	}
	
</style>

</head>
<body>
	
	<div class="container">
		<div class="row">
			<h3 style="color: rgb(245, 89, 128);">최근 주문내역</h3>    
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
					<tr class="active">
						<th>번호</th><th>주문번호</th><th>주문상품</th><th>결제금액</th><th>주문일자</th>
					</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>
				<a id="moreLink" class="pull-right" href="/bachida/user/myOrderList">..더보기</a>
			</div>
			<br>
		</div>
		<div class="row" id="tableDiv">
			<h3>회원정보</h3>
			<br>
			<table class="table">
				<tr>
					<th class="active">회원상태</th>
					<td colspan="3" id="enable"></td>
				</tr>
				<tr>
					<th class="active">아이디</th>
					<td id="id"></td>
					<th class="active">이름</th>
					<td id="name"></td>
				</tr>
				<tr>
					<th class="active">캐쉬</th>
					<td id="cash"></td>
					<th class="active">경고회수</th>
					<td id="warningCnt"></td>
				</tr>
				<tr>
					<th class="active">연락처</th>
					<td id="tel"></td>
					<th class="active">이메일</th>
					<td id="email"></td>
				</tr>
				<tr>
					<th class="active">생년월일</th>
					<td id="birthDate"></td>
					<th class="active">회원가입일</th>
					<td id="joinDate"></td>
				</tr>
				<tr>
					<th class="active">관심분야</th>
					<td colspan="3" id="interest"></td>
				</tr>
			</table>
			<br>
		</div>
	</div>
</body>
</html>