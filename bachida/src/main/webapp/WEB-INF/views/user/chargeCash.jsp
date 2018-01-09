<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script type="text/javascript" src="/bachida/js/bootstrap.js"></script>
<script>
	$(function(){
		$("#chargeBtn").on("click",function(){
			/* $("#chargeFrm").attr("action","/bachida/user/cashCharge").attr("method","post")
			$("#chargeFrm").submit(); */
			$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($("#chargeFrm"));
			$.ajax({
				url : "/bachida/user/cashCharge",
				type : "post",
				data : $("#chargeFrm").serialize(),
				success: function(){
					alert("충전이 완료되었습니다.");
					location.href = "/bachida/mypage";
				}
			});
		});
	});
</script>
<style>
.table{margin-bottom:25px;border-bottom:1px solid #ddd}
</style>
</head>
<body>
	<div class="container">
		<!-- <div class="col-md-8"> -->
			<!-- <nav class="navbar navbar-default">
				<div class="container">
					<div id="navbar" class="text-white collapse navbar-collapse">
						<ul class="nav navbar-nav">
							<li><a>충전하기</a></li>
						</ul>
					</div>
				</div>
			</nav> -->
			<h3 style="color: rgb(245, 89, 128);">충전하기</h3>
			<form id="chargeFrm">
			<table class="table">
				<tr class="active">
					<th>충전하실 금액</th>
				</tr>
				<tr>
					<td class="text-center">
						<input type="radio" name="cash" value=5000><label>5000원</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="cash" value=10000><label>10000원</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="cash" value=50000><label>50000원</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="cash" value=100000><label>100000원</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				</table>
			<table class="table">
				<tr class="active">
					<th>결제방식</th>
				</tr>
				<tr>
					<td class="text-center">
						<ul class="list-inline">
							<li><label><input type="radio" name="pay"> 신용카드</label></li>
							<li><label><input type="radio" name="pay"> 무통장입금</label></li>
						</ul>
					</td>
				</tr>
			</table>
			<div>
			<button class="btn btn-default center-block" type="button"	id="chargeBtn">충전하기</button></div>
		</form>
		<!-- </div> -->
	</div>
</body>
</html>