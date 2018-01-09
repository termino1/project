<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
	$(function() {
		var password = $("#password")
		var password2 = $("#password2")
		
		// 아이디중복확인이벤트
		$("#idCheck").on("click",function(){
			$.ajax({
				url : "/bachida/user/idCheck",
				method : "post",
				data : {"id" : $("#id").val(),'${_csrf.parameterName}':'${_csrf.token}'},
				success : function(result){
					console.log(result)
					if(result==false){
						$("#idMsg").text("사용가능한 아이디입니다.");
						$("#joinBtn").prop("disabled", false);
					}
					else
						$("#idMsg").text("중복된 아이디가 있습니다.");
				}
			});
		});
		
		//회원가입 이벤트
		$("#joinBtn").on("click",function(){
			/* 나중에 hibernate적용 */
			if(password.val()==""){
				alert("비밀번호를 입력해주세요");
			}
			if(password2.val()==""){
				alert("비밀번호를 입력해주세요");
			}
			if(password.val()!=password2.val()){
				alert("비밀번호가 서로 일치하지 않습니다.");
			}else{
				$form = $("#joinFrm");
				$form.attr("method","post");
				$form.attr("action","/bachida/user/join");
				$("<input>").attr("type","hidden").attr("name",'${_csrf.parameterName}').val('${_csrf.token}').appendTo($form);
				$form.submit();
			}
		});
		
		
		//취소이벤트
		$("#cancelBtn").on("click",function(){
			location.href = "/bachida";
		});
		
		$("#date").datepicker(
				{
					showOn : "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
					changeMonth : true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
					changeYear : true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
					minDate : '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
					nextText : '다음 달', // next 아이콘의 툴팁.
					prevText : '이전 달', // prev 아이콘의 툴팁.
					numberOfMonths : [ 1, 1 ], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
					//stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
					yearRange : 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
					showButtonPanel : true, // 캘린더 하단에 버튼 패널을 표시한다. 
					currentText : '오늘 날짜', // 오늘 날짜로 이동하는 버튼 패널
					closeText : '닫기', // 닫기 버튼 패널
					dateFormat : "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
					showAnim : "slide", //애니메이션을 적용한다.
					showMonthAfterYear : true, // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ], // 요일의 한글 형식.
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]
				// 월의 한글 형식.

				});
	});
</script>
<style>
	button{
		margin-left: 10px;
	}
</style>
</head>
<body> 
	<div class="container">
		<div class="row">
			<form id="joinFrm">
				<div class="col-md-12">
				<h3 style="color: rgb(245, 89, 128);">회원가입</h3>
					<table class="table form-inline">
						<tr>
							<td class="active">아이디</td>
							<td>
								<input type="text" name="id" id="id" class="form-control">
								<button type="button" class="btn btn-default" id="idCheck">중복확인</button><br>
								<span id="idMsg"></span>
							</td>
						</tr>
						<tr>
							<td class="active">이름</td>
							<td>
								<input type="text" name="name" class="form-control">
							</td>
						</tr>
						<tr>
							<td class="active">이메일</td>
							<td><input type="text" name="email" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">휴대전화</td>
							<td><input type="text" name="tel" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">생년월일일</td>
							<td><input type="date" name="birthDate" id="date" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">비밀번호</td>
							<td><input type="password" name="password" class="form-control"></td>
						</tr>
						<tr>
							<td class="active">비밀번호 확인</td>
							<td><input type="password" name="password2" class="form-control"></td>
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
						<button type="button" id="joinBtn" class="pull-right btn btn-danger" disabled="disabled">회원가입</button>
						<button type="button" id="cancelBtn" class="pull-right btn btn-default">취소</button>
				</div>
			</form>

		</div>
	</div>
</body>
</html>