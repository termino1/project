<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Insert title here</title>
<style type="text/css">
table{
	text-align: center;
}
body {
 /*  padding:50px; */
}
.bordertable th{
  background-color: #f7f8fa;        
  text-align: center;
}

.bordertable td{
  padding-left:20px !important;
}  

.bordertable th, .bordertable td{
  font-family: '나눔고딕',NanumGothic,'맑은고딕',MalgunGothic,'돋움',Dotum,Helvetica,sans-serif;
  font-size: 12px;      
  border:1px solid #ededed !important;
  font-weight: normal;          
  line-height: 19px;
  color:#20232;
  padding-top: 9px !important;
  padding-bottom: 7px !important;
}
hr{
	margin: 0px;
}
p {
	margin-top: 10px;
}

.col-xs-4{
	border: 1px solid #bcc0c7;
}
</style>
<script type="text/javascript">


	$(function () {
		var $map = ${map};
		console.log($map);
		var $list = $map.listSales;
		console.log($list);
		var $pagination = $map.pagination;
		var $table = $("table");
		$table.append('<tr><th>주문 번호</th><th>작품명</th><th>주문상태</th><th>수량</th><th>주문자</th><th>판매금액</th><th>주문일자</th></tr>');
		$.each($list, function(i, sales) {
			var $tr = $("<tr></tr>").appendTo($table);
			$("<td></td>").text(sales.ORDERPRODUCTIDX).appendTo($tr);
			$("<td></td>").text(sales.PRODUCTNAME).appendTo($tr);
			$("<td></td>").text(sales.SATET).appendTo($tr);
			$("<td></td>").text(sales.QUANTITY).appendTo($tr);
			$("<td></td>").text(sales.ORDERNAME).appendTo($tr);
			$("<td></td>").text(sales.PRICE+"원").appendTo($tr);
			$("<td></td>").text(sales.ORDERDATE).appendTo($tr);
			
		});
		var $gross = $map.gross;
		var $total = $map.total;
		var $deduct = $map.deduct;
		var $stats = $("#stats");
			
		var $div = $("<div></div>").addClass("row-fluid").appendTo($stats);
		var $div_left = $("<div></div>").addClass("col-xs-4").addClass("placeholder").appendTo($div);
		var $div_center = $("<div></div>").attr("id","center_line").addClass("col-xs-4").addClass("placeholder").appendTo($div);
		var $div_right = $("<div></div>").addClass("col-xs-4").addClass("placeholder").appendTo($div);
		$("<h4></h4>").text("매출액").appendTo($div_left);
		$("<span></span>").text($total+"원").appendTo($div_left);
		$("<h4></h4>").text("수수료").appendTo($div_center);
		$("<span></span>").text($deduct+"원").appendTo($div_center);
		$("<h4></h4>").text("합계").appendTo($div_right);
		$("<span></span>").text($gross+"원").appendTo($div_right);
		
	});
	</script>
	
</head>
<body>
		
		<div class="page-header clearfix">
			<h4 style="color: rgb(245, 89, 128);">정산예정금액 확인</h4>
			<hr>
			<p><span id="tr_count"><strong>- 판매대금 정산을 일시적으로 조회할 수 있는 메뉴입니다.</strong></span><br>
				<span><strong>- 수수료는 판매금액의 5%입니다.</strong></span>
			</p>
		</div>
	<div>
		<table id="list" class="table table-bordered bordertable">
			
		</table>
	</div>
	<hr>
	<div class="row stats" id="stats" >
		
	</div>
</body>
</html>