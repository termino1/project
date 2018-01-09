<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css?v=3">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		var $chooseProduct = ${chooseProduct};
		var $chooseList=$chooseProduct.product;
		var $bookmark=$chooseProduct.bookmark;
		console.log($bookmark)
			var $appendDiv = $("#list");
		if($bookmark.length==0){
			$("<p></p>").text("해당 내역이 없습니다.").css({"font-weight": "bold"}).appendTo($appendDiv);
		}
		console.log($chooseList);
		$.each($chooseList,function(i,choose){
			console.log(choose);
			 $col = $("<div></div>").addClass("col-xs-3").appendTo($appendDiv);
			$thumb = $("<div></div>").addClass("thumbnail").appendTo($col);
			$a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/"+ choose.productIdx).appendTo($thumb);
			$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+choose.productIdx).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
			$caption = $("<div></div>").addClass("caption").appendTo($a);
			$("<h3></h3>").text(choose.productName).appendTo($caption);
			$("<p></p>").text(choose.artisanId).appendTo($caption); 
			$("<p></p>").addClass("price").text(choose.productPrice+"원").appendTo($caption); 
			$recommend = $("<p></p>").addClass("text-center").addClass("recommend").addClass("on").addClass("active").appendTo($thumb);
			$link = $("<a></a>").attr("data-bookmarkId",choose.productIdx).appendTo($recommend);
			$("<span></span>").addClass("glyphicon").addClass("glyphicon-heart").appendTo($link);
		})
		
		 $(".recommend.on").on("click","a",function(){
			var $confirm = confirm("삭제하시겠습니까?");
			 if($confirm==true){
				 var formData = new FormData();
				 formData.append("productIdx",$(this).attr('data-bookmarkId'));
				 formData.append("_csrf", '${_csrf.token}');
				 $.ajax({
					 url:"${pageContext.request.contextPath}/product/deleteChooseProduct/",
					 type:"post",
					 data:formData,
					 processData:false,	// FormData 전송에 필요한 설정
						contentType:false,	// FormData 전송에 필요한 설정
						success:function() {
							location.reload(true);
						}
					});
			 }
			 		
		})
	})
</script>
</head>
<body>
	
		<!-- <ol class="breadcrumb">
			<li><a href="#"><span class="glyphicon glyphicon-home"	aria-hidden="true"></span></a></li>
			<li><a href="#">마이페이지</a></li>
			<li class="active">즐겨찾는 작품</li>
		</ol> -->
		<!--//경로-->                 
		<div class="page-header clearfix">
			<h3 style="color: rgb(245, 89, 128);">찜한작품</h3>
		</div>
		<!-- 즐겨찾는 작품목록 -->
		<div class="row productList choose" id="list"></div>
	
</body>
	</html>