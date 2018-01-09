<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청 계약금결제</title>
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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(function() {
	/* 계약금 결제 */
	var $id = ${id};			// 접속자 아이디
	console.log($id);
	var $estimate = ${estimate};	// 견적서 정보
	console.log($estimate);
	var cash = ${cash};			// 구매자 캐쉬
	//console.log($cash);
	//console.log(typeof $cash);	// number
	
	$("#artisanId").val($estimate.artisanId);
	$("#id").val($estimate.id);
	$("#orderDivision").val($estimate.orderDivision);
	$("#content").val($estimate.content);
	$("#price").val($estimate.price);
	var $downPayment = $("#downPayment").val($estimate.price * 0.1);	// 계약금 : 주문금액의 10%
	var downPayment = Number($downPayment.val());	// 계약금을 넘버로 변환
	//console.log($downPayment);
	//console.log(typeof downPayment);
	
	$("#downPaymentBtn").on("click", function() {	// 계약금 결제 버튼
		//console.log(cash>=downPayment);	// true/false
		if(cash>=downPayment) {	// 구매자의 캐쉬가 결제할 계약금보다 크거나 같으면 계약금 결제 진행
			var $confirm = confirm("계약금 결제가 완료됩니다. 계약금을 결제하면 교환/환불이 어렵습니다.");
 			if($confirm==true) {
 				var $form = $(("#estimatePcustom"));
 				// input에 배송지(address) 합치기 : (우편번호)주소, 상세주소 
 				$("<input type='hidden' name='address' value='"+ "(" + $("#sample6_postcode").val() + ")" + $("#sample6_address").val() + ", " + $("#sample6_address2").val() +"'>").appendTo($form);
 				//console.log($("input[name='address']").val());
				// 폼에 pcustomIdx, productionOrderIdx, cash 숨겨서 보내기
				$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($estimate.pcustomIdx).appendTo($form);
				$("<input>").attr("type", "hidden").attr("name", "productionOrderIdx").val($estimate.productionOrderIdx).appendTo($form);
				$("<input>").attr("type", "hidden").attr("name", "cash").val(cash).appendTo($form);
				//console.log($estimate.artisanId);	// Peek-A-Boo
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

// 다음 주소 api
function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
    
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<form action="/bachida/pcustom/down_payment_pcustom" method="post" id="estimatePcustom" name="estimatePcustom">
				<div class="col-md-7">
					<hr>
					<h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2>
					<h3>계약금 결제</h3>
					<h5>주소를 입력해 주세요. 계약금은 주문금액의 10%입니다.</h5>
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
								<!-- <input type="text" id="address" name="address" placeholder="배송지를 입력해 주세요."> -->
								<input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호">
								<input type="button" onclick="sample6_execDaumPostcode()" class="btn btn-default" value="우편번호 찾기"><br>
								<input type="text" id="sample6_address" class="form-control" placeholder="주소">
								<input type="text" id="sample6_address2" class="form-control" placeholder="상세주소">
							</td>
						</tr>
					</table>
					<hr>
					<!-- Spring Security의 token값 설정 -->
					<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> --%>
					<button type="button" id="downPaymentBtn" class="glyphicon glyphicon-usd btn btn-default">계약금결제</button>
				</div>
			</form>
		</div>
		<hr>
	</div>
</body>
</html>