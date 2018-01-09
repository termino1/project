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
		var $product = ${product};
		//var $product = ${product};
		//var $list = $product.list1;
		var $list = $product.list1;
		var $pagination = $product.pagination1;
		var search = $(location).attr("search");
		console.log($product);
		//console.log($product);
		console.log($list);
		console.log($list[0]);
		
		/* var $bestProduct = $product.bestProduct;
		var $listProduct = $product.productList;
		var $activeBookmark = $product.activeBookmark;
		var $mainCategory = $product.mainCategoryIdx;
		var $metaCategory = $product.metaCategoryIdx;
		var $activeMetaCategory = $product.activeMetaCategory;
		var $pagination = $product.pagination;
		var $best = $("#best-product");
	 */
		
	 
	 
	 if($list.length==0) {	// 검색 결과 없을 경우
			$("<h4></h4>").text("검색 결과가 없습니다.").addClass("text-center").appendTo($("#productList"));
		}
	 
	 
		/* 상품목록 */
		var $productList = $("#productList");
		var $a2;
		$.each($list, function(i,$list){
			
			var	$div = $("<div></div>").addClass("col-xs-3").appendTo($productList);
			var $thumbnail = $("<div></div>").addClass("thumbnail").appendTo($div);
			var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + $list.productIdx).appendTo($thumbnail);
				$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+$list.productIdx).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
				$caption = $("<div></div>").addClass("caption").appendTo($a);
				$("<h3></h3>").text($list.productName).appendTo($caption);
				$("<p></p>").text($list.artisanName).appendTo($caption);
				$("<p></p>").text($list.productPrice+"원").addClass("price").appendTo($caption);
				$p = $("<p></p>").addClass("text-center").addClass("recommend").addClass("off").attr("id","product"+$list.productIdx).attr("data-productIdx",$list.productIdx).appendTo($thumbnail);
				$a2 = $("<a></a>").attr("data-productIdx",$list.productIdx).attr("data-id","ksm0200").appendTo($p);
				$("<span></span>").addClass("glyphicon").addClass("glyphicon-heart").appendTo($a2);
				$("<span></span>").addClass("recommendCnt").text($list.recommend).appendTo($a2);
				//console.log($list.productIdx);
				/* $.each($activeBookmark,function(i,bookmark){
						if(bookmark==list.productIdx)
							$("#product"+list.productIdx).addClass("on").removeClass("off");
				}); */ 
		})
		
		/* 상품목록 */
		/* var $productList = $("#productList");
		var $a2;
		$.each($listProduct, function(i,list){
			
			var	$div = $("<div></div>").addClass("col-xs-3").appendTo($productList);
			var $thumbnail = $("<div></div>").addClass("thumbnail").appendTo($div);
			var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + list.productIdx).appendTo($thumbnail);
				$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+list.productIdx).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
				$caption = $("<div></div>").addClass("caption").appendTo($a);
				$("<h3></h3>").text(list.productName).appendTo($caption);
				$("<p></p>").text(list.artisanId).appendTo($caption);
				$("<p></p>").text(list.productPrice+"원").addClass("price").appendTo($caption);
				$p = $("<p></p>").addClass("text-center").addClass("recommend").addClass("off").attr("id","product"+list.productIdx).attr("data-productIdx",list.productIdx).appendTo($thumbnail);
				$a2 = $("<a></a>").attr("data-productIdx",list.productIdx).attr("data-id","ksm0200").appendTo($p);
				$("<span></span>").addClass("glyphicon").addClass("glyphicon-heart").appendTo($a2);
				$("<span></span>").addClass("recommendCnt").text(list.recommend).appendTo($a2);
				$.each($activeBookmark,function(i,bookmark){
						if(bookmark==list.productIdx)
							$("#product"+list.productIdx).addClass("on").removeClass("off");
				});
		}) */
		
		/* 즐겨찾는상품 추가 */
		/* $(".off").on("click","a",function(){
			console.log($(this).parent());
			var $confirm = confirm("즐겨찾는 상품에 추가하시겠습니까?");
			 if($confirm==true){
				 var formData = new FormData();
				 formData.append("productIdx",$(this).attr('data-productIdx'));
				 formData.append("_csrf", '${_csrf.token}');
				 $.ajax({
					 url:"${pageContext.request.contextPath}/product/choose_add",
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
		 $(".on").on("click","a",function(){
			var myself = $(this);
			var $confirm = confirm("삭제하시겠습니까?");
			 if($confirm==true){
				 var formData = new FormData();
				 var id = $(this).attr('data-id');
				 formData.append("_csrf", '${_csrf.token}');
				 formData.append("productIdx",$(this).attr('data-productIdx'));
				 console.log($(this).prop('data-productIdx'))
				 $.ajax({
					 url:"${pageContext.request.contextPath}/product/deleteChooseProduct",
					 type:"post",
					 data:formData,
					 processData:false,	// FormData 전송에 필요한 설정
						contentType:false,	// FormData 전송에 필요한 설정
						success:function() {
							location.reload(true);
						}
					});
			 }
		}) */
		
		
		
		/* 페이지네이션 */
		var ul = $("#pagination");
		var li;
		var sSplit = search.split('&');
		if($list.length!=0) {
		if($pagination.prev>0) {	// 이전
			li = $("<li></li>").text('이전').appendTo(ul);
			li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom'+sSplit[0] + '&pageno=' + $pagination.prev));
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {	// 페이지 10개
			li = $("<li></li>").text(i).appendTo(ul);
				if($pagination.pageno==i){
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom1'+sSplit[0] + '&pageno=' + i).css({"background-color":"#337ab7", "border":"1px solid #337ab7", "color":"white"}));
				}else{
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom1'+sSplit[0] + '&pageno=' + i));
				}
			}
		if($pagination.next>0) {	// 다음
			li = $("<li></li>").text('다음').appendTo(ul);
			li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom1' +sSplit[0] + '&pageno=' + $pagination.next));
		}
		}
		
		
	/* 	var ul = $("#pagination");
		var li;
		// split : 문자열을 구분할 때 특정 구분자(Delimter)를 기준으로 나눠서 배열로 각각의 값을 담아 반환
		// 변수명.split('구분의 기준이 되는 문자열')
		var sSplit = search.split('&');
		//console.log(sSplit);	// ["?keyword=태양비누", "pageno=2"] ?keyword=태양비누&pageno=2
		
		if($pagination.prev>0) {	// 이전
			li = $("<li></li>").text('이전').appendTo(ul);
			if(search=="" || sSplit[0].match("pageno")) {	// 기본 : 주소에 ?뒤가 없거나 split구분 첫번째에 pageno가 있으면
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/list_pcustom?pageno=' + $pagination.prev));
			}  else if(sSplit[0].match("keyword")) {		// 검색 : 주소에 split구분 첫번째에 keyword가 있으면
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom'+sSplit[0] + '&pageno=' + $pagination.prev));
			}
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {	// 페이지 10개
			li = $("<li></li>").text(i).appendTo(ul);
			if(search=="" || sSplit[0].match("pageno")) {	// 기본 : 주소에 ?뒤가 없거나 split구분 첫번째에 pageno가 있으면
					// 그냥 목록의 페이징
				if($pagination.pageno==i) {
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/list_pcustom?pageno=' + i).css({"background-color":"#337ab7", "border":"1px solid #337ab7", "color":"white"}));
				}
				else {
					li.wrapInner($("<a></a").attr('href', '/bachida/pcustom/list_pcustom?pageno='+ i));
				}
			} else if(sSplit[0].match("keyword")) {			// 검색 : 주소에 split구분 첫번째에 keyword가 있으면
				// 검색한 목록의 페이징
				if($pagination.pageno==i){
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom'+sSplit[0] + '&pageno=' + i).css({"background-color":"#337ab7", "border":"1px solid #337ab7", "color":"white"}));
				}else{
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom'+sSplit[0] + '&pageno=' + i));
				}
			}
		}
		if($pagination.next>0) {	// 다음
			li = $("<li></li>").text('다음').appendTo(ul);
			if(search=="" || sSplit[0].match("pageno")) {	// 기본
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/list_pcustom?pageno=' + $pagination.next));
			}  else if(sSplit[0].match("keyword")) {		// 검색
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom' +sSplit[0] + '&pageno=' + $pagination.next));
			}
		} */
		
		
		
	})
	 
 
</script>
</head>
<body> 

	<div class="container">
		<!-- <ol class="breadcrumb">
			<li><a href="#"><span class="glyphicon glyphicon-home"	aria-hidden="true"></span></a></li>
			<li class="mainCategory">대분류</li>
			<li class="active activeMetaCategory">소분류</li>
		</ol> -->
		<!--//경로-->
		<!--  <div class="page-header clearfix">
			<h1 class="pull-left mainCategory">대분류</h1>
			<ul class="list-inline" id="meta_category"></ul>
			<div class="pull-right" style="margin-top:-30px">
				<form id="frm">
					<select class="form-control" id="selectbox" >
						<option value="1">최신순</option>
						<option value="2">가격낮은순</option>
						<option value="3">가격높은순</option>
						<option value="4">인기순</option>
					</select>
				</form>
			</div>
		</div>
		<h2 class="title">카테고리 인기작품</h2>
		<div class="row best-product" id="best-product"></div>
		<hr>-->
		<!-- 상품목록 -->
		<div class="row productList" id="productList"></div>
		<div class="text-center" >
			<ul class="pagination pagination-sm" id="pagination">
				
			</ul>
		</div> 
		<!--//pagination-->
	</div>
	
	</body>
	</html>