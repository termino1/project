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
		var reportId = ${reportId};
		$("#reportId").val(reportId);
		
		$("#reportBtn").on("click",function(){
			var formData = new FormData($("#reportFrm")[0]);
			formData.append("${_csrf.parameterName}","${_csrf.token}");
			$.ajax({
				url : "/bachida/user/writeReport",
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
<style>
	#reportId{
		border : none;
	}
</style>
</head>
<body>   
	<h3 style="color: rgb(245, 89, 128);">회원신고 </h3>
	<div class="col-md-8">
	<form id="reportFrm" enctype="multipart/form-data">
	<table class="table">
		<tr><td class="active text-center">아이디</td><td><input type="text" id="reportId" name="reportId" readonly="readonly"></td></tr>
		<tr><td class="active text-center">신고내용</td><td><textarea class="form-control" name="reportContent" id="reportContent" rows="3"></textarea></td></tr>
		<tr><td class="active text-center">캡쳐사진</td><td><input type="file" name="file" id="file"></td></tr>
		<tr>
			<td colspan="2">
				<button type="button" class="btn btn-default center-block" id="reportBtn">신고하기</button>
			</td>
		</tr>
	</table>
	</form>
	</div>
</body>
</html>