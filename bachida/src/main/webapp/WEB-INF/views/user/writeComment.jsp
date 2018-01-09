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
		var $orderProduct = ${orderProduct};
		var $product = ${product};
		
		$("#productImg").attr("src","/bachida/user/displayFile/"+$product.productIdx).css({"width":"100%","height":"75px","max-width":"100px"});
		$("#productName").text($product.productName);
		$("#artisanId").text($product.artisanId);
		
		$("#writeCommentBtn").on("click",function(){
			var formData = new FormData($("#commentFrm")[0]);
			formData.append("productIdx",$product.productIdx);
			formData.append("orderProductIdx",$orderProduct.orderProductIdx);
			formData.append("${_csrf.parameterName}","${_csrf.token}");
			$.ajax({
				url:"/bachida/user/writeComment",
				type : "post",
				data : formData,
				processData:false,	// FormData 전송에 필요한 설정
				contentType:false,	// FormData 전송에 필요한 설정
				success: function(){
					alert("상품평작성이 완료되었습니다.");
					opener.window.location.reload(true);
					window.close();
				}
			});
		});
	});
</script>
</head>
<body>
	<h3 style="color: rgb(245, 89, 128);">상품평쓰기</h3>
	<div class="col-md-8">
	<div>
		<img id="productImg" class="pull-left">
		<h4 id="productName"></h4>
		<p id="artisanId"></p>
	</div>
	<form id="commentFrm" enctype="multipart/form-data">
	<table class="table">
		<tr><td class="active text-center">상품평</td><td><textarea class="form-control" name="content" id="content" rows="3"></textarea></td></tr>
		<tr><td class="active text-center">첨부파일</td><td><input type="file" name="file" id="file"></td></tr>
		<tr>
			<td colspan="2">
				<button type="button" class="btn btn-default pull-right" id="writeCommentBtn">상품평작성</button>
			</td>
		</tr>
	</table>
	</form>
	</div>
</body>
</html>