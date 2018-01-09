<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script>
	$(function(){
		$("#actInsert").on("click",function(){
			 var textareaVal = $("textarea").val();
			 result = textareaVal.replace(/(\n|\r\n)/g, '<br>');
			$("#content").val(result);
			console.log($("#content").val());
			$("form").submit();
		 });
	});
</script>
<body>
	<div class="col-md-12">
		<form action="/bachida/artisantimeline/timeline_insert" method="post" enctype="multipart/form-data">
			<table class="table">
				
				<tbody>
				<th>타임라인 작성</th>
					<tr>
						<td class="active text-center">내용</td>
						<td><textarea class="form-control" name="content" id="content" rows="3" placeholder="내용을 입력해주십시오." style="height: 380px;"></textarea>
						</td>
					</tr>
					
					<tr>
						<td class="active text-center">첨부파일</td>
						<td><input type="file" name="pic" id="file"></td>
						<td><input type="hidden" name="_csrf" value="${_csrf.token}"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button class="btn btn-default pull-right" type="button" id="actInsert">완료</button>
						</td>
					</tr>
				</tbody>
			</table>


		</form>
	</div>
</body>
</html>