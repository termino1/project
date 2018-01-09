<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
.h3col {
	background: #f5f5f5;
	border-bottom: 1px solid black;
}
.table{
	margin-left: 30px;
	width: 400px;
}
.table > tbody > tr > td{
	border-top: 0px;
}
.row {
	width: 530px;
	margin-top: 20px;
	border: 1px solid black;
}
h3 {
	line-height: 0;
}
</style>
<script>
	$(function(){
		
		
		//이메일인증
		$("#resignBtn").on("click",function(){
			$("<input>").attr("type","hidden").attr("name",'${_csrf.parameterName}').val('${_csrf.token}').appendTo($("#resignFrm"));
			var $form = $("#resignFrm").serialize();
			$.ajax({
				url : "/bachida/user/resign",
				method : "post",
				data : $form,
				success : function(result){
					if(result==""){
						alert("해당하는 정보의 회원이 없습니다");
					}else{
						alert("회원님의 이메일로 인증번호가 발송되었습니다. ");
						$("#resignBtn").css("display","none");
						$("#emailConfirmBtn").prop("disabled",false);
						$tr = $("#emailKey");
						$("<td></td>").text("인증번호").appendTo($tr);
						$td = $("<td></td>").appendTo($tr);
						$("<input>").attr("type","text").attr("id","key").appendTo($td);
						$("#emailConfirmBtn").on("click",function(){
							if(result==$("#key").val()){
								//location.href = "/bachida/user/pwdChange?id="+$("#id").val();
								var form = $("<form></form>").attr("method","post").attr("action","/bachida/user/resignUser").appendTo("body");
								$("<input>").attr("name","id").attr("type","hidden").val($("#id").val()).appendTo(form);
								$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo(form);
								form.submit();
							}else{
								alert("잘못된 인증번호입니다.")
							}
						});
					}
				}
			});
		});
		
	});
</script>
<body> 
	<div class="container">
		<div class="row">
			<div class="col-md-12 h3col">
				<h3 style="color: rgb(245, 89, 128);">회원탈퇴</h3>
				<br>
				<p>
					회원탈퇴에 따른 이용내역 삭제
				</p>
				<p>&nbsp;&nbsp;- 회원탈퇴를 신청하면, 모든 이용내역이 삭제되어 복구가 불가능하게 됩니다.</p>
			</div>
			<div class="col-md-11">
				<form id="resignFrm">
					<table class="table">
						<tr>
							<td>아이디 :</td>
							<td><input type="text" name="id" id="id"></td>
						</tr>
						<tr>
							<td>비밀번호 :</td>
							<td><input type="password" name="password" id="password"></td>
						</tr>
						<tr>
							<td>이메일 :</td>
							<td>
								<input type="text" name="email">
								<button type="button" class="btn btn-default" id="resignBtn">이메일인증</button>
							</td>
						</tr>
						<tr id="emailKey">
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" class="btn btn-default center-block" id="emailConfirmBtn" disabled="disabled">다음</button>
							<td>
						</tr>
					</table>
					
				</form>
			</div>
		</div>
	</div>
</body>
</html>