<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
/* 
<table class="table">
	<tr class="active">
		<th>번호</th>
		<th>주문상품</th>
		<th>수량</th>
		<th>판매자아이디</th>
		<th>결제금액</th>
		<th>처리상태</th>
	</tr>
	<tr>
		<td>2</td>
		<td>
			<img class="pull-left" src="http://www.blueb.co.kr/SRC2/_image/w01.jpg" style="width: 100%; height:75px; max-width:150px;">
			<p>상품</p>
			<p>옵션명</p>
		</td>
		<td>1개</td>
		<td rowspan="2">ㅎ;</td>
		<td rowspan="2" class="price">100000원</td>
		<td rowspan="2">
		배송중<br>
	<button type="button" class="btn btn-default deliveryCompBtn">배송완료</button>
</td>
</tr>
<tr>
<td>1</td>
<td>
	<img class="pull-left" src="http://www.blueb.co.kr/SRC2/_image/w01.jpg" style="width: 100%; height:75px; max-width:150px;">
	<p>상품</p>
	<p>옵션명</p>
</td>
<td class="vertical">1개</td>
</tr>
</table>
<p class="pull-right">
총 결제금액 : 100000원
</p> */ 
	$(function(){
		var $list = ${orderDetail};
		var $orderProduct = $list.orderProduct;
		var $order = $list.order;
		console.log($orderProduct);
		console.log($order);
		var $orderList = $("#orderList");
		$("#ordersIdx").text("상품정보(주문번호 : "+$order.ordersIdx+")");
		$("#orderDate").text($order.orderDate);
		$("#totalPrice").text($order.totalPrice+"원");
		$("#orderName").text($orderProduct[0].orderName);
		$("#orderTel").text($orderProduct[0].orderTel);
		$("#orderEmail").text($orderProduct[0].orderEmail);
		$("#address").text($order.address);
		$.each($orderProduct, function(i, op) {
			var $option = op.orderOption;
			console.log($option.length);
			//var $length = $option.length;
			//console.log($length);
			var $table = $("<table>").addClass("table").addClass("table-bordered").appendTo($orderList);
			var $tbody = $("<tbody>").appendTo($table)
			var $thRow = $("<tr>").addClass("active").appendTo($tbody);
			var $optionLength = $option.length;
			$("<th>").addClass("text-center").text("번호").appendTo($thRow);
			$("<th>").addClass("text-center").text("주문상품").appendTo($thRow);
			$("<th>").addClass("text-center").text("수량").appendTo($thRow);
			$("<th>").addClass("text-center").text("금액").appendTo($thRow);
			$("<th>").addClass("text-center").text("판매자아이디").appendTo($thRow);
			$("<th>").addClass("text-center").text("처리상태").appendTo($thRow);
			if($optionLength==0){
				var $tr = $("<tr>").appendTo($tbody);
				$("<td>").addClass("text-center").text(1).appendTo($tr);
				var $imgTd = $("<td>").appendTo($tr);
				var $a = $("<a></a>").attr("href","/bachida/product/getProduct/"+op.productIdx).appendTo($imgTd);
				$("<img>").attr("src","/bachida/user/displayFile/"+op.productIdx).css({"width":"100%","height":"75px","max-width":"100px"}).addClass("pull-left").appendTo($a);
				$("<p>").text(op.productName).appendTo($imgTd);
				$("<td>").addClass("text-center").text(op.quantity).appendTo($tr);
				$("<td>").addClass("text-center").text(op.price).appendTo($tr);
				$("<td>").addClass("text-center").text(op.artisanId).appendTo($tr);
				if(op.state=="배송"){
					var $stateTd = $("<td>").text(op.state).appendTo($tr);
					$("<br>").appendTo($stateTd);
					$("<input>").val("배송완료").attr("type","button").attr("data-opIdx",op.orderProductIdx).addClass("btn").addClass("btn-default").addClass("deliveryCompBtn").appendTo($stateTd);
				}else if(op.state=="배송완료"){
					console.log(op.commentCheck);
					var $stateTd = $("<td>").text(op.state).appendTo($tr);
					$("<br>").appendTo($stateTd);
					if(op.commentCheck==false){
						$("<input>").val("상품평작성").attr("type","button").attr("data-opIdx",op.orderProductIdx).attr("data-pIdx",op.productIdx).addClass("btn").addClass("btn-default").addClass("commentBtn").appendTo($stateTd);
					}else
						$("<input>").val("상품작성완료").attr("type","button").attr("disabled","disabled").addClass("btn").addClass("btn-default").addClass("commentBtn").appendTo($stateTd);
				}else
					$("<td>").addClass("text-center").text(op.state).appendTo($tr);
			}else{
				$.each($option, function(j, option) {
					if(j==0){
						var $tr = $("<tr>").appendTo($tbody);
						$("<td>").addClass("text-center").text($optionLength).appendTo($tr);
						var $imgTd = $("<td>").appendTo($tr);
						var $a = $("<a></a>").attr("href","/bachida/product/getProduct/"+op.productIdx).appendTo($imgTd);
						$("<img>").attr("src","/bachida/user/displayFile/"+op.productIdx).css({"width":"100%","height":"75px","max-width":"100px"}).addClass("pull-left").appendTo($a);
						$("<p>").text(op.productName).appendTo($imgTd);
						$("<p>").text(option.optionContent).appendTo($imgTd);
						$("<td>").addClass("text-center").text(option.optionQuantity).appendTo($tr);
						$("<td>").addClass("text-center").text(option.cost).appendTo($tr);
						$("<td>").addClass("text-center").attr("rowspan",$optionLength).text(op.artisanId).appendTo($tr);
						if(op.state=="배송"){
							var $stateTd = $("<td>").attr("rowspan",$optionLength).text(op.state).appendTo($tr);
							$("<br>").appendTo($stateTd);
							$("<input>").val("배송완료").attr("type","button").attr("data-opIdx",op.orderProductIdx).addClass("btn").addClass("btn-default").addClass("deliveryCompBtn").appendTo($stateTd);
						}else if(op.state=="배송완료"){
							var $stateTd = $("<td>").attr("rowspan",$optionLength).text(op.state).appendTo($tr);
							$("<br>").appendTo($stateTd);
							if(op.commentCheck==false){
								$("<input>").val("상품평작성").attr("type","button").attr("data-opIdx",op.orderProductIdx).attr("data-pIdx",op.productIdx).addClass("btn").addClass("btn-default").addClass("commentBtn").appendTo($stateTd);
							}else
								$("<input>").val("상품평작성완료").attr("type","button").attr("disabled","disabled").addClass("btn").addClass("btn-default").addClass("commentBtn").appendTo($stateTd);
						}else
							$("<td>").addClass("text-center").text(op.state).appendTo($tr);
					}else{
						var $tr = $("<tr>").appendTo($tbody);
						$("<td>").text($optionLength).appendTo($tr);
						var $imgTd = $("<td>").appendTo($tr);
						$("<img>").attr("src","/bachida/user/displayFile/"+op.productIdx).css({"width":"100%","height":"75px","max-width":"100px"}).addClass("pull-left").appendTo($imgTd);
						$("<p>").text(op.productName).appendTo($imgTd);
						$("<p>").text(option.optionContent).appendTo($imgTd);
						$("<td>").text(op.quantity).appendTo($tr);
						$("<td>").text(option.cost).appendTo($tr);
					}
					$optionLength-=1;
				})
			}
			$("<p>").addClass("pull-right").text("총 결제 금액 : "+op.price+"원").appendTo($orderList);
		});
		
		//배송완료 처리
		$(".deliveryCompBtn").on("click",function(){
			if(confirm("배송완료 처리를 하시겠습니까?")){
				var $form = $("<form>").appendTo("body");
				$("<input>").attr("type","hidden").attr("name","orderProductIdx").val($(this).attr("data-opIdx")).appendTo($form);
				$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
				var $data = $form.serialize();
				$.ajax({
					url:"/bachida/user/DeliveryComplete",
					type:"post",
					data:$data,
					success: function(){
						location.reload();
					}
				});
			}
		});
		
		$(".commentBtn").on("click",function(){
			window.open("/bachida/user/writeComment?orderProductIdx="+$(this).attr("data-opIdx")+"&productIdx="+$(this).attr("data-pIdx")+"&ordersIdx="+$order.ordersIdx,"상품평쓰기","width=500,height=450");
		});
		/* 확인버튼 */
		$("#orderListBtn").on("click",function(){
			window.history.back();
		})
	});
	
</script>
<style>
	tr > td{
		vertical-align: middle !important;
	}
	.table.table01{border-bottom:1px solid #ddd}
	.table.table01 td,.table.table01 th{vertical-align: middle !important;}
	h4{font-weight: bold}
</style>
</head>
<body>
	<div class="container">
		<h3 style="color: rgb(245, 89, 128);">주문내역서</h3>
		<p id="ordersIdx"></p>
		<div id="orderList" class="row">
			
		</div>
		<hr>
		<div class="row">
			<h4>결제정보</h4>
			<table class="table table01">
				<tr>
					<th class="active" style="height:50px;">주문일자</th>
					<td id="orderDate"></td>
					<th class="active">총 결제금액</th>
					<td id="totalPrice"></td>
				</tr>
			</table>
			<h4>주문자 정보</h4>
			<table class="table table01">
				<tr>
					<th class="active">주문자</th>
					<td id="orderName"></td>
					<th class="active">연락처</th>
					<td id="orderTel"></td>
				</tr>
				<tr>
					<th class="active">이메일</th>
					<td id="orderEmail"></td>
					<th class="active">배송지</th>
					<td id="address"></td>
				</tr>
				<!-- <tr>
				</tr> -->
			</table>
			<!-- <hr> -->
			<button class="btn btn-default center-block" type="button" id="orderListBtn">확인</button>
		</div>
	</div>
</body>
</html>