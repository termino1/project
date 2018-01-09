<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script type="text/javascript" src="/bachida/js/bootstrap.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		var $map = ${viewProduct};
		//console.log($map);
		/* var $attachList = $map.attachList;
		console.log($attachList); */
		var $main = JSON.parse($map.mainCategoryName);
		var $meta = JSON.parse($map.metaCategoryName);
		console.log($meta);
		var $optionList = $map.optionList;
		console.log($optionList);
		/* $.each($main, function(i,main){
			console.log("ddddddddddd")
		}); */
		var $product = $map.product;
		console.log($product);
		$("#productName").val($product.productName);
		$("#productPrice").val($product.productPrice);
		
		var textareaVal = $product.productInfo;
		result = textareaVal.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
		
		$("#productInfo").val(result);
		
		console.log("실행====");
		console.log($product.mainCategoryIdx);
		
		$("#main").val($product.mainCategoryIdx);
		$("#meta").val($product.metaCategoryName);
		$("#productState").val($product.productState);
		
		$.each($main, function(i, main) {
			console.log("메인카테고리 회전")
			var option = $("<option></option>").val(main.mainCategoryIdx).text(main.mainCategoryName).appendTo($("#main"));
			if($product.mainCategoryIdx==main.mainCategoryIdx){
				option.val(main.mainCategoryIdx).attr("selected","selected");
				metaCategory(main.mainCategoryIdx);
			}
		});
		
		function metaCategory(mainIdx){
			$("#meta").empty();
			$.each($meta, function(i, meta) {
				if(mainIdx==meta.mainCategoryIdx){
					var metaOption = $("<option></option>").val(meta.metaCategoryIdx).text(meta.metaCategoryName).appendTo($("#meta"));
					if($product.metaCategoryIdx==meta.metaCategoryIdx){
						metaOption.val(meta.metaCategoryIdx).attr("selected","selected");
					}
				}
			});
		}
		
		$("#main").on("change",function(){
			metaCategory(this.value);
		});
		
		$("#actUpadte").on("click",function(){
			
				 var textareaVal = $("#productInfo").val();
				 result = textareaVal.replace(/(\n|\r\n)/g, '<br>');
				$("#productInfo").val(result);
			
			
			$("<input>").attr("type","hidden").attr("name","productIdx").val($product.productIdx).appendTo("#updateFrm");
			var formData = new FormData($("#updateFrm")[0]);
			$.ajax({
				url : "/bachida/artisan/product_update",
				type : "post",
				data : formData,
				processData:false,	// FormData 전송에 필요한 설정
				contentType:false,	// FormData 전송에 필요한 설정
				success : function(result){
					if(result){
						alert("수정이 완료 되었습니다.");
						opener.parent.location.reload(true);
						window.close();
					}
				}
			})
		});
		
		$("#cancel").on("click",function(){
			if(confirm("취소하시겠습니까? 내용은 저장되지 않습니다.")){
				window.close();
			}
		});
		
	});
</script>
<style>
	select{
		display: block;
	}
</style>
</head>
<body>
	<h3 style="color: rgb(245, 89, 128);">작품수정</h3>
	<div class="col-md-12">
		<form id="updateFrm" enctype="multipart/form-data">
			<table class="table">
				<tr>
					<td class="active text-center">작품명</td>
					<td><input type="text" name="productName" id="productName"></td>
				</tr>
				<tr>
					<td class="active text-center">가격</td>
					<td><input type="text" name="productPrice" id="productPrice"></td>
				</tr>
				<tr>
					<td class="active text-center">상품상세</td>
					<td><textarea class="form-control" name="productInfo"
							id="productInfo" rows="15"></textarea></td>
				</tr>
				<tr>                             
					<td class="active text-center" >대분류</td>
					<td>
					
					<select class="select" name="mainCategoryIdx" id="main" >
					
					
					</select>
					
					</td>
				</tr>
				<tr>
					<td class="active text-center">소분류</td>
					<td>
					<select class="select" name="metaCategoryIdx" id="meta" >
					
					
					</select>
					</td>
				</tr>
				<tr>
					<td class="active text-center">상품상태</td>
					<td>
					<select class="select" name="productState" id="productState"rows="3">
					<option>판매중</option>
					<option>매진</option>
					
					</select>
					</td>
				</tr>
				<tr>                                                   
					<td colspan="2">
						<button type="button" class="btn btn-default pull-right" id="cancel" >취소</button>
						<button type="button" class="btn btn-default pull-right" id="actUpadte" style="margin-right: 10px;">수정</button>
					</td>
					<td><input type="hidden" name="_csrf" value="${_csrf.token}"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>