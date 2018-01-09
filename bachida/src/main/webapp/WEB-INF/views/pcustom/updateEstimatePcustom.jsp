<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청 견적서수정</title>
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
	$(function(){
		/* 1:1커스텀 견적서 수정 */
		var $estimate = ${estimate};
		var $id = ${id};	// 접속자 아이디
		console.log($estimate);
		console.log($id);
		
		$("#artisanId").val($estimate.artisanId);
		$("#id").val($estimate.id);
		$("#content").val($estimate.content);
		$("#price").val($estimate.price);
		
		// 확인버튼
		$("#updateEstimateBtn").on("click", function() {
			var $confirm = confirm("견적서를 수정합니다.");
			if($confirm==true) {
				$("<input>").attr("name","pcustomIdx").attr("type","hidden").val($estimate.pcustomIdx).appendTo($("#estimatePcustom"));
				$("<input>").attr("name","productionOrderIdx").attr("type","hidden").val($estimate.productionOrderIdx).appendTo($("#estimatePcustom"));
				// Spring Security의 token값 설정
				$("<input>").attr("type", "hidden").attr("name","${_csrf.parameterName }").val("${_csrf.token}").appendTo($("#estimatePcustom"));
			}
		});
		
		// 취소버튼
		$("#cencel").on("click", function() {
			location.href="/bachida/pcustom/read_pcustom/" + $estimate.pcustomIdx;
		});
		
	});
	
	function checkKeyInt(e,event) {
		/* 주문금액 인풋에 숫자만 입력받기 */
		if(event.keyCode) {
			var code = event.keyCode;
			// 48은 숫자 0, 57은 숫자 9
			if((code >= 48 && code <= 57) || (code >=96 && code <= 105) || (code==8) || (code==9) || (code==46)) {
				return;
			} else {
				e.returnValue = false;
			}
		} else if(e.which) {
			var code = e.which;
			if ((code >= 48 && code <= 57) || (code >= 96 && code <= 105) || (code==8) || (code==9) || (code==46)) {
			      return;
			    } else {
			      e.preventDefault();
			    }
		}
	}
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<form action="/bachida/pcustom/update_pcustom_estimate" method="post" id="estimatePcustom" name="estimatePcustom">
				<div class="col-md-7">
					<hr>
					<h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2>
					<h3>견적서 수정</h3>
					<h5>작품상세정보와 예상완료일, 수량, 가격 등 자세하게 입력해 주세요.<br>
						구매자의 결제 전까지 수정 가능합니다.
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
							<th>내용</th>
							<td>
								<textarea id="content" name="content" class="form-control" rows="10" cols=""></textarea>
							</td>
						</tr>
						<tr>
							<th>주문금액</th>
							<td>
								<input type="text" id="price" name="price" class="form-control" placeholder="숫자만 입력해 주세요.">
							</td>
						</tr>
					</table>
					<!-- Spring Security의 token값 설정 -->
					<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> --%>
					<button id="updateEstimateBtn" class="glyphicon glyphicon-ok btn btn-default">확인</button>
				</div>
			</form>
			<hr>
		</div>
		<button id="cencel" class="glyphicon glyphicon-chevron-left btn btn-default">취소</button>
		<hr>
	</div>
</body>
</html>