<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청 잔금결제</title>
<style>
	textarea {
		resize: none;
	}
	th, h3 {
		color: rgb(245, 89, 128);
	}
	#pcustom {
		text-decoration: none;
		color: rgb(245, 89, 128);
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	/* 잔금 결제 */
	var $id = ${id};			// 접속자 아이디
	console.log($id);
	var $estimate = ${estimate};
	console.log($estimate);
	var cash = ${cash};	
	
	$("#artisanId").val($estimate.artisanId);
	$("#id").val($estimate.id);
	$("#orderDivision").val($estimate.orderDivision);
	$("#content").val($estimate.content);
	$("#price").val($estimate.price);
	$("#downPayment").val($estimate.price * 0.1);	// 계약금 : 주문금액의 10%
	$("#address").val($estimate.address);
	var $finallyPayment = $("#finallyPayment").val($estimate.price * 0.9);	// 잔금 : 주문금액의 90%
	var finallyPayment = Number($finallyPayment.val());	// 잔금을 넘버로 변환
	
 	$("#finallyPaymentBtn").on("click", function() {
 		if(cash>=finallyPayment) {	// 구매자의 캐쉬가 결제할 잔금보다 크거나 같으면 잔금 결제 진행
 			var $confirm = confirm("최종결제가 완료됩니다. 결제를 완료하면 교환/환불이 어렵습니다.");
 			if($confirm==true) {
 				var $form = $(("#estimatePcustom"));
 				// 폼에 pcustomIdx, productionOrderIdx, cash 숨겨서 보내기
 				$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($estimate.pcustomIdx).appendTo($form);
				$("<input>").attr("type", "hidden").attr("name", "productionOrderIdx").val($estimate.productionOrderIdx).appendTo($form);
				$("<input>").attr("type", "hidden").attr("name", "cash").val(cash).appendTo($form);
				// Spring Security의 token값 설정
				$("<input>").attr("type", "hidden").attr("name", "${_csrf.parameterName}").val("${_csrf.token}").appendTo($form);
				$form.submit();
 			}
 		} else {	// 구매자의 캐쉬가 결제할 계약금보다 작으면 페이지 리로드
 			alert("보유하신 캐쉬가 부족합니다. 캐쉬 충전 후 다시 진행해 주십시오.");
 			location.reload();
 		} 
	});
	
});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<form action="/bachida/pcustom/finally_payment_pcustom" method="post" id="estimatePcustom" name="estimatePcustom">
				<div class="col-md-7">
					<hr>
					<h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2>
					<h3>잔금 결제</h3>
					<h5>주문금액에서 계약금을 제외한 나머지 금액을 결제합니다.</h5>
					<table class="table table-bordered table-hover">
						<tr>
							<th>작가</th>
							<td>
								<input type="text" id="artisanId" name="artisanId" class="form-control" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>구매자</th>
							<td>
								<input type="text" id="id" name="id" class="form-control" readonly="readonly">
							</td>
						</tr>
						
						<tr>
							<th>구분</th>
							<td>
								<input type="text" id="orderDivision" name="orderDivision" class="form-control" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea id="content" name="content" class="form-control" rows="10" cols="" readonly="readonly"></textarea>
							</td>
						</tr>
						<tr>
							<th>주문금액</th>
							<td>
								<input type="text" id="price" name="price" class="form-control" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>계약금</th>
							<td>
								<input type="text" id="downPayment" name="downPayment" class="form-control" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>배송지</th>
							<td>
								<input type="text" id="address" name="address" class="form-control" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>잔금</th>
							<td>
								<input type="text" id="finallyPayment" name="finallyPayment" class="form-control" readonly="readonly">
							</td>
						</tr>
					</table>
					<hr>
					<button id="finallyPaymentBtn" class="glyphicon glyphicon-usd btn btn-default">잔금결제</button>
				</div>
			</form>
		</div>
		<hr>
	</div>
</body>
</html>