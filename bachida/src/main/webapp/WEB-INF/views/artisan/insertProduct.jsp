<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	textarea {
	width: 300px;
	height: 500px;
}
</style>
<script>
	//예제 appendTo
	$(function() {
		var $mainCategory = ${mainCategory};
		console.log($mainCategory);
		var $metaCategory = ${metaCategory};
		console.log($metaCategory);
		var idx = 0;
		/* 
		$.each($mainCategory, function(i, $main) {
			$("<option></option>").val($main.mainCategoryIdx).text($main.mainCategoryName).appendTo("#mainCategoryIdx");
		});
		$.each($metaCategory, function(i, $meta) {
			$("<option></option>").val($meta.metaCategoryIdx).text($meta.metaCategoryName).appendTo("#metaCategoryIdx");
		});
		 */
		$.each($mainCategory, function(i, main) {
			var option = $("<option></option>").val(main.mainCategoryIdx).text(main.mainCategoryName).appendTo($("#mainCategoryIdx"));
				metaCategory(main.mainCategoryIdx);
		});
		function metaCategory(mainIdx){
			$("#metaCategoryIdx").empty();
			$.each($metaCategory, function(i, meta) {
				if(mainIdx==meta.mainCategoryIdx){
					var metaOption = $("<option></option>").val(meta.metaCategoryIdx).text(meta.metaCategoryName).appendTo($("#metaCategoryIdx"));
				}
			});
		}
		
		$("#mainCategoryIdx").on("change",function(){
			metaCategory(this.value);
		});
		
		
		

		$("#btn").on(
				"click",
				function() {
					var trName = $("<tr></tr>").appendTo("#frm table");
					$("<td class='active text-center'></td>").text("옵션" + (idx+1)).appendTo(trName);
					var tdName = $("<td></td>").appendTo(trName);
					$("<input>").attr("name",
							"options[" + idx + "].optionContent").attr("type",
							"text").appendTo(tdName);
					//$("<br>").appendTo("#frm");
					
					var trCost = $("<tr></tr>").appendTo("#frm table");
					$("<td class='active text-center'></td>").text("추가금액").appendTo(trCost);
					var tdCost = $("<td></td>").appendTo(trCost);
					$("<input class='number'>").attr("name", "options[" + idx + "].cost")
					.attr("type", "text").appendTo(tdCost);
					//$("<br>").appendTo("#frm");
						idx++;
				});

		/* $("#submit").on("click", function() {
			$("#frm").submit();
		}); */
		
		
		// textarea 엔터 <br>로 바꾸기..!
	    $("#submit").on("click",function(){
	    	
		    	var textareaVal = $("#productInfo").val();
				 intro_result = textareaVal.replace(/(\n|\r\n)/g, '<br>');
				$("#productInfo").val(intro_result);
				$("#frm").submit();
	    	
		 });
		
		
		
		
		
		
		$("#cancel").on("click",function(){
			if(confirm("취소하시겠습니까? 내용은 저장되지 않습니다.")){
				location.href="/bachida/artisan/product_list";
			}
		});
	});
</script>
</head>
<body>
	<!-- <form action="/product/artisan/product_insert" method="post" id="frm">
		<br> 상품명<input type="text" id="productName" name="productName"><br>
		가격<input type="text" id="productPrice" name="productPrice"><br>
		상품상세<input type="text" id="productInfo" name="productInfo"><br>
		소분류<input type="text" id="metaCategoryIdx" name="metaCategoryIdx">
		대분류<input type="text" id="mainCategoryIdx" name="mainCategoryIdx">
		상품상태<input type="text" id="productState" name="productState"><br>

		option_content<input type="text" id="optionContent" name="options[0].optionContent">
		option_cost<input type="text" id="csot" name="options[0].cost">
		option_content<input type="text" id="optionContent" name="options[1].optionContent">
		option_cost<input type="text" id="csot" name="options[1].cost">
	</form> -->

	<div class=container>         
	<h2 style="text-align: center;color: rgb(245, 89, 128);">작품등록</h2>
	<h4>판매할 작품을 등록해주세요.</h4>
		<div class="row">
			<div>
				<form action="/bachida/artisan/product_insert1" method="post" id="frm" enctype="multipart/form-data">
					<table class="table">
						<tr>
							<td class="active text-center">작품명</td>
							<td><input type="text" id="productName" name="productName" class="form-control"></td>
						</tr>
						<tr>
							<td class="active text-center">가격</td>
							<td><input type="text" id="productPrice" name="productPrice" class="number"></td>
						</tr>
						<tr>
							<td class="active text-center">작품상세소개</td>
							<td><textarea class="form-control" id="productInfo" name="productInfo" rows="12"  style="resize: none;"></textarea></td>
						</tr>                  
						<tr>
							<td class="active text-center">대분류</td>
							<td><select id="mainCategoryIdx" name="mainCategoryIdx"></select></td>
						</tr>
						<tr>
							<td class="active text-center">소분류</td>
							<td><select id="metaCategoryIdx" name="metaCategoryIdx"></select></td>
						</tr>
						<tr>
							<td class="active text-center">첨부파일</td>                            
							<td><input type="file" name="files" multiple="multiple"></td>
						</tr>
					</table>
					              
					<input type="hidden" name="_csrf" value="${_csrf.token}">
				</form>
			</div>     
		</div>                                
	</div>                          
	<button id="btn" type="button" class="btn btn-default">옵션추가</button>
	<button id="cancel" type="button" class="btn btn-primary pull-right">취소</button>&nbsp;&nbsp;
	<button id="submit" type="button" class="btn btn-success pull-right" style="margin-right : 10px">등록하기</button>
	
</body>
</html>