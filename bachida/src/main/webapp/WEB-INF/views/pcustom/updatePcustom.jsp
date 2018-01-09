<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청 글수정</title>
<style type="text/css">
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

/* 1:1커스텀 글수정 */

$(function() {
	var $pcustom = ${update};
	console.log($pcustom);
	
	$("#title").val($pcustom.title);
	$("#content").text($pcustom.content);
	/* var $ul = $("#attach");
	if($pcustom.savedFileName!=null)
		var $img = $("<img>").attr("src", "/bachida/pcustom/displayFileMain/" + $pcustom.savedFileName + "/" + $pcustom.pcustomIdx).appendTo($ul);
	$ul.wrapInner($img); */
	
	//console.log($("#file")==null);
	
	var $form = $("form");
	$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($pcustom.pcustomIdx).appendTo($form);
	$("<input>").attr("type", "hidden").attr("name", "id").val($pcustom.id).appendTo($form);
	
	$("#updatePcustom").on("click", function() {	// 수정버튼 클릭
		// Spring Security의 token값 설정
		$("<input>").attr("type", "hidden").attr("name", "${_csrf.parameterName}").val("${_csrf.token}").appendTo($form);
	});
});

</script>
</head>
<body>
	<div id="page">
		<hr>
		<!-- <h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2> -->
		<h3>1:1제작요청 수정</h3>
		<hr>
		<form action="/bachida/pcustom/update_pcustom" method="post" enctype="multipart/form-data">
			<table class="table table-bordered table-hover">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" class="form-control" id="title" name="title">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea class="form-control" id="content" name="content" rows="20" cols="100"></textarea>
					</td>
				</tr>
			</table>
			<!-- 글 첨부파일 업로드 -->
			<div id="fileDiv">
			<p>
				<input type="file" id="file" name="file" class="btn btn-default">
			</p>
			</div>
		
			<br>
			<button id="updatePcustom" class="glyphicon glyphicon-ok btn btn-default">수정</button>
			
			<hr>
		</form>
	</div>
		
</body>
</html>