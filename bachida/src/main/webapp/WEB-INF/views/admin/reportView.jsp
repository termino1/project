<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		var $report = ${report};
		$("#reportInfo").html("접수아이디 : "+$report.id+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"신고아이디: "+$report.reportId+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+$report.writeDate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+$report.reportState);
		$("#reportContent").text($report.reportContent);
		$("<img>").addClass("center-block").attr("src","/bachida/user/displayFile?savedFileName="+$report.savedFileName+"&originalFileName="+$report.originalFileName).css({"width":"500px","height":"500px"}).appendTo("#reportImg");
		
		if($report.reportState=="접수"){
			$("<button>").addClass("btn").addClass("btn-default").addClass("pull-right").attr("id","blockBtn").text("차단").appendTo($("#reportDiv"));
			$("<button>").addClass("btn").addClass("btn-default").addClass("pull-right").attr("id","warnBtn").text("경고").appendTo($("#reportDiv"));
		}
		
		$("#blockBtn").on("click",function(){
			if(confirm("회원을 차단하시겠습니까?")){
				var $form = $("<form>").appendTo("body");
				$("<input>").attr("name","reportId").attr("type","hidden").val($report.reportId).appendTo($form);
				$("<input>").attr("name","reportIdx").attr("type","hidden").val($report.reportIdx).appendTo($form);
				$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
				var $formData = $form.serialize();
				$.ajax({
					url : "/bachida/admin/reportBlock",
					data : $formData,
					type : "post",
					success: function(){
						alert("차단이 완료되었습니다");
						location.reload();
					}
				});
			}
		});
		
		$("#warnBtn").on("click",function(){
			if(confirm("회원을 경고하시겠습니까?")){
				var $form = $("<form>").appendTo("body");
				$("<input>").attr("name","reportId").attr("type","hidden").val($report.reportId).appendTo($form);
				$("<input>").attr("name","reportIdx").attr("type","hidden").val($report.reportIdx).appendTo($form);
				$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
				var $formData = $form.serialize();
				$.ajax({
					url : "/bachida/admin/reportWarning",
					data : $formData,
					type : "post",
					success: function(){
						alert("경고가 완료되었습니다");
						location.reload();
					}
				});
			}
		});
		
		$("#reportListBtn").on("click",function(){
			location.href = "/bachida/admin/reportList"
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<h3 style="color: rgb(245, 89, 128);">신고내역</h3>
			<div class="col-md-10" id="reportDiv">
				<!-- <button class="btn btn-default pull-right" type="button" id="messageDelete">삭제</button> -->
				<button class="btn btn-default pull-right" type="button" id="reportListBtn">목록</button>
				<table class="table table-hover">
					<tr>
						<th id="reportInfo"></th>
					</tr>
					<tr>
						<th id="reportImg">
						
						</th>
					</tr>
					<tr>
						<th id="reportContent"></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>