<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
	$(function() {
		var user = ${mypage_user};
		var authorities = user.authorities;
		var interests = user.interests;
		console.log(user);
		console.log(authorities);
		console.log(interests);
		$("#id").val(user.id);
		$("#name").val(user.name);
		$("#email").val(user.email);
		$("#tel").val(user.tel);
		$("#birthDate").val(user.birthDate);
		$("#joinDate").val(user.joinDate);
		$.each(interests, function(i, interest) {
			$("input[type='checkbox'][value='"+interest.mainCategoryIdx+"']").prop("checked",true);
		})
		
		$("#updateBtn").on("click",function(){
			if($("#password").val()==""){
				alert("비밀번호를 입력해주세요");
				return;
			}
			$("<input>").attr("type","hidden").attr("name",'${_csrf.parameterName}').val('${_csrf.token}').appendTo($("#updateFrm"));
			var $form = $("#updateFrm").serialize();
			$.ajax({
				url : "/bachida/user/updateUser",
				type : "post",
				data : $form,
				success : function(result){
					if(result==true){
						alert("회원수정이 완료되었습니다.");
						location.href = "/bachida";
					}else
						alert("비밀번호가 맞지 않습니다.")
				}
			});
			/* $("#updateFrm").attr("action","/bachida/user/updateUser").attr("method","post");
			$("#updateFrm").submit(); */
		})
	});
</script>
<style>
.table{border-bottom: 1px solid #ddd}
</style>
</head>
<body>  
<h3 style="color: rgb(245, 89, 128);">회원정보 변경</h3>
	<div class="container">
		<div class="row">
			<form id="updateFrm">
				<div class="col-md-12">           
					
					<table class="table form-inline">
					<colgroup>
					<col width="200px"/>
					<col />
					</colgroup>
						<tr>
							<td class="active">아이디</td>
							<td>
								<input type="text" name="id" id="id" readonly="readonly" class="form-control">
							</td>
						</tr>
						<tr>
							<td class="active">이름</td>
							<td>
								<input type="text" name="name" id="name" readonly="readonly" class="form-control">
							</td>
						</tr>
						<tr>
							<td class="active">이메일</td>
							<td><input type="text" name="email" id="email" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">휴대전화</td>
							<td><input type="text" name="tel" id="tel" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">생년월일</td>
							<td><input type="text" name="birthDate" id="birthDate" readonly="readonly" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">가입일</td>
							<td><input type="text" name="joinDate" id="joinDate" readonly="readonly" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">비밀번호</td>
							<td><input type="password" name="password" id="password" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">새로운 비밀번호</td>
							<td><input type="password" name="newPassword" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">비밀번호 확인</td>
							<td><input type="password" name="newPassword2" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">관심 카테고리</td>
							<td>
								<input type="checkbox" name="interest" value=1>악세사리
								<input type="checkbox" name="interest" value=2>패션소품
								<input type="checkbox" name="interest" value=3>생활
								<input type="checkbox" name="interest" value=5>반려동물
								<input type="checkbox" name="interest" value=4>디자인문구
							</td>
						</tr>
					</table>
						<button type="button" id="updateBtn" class="pull-right btn btn-danger">정보수정</button>
				</div>
			</form>

		</div>
	</div>
</body>
</html>