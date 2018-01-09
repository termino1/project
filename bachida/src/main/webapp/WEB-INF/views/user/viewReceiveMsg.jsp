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
		$msg = ${message};
		$("#messageInfo").text("보낸사람: "+$msg.sender+" 전송일자: "+$msg.sendDate);
		$("#messageContent").text($msg.messageContent);
		
		/* $("#messageDelete").on("click",function(){
			location.href = "/bachida/user/msgDelete?messageIdx="+$msg.messageIdx;
		}); */
		$("#messageList").on("click",function(){
			location.href = "/bachida/user/receiveMsgList";
		});
		$("#writeBtn").on("click",function(){
			var $form = $("<form></form>").attr("action","/bachida/user/msgWriteForm").attr("method","get").appendTo("body");
			$("<input>").attr("name","receiver").attr("type","hidden").val($msg.sender).appendTo($form);
			//$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
			$form.submit();
		});
		$("#closeMsg").on("click",function(){
			opener.parent.location.reload(true);
			window.close();
		});
	})
	
</script>
<style>
	.navbar{
		width: 800px;
	}
</style>
</head>
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
				<!-- <button class="btn btn-default pull-right" type="button" id="messageDelete">삭제</button> -->
				<button class="btn btn-default pull-right" type="button" id="writeBtn">답장</button>
				<button class="btn btn-default pull-right" type="button" id="messageList">목록</button>
					<table class="table table-hover">
						<tr>
							<th id="messageInfo"></th>
						</tr>
						<tr>
							<th id="messageContent"></th>
						</tr>
					</table>
					<button class="btn btn-default pull-right" type="button" id="closeMsg">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>