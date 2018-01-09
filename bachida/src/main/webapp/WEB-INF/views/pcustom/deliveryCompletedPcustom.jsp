<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청 배송처리</title>
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
	/* 배송 처리 페이지 */
	var $id = ${id};			// 접속자 아이디
	console.log($id);
	var $estimate = ${estimate};
	console.log($estimate);
	
	$("#artisanId").val($estimate.artisanId);
	$("#id").val($estimate.id);
	$("#orderDivision").val($estimate.orderDivision);
	$("#content").val($estimate.content);
	$("#price").val($estimate.price);
	
 	$("#deliveryBtn").on("click", function() {	// 배송버튼 클릭
 		var $confirm = confirm("배송처리가 완료됩니다.");
 		if($confirm==true) {
 			var $form = $(("#estimatePcustom"));
 			// 폼에 pcustomIdx, productionOrderIdx 숨겨서 보내기
 			$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($estimate.pcustomIdx).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name", "productionOrderIdx").val($estimate.productionOrderIdx).appendTo($form);
			$form.submit();
 		} 
	});
	
});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<form action="/bachida/pcustom/delivery_completed_pcustom" method="post" id="estimatePcustom" name="estimatePcustom">
				<div class="col-md-7">
					<hr>
					<h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2>
					<h3>배송처리</h3>
					<h5>택배사와 운송장번호를 입력해 주세요.</h5>
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
								<input type="text" id="id" name="id" class="form-control" class="form-control" readonly="readonly">
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
							<th>택배사</th>
							<td>
								<input type="text" id="parcelName" name="parcelName" class="form-control">
							</td>
						</tr>
						<tr>
							<th>운송장번호</th>
							<td>
								<input type="text" id="parcelIdx" name="parcelIdx" class="form-control">
							</td>
						</tr>
					</table>
					<hr>
					<!-- Spring Security의 token값 설정 -->
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<button id="deliveryBtn" class="glyphicon glyphicon-gift btn btn-default">배송</button>
				</div>
			</form>
		</div>
		<hr>
	</div>
</body>
</html>