<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="/bachida/js/bootstrap.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script>
	$(function(){
		var $receiver = ${receiver};
		$("#receiver").val($receiver);
		
		$("#cancelBtn").on("click",function(){
			window.close();
		});
		$("#writeBtn").on("click",function(){
			$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($("#msgFrm"));
			var $form = $("#msgFrm").serialize()
			$.ajax({
				url : "/bachida/user/msgWrite",
				data : $form,
				type : "post",
				success: function(){
					alert("전송이 완료되었습니다");
					opener.parent.location.reload(true);
					window.close();
				}
			});
		});
	});
</script>
</head>
<style>
	#receiver{
		border: none;
	}
</style>
<body>
	<div class="container">
		<h3 style="color: rgb(245, 89, 128);">내 쪽지함</h3>
		<nav class="navbar navbar-default">
			<div class="container">
				<div id="navbar" class="text-white collapse navbar-collapse">
					<ul class="nav navbar-nav">
						<li class="active"><a href="/bachida/user/receiveMsgList">받은쪽지함</a></li>
						<li><a href="/bachida/user/sendMsgList">보낸쪽지함</a></li>
					</ul>
				</div>
			</div>
		</nav>
		<div class="row">
			<div class="col-md-8"> 
				<form id="msgFrm">
					<table class="table">
						<tr><td>받는사람 : <input type="text" name="receiver" id="receiver" readonly="readonly"></td></tr>
						<tr><td><textarea class="form-control" name="messageContent" id="messageContent" rows="3"></textarea></td></tr>
						<tr>
							<td colspan="2">
								<button type="button" class="btn btn-default pull-right" id="writeBtn">보내기</button>
								<button type="button" class="btn btn-default pull-right" id="cancelBtn">취소</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	
</body>
</html>