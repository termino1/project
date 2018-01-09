<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css?v=3">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	$(function() {
		var $order = ${orderOne};
		var $product = $order.orderProduct;
		var $option = $order.options;
		var $payment = $order.payment;
		console.log($order)
		console.log($payment)
		console.log($product);
		$("#orderName").val($product.orderName);
		$("#orderTel").val($product.orderTel);
		$("#orderEmail").val($product.orderEmail);
		$("#cash").val($payment);
		
		var $tbody = $("<tbody></tbody>").appendTo("#table");
		var $tr = $("<tr></tr>").appendTo($tbody);
		var $td3 = $("<td></td>").addClass("pd20").text($product.productName).appendTo($tr);
		if ($option != null) {	// 옵션이 있으면
			for (var i = 0; i < $option.length; i++) {
				$("<p></p>").text($option[i].optionContent + " : "+ $option[i].optionQuantity).appendTo($td3);
				$("<input>").attr("type", "hidden").attr("name","options[" + i + "].optionContent").val($option[i].optionContent).appendTo("#frm");
				$("<input>").attr("type", "hidden").attr("name","options[" + i + "].cost").val($option[i].cost).appendTo("#frm");
				$("<input>").attr("type", "hidden").attr("name","options[" + i + "].optionQuantity").val($option[i].optionQuantity).appendTo("#frm");
			}
		}
		$("<td></td>").addClass("text-center").text($product.quantity).appendTo($tr);
		$("<td></td>").addClass("text-right").text($order.productPrice).appendTo($tr);
		$td = $("<td></td>").addClass("text-center").appendTo($tr);
		$("<div></div>").text($order.artisan).appendTo($td);
		/* $("<a class='btn btn-line btn-xs'></a>").text("작가에게 문의하기").attr("href","#").appendTo($td); */
		$tfoot = $("<tfoot></tfoot>").appendTo("#table");
		$tr2 = $("<tr></tr>").appendTo($tfoot);
		$("<td colspan='4'></td>").text("합계 " + $product.price + " 원").addClass("text-right").appendTo($tr2);
		if($option == null) {
		$("#totalPrice").text($product.price);
		$(".totalPrice").val($product.price);
		}else{
		//$("#totalPrice").text(Number($product.price*$product.quantity));
			$("#totalPrice").text($product.price);
			$(".totalPrice").val($product.price);
		}
		
		$("<input>").attr("type", "hidden").attr("name","price").val($product.price).appendTo("#frm");
		$("<input>").attr("type", "hidden").attr("name","quantity").val($product.quantity).appendTo("#frm");
		$("<input>").attr("type", "hidden").attr("name","productIdx").val($product.productIdx).appendTo("#frm");
		$("<input>").attr("type", "hidden").attr("name","productName").val($product.productName).appendTo("#frm");
		$("<input>").attr("type", "hidden").attr("name","totalPrice").val($product.price).appendTo("#frm");
		$("<input>").attr("type", "hidden").attr("name","orderQuantity").val(1).appendTo("#frm");
		$("<input>").attr("type", "hidden").attr("name","artisanId").val($order.artisan).appendTo("#frm");
		
		if($payment<$product.price){
			$("#msg").text("캐쉬부족")
		}else{
			$("#msg").text("(결제 후 잔여캐쉬 : "+ Number($payment-$product.price) +" 원)")
		}
		$("#btn-order").on("click",function(){
			console.log(typeof payment);
			if($payment< $product.price){
				return alert("캐쉬부족");
			}
			// input에 배송지(address) 합치기 : (우편번호)주소, 상세주소 
			$("<input type='hidden' name='address' value='"+ "(" + $("#sample6_postcode").val() + ")" + $("#sample6_address").val() + ", " + $("#sample6_address2").val() +"'>").appendTo("#frm");
			$("#frm").attr("action","${pageContext.request.contextPath}/product/orderProductWrite");
			$("#frm").serializeArray();
			console.log($("#frm").serializeArray());
			$("#frm").submit();
		})
		//캐쉬충전
		$("#charge-btn").on("click",function(){
		 $.ajax({
			 url:"${pageContext.request.contextPath}/product/cashCharge",
			 type:"post",
			 data:$("#cashChargefrm").serializeArray(),
			 success:function() {
					location.reload(true);
				}
			});
		})
	})
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
<style>
dl {margin-top: 15px}
dl dt {font-weight: normal;	line-height: 30px}
dl dd {margin-bottom: 10px}
.input_text{border:none;background: none;text-align: right;width:100px}
#charge input[type=radio]{margin-top:-6px}
#charge .modal-header{padding:10px;border:none}
#charge .close{font-size:40px; padding-right:10px}
#charge .modal-title{background-color: #555; color: #fff; padding: 5px 10px;  border-radius: 5px !important;}
</style>
</head>

<body>
	<div class="container">
		<form id="frm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="page-header clearfix product-title">
				<h1 class="product_name">주문하기</h1>
			</div>
			<ul class="list-unstyled text-danger mgb20">
				<li><span class="glyphicon glyphicon-info-sign"></span> 핸드메이드	작품의 특성상 주문 후 취소/교환/환불이 어려울 수 있으니 신중한 구매 부탁드립니다.</li>
				<li><span class="glyphicon glyphicon-info-sign"></span> 작품에 대한 문의사항은 '작가님께 문의하기' 버튼을 눌러 문의해주세요</li>
			</ul>

			<div class="panel panel-default">
				<div class="panel-heading">구매할 작품</div>

				<div class="panel-body">
					<table class="table table-condensed table-bordered table-order"	id="table">
						<thead>
							<tr>
								<th scope="col" class="text-center">작품정보</th>
								<th scope="col" class="text-center">수량</th>
								<th scope="col" class="text-center">가격</th>
								<th scope="col" class="text-center">작가</th>
							</tr>
						</thead>
					</table>
					<div class="text-right well">
						<h4>총 결제금액 <span id="totalPrice"></span> 원</h4>
					</div>
				</div>
			</div>
	<div class="panel panel-default">
				<div class="panel-heading">결제정보</div>
				<div class="panel-body">
					<dl class="dl-horizontal form-inline">
						<dt>보유캐쉬</dt>
						<dd><input id="cash" type="text" readonly="readonly" class="input_text">원 <button type="button" class="btn btn-xs btn-default" data-toggle="modal" data-target="#charge">충전하기</button> <span id="msg"></span></dd>
						<dt>총 결제금액</dt>
						<dd><input class="totalPrice input_text" type="text" readonly="readonly"/>원</dd>
						
					</dl>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">배송지정보</div>
				<div class="panel-body">
					<dl class="dl-horizontal form-inline">
						<dt>받는분</dt>
						<dd><input type="text" name="orderName" id="orderName" class="form-control input-sm"></dd>
						<dt>연락처</dt>
						<dd><input type="text" name="orderTel" id="orderTel" class="form-control input-sm"></dd>
						<dt>이메일</dt>
						<dd><input type="text" name="orderEmail" id="orderEmail" class="form-control input-sm"></dd>
						<dt>주소</dt>
						<dd class="form-horizontal">
							<!-- <input type="text" name="address" class="input-sm" size="80">
							<a href="#" class="btn btn-sm btn-default">주소검색</a> -->
							<input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호">
								<input type="button" onclick="sample6_execDaumPostcode()" class="btn btn-default" value="우편번호 찾기"><br>
								<input type="text" id="sample6_address" class="form-control" placeholder="주소">
								<input type="text" id="sample6_address2" class="form-control" placeholder="상세주소">
						</dd>
					</dl>
				</div>
			</div>
		
			<div class="text-center mgb20">
				<button class="btn btn-gray" type="button">취소하기</button> &nbsp; <button class="btn btn-pink" type="button" id="btn-order">결제하기</button>
			</div>
		</form>

	</div>
	<div class="modal fade" id="charge" tabindex="-1" role="dialog"
		aria-labelledby="charge" aria-hidden="true">
		
		<div class="modal-dialog">
		<form id="cashChargefrm">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="charge">충전하기</h4>
				</div>
				<div class="modal-body">
					
						<div class="panel panel-default">

							<div class="panel-heading">충전하실 금액</div>
							<div class="panel-body">
								<label class="radio-inline"> <input type="radio"	name="cash"  value="5000">5,000원</label> 
								<label class="radio-inline"> <input type="radio"	name="cash"  value="10000">10,000원</label> 
								<label class="radio-inline"> <input type="radio"	name="cash"  value="50000">50,000원</label> 
								<label class="radio-inline"> <input type="radio"	name="cash"  value="100000">100,000원</label>
							</div>
						</div>
					
				</div>
				<div class="modal-footer" style="text-align: center">
					<button  class="btn btn-default" id="charge-btn" type="button">충전하기</button>
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
</html>