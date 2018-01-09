<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
//예제 appendTo
	$(function(){
		var idx = 0;
		$("#btn").on("click", function(){
			$("<span></span>").text("옵션명 : ").appendTo("#frm");
			$("<input>").attr("name","options["+idx+"].optionContent").attr("type","text").appendTo("#frm");
			$("<br>").appendTo("#frm");
			$("<span></span>").text("비용 : ").appendTo("#frm");
			$("<input>").attr("name","options["+idx+"].cost").attr("type","text").appendTo("#frm");
			$("<br>").appendTo("#frm");
			idx++;
		});
		
		$("#submit").on("click",function(){
			$("#frm").submit();
		});
	});
</script>
</head>
<body>
<form action="/product/product/insert_board" method="post" id="frm">
		상품번호<input type="text" id="productIdx"  name="productIdx">
		상품명<input type="text" id="productName" name="productName">
		가격<input type="text" id="productPrice" name="productPrice">
		상품상세<input type="text" id="productInfo" name="productInfo">
		작가<input type="text" id="artisanId"  name="artisanId">
		소분류<input type="text" id="metaCategoryIdx" name="metaCategoryIdx">
		대분류<input type="text" id="mainCategoryIdx"  name="mainCategoryIdx">
		상품상태<input type="text" id="productState"  name="productState"><br>
		
		<!-- option_content<input type="text" id="optionContent" name="options[0].optionContent">
		option_cost<input type="text" id="csot" name="options[0].cost">
		option_content<input type="text" id="optionContent" name="options[1].optionContent">
		option_cost<input type="text" id="csot" name="options[1].cost"> -->
	</form>
		<button id="btn" type="button">check</button>
		<button id="submit" type="button">넘기</button>
</body>
</html>