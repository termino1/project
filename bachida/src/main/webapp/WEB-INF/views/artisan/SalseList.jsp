<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
$(function () {
	var $map = ${artisanProduct};
	console.log($map);
	var $list= $map.list;
	console.log($list);
	var $SalesCnt= $map.productSalesCnt;
	console.log($SalesCnt);
	var $pagination = $map.pagination;
	//$("#SalesCnt").text("총").text($SalesCnt).text("건");
	
	var $artisanSalesList = $("#artisanSalesList");
	$.each($list, function (i,list) {
		var	$div = $("<div></div>").addClass("col-xs-3").appendTo($artisanSalesList);
		var $thumbnail = $("<div></div>").addClass("thumbnail").appendTo($div);
		var $a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + list.PRODUCTIDX).appendTo($thumbnail);
			$("<img>").attr("src","${pageContext.request.contextPath}/artisan/sale/displayFile/?fileName=" + list.SAVEDFILENAME+"&productIdx="+ list.PRODUCTIDX).appendTo($a);
			$caption = $("<div></div>").addClass("caption").appendTo($a);
			$("<p class='productTitle'></p>").text(list.PRODUCTNAME).appendTo($caption);
			$("<p></p>").text(list.PRODUCTPRICE+"원").addClass("price").appendTo($caption);
			$p = $("<p></p>").addClass("text-center").addClass("recommend").addClass("off").appendTo($thumbnail);
			$a2 = $("<a></a>").attr("data-productIdx",list.PRODUCTIDX).appendTo($p);
			/* $("<span></span>").addClass("glyphicon").addClass("glyphicon-heart").appendTo($a2);
			$("<span></span>").addClass("recommendCnt").text(list.RECOMMEND).appendTo($a2); */
			
	});
	var $saleCnt = $("#SalesCnt");
	var $divCnt = $("<div></div>").attr("id","sales").appendTo($saleCnt);
	var $p1 = $("<p></p>").text("총 ").appendTo($divCnt);
	var $span1 = $("<span></span>").text($SalesCnt).appendTo($p1);
	$("<span></span>").text(" 건").appendTo($span1);
	
	var ul = $("#paginationUl");
	var li;
	if($pagination.prev>0) {
		li = $("<li></li>").text('이전').appendTo(ul);
		li.wrapInner($("<a></a").attr('href', '/bachida/user/applyList?pageno='+ $pagination.prev))
	}
	for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
		li = $("<li></li>").text(i).appendTo(ul);
		if($pagination.pageno==i) 
			li.wrapInner($("<a></a").attr('href', '/bachida/user/applyList?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
		else
			li.wrapInner($("<a></a").attr('href', '/bachida/user/applyList?pageno='+ i))
	}
	if($pagination.next>0) {
		li = $("<li></li>").text('다음').appendTo(ul);
		li.wrapInner($("<a></a").attr('href', '/bachida/user/applyList?pageno='+ $pagination.next));
	}	
});


</script>
<title>Insert title here</title>
<style>
	#paginationUl {
		display: table;
  		margin-left: auto;
  		margin-right: auto;
  		padding : 0;
	}
	#pagination li {
		list-style: none;
		display : inline-block;
		width: 35px;
		text-align : center;
		height : 35px;
		line-height: 35px;
		font-size : 0.75em;
		border: 1px solid #ddd;
	}
	#pagination a {
		text-decoration:  none;
		display : block;
		color : #337ab7;
	}
	#pagination a:link, #pagination a:visited {
		color : #337ab7;
	}
	#pagination {
		margin-top: 20px;
	}
	tbody > tr {cursor: pointer;}
	div{
		display: block;
	}
	.productTitle{
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
	}
	/* 상품목록 */
.thumbnail:hover,a.thumbnail:hover {border-color:#f55980}
.productList .thumbnail .caption>h3 {font-size: 14px;white-space: nowrap;text-overflow:ellipsis;overflow: hidden}
.productList .thumbnail img,.best-product .thumbnail img {height: 155px;background-color: #eee;width:100%}
.price {color:#000;font-size: 19px}
.recommend a{color:#ccc;font-size: 16px}
.recommend.on .glyphicon{color:#f55980} 
.recommend .recommendCnt{padding-left:5px;}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div>
				<h4 style="color: rgb(245, 89, 128);">현재 판매중인 목록입니다.</h4>
			</div>
			<div class ="page-header clearfix" id="cntSales">
			<div id="SalesCnt">
				
			</div>
			</div>
			<div class="artisanSalesList productList" id="artisanSalesList">
				
			</div>
			<br>
		</div>
		<div id="pagination">
			<ul id="paginationUl">
			</ul>
		</div>         
	</div>
</body>
</html>