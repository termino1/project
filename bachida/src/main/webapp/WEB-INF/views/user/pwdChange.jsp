<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		var id = ${id};
		$("#pwdChangeBtn").on("click",function(){
			var pwd = $("#pwd")
			var pwd2 = $("#pwd2")
			if(pwd.val()==""){
				alert("비밀번호를 입력해주세요");
				pwd.val("");
				pwd2.val("");
			}
			if(pwd2.val()==""){
				alert("비밀번호를 입력해주세요");
				pwd.val("");
				pwd2.val("");
			}
			if(pwd.val()==pwd2.val()){
				$.ajax({
					url : "/bachida/user/pwdChange?id="+id+"&pwd="+pwd.val(),
					data : "${_csrf.parameterName}=${_csrf.token}",
					type : "post",
					success: function(result){
						if(result==true){
							alert("비밀번호가 변경되었습니다.");
							location.href = "/bachida";
						}
					}
				});
			}else{
				alert("비밀번호가 서로 일치하지 않습니다.");
				pwd.val("");
				pwd2.val("");
			}
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12 h3col">
				<h3 style="color: rgb(245, 89, 128);">비밀번호 변경</h3>
			</div>
			<div class="col-md-7">
				<form id="pwdChange">
					<table class="table">
						<tr>
							<td>새로운 비밀번호 :</td>
							<td><input type="password" name="pwd" id="pwd"></td>
						</tr>
						<tr>
							<td>비밀번호 확인:</td>
							<td><input type="password" id="pwd2"></td>
						</tr>
						<tr>
							<td colspan="2"><button type="button" class="btn btn-default center-block" id="pwdChangeBtn">비밀번호 변경</button></td>
						</tr>
					</table>
					
				</form>
			</div>
		</div>
	</div>

</body>
</html>