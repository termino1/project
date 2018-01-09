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
	height : 50px;
	background: #f5f5f5;
	border-bottom: 1px solid black;
	height: 50px;
}
.table{
	margin-left: 30px;
	width: 400px;
}
.table > tbody > tr > td{
	border-top: 0px;
}
.row {
	width: 500px;
	margin-top: 20px;
	border: 1px solid black;
}
h3 {
	line-height: 0;
}
</style>
<script>
	$(function(){
		
		//아이디 찾기
		$("#idFindBtn").on("click",function(){
			$("<input>").attr("type","hidden").attr("name",'${_csrf.parameterName}').val('${_csrf.token}').appendTo($("#idFind"));
			var $form = $("#idFind").serialize();
			console.log($form);
			$.ajax({
				url : "/bachida/user/idFind",
				method : "post",
				data : $form,
				success : function(result){
					if(result==""){
						alert("해당하는 정보의 회원이 없습니다");
					}
					else
						alert("아이디는 "+result+" 입니다. ");
						$("#name").val("");
						$("#email").val("");
				}
			});
		});
		
		//비밀번호찾기(이메일인증)
		$("#pwdFindBtn").on("click",function(){
			$("<input>").attr("type","hidden").attr("name",'${_csrf.parameterName}').val('${_csrf.token}').appendTo($("#pwdFind"));
			var $form = $("#pwdFind").serialize();
			console.log($form);
			$.ajax({
				url : "/bachida/user/pwdFind",
				method : "post",
				data : $form,
				success : function(result){
					console.log(result);
					if(result==""){
						alert("해당하는 정보의 회원이 없습니다");
					}else{
						alert("회원님의 이메일로 인증번호가 발송되었습니다. ");
						$("#pwdFindBtn").css("display","none");
						$("#emailConfirmBtn").prop("disabled",false);
						$tr = $("#emailKey");
						$("<td></td>").text("인증번호").appendTo($tr);
						$td = $("<td></td>").appendTo($tr);
						$("<input>").attr("type","text").attr("id","key").appendTo($td);
						$("#emailConfirmBtn").on("click",function(){
							if(result==$("#key").val()){
								//location.href = "/bachida/user/pwdChange?id="+$("#id").val();
								var form = $("<form></form>").attr("method","post").attr("action","/bachida/user/completeConfirmation").appendTo("body");
								$("<input>").attr("name","id").attr("type","hidden").val($("#id").val()).appendTo(form);
								$("<input>").attr("type","hidden").attr("name",'${_csrf.parameterName}').val('${_csrf.token}').appendTo(form);
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
				<h3 style="color: rgb(245, 89, 128);">아이디 찾기</h3>
			</div>
			<div class="col-md-7">
				<form id="idFind">
					<table class="table">
						<tr>
							<td>이름 :</td>
							<td><input type="text" id="name" name="name"></td>
						</tr>
						<tr>
							<td>이메일 :</td>
							<td><input type="text" id="email" name="email"></td>
						</tr>
						<tr>
							<td colspan="2"><button type="button" class="btn btn-default center-block" id="idFindBtn">아이디 찾기</button></td>
						</tr>
					</table>
					
				</form>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 h3col">
				<h3 style="color: rgb(245, 89, 128);">비밀번호 찾기 찾기</h3>
			</div>
			<div class="col-md-7">
				<form id="pwdFind">
					<table class="table">
						<tr>
							<td>아이디 :</td>
							<td><input type="text" name="id" id="id"></td>
						</tr>
						<tr>
							<td>이메일 :</td>
							<td><input type="text" name="email"><button type="button" class="btn btn-default" id="pwdFindBtn">이메일인증</button></td>
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