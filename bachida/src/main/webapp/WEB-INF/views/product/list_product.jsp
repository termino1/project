<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css?v=3">
<style>
h1.mainCategory {padding-right:10px}
#meta_category {margin:5px;}
</style>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
$(function() {
		var userInfo = ${sessionScope.user}
		var $product = ${product};
		var $bestProduct = $product.bestProduct;
		var $listProduct = $product.productList;
		var $activeBookmark = $product.activeBookmark;
		var $mainCategory = $product.mainCategoryIdx;
		var $metaCategory = $product.metaCategoryIdx;
		var $activeMetaCategory = $product.activeMetaCategory;
		var $pagination = $product.pagination;
		var $best = $("#best-product");
		console.log($product);
		console.log($activeBookmark);
		/* 페이지네이션 */
		var ul = $("#pagination");
		var li;
		var $url;
		if($product.selectOption==1){
			if($pagination.prev>0) {
				li = $("<li></li>").text('이전으로').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx + '/?pageno='+ $pagination.prev))
			}
			for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
				li = $("<li></li>").text(i).appendTo(ul);
				if($pagination.pageno==i) 
					li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx + '/?pageno='+ i)).addClass("active")
				else
					li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx + '/?pageno='+ i))
			}
			if($pagination.next>0) {
				li = $("<li></li>").text('다음으로').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx + '/?pageno='+ $pagination.next));
			}	
		}
		
		else if($product.selectOption!=1){
			if($pagination.prev>0) {
				li = $("<li></li>").text('이전으로').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx +'/'+$product.selectOption+'/?pageno='+ $pagination.prev))
			}
			for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
				li = $("<li></li>").text(i).appendTo(ul);
				if($pagination.pageno==i) 
					li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx +'/'+$product.selectOption+ '/?pageno='+ i)).addClass("active")
				else
					li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx +'/'+$product.selectOption+ '/?pageno='+ i))
			}
			if($pagination.next>0) {
				li = $("<li></li>").text('다음으로').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '${pageContext.request.contextPath}/product/'+$mainCategory.mainCategoryIdx+'/' + $activeMetaCategory.metaCategoryIdx +'/'+$product.selectOption+ '/?pageno='+ $pagination.next));
			}	
		}
		
	
		/* 카테고리 */
		$(".mainCategory").text($mainCategory.mainCategoryName);
		$(".activeMetaCategory").text($activeMetaCategory.metaCategoryName);
		var $meta_category = $("#meta_category");
		$.each($metaCategory,function(i,meta){
			var $li = $("<li></li>").appendTo($meta_category);
			$("<a></a>").attr("href","${pageContext.request.contextPath}/product/"+$mainCategory.mainCategoryIdx+"/"+meta.metaCategoryIdx).text(meta.metaCategoryName).appendTo($li);
		})
		
		/* 베스트상품 */
		$.each($bestProduct,function(i,product){
			var	$div =  $("<div></div>").addClass("col-xs-3").appendTo($best);	
			var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + product.productIdx).addClass("thumbnail").appendTo($div);	
			$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+product.productIdx).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
		
		})
		
		/* 상품목록 */
		var $productList = $("#productList");
		var $a2;
		$.each($listProduct, function(i,list){
			
			var	$div = $("<div></div>").addClass("col-xs-3").appendTo($productList);
			var $thumbnail = $("<div></div>").addClass("thumbnail").appendTo($div);
			var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + list.productIdx).appendTo($thumbnail);
				$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+list.productIdx).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
				$caption = $("<div></div>").addClass("caption").appendTo($a);
				$("<h3></h3>").text(list.productName).appendTo($caption);
				$("<p></p>").text(list.artisanName).appendTo($caption);
				$("<p></p>").text(list.productPrice+"원").addClass("price").appendTo($caption);
				$p = $("<p></p>").addClass("text-center").addClass("recommend").addClass("off").attr("id","product"+list.productIdx).attr("data-productIdx",list.productIdx).appendTo($thumbnail);
				$a2 = $("<a></a>").attr("data-productIdx",list.productIdx).appendTo($p);
				$("<span></span>").addClass("glyphicon").addClass("glyphicon-heart").appendTo($a2);
				$("<span></span>").addClass("recommendCnt").text(list.recommend).appendTo($a2);
				$.each($activeBookmark,function(i,bookmark){
						if(bookmark==list.productIdx)
							$("#product"+list.productIdx).addClass("on").removeClass("off");
				});
					
				
		})
		/* 즐겨찾는상품 추가 */
		$(".off").on("click","a",function(){
			console.log($(this).parent());
			if(userInfo=='guest'){
				alert("로그인해주세요!");
			}else{
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
		})
		/* 정렬 */
		$("#selectbox").val($product.selectOption).attr("selected","selected");
		$("#selectbox").on("change",function(){
			var $num = $(this).val();
			if($num==1){
				location.href = "${pageContext.request.contextPath}/product/"+$mainCategory.mainCategoryIdx+"/"+$metaCategory[0].metaCategoryIdx;
			}
			else
				location.href ="${pageContext.request.contextPath}/product/"+$mainCategory.mainCategoryIdx+"/"+$metaCategory[0].metaCategoryIdx+"/"+ $num;
			})
		
	})
	 
 
</script>
</head>
<body> 

	<div class="container">
		<ol class="breadcrumb">
			<li><a href="#"><span class="glyphicon glyphicon-home"	aria-hidden="true"></span></a></li>
			<li class="mainCategory">대분류</li>
			<li class="active activeMetaCategory">소분류</li>
		</ol>
		<!--//경로-->
		<div class="page-header clearfix">
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
		<hr>
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