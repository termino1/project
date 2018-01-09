<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청 견적서확인</title>
<style type="text/css">
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
	/* 1:1주문제작 견적서 확인 */
	var $id = ${id};	// 접속자 아이디
	console.log($id);
	var $estimate = ${estimate};
	console.log($estimate);
	var $isDownPaymentPcustom = ${isDownPaymentPcustom};		// 계약금 결제 유무
	var $isFinallyPaymentPcustom = ${isFinallyPaymentPcustom};	// 잔금 결제 유무
	var $isDeliveryCompletedPcustom = ${isDeliveryCompletedPcustom};	// 배송완료 유무
	//console.log($isDownPaymentPcustom);
	//console.log($isFinallyPaymentPcustom);
	//console.log($isDeliveryCompletedPcustom);
	
	$("#artisanId").val($estimate.artisanId);
	$("#id").val($estimate.id);
	$("#orderDivision").val($estimate.orderDivision);
	$("#content").val($estimate.content);
	$("#price").val($estimate.price);
	
	// 견적서보기 페이지 버튼 컨트롤
	if($id==$estimate.id) {	// 글쓴이만 보이는 버튼
		// 계약금결제하기 버튼
		$("<button></button>").attr("id", "downPaymentBtn").addClass("glyphicon").addClass("glyphicon-usd").addClass("btn").addClass("btn-default").text("계약금결제하기").appendTo("#writerBtnSpan");
		// 잔금결제하기
		$("<button></button>").attr("id", "finallyPaymentBtn").addClass("glyphicon").addClass("glyphicon-usd").addClass("btn").addClass("btn-default").text("잔금결제하기").appendTo("#writerBtnSpan");
	}
	if($id==$estimate.artisanId) {	// 작가만 보이는 버튼
		$("<button></button>").attr("id", "deliveryBtn").addClass("glyphicon").addClass("glyphicon-gift").addClass("btn").addClass("btn-default").text("배송처리").appendTo("#artisanBtnSpan");
	}
	
	// 계약금 결제 안하면 계약금 결제 버튼만 보이기
	if($isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom!==1) {
		$("#downPaymentBtn").show();
		$("#finallyPaymentBtn").hide();
		$("#deliveryBtn").hide();
	} else if($isDownPaymentPcustom==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom!==1) {
		// 계약금 결제 하면 잔금결제 버튼만 보이기
		$("#downPaymentBtn").hide();
		$("#finallyPaymentBtn").show();
		$("#deliveryBtn").hide();
	} else if($isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom==1 && $isDeliveryCompletedPcustom!==1) {
		// 잔금 결제하면 결제버튼 숨기기, 결제완료 메세지 띄어주기, 작가 배송처리 버튼 보이기
		$("#downPaymentBtn").hide();
		$("#finallyPaymentBtn").hide();
		$("#deliveryBtn").show();
		alert("결제를 이미 완료했습니다.");
	} else if($isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom==1) {
		// 배송완료면 확인 버튼만 보이기
		$("#downPaymentBtn").hide();
		$("#finallyPaymentBtn").hide();
		$("#deliveryBtn").hide();
		
	}
	
	// 계약금 결제하기 버튼. 계약금 결제 페이지 이동
	$("#downPaymentBtn").on("click", function() {
		//console.log("계약금 결제 버튼!!");
		var $form = $("#estimatePcustom");
		$form.attr("action", "/bachida/pcustom/down_payment_pcustom_go/" + $estimate.pcustomIdx);
		$form.attr("method", "post");
		$form.submit();
	});
	
	// 잔금 결제하기 버튼. 잔금 결제 페이지 이동
	$("#finallyPaymentBtn").on("click", function() {
		//console.log("잔금 결제 버튼!!");
		var $form = $("#estimatePcustom");
		$form.attr("action", "/bachida/pcustom/finally_payment_pcustom_go/" + $estimate.pcustomIdx);
		$form.attr("method", "post");
		$form.submit();
	});
	
	// 배송처리 버튼. 배송처리 페이지 이동
	$("#deliveryBtn").on("click", function() {
		var $form = $("#estimatePcustom");
		$form.attr("action", "/bachida/pcustom/delivery_completed_pcustom_go/" + $estimate.pcustomIdx);
		$form.attr("method", "post");
		$form.submit();
	});
	
	// 확인 버튼. 게시글 페이지 이동
	$("#check").on("click", function() {
		//console.log("확인 버튼!!");
		location.href = "/bachida/pcustom/read_pcustom/" + $estimate.pcustomIdx;
	});
	
});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<form action="/bachida/pcustom/insert_pcustom_estimate" method="post" id="estimatePcustom" name="estimatePcustom">
				<div class="col-md-7">
					<hr>
					<h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2>
					<h3>견적서 확인</h3>
					<h5>견적서를 확인해 주세요. 수정을 원하면 작가에게 다시 문의해 주세요.<br>
						계약금 결제 전까지 수정이 가능합니다.
					</h5>
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
					</table>
					<!-- Spring Security의 token값 설정 -->
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<hr>
				</div>
			</form>
		</div>
		
		<!-- 확인버튼 -->
		<span id="checkBtnSpan">
			<button id="check" class="glyphicon glyphicon-ok btn btn-default">확인</button>
		</span>
		<!-- 글쓴이만 보이는 버튼 -->
		<span id="writerBtnSpan">
			<!-- <button id="downPaymentBtn" class="glyphicon glyphicon-usd btn btn-default">계약금결제하기</button> -->
			<!-- <button id="finallyPaymentBtn" class="glyphicon glyphicon-usd btn btn-default">잔금결제하기</button> -->
		</span>
		<!-- 해당작가만 보이는 버튼 -->
		<span id="artisanBtnSpan">
			<!-- <button id="deliveryBtn" class="glyphicon glyphicon-gift btn btn-default">배송처리</button> -->
		</span>
		<hr>
	</div>
</body>
</html>