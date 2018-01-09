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
		$("#applyBtn").on("click",function(){
			var imgVal = $('#files').val();
			if(imgVal==''){
				alert("사진파일을 첨부해주세요");
				return;
			}
			var formData = new FormData($("#applyFrm")[0]);
			formData.append("${_csrf.parameterName}","${_csrf.token}");
			$.ajax({
				url : "/bachida/user/artisanApply",
				type : "post",
				data : formData,
				processData:false,	// FormData 전송에 필요한 설정
				contentType:false,	// FormData 전송에 필요한 설정
				success : function(result){
					if(result){
						alert("신청이 완료되었습니다");
						window.close();
					}
				}
			})
		});
	});
</script>
</head>
<body> 
	<h3 style="color: rgb(245, 89, 128);">작가신청</h3>
	<ul>
		<li>작가님의 작품 중 대표작 한 가지를 골라 그 작품을 가장 잘 나타낼 수 있는 사진 1장을 첨부해주세요.</li>
		<li>대표작품에 대한 설명을 작성해주세요.</li>
		<li>ex) 작품명, 상세설명, 제작과정(핸드메이드-수공예로 제작됨을 알 수 있는 과정 설명), 예상판매가격 등을 포함해주세요.</li>
	</ul>
	<div class="col-md-8">
	<form id="applyFrm" enctype="multipart/form-data">
	<table class="table">
		<tr class="form-inline"><td class="active text-center">연락처</td><td><input type="text" name="artisanTel" id="artisanTel" class="form-control"></td></tr>
		<tr class="form-inline"><td class="active text-center">이메일</td><td><input type="text" name="artisanEmail" id="artisanEmail" class="form-control"></td></tr>
		<tr><td class="active text-center">작가소개</td><td><textarea class="form-control" name="artisanIntro" id="artisanIntro" rows="3"></textarea></td></tr>
		<tr><td class="active text-center">작품소개</td><td><textarea class="form-control" name="craftIntro" id="craftIntro" rows="3"></textarea></td></tr>
		<tr><td class="active text-center">첨부파일</td><td><input type="file" name="files" id="files" multiple="multiple"></td></tr>
		<tr>
			<td colspan="2">
				<button type="button" class="btn btn-default pull-right" id="applyBtn">신청</button>
			</td>
		</tr>
	</table>
	</form>
	</div>
</body>
</html>