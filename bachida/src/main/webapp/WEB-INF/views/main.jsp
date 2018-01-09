<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		$('.carousel').carousel();
		var user=${user};
		var interest;
		var $activeBookmark = [];
		var mainList = ${mainList};
		if(user!="guest"){
			user = ${user};
			// 추천상품
			var recommendList = ${recommendList};
			var recommList = recommendList.recommendList;
			$activeBookmark = ${activeBookmark};
			if(recommList=="없음"){
				console.log("관심카테고리 없음");
				$("#recommendDiv").hide();
			}else{
				console.log("관심카테고리 있음");
				var $recommendProductList = $("#recommendProductList");
				var $a2;
				var clearfixDiv;
				$.each(recommList, function(i,list){
					$.each(mainList,function(index,main){
						if(list[0].mainCategoryIdx==main.mainCategoryIdx){
							$("<h4 class='recommCategory'></h4>").text("관심 카테고리 : " + main.mainCategoryName).appendTo($recommendProductList);	
							clearfixDiv = $("<div class='clearfix'></div>").appendTo($recommendProductList);
						} 
					});
					$.each(list,function(idx,p){
						var	$div = $("<div></div>").addClass("col-xs-3").appendTo(clearfixDiv);
						var $thumbnail = $("<div></div>").addClass("thumbnail").appendTo($div);
						var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + p.productIdx).appendTo($thumbnail);
						$("<img>").attr("src","/bachida/user/displayFile?savedFileName="+p.attach[0].savedFileName+"&originalFileName="+p.attach[0].originalFileName).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
						$caption = $("<div></div>").addClass("caption").appendTo($a);
						$("<h3></h3>").text(p.productName).css("margin","0").appendTo($caption);
						$("<p></p>").text(p.artisanName).css("margin","0").appendTo($caption);
						$("<p></p>").text(p.productPrice+"원").addClass("price").css("margin","0").appendTo($caption);
						$p = $("<p></p>").addClass("text-center").addClass("recommend").addClass("off").attr("id","product"+p.productIdx).attr("data-productIdx",p.productIdx).appendTo($thumbnail);
						$a2 = $("<a></a>").attr("data-productIdx",p.productIdx).attr("data-id","").appendTo($p);		// 로그인한 아이디 받아오기
						$("<span></span>").addClass("glyphicon").addClass("glyphicon-heart").appendTo($a2);
						$("<span></span>").addClass("recommendCnt").text(p.recommend).appendTo($a2);
						$.each($activeBookmark,function(i,bookmark){
							if(bookmark==p.productIdx)
								$("#product"+p.productIdx).addClass("on").removeClass("off");
						});
					})
						
				}) 
			}
		}else{ 		
			// 로그인전 : 추천상품 안보이게
			console.log("게스트");
			$("#recommendDiv").hide();
		}
		var recentList = ${recentList};
		var rList = recentList.recentList;
		console.log(rList);
		// carousel 부분  최신상품 3개
		var $listbox = $(".carousel-inner");
		$listbox.empty();
		$.each(rList,function(i,product){
			var div = $("<div class='item'></div>").appendTo($listbox);
			div.attr("data-idx",i);
			var link = $("<a href='#'></a>");
			var img = $("<img style='margin: 0 auto; width: 800px; height: 400px;'>").appendTo(div);
			link.attr("href","${pageContext.request.contextPath}/product/getProduct/" + product.productIdx);
			img.wrap(link);
			if(product.attach[0]!=null){
				img.attr("src","/bachida/user/displayFile?savedFileName="+product.attach[0].savedFileName+"&originalFileName="+product.attach[0].originalFileName);
			}
			var captionDiv = $("<div class='carousel-caption'></div>").appendTo(div);
			$("<h3></h3>").text(product.productName).appendTo(captionDiv);
			$("<p></p>").text(product.artisanName).appendTo(captionDiv);
		})
		var active = $(".item");
		active.first().addClass("active");		
		
		// 인기상품
		var popularList = ${popularList};
		var pList = popularList.popularList;
		var $productList = $("#productList");
		var $a2;
		$.each(pList, function(i,list){
			console.log("지금여기확인222");
			console.log(list);
			var	$div = $("<div></div>").addClass("col-xs-3").appendTo($productList);
			var $thumbnail = $("<div></div>").addClass("thumbnail").appendTo($div);
			var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + list.productIdx).appendTo($thumbnail);
				$("<img>").attr("src","/bachida/user/displayFile?savedFileName="+list.attach[0].savedFileName+"&originalFileName="+list.attach[0].originalFileName).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").appendTo($a);
				$caption = $("<div></div>").addClass("caption").appendTo($a);
				$("<h3></h3>").text(list.productName).css("margin","0").appendTo($caption);
				$("<p></p>").text(list.artisanName).css("margin","0").appendTo($caption);
				$("<p></p>").text(list.productPrice+"원").addClass("price").css("margin","0").appendTo($caption);
				$p = $("<p></p>").addClass("text-center").addClass("recommend").addClass("off").attr("id","product"+list.productIdx).attr("data-productIdx",list.productIdx).appendTo($thumbnail);
				$a2 = $("<a></a>").attr("data-productIdx",list.productIdx).attr("data-id","").appendTo($p);		// 로그인한 아이디 받아오기
				$("<span></span>").addClass("glyphicon").addClass("glyphicon-heart").appendTo($a2);
				$("<span></span>").addClass("recommendCnt").text(list.recommend).appendTo($a2);
				console.log("durldurl")
				$.each($activeBookmark,function(idx,bookmark){
					console.log(bookmark);
						if(bookmark==list.productIdx)
							$("#product"+list.productIdx).addClass("on").removeClass("off");
				}); 
					
				
		})
	
			
// 로그인전 : 로그인폼 보여주기.... 
		/* 즐겨찾는상품 추가 */
		$(".off").on("click","a",function(){
			if(user=='guest'){
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
		
		$("<a></a>").attr("data-activates");
	});
</script>
<style>
.recommend.off a{color:#ccc}
.recommend.on a {color: #ccc}
.recommend a {font-size: 17px}
.recommend.on a .glyphicon{color: rgb(245, 89, 128)}
.notice > div {width:48%;border:1px solid #ddd;padding:15px 20px}
.notice > div.pull-left{margin-right:2%}
.notice > div.pull-right{margin-left:2%}
.notice > div ul {padding-left:15px}
.notice ul li{line-height: 30px}
.notice ul li >span {float:right;}

/* 상품목록 */
.thumbnail:hover,a.thumbnail:hover {border-color:#f55980}
.productList .thumbnail .caption>h3 {font-size: 14px;white-space: nowrap;text-overflow:ellipsis;overflow: hidden}
.productList .thumbnail img,.best-product .thumbnail img {height: 155px;background-color: #eee;width:100%}
.price {color:#000;font-size: 19px}

</style>
</head>
<body>
<div class="container">
	<!-- <h3>최신상품3개영역</h3>  -->                       
	<div id="carousel" class="carousel slide" data-ride="carousel" style="max-width: 800px; margin:0 auto; max-height: 400px;">
  <!-- Indicators -->                                                           
  <ol class="carousel-indicators">
    <li data-target="#carousel" data-slide-to="0" class="active"></li>
    <li data-target="#carousel" data-slide-to="1"></li>
    <li data-target="#carousel" data-slide-to="2"></li>
  </ol>
                                                                         
  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">                        
    
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
	
	
	<h2 style="text-align: center; margin: 70px 0 50px; color: rgb(245, 89, 128); ">인기상품</h2>
	
	<div class="row productList" id="productList">
	</div>             
	
	<div id="recommendDiv">
	<h2 style="text-align: center;    margin: 70px 0 50px;  color: rgb(245, 89, 128);">추천상품</h2>
		<div class="row recommendProductList productList" id="recommendProductList"></div>             
	</div>
	<div class="clearfix notice">
	<div class="pull-left" >
	<h3 style="text-align: center; color: rgb(245, 89, 128);">공지사항</h3>   
	    <ul>
	    	<li><a href="#"><strong>※본 안내는 주문전 꼭! 숙지하셔야 됩니다※</strong></a> <span>2018.01.01</span></li>
	    	<li><a href="#">바치:다 시스템 정기 점검 안내</a> <span>2017.12.29</span></li>
	    	<li><a href="#">캐시 사용조건 변경 안내</a><span>2017.12.25</span></li>
	    	<li><a href="#">2018년 연휴기간 배송안내</a><span>2017.11.28</span></li>
	    	<li><a href="#">바치:다 사무실 이전 안내</a><span>2017.11.20</span></li>
	    </ul>       
	</div>                                   
	<div class="pull-right" >
	<h3 style="text-align: center; color: rgb(245, 89, 128);">QnA</h3>
	 <ul>
	    	<li><a href="#">비회원으로 구매가 가능한가요?</a> <span>2018.01.01</span></li>
	    	<li><a href="#">주문하고 아무 연락이 없어요!</a> <span>2017.12.29</span></li>
	    	<li><a href="#">요청한 시안이 올라오지 않아요</a><span>2017.12.25</span></li>
	    	<li><a href="#">주문했는데 사진이나 문구를 수정하고 싶어요!</a><span>2017.11.28</span></li>
	    	<li><a href="#">예상 배송일이 지났는데 배송시작을 안하네요..</a><span>2017.11.20</span></li>
	    </ul>       
	</div>
	</div>
	</div>
</body>
</html>