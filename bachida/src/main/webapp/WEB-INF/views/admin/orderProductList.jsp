<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	var $map = ${map};
	var $list = $map.list;
	var $pagination = $map.pagination;
	var $tbody = $("#tbody");
	var $allOrderCnt = $map.allOrderCnt;
	var $orderPrice = $map.orderPrice;
	if($list.length==0){
		var $tr = $("<tr></tr>").appendTo($tbody);
		$("<td colspan='5'></td>").text("해당 내역이 없습니다.").css({"text-align": "center","font-weight": "bold"}).appendTo($tr);
	}
	$.each($list, function(i, orderProduct) {
		var $comm = orderProduct.price*0.05;
		var $tr = $("<tr></tr>").addClass("tdata").appendTo($tbody);
		$("<td></td>").text(orderProduct.orderProductIdx).appendTo($tr);
		$("<td></td>").text(orderProduct.productName).appendTo($tr);
		$("<td></td>").text(orderProduct.artisanId).appendTo($tr);
		$("<td></td>").text(orderProduct.orderDate).appendTo($tr);
		$("<td></td>").text(orderProduct.price+"원").appendTo($tr);
		$("<td></td>").text($comm+"원").appendTo($tr);
		$("<td></td>").text((orderProduct.price-$comm)+"원").appendTo($tr);
		$("<td></td>").text(orderProduct.state).appendTo($tr);
	})
	var ul = $("#paginationUl");
	var li;
	if($pagination.prev>0) {
		li = $("<li></li>").text('이전').appendTo(ul);
		li.wrapInner($("<a></a").attr('href', '/bachida/admin/orderProductList?pageno='+ $pagination.prev))
	}
	for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
		li = $("<li></li>").text(i).appendTo(ul);
		if($pagination.pageno==i) 
			li.wrapInner($("<a></a").attr('href', '/bachida/admin/orderProductList?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
		else
			li.wrapInner($("<a></a").attr('href', '/bachida/admin/orderProductList?pageno='+ i))
	}
	if($pagination.next>0) {
		li = $("<li></li>").text('다음').appendTo(ul);
		li.wrapInner($("<a></a").attr('href', '/bachida/admin/orderProductList?pageno='+ $pagination.next));
	}
	
	$("#allOrderCnt").text($allOrderCnt+"건");
	$("#allPrice").text($orderPrice+"원");
	$("#allComm").text(($orderPrice*0.05)+"원");
});
</script>
<style>
	#paginationUl {
		display: table;
  		margin-left: auto;
  		margin-right: auto;
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
</style>
</head>
<body> 
	<div class="container">
		<div class="row">
			<h3 style="color: rgb(245, 89, 128);">주문관리</h3>
			<div class="col-md-10">
				<table class="table">
					<tr>
						<th class="active">총 주문건수</th>
						<td id="allOrderCnt"></td>
						<th class="active">총 주문금액</th>
						<td id="allPrice"></td>
						<th class="active">총 수수료</th>
						<td id="allComm"></td>
					</tr>
				</table>
			</div>
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
					<tr class="active">
						<th>주문상품번호</th>
						<th>상품명</th>
						<th>판매자</th>
						<th>주문일자</th>
						<th>구매액</th>
						<th>수수료</th>
						<th>정산금</th>
						<th>상태</th>
					</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>                   
				<div id="pagination">
					<ul id="paginationUl">
					</ul>
				</div>                                       
			</div>
			
		</div>
	</div>
</body>
</html>