<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		var $user = ${user};
		var $interest = $user.interests;
		var $auth = $user.authorities;
		console.log($auth.length)
		if($user.enable==true){
			$("#enable").text("활동회원 ");
			$("<a>").attr("href","#").attr("id","blockBtn").text("회원 차단").addClass("btn").addClass("btn-default").appendTo($("#enable"));
		}else if($user.enable==false){
			$("#enable").text("차단회원 ");
			$("<a>").attr("href","#").attr("id","clearBlockBtn").text("차단 해제").addClass("btn").addClass("btn-default").appendTo($("#enable"));
		}
		$("#id").text($user.id);
		$("#name").text($user.name);
		$("#cash").text($user.cash+"원");
		$("#joinDate").text($user.joinDate);
		$("#tel").text($user.tel);
		$("#email").text($user.email);
		$("#birthDate").text($user.birthDate);
		$("#warningCnt").text($user.warningCnt+"회");
		if($interest.length!=0){
			var interestCol = "";
			$.each($interest, function(i, interest) {
				if(interest.mainCategoryIdx==1)
					interestCol += "악세사리 ";
				else if(interest.mainCategoryIdx==2)
					interestCol += "패션소품 ";
				else if(interest.mainCategoryIdx==3)
					interestCol += "생활 ";
				else if(interest.mainCategoryIdx==4)
					interestCol += "디자인문구 ";
				else if(interest.mainCategoryIdx==5)
					interestCol += "반려동물 ";
			})
			console.log(interestCol);
			$("#interest").text(interestCol);
		}else
			$("#interest").text("없음");
		
		$.each($auth, function(i, auth) {
			console.log(auth.authority=="ROLE_USER");
			if(auth.authority=="ROLE_MANAGER"){
				$.ajax({
					url:"/bachida/admin/artisanInfo",
					data : "id="+$user.id,
					type : "get",
					success: function(artisan){
						console.log(artisan);
						$("<h3>").text("작가정보").appendTo($("#tableDiv"))
						var $table = $("<table>").addClass("table").appendTo($("#tableDiv"));
						var $firstTr = $("<tr>").appendTo($table);
						$("<th>").addClass("active").text("작가명").appendTo($firstTr);
						$("<td>").attr("colspan","3").text(artisan.artisanName).appendTo($firstTr);
						var $secTr = $("<tr>").appendTo($table);
						$("<th>").addClass("active").text("작가연락처").appendTo($secTr);
						$("<td>").text(artisan.artisanTel).appendTo($secTr);
						$("<th>").addClass("active").text("작가이메일").appendTo($secTr);
						$("<td>").text(artisan.artisanEmail).appendTo($secTr);
						var $thTr = $("<tr>").appendTo($table);
						$("<th>").addClass("active").text("작가소개").appendTo($thTr);
						$("<td>").attr("colspan","3").text(artisan.artisanIntro).appendTo($thTr);
					}
				})
			}
		})
		
		$("#blockBtn").on("click",function(){
			if(confirm("차단하시겠습니까?")){
				var $form = $("<form>").appendTo("body");
				$("<input>").attr("name","id").attr("type","hidden").val($user.id).appendTo($form);
				$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
				var $formData = $form.serialize();
				$.ajax({
					url : "/bachida/admin/blockUser",
					data : $formData,
					type : "post",
					success: function(){
						alert("차단이 완료되었습니다");
						location.reload();
					}
				});
			}
		});
		
		$("#clearBlockBtn").on("click",function(){
			if(confirm("차단을 해제하시겠습니까?")){
				var $form = $("<form>").appendTo("body");
				$("<input>").attr("name","id").attr("type","hidden").val($user.id).appendTo($form);
				$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
				var $formData = $form.serialize();
				$.ajax({
					url : "/bachida/admin/clearblockUser",
					data : $formData,
					type : "post",
					success: function(){
						alert("차단 해제가 완료되었습니다");
						location.reload();
					}
				});
			}
		});
	});
</script>
</head>
<body>  
	<div class="container">
		<div class="row" id="tableDiv">
			<h3>회원정보</h3>
			<br>
			<table class="table">
				<tr>
					<th class="active">회원상태</th>
					<td colspan="3" id="enable"></td>
				</tr>
				<tr>
					<th class="active">아이디</th>
					<td id="id"></td>
					<th class="active">이름</th>
					<td id="name"></td>
				</tr>
				<tr>
					<th class="active">캐쉬</th>
					<td id="cash"></td>
					<th class="active">경고회수</th>
					<td id="warningCnt"></td>
				</tr>
				<tr>
					<th class="active">연락처</th>
					<td id="tel"></td>
					<th class="active">이메일</th>
					<td id="email"></td>
				</tr>
				<tr>
					<th class="active">생년월일</th>
					<td id="birthDate"></td>
					<th class="active">회원가입일</th>
					<td id="joinDate"></td>
				</tr>
				<tr>
					<th class="active">관심분야</th>
					<td colspan="3" id="interest"></td>
				</tr>
			</table>
			<br>
		</div>
	</div>
</body>
</html>