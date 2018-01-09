<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		$list = ${order};
		var $tbody = $("#tbody");
		if($list.length==0){
			var $tr = $("<tr></tr>").appendTo($tbody);
			$("<td colspan='5'></td>").text("해당 내역이 없습니다.").css({"text-align": "center","font-weight": "bold"}).appendTo($tr);
		}
		$.each($list, function(i, order) {
			var $tr = $("<tr>").appendTo($tbody);
			$("<td>").text(i+1).appendTo($tr);
			$("<td>").text(order.ORDERSIDX).appendTo($tr);
			var $orderProduct = $("<td>").appendTo($tr);
			var $div = $("<div>").appendTo($orderProduct);
			$("<img>").attr("src","/bachida/user/displayFile/"+order.PRODUCTIDX).addClass("pull-left").appendTo($div);
			var $p = $("<p>").text(order.PRODUCTNAME).appendTo($div);
			$("<small>").text(" 외 "+(order.ORDERQUANTITY-1)+"상품").appendTo($p);
			var $link = $("<a>").attr("href", "/bachida/user/orderView/"+order.ORDERSIDX);
			$orderProduct.wrapInner($link);
			$("<td>").text(order.TOTALPRICE+"원").appendTo($tr);
			$("<td>").text(order.ORDERDATE).appendTo($tr);
		});
	});
</script>
<style>
	img{
		width:100%; 
		height : 60px;
		max-width:100px;
	}
	
</style>
</head>
<body>
<h3 style="color: rgb(245, 89, 128);">내 주문내역</h3>
	<div class="container">
		<div class="row">           
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
					<tr class="active">
						<th>번호</th><th>주문번호</th><th>주문상품</th><th>결제금액</th><th>주문일자</th>
					</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>