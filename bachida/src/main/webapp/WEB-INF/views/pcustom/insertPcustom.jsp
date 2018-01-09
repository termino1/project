<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청 글쓰기</title>
<style>
	textarea {
		resize: none;
	}
	th {
		width: 100px;
	}
	th, h3 {
		color: rgb(245, 89, 128);
	}
	#pcustom {
		text-decoration: none;
		color: rgb(245, 89, 128);
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	var map = ${sessionScope.map};	// 작가정보
	//console.log(map);
	//console.log(map.artisan.artisanId);	// 작가아이디
	
	// 세션에 저장된 작가아이디 게또
	$("<input>").attr("name","artisanId").attr("type","hidden").val(map.artisan.artisanId).appendTo($("#frm"));
	
	// 글쓰기 취소 버튼
	$("#cencel").on("click", function() {
		// 해당작가홈으로
		location.href="/bachida/artisantimeline/timeline_list/?artisanId=" + map.artisan.artisanId;
	});
});
</script>
</head>
<body>

<!-- 1:1커스텀 글쓰기 -->
	<div class="col-md-12">
		<form action="/bachida/pcustom/insert_pcustom" method="post" id="frm" name="frm" enctype="multipart/form-data">
			<hr>
			<!-- <h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2> -->
			<h3>1:1제작요청 글쓰기</h3>
			<h5>요청내용을 입력해 주세요.</h5>
			<table class="table table-bordered table-hover">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="title" name="title" class="form-control">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="content" name="content" class="form-control" rows="20" cols="100"></textarea>
					</td>
				</tr>
			</table>
		
		<div id="fileDiv">
			<p>
				<input type="file" id="file" name="file" class="btn btn-default">
			</p>
		</div>
		
		<br>
		<!-- Spring Security의 token값 설정 -->
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<button class="glyphicon glyphicon-ok btn btn-default">등록</button>
		<hr>
		
		</form>
	
	<button id="cencel" class="glyphicon glyphicon-chevron-left btn btn-default">취소</button>
	<hr>
	</div>	
</body>
</html>