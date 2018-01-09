<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<meta charset="utf-8">
<title>Untitled Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css?v=3">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		var $view = ${productView};
		var $principal = ${principal};
		console.log($view);
		console.log($principal);
		var $product = $view.getProduct;
		var $productOption = $view.getOption;
		var $Attach = $view.getAttachs;
		var $artisan = $view.getArtisan;
		console.log($artisan);
		var $productComment = $view.productComment;
		var $productMore=$view.productMore;
		
		var isFollow = $view.isFollow;
		console.log("즐겨찾기 여부");
		if(isFollow!=null){
			$("#artisanBookmark").css("background-color","lightcoral").attr("id","deleteBookmark").attr("data-bookmarkIdx",isFollow.artisanBookmarkIdx).attr("data-artisanId",$artisan.artisanId);
		}else
			$("#artisanBookmark").attr("data-artisanId",$artisan.artisanId);
		
		/* 상품사진 */
		var $product_carousel = $("#product-carousel>ol.carousel-indicators");
		var $carousel_inner = $("#product-carousel>.carousel-inner");
		$.each($Attach, function(i, attach){
			var $li = $("<li></li>").attr("data-target","#product-carousel").attr("data-slide-to",i).appendTo($product_carousel);
			$("<img>").addClass("media-object").attr("src","/bachida/user/displayFile?savedFileName="+attach.savedFileName+"&originalFileName="+attach.originalFileName).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($li);
			var $div = $("<div></div>").addClass("item").appendTo($carousel_inner);
			$("<img>").addClass("media-object").attr("src","/bachida/user/displayFile?savedFileName="+attach.savedFileName+"&originalFileName="+attach.originalFileName).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($div);
		})
		$('.carousel-inner').children().first('.item').addClass('active');
		
			//var $li = $("<li></li>").attr("data-target","#product-carousel").attr("data-slide-to",i).appendTo($product_carousel);
			//$("<img>").addClass("media-object").attr("src","${pageContext.request.contextPath}/images/no-image.jpeg").appendTo($li);
		
		/* 옵션 */
		var $select = $("#productOption");
		$.each($productOption,function(i,option){
			$("<option></option>").text(option.optionContent + ":" + option.cost +" 원").attr("data-name",option.optionContent).attr("value",[i]).attr("data-price",option.cost).attr("data-select",false).appendTo($select);
		})
		
		var optionIdx= 0;
		if($productOption.length==0){
			$("#optionDl").hide();
			var $div = $("<div></div>").appendTo("#option_append");
			var $ea2 = Number();
			$("<span></span>").text("수량").addClass("width30").attr('data-price', $("option:selected").data('price')).appendTo($div);
			$("<button></button>").addClass("btn-minus").attr("type","button").text("-").appendTo($div);
			$("<input>").addClass("price").addClass("text-center").val(1).attr('data-price', $("option:selected").data('price')).attr("readonly","readonly").attr("size","3").attr("data-name","ea").appendTo($div)
			$("<button></button>").addClass("btn-plus").attr("type","button").text("+").appendTo($div);
			result2();
		}
		$("#productOption").on("change",function(){
			if($("option:selected").attr("data-select")=="true") {
				alert("이미 선택한 옵션입니다");
				return false;
			}
			var $select_option = $("#productOption option:selected").text();
			var $data_option = $("#productOption option:selected").attr("value");
			var $optionContent = $("#productOption option:selected").attr("data-name");
			if($data_option!=null){
				var $div = $("<div></div>").attr("data-value",$data_option).appendTo("#option_append");
				$("<span></span>").text($("option:selected").text()).addClass("width30").attr('data-price', $("option:selected").data('price')).appendTo($div);
				$("<button></button>").addClass("btn-minus").attr("type","button").text("-").appendTo($div);
				$("<input>").addClass("price").addClass("text-center").val(1).attr("name","cartOptions["+optionIdx+"].optionQuantity").attr('data-price', $("option:selected").data('price')).attr("readonly","readonly").attr("size","3").attr("data-name","ea").appendTo($div)
				$("<button></button>").addClass("btn-plus").attr("type","button").text("+").appendTo($div);
				$("<span></span>").addClass("span").text((Number($("option:selected").data('price')) + Number($product.productPrice)) +"원").appendTo($div);
				$("<button></button>").addClass("btn-delete").text("X").attr("value",$data_option).appendTo($div);
				$("option:selected").attr("data-select", true);
				$("<input>").attr("type","hidden").attr("name","cartOptions["+optionIdx+"].optionContent").attr("value",$optionContent).appendTo($div);
				$("<input>").attr("type","hidden").attr("name","cartOptions["+optionIdx+"].cost").attr("value",$("option:selected").data('price')).appendTo($div);
				optionIdx++;
				result();
			
			}
		})
			$(".product_name").text($product.productName);
			$(".product_price").text($product.productPrice + " 원");
			$("#product_info").html($product.productInfo).css("text-align","center");
			$(".artisan_name").text($artisan.artisanName);
			$("#artisanPolicy").html($artisan.artisanPolicy).css("text-align","center");
			$(".artisan_Intro").html($artisan.artisanIntro);
			$("#btn-cart").attr("data-productIdx",$product.productIdx);
			console.log($product.artisanId);
			$(".artisanHome_btn").attr("data-id", $product.artisanId);
			$("#drop").attr("data-id",$product.artisanId);
			console.log($artisan);
			$("#artisanPhoto").attr("src","/bachida/user/displayFile?savedFileName="+$artisan.savedFileName+"&originalFileName="+$artisan.originalFileName);
			
			/* 옵션삭제 */
			$("#option_append").on("click",".btn-delete",function(){
				var $n = $(this).val();
				$('div[data-value='+$n+']').remove();
				$("#productOption option").val($n).attr("data-select","false");
				result();
			})
			/* 옵션 개수 차감 */
			$("#option_append").on("click",".btn-minus",function(){
				var price3 = $(this).next().attr('data-price');
				var cnt3 = Number($(this).next().val());
				cnt3--;
				if(cnt3<1){
					alert("한 개 이상 선택하세요");
					return false;
				}
				$(this).next().val(cnt3);
				if($productOption.length!=0){
					$(this).next().next().next().text((Number($product.productPrice) + Number(price3))*cnt3 +"원");
					result();
				}
				else
					result2();
			})
			/* 옵션 개수 증가 */
			$("#option_append").on("click",".btn-plus",function(){
				var price2 = $(this).prev().attr('data-price');
				var cnt2 = Number($(this).prev().val());
				cnt2++;
				$(this).prev().val(cnt2);
				$(this).next().text((Number($product.productPrice) + Number(price2))*cnt2 +"원");
				if($productOption.length!=0)
					result();
				else
					result2();
			})
		
		function result() {
			var result = 0;
			$list = $(".price");
			$list.each(function(idx) {
				var price = $(this).attr('data-price');
				var cnt = Number($(this).val());
				result = result + ((Number($product.productPrice) + Number(price))*cnt);
			})
			$("#result").text(result+" 원").attr("data-total",result);
		}
		function result2() {
			var $val1 = Number($product.productPrice);
			var $val2 = Number($(".price").val());
			$("#result").attr("data-total",($val1 * $val2)).text(($val1 * $val2) +" 원");
		}
		
		/* 즐겨찾는상품 카운트 */
		$("#recommendCnt").text($product.recommend);
		if($view.activeBookmarkOne==0)
			$("#btnFavorite").parent().addClass("off").removeClass("on");
		else
			$("#btnFavorite").parent().addClass("on").removeClass("off");
		
		/* 즐겨찾는상품 추가 */
		
		$(".off").on("click","button",function(){
			if($principal=="guest"){
				var result = confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")
				if(result==true)	
					return location.href='${pageContext.request.contextPath}/user/login';
			}else{
			var $confirm = confirm("즐겨찾는 상품에 추가하시겠습니까?");
			 if($confirm==true){
				 var formData = new FormData();
				 formData.append("productIdx",$product.productIdx);
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
		/* 즐겨찾는상품 삭제 */
		 $(".on").on("click","button",function(){
			var myself = $(this);
			var $confirm = confirm("삭제하시겠습니까?");
			 if($confirm==true){
				 var formData = new FormData();
				 formData.append("productIdx",$product.productIdx);
				 formData.append("_csrf", '${_csrf.token}');
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
		/* 구매후기 */
		var $Comment = $("#productComment>.row");
		$.each($productComment, function(i,comment){
			console.log(comment)
			var $div = $("<div></div>").addClass("col-xs-3").appendTo($Comment);
			var $thumbnail = $("<div></div>").addClass("thumbnail").addClass("review").attr("data-toggle","modal").attr("data-target","#commentModal" + i).appendTo($div);
			$("<img>").attr("src","/bachida/user/displayFile?savedFileName="+comment.savedFileName+"&originalFileName="+comment.originalFileName).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($thumbnail);
			var	$caption = $("<div></div>").addClass("caption").appendTo($thumbnail);
			var $h3 = $("<h3></h3>").text(comment.id).appendTo($caption);
			$("<span></span>").addClass("pull-right").text(comment.writeDate).appendTo($h3);
			$("<p></p>").text(comment.content).appendTo($caption);
			
		/* 구매후기-모달 */
		var $modal = $("<div></div>").addClass("modal").addClass("fade").addClass("reviewModal").attr("tabindex","1").attr("role","dialog").attr("area-hidden","true").attr("id","commentModal" + i).appendTo($Comment);
		var $modal_dialog = $("<div></div>").addClass("modal-dialog").addClass("modal-lg").appendTo($modal);
		var $modal_content = $("<div></div>").addClass("modal-content").appendTo($modal_dialog);
		var $row = $("<div></div>").addClass("row").appendTo($modal_content);
		var $left = $("<div></div>").addClass("col-xs-6").addClass("left").appendTo($row);
			$("<img>").attr("src","/bachida/user/displayFile?savedFileName="+comment.savedFileName+"&originalFileName="+comment.originalFileName).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($left);
		var $right = $("<div></div>").addClass("col-xs-6").addClass("right").appendTo($row);
		var $button = $("<button></button>").addClass("close").attr("type","button").attr("data-dismiss","modal").attr("title","닫기").appendTo($right);
			$("<span></span>").text('Ⅹ').attr("aria-hidden","true").appendTo($button);
		var $ul = $("<ul></ul>").appendTo($right);
			$("<li></li>").text("작성자 : " + comment.id).appendTo($ul);
			$("<li></li>").text("작성일 : " + "2017-11-11").appendTo($ul);
			$("<li></li>").text(comment.content).appendTo($ul);
			
		})
		
		/* 상품더보기 */
		$.each($productMore,function(i,more){
			var $li = $("<li></li>").appendTo($(".product-more"));
			var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/"+ more.productIdx).appendTo($li);
			$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+more.productIdx).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
			$("<p></p>").text(more.productName).appendTo($a);
		})
		/* 장바구니담기 */
		$("#btn-cart").on("click",function(){
			if($principal=="guest"){
				var result = confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")
				if(result==true)	
					return location.href='${pageContext.request.contextPath}/user/login';
			}else{
			if($productOption.length!=0 && $("#option_append").text()==""){
				alert("옵션 선택 해주세요!");
			}else{
			 var $confirm = confirm("장바구니에 추가하시겠습니까?");
			 if($confirm==true){
				 var $Quantity =$("#option_append");
				 var $len = $Quantity.children($(":input[data-name='ea']")).size();
				 var $sum = 0;
				  for(i=0;i<$len;i++){
					 $sum += Number($("input[data-name=ea]").eq(i).val());
				 } 
				  
				  var totalPrice = $("#result").attr("data-total");
					$("<input>").attr("type","hidden").attr("name","productIdx").attr("value",$product.productIdx).appendTo("#frm");
					$("<input>").attr("type","hidden").attr("name","quantity").attr("value",$sum).appendTo("#frm");
					$("<input>").attr("type","hidden").attr("name","price").attr("value",totalPrice).appendTo("#frm");
					$("<input>").attr("type","hidden").attr("name","${_csrf.parameterName}").attr("value","${_csrf.token}").appendTo("#frm");
					/* $("#frm").attr("action","${pageContext.request.contextPath}/product/put_cart").attr("method","post");
					$("#frm").serializeArray();
					$("#frm").submit(); */
					
					$.ajax({
						url:"${pageContext.request.contextPath}/product/put_cart",
						type:"post",
						data:$("#frm").serializeArray() ,
						success:function(result){
							if(result==1){
								if(confirm("장바구니로 이동하시겠습니까?")){
									location.href="/bachida/product/view_cart";
								}
							}
						}
					});
					
				 } 			
			}
			}
		})
		/* 바로주문-주문하기 */
		$("#orderProduct").on("click",function(){
			if($principal=="guest"){
				var result = confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")
				if(result==true)	
					return location.href='${pageContext.request.contextPath}/user/login';
			}else{
				if($productOption.length!=0 && $("#option_append").text()==""){
					alert("옵션 선택 해주세요!");
				}else{
					var $confirm = confirm("주문 페이지로 이동 하시겠습니까?");
					 if($confirm==true){
						 var $Quantity =$("#option_append");
						 var $len = $Quantity.children($(":input[data-name='ea']")).size();
						 var $sum = 0;
						 for(i=0;i<$len;i++){
							 $sum += Number($("input[data-name=ea]").eq(i).val());
							 } 
					
						  var totalPrice = $("#result").attr("data-total");
							$("<input>").attr("type","hidden").attr("name","productIdx").attr("value",$product.productIdx).appendTo("#frm");
							$("<input>").attr("type","hidden").attr("name","quantity").attr("value",$sum).appendTo("#frm");
							$("<input>").attr("type","hidden").attr("name","price").attr("value",totalPrice).appendTo("#frm");
							$("#frm").attr("action","${pageContext.request.contextPath}/product/orderProductMove").attr("method","get");
							$("#frm").serializeArray();
							console.log($("#frm").serializeArray());
							$("#frm").submit();
					 } 
				}
			}
			
		})
		
		
		// 작가홈
		$(".artisanHome_btn").on("click",function(e){
			e.preventDefault();
			window.open("/bachida/artisantimeline/timeline_list?artisanId="+$(this).attr("data-id"));
		});
		// 작가 즐겨찾기
		$("#artisanBookmark").on("click",function(e){
			if($principal=="guest"){
				var result = confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")
				if(result==true)	
					return location.href='${pageContext.request.contextPath}/user/login';
			}else{
			if(confirm("Follow 하시겠습니까?")){
				var artisanId = $(this).attr('data-artisanId');
				$.ajax({
					url : "${pageContext.request.contextPath}/artisantimeline/add_artisan/?artisanId="+artisanId,
					type:"post",
					data : "${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(result) {
						if(result!=0){
							$("#artisanBookmark").attr("id","deleteBookmart").attr("data-bookmartIdx",result);
						}
						location.reload(true);
					}
				});
			};
			}
		})
		
		//작가 즐겨찾기 해제
		 $("#deleteBookmark").on("click",function(){
			 if(confirm("follow 해제 하시겠습니까?")){
				 var artisanBookmarkIdx = $(this).attr("data-bookmarkIdx");
				 $.ajax({
					url:"/bachida/bookmarkArtisan/delete_bookmark",
					type:"post",
					data : "artisanBookmarkIdx="+artisanBookmarkIdx+"&${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(result){
						if(result==1)
							$("#deleteBookmark").attr("id","addBookmart").removeAttr("data-bookmarkIdx");
						location.reload(true);
					}
				 });
			 }
		 });
		
		
		// 쪽지 드롭다운
		$(".msgdropdown").on("click",".msgDrop",function(){
			var receiver = $("#drop").attr("data-id");
			//var receiver = $("td").find("a.active").attr("data-id");
			window.open("/bachida/user/msgWriteForm?receiver="+receiver,"쪽지함","width=850,height=500");			
			//window.open("/bachida/user/msgWriteForm?receiver="+receiver);
		});
		
		// 신고 드롭다운
		$(".msgdropdown").on("click",".reportDrop",function(){
			var reportId = $("#drop").attr("data-id");
			//var receiver = $("td").find("a.active").attr("data-id");
			window.open("/bachida/user/writeReport/"+reportId,"회원신고","width=850,height=500");			
			//window.open("/bachida/user/msgWriteForm?receiver="+receiver);
		});
		
	})
</script>
<style>
	.msgdropdown{
		padding: 0;
		margin: 0;
		min-width: 36px;
		text-align: center;
		left: auto;
    	right: -37px;
    top: 10px;
	}
	.msgdropdown li a{
		padding: 0;
	}
</style>
</head>
<body>

<div class="container">                                           
	<div class="row">    
		<div class="col-xs-5">                                      
			<div class="media profile">
				<div class="media-left media-middle">
					<a href="#"> <img class="media-object"	id="artisanPhoto" alt="작가로고" ></a>
				</div>
				<div class="media-body">
					<div class="pull-right">
						<a href="#" class="btn btn-xs btn-default radius50" id="artisanBookmark">작가찜</a> 
						<a href="#" class="btn btn-xs btn-default radius50 artisanHome_btn">작가홈</a>
					</div>
					<div class="dropdown" style="display: inline-block;">
						<div style="display: inline-block; position: relative;">
						<a id="drop" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">
							<h4 class="media-heading artisan_name" >작가명</h4>
						</a>
						<ul class="dropdown-menu msgdropdown" role="menu" aria-labelledby="drop">
							<li><a href="#" class='msgDrop'>쪽지</a></li>
							<li><a href="#" class='reportDrop'>신고</a></li>
						</ul>
						</div>
					</div>
					<p class="artisan_Intro">작가소개 출력 부분입니다.</p>
				</div>
			</div>
			 <div id="product-carousel" class="carousel slide">
				<div class="carousel-inner" role="listbox"></div>
				<ol class="carousel-indicators"></ol>
			</div> 
		</div>                                           
		<div class="col-xs-7">
			<div class="page-header clearfix product-title">
				<h1 class="product_name">레이어드 실버 이어링</h1>
			</div>
			<div class="product-info">
				<dl class="dl-horizontal">
					<dt>판매가</dt>
					<dd class="product_price">4,500원</dd>
				</dl>
				<dl class="dl-horizontal" id="optionDl">
					<dt>옵션</dt>
					<dd class="form-inline">
						<select name="productOption" id="productOption" class="form-control">
						<option>----옵션선택----</option>
						</select>
					</dd>
				</dl>                                 
			<form id="frm">
				<div class="product-option-area">
					<div id="option_append"></div>
				</div>
			</form>
			<div class="total-price clearfix">
				<div class="pull-left">총작품금액</div>
				<div class="pull-right" id="result">0 원</div>
			</div>
			<ul class="product-view-btns">
				<li><button type="button" class="btn01 btn" id="orderProduct">주문하기</button></li>
				<li><button type="button" class="btn02 btn" id="btn-cart">장바구니</button></li>
				<li><button type="button" class="btn03 btn" id="btnFavorite">찜하기  
				<span class="glyphicon glyphicon-heart-empty"  aria-hidden="true"></span> <span id="recommendCnt"></span></button></li>
			</ul>
		</div>
	</div>
</div>
<hr />
	<ul class="detail-nav">
		<li id="detail-info" class="active"><a href="#detail-info">작품상세정보</a></li>
		<li><a href="#product-review">구매후기</a></li>
		<li><a href="#delivery">배송정책</a></li>
		<li><a href="#product-more">작품더보기</a></li>
	</ul>
	<div class="detail-content" id="product_info"></div>
		<ul class="detail-nav">
			<li><a href="#detail-info">작품상세정보</a></li>
			<li id="product-review" class="active"><a href="#review">구매후기</a></li>
			<li><a href="#delivery">배송정책</a></li>
			<li><a href="#product-more">작품더보기</a></li>
		</ul>
		<div class="detail-content" id="productComment">
			<div class="row"></div>
		</div>
		<ul class="detail-nav">
			<li><a href="#detail-info">작품상세정보</a></li>
			<li><a href="#product-review">구매후기</a></li>
			<li id="delivery" class="active"><a href="#delivery">배송정책</a></li>
			<li><a href="#product-more">작품더보기</a></li>
		</ul>
		<div class="detail-content" id="artisanPolicy"></div>
		<ul class="detail-nav">
			<li><a href="#detail-info">작품상세정보</a></li>
			<li><a href="#product-review">구매후기</a></li>
			<li><a href="#delivery">배송정책</a></li>
			<li id="product-more" class="active"><a href="#product-more">작품더보기</a></li>
		</ul>
		<div class="detail-content">
			<p><span class="artisan_name"></span> 작가님의 다른 작품 
			<a href="#" class="btn btn-xs btn-default radius50 artisanHome_btn" >작가홈</a></p>
			<ul class="product-more"></ul>
		</div>
	</div>

