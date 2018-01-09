<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
$(function() {
	var $artisan = ${artisan};
	console.log($artisan);
	if($artisan.artisanName==""){
		$("#infoUpdate_btn").prop("disabled",true);
	}
	
	$("#artisanId").val($artisan.artisanId);
	$("#artisanName").val($artisan.artisanName);
	$("#artisanEmail").val($artisan.artisanEmail);
	$("#artisanTel").val($artisan.artisanTel);
	
	var intro_textareaVal = $artisan.artisanIntro;
	result = intro_textareaVal.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	$("#artisanIntro").val(result);
	
	var policy_textareaVal = $artisan.artisanPolicy;
	policyResult = policy_textareaVal.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	$("#artisanPolicy").val(policyResult);
	

	if($artisan.originalFileName!=""){
		$("<a></a>").attr("href","#").text($artisan.originalFileName).appendTo("span#thumName");
		$(".img-circle").attr("src","/bachida/user/displayFile?savedFileName="+$artisan.savedFileName+"&originalFileName="+$artisan.originalFileName);
//		$(".img-circle").attr("src","https://loremflickr.com/80/80");
		$("#file").hide();
		$("<button type='button'></button>").attr("id","updateThum").text("변경").appendTo($("#thumTd"));
	}else{
		$("#thumName").hide();
		$("#thum").hide();
	}
	$("#updateThum").on("click",function(){
		$("#file").show();
		$(this).hide();
	});
	
	// 작가명 중복확인 수정해야함!
	
	$("#idCheck").on("click",function(){
		$.ajax({
			url : "/bachida/artisan/nameCheck",
			method : "post",
			data : {"artisanName" : $("#artisanName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			success : function(result){
				console.log(result)
				if(result==false){
					$("#idMsg").text("사용가능한 이름입니다.");
					$("#infoUpdate_btn").prop("disabled",false);
				}
				else {
					$("#idMsg").text("중복된 이름이 있습니다.");
					$("#infoUpdate_btn").prop("disabled",true);
				}
			}
		});
	});
	
	
	
	// textarea 글자수 체크
    $('#artisanIntro').keyup(function(){
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
        $('#introCounter').html(content.length + '/1000');
    });
    $('#artisanIntro').keyup();
    $('#artisanPolicy').keyup(function (e){
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
        $('#policyCounter').html(content.length + '/1000');
    });
    $('#artisanPolicy').keyup();   
    
    // textarea 엔터 <br>로 바꾸기..!
    $("#infoUpdate_btn").on("click",function(){
    	if($("#file").val()==null && $("#thumName").text()==null) {
    		alert("썸네일 사진을 설정해주세요");
  		}else{
	    	var intro_textareaVal = $("#artisanIntro").val();
			 intro_result = intro_textareaVal.replace(/(\n|\r\n)/g, '<br>');
			$("#artisanIntro").val(intro_result);
			console.log($("#artisanIntro").val());
			
			 var policy_textareaVal = $("#artisanPolicy").val();
			 policy_result = policy_textareaVal.replace(/(\n|\r\n)/g, '<br>');
			$("#artisanPolicy").val(policy_result);
			// file 비어있으면 기존 파일명 보내기;
			if($artisan.originalFileName!=""){
				$("<input type='hidden'>").attr("name","originalFileName").val($artisan.originalFileName).appendTo("form");
				$("<input type='hidden'>").attr("name","savedFileName").val($artisan.savedFileName).appendTo("form");
			}
			$("form").submit();
    	}
	 });
    
    
});
</script>
<style>
.wrap {
    width: 600px;
    height: auto;
    position: relative;
    display: inline-block;
}
.wrap textarea {
    width: 100%;
    resize: none;
    min-height: 4.5em;
    line-height:1.6em;
    max-height: 9em;
}
.wrap span {
    position: absolute;
    bottom: 5px;
    right: 5px;
}
#introCounter,#policyCounter {
	background: rgba(255, 0, 0, 0.5);
	border-radius: 0.5em;
	padding: 0 .5em 0 .5em;
	font-size: 0.75em;
	height: auto !important;
}
</style>
</head>
<body>
<h3 style="text-align: center;color: rgb(245, 89, 128);">작가정보수정</h3>
	<form action="/bachida/artisan/infoUpdate" method="post" enctype="multipart/form-data">
		<table class="table form-inline">
			<tr>              
				<td>아이디</td>
				<td><input type="text" name="artisanId" id="artisanId" readonly="readonly" class="form-control"></td>
			</tr>                                            
			<tr>
				<td>작가명</td>
				<td><input type="text" name="artisanName" id="artisanName" class="form-control">
					<button type="button" class="btn btn-default" id="idCheck">중복확인</button><br>
					<span id="idMsg"></span>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="artisanTel" id="artisanTel" class="form-control"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="artisanEmail" id="artisanEmail" class="form-control"></td>
			</tr>
			<tr>
				<td>작가소개</td>
				<td><div class="wrap">
						<textarea rows="4"  name="artisanIntro" id="artisanIntro" maxlength="1000" ></textarea>
						<span id="introCounter">###</span>
					</div>
				</td>     
			</tr>                                                 
			<tr>
				<td>배송정책</td>              
				<td><div class="wrap">
						<textarea rows="4" name="artisanPolicy" id="artisanPolicy" maxlength="1000" ></textarea>
						<span id="policyCounter">###</span>
					</div>                                      
				</td>
			</tr>                                            
			<tr>
				<td>썸네일</td>                 
				<td id="thumTd">
					<a href="#" id="thum"> <img class="img-circle" alt="작가로고" style="width: 80px; height: 80px;"></a>
					<span id="thumName"></span>
					<input type="file" name="file" id="file" value="파일" class="btn btn-default">
				</td>  
			</tr>
			<tr>                                                     
				<td colspan="2" style="text-align: center;"><button type="button" class="btn btn-success" id="infoUpdate_btn">정보 수정</button></td>
			</tr>                  
		</table>
		<input type="hidden" name="_csrf" value="${_csrf.token}">
	</form>
	
</body>
</html>