<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>
	$(function(){
		$("#idFindBtn").on("click",function(){
			location.href = "/bachida/user/idPwdFind";
		});
		
		$("#loginBtn").on("click",function(){
			$("#loginFrm").attr("action","/bachida/user/login").attr("method","post")
			$("<input>").attr("type","hidden").attr("name",'${_csrf.parameterName}').val('${_csrf.token}').appendTo($("#loginFrm"));
			$("#loginFrm").submit();
		});
		
		$("#joinBtn").on("click",function(){
			location.href = "/bachida/user/join";
		});
	});
</script>
<style>
	input[type='button']{
		margin-right: 10px;
	}
</style>
<body>
	<div class="container">
			<div class="row">
        		<div class="col-md-offset-3 col-md-5">
            		<h4 style="color: rgb(245, 89, 128);">로그인</h4>
            		<form id="loginFrm">
            			<div class="form-group">
           					<input type="text" name="loginid" class="form-control" placeholder="ID">
                		</div>
                		<div class="form-group">
            				<input type="password" name="loginpwd" class="form-control" placeholder="Password" >
           				</div>
            			<a id="idFindBtn" href="#" class="center-block text-center">아이디/비밀번호 찾기</a>
            			<input id="loginBtn" type="button" class="pull-right btn btn-primary" value="로그인">
            			<input id="joinBtn" type="button" class="pull-right btn btn-primary" value="회원가입">
            			
            		</form>
            	</div>
        	</div>
    	</div>
</body>
</html>