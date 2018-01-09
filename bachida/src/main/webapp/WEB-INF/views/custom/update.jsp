<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
 <script type="text/javascript" src="/bachida/js/materialize.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link type="text/css" rel="stylesheet" href="/bachida/css/materialize.min.css"  media="screen,projection"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		$("#search").hide();
		var $map = ${map};
		var $custom = $map.custom;
		$("#custom_title").val($custom.title);
		$("#custom_closing_date").val($custom.closingDate);
		$("#custom_wish_price").val($custom.wishPrice);
		$("#custom_id").val($custom.id);
		var textareaVal = $custom.content;
		result = textareaVal.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
		
		$("#custom_content").val(result);
		$("#custom_quantity").val($custom.quantity);
		
		$("<input>").attr("type","hidden").attr("name","customIdx").val($custom.customIdx).appendTo("form");
		
		$("a").on("click",function(){
			if(confirm("취소하시겠습니까?")){
				location.href="/bachida/custom/view?customIdx="+$custom.customIdx + "&writer=" + $custom.id;
			};
		})
		
		$("#update_btn").on("click",function(){
			 var textareaVal = $("textarea").val();
			 result = textareaVal.replace(/(\n|\r\n)/g, '<br>');
			$("#custom_content").val(result);
			console.log($("#custom_content").val());
			$("form").submit();
		});
		
	});

</script>
<style>
	.container{
width: 1000px !important;
}
</style>
</head>
<body>
	<div class="container">
	<form action="/bachida/custom/update_custom" method="post">
		<input type="hidden" name="id" id="custom_id" >
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<table>
			<tr>                          
				<td colspan="3">
					<div class="input-field s12">
						<input id="custom_title" name="title" type="text" class="validate">
						<label for="title">제목</label>
					</div>
				</td>
			</tr>               
			<tr>
				<td>
					 <div class="input-field">
         				<input id="custom_wish_price" name="wishPrice" type="number" class="validate">
      				    <label for="wishPrice">희망가격</label>
     				</div>
				</td>
				<td>
					<div class="input-field">
						<input id="custom_quantity" name="quantity" type="number" class="validate"> 
						<label for="quantity">수량</label>
					</div>
				</td>
				<td>
					<div class="input-field">
						<label for="date" class="active">마감기한</label>
						<input id="custom_closing_date" name="closingDate" type="date">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="input-field s12">  
          				<textarea id="custom_content" name="content"  class="materialize-textarea" style="min-height: 200px"></textarea>
          				<label for="content">내용</label>
        			</div>
				</td>
			</tr>                             
			<!-- <tr>
				<td colspan="2">
					<div class="file-field input-field">
						<div class="btn">
							<span>File</span> <input type="file" name="file">
						</div>
						<div class="file-path-wrapper">
							<input class="file-path validate" type="text">
						</div>
					</div>
				</td>
			</tr> -->
			<tr>
				<td></td>  
				<td>  
					<button class="btn" style="float: right" type="button" id="update_btn">수정하기</button>               
				</td>                              
				<td>
					<a class="btn">취소</a>
				</td>
				
			</tr>
		</table>
</form>
</div>
</body>
</html>