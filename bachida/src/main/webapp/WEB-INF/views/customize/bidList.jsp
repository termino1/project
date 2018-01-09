<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
 <script type="text/javascript" src="/bachida/js/materialize.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link type="text/css" rel="stylesheet" href="/bachida/css/materialize.min.css"  media="screen,projection"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
function printBidList($bidList, $customList, $productionOrder){
	var $list = $("#list");
	$list.empty();
	if($bidList.length==0){
		$("<p></p>").text("해당 내역이 없습니다.").css("font-size","large").appendTo($list);
	}
	
	// table로 뿌리기!
	$.each($bidList,function(i,bid){
		var first_tr = $("<tr></tr>").appendTo($list);
		$("<td rowspan='2' id='bidIdxTd'></td>").text(bid.bidIdx).appendTo(first_tr);
		for(i=0;i<$customList.length;i++){
			var custom = $customList[i];
			if(bid.customIdx==custom.customIdx){
				var title_td = $("<td colspan='5'></td>").text(custom.title).appendTo(first_tr);
				break;
			}
		}
		var $link = $("<a class='c_title'></a>").attr("href","/bachida/custom/view?customIdx="+bid.customIdx);
		title_td.wrapInner($link);
		var sec_tr = $("<tr></tr>").appendTo($list);
		$("<td class='truncate'></td>").text(bid.content).css("max-width","200px").appendTo(sec_tr);
		$("<td></td>").text(bid.price + "원").appendTo(sec_tr);
		var state_td = $("<td></td>").text(bid.state).css("color","grey").appendTo(sec_tr);
		var btn_td = $("<td></td>").appendTo(sec_tr);
		var orderState_td = $("<td></td>").appendTo(sec_tr);
		
		if(bid.state=="낙찰")
			state_td.css("color","blue").css("font-weight","bold");
		if(bid.state=="낙찰"){
			btn_td.css("padding","0");
			$("<button id='custom_btn' class='btn'></button>").text("주문제작").attr("data-idx",bid.bidIdx).attr("data-artisanId",bid.artisanId).appendTo(btn_td);
			
		}
		
		$.each($productionOrder, function(i,order){
			if(order!=null && order.bidIdx==bid.bidIdx){	// 제작주문서 있다면//
				$("<span class='whiteFont'></span>").text(order.state).appendTo(orderState_td);
			}
			
		}); 
	});
	
}


	$(function(){
		var $map = ${map};
		var $bidList = $map.bidList;
		var $allBidList = $map.allBidList;
		var $customList = $map.customList;
		var $pagination = $map.pagination
		var $productionOrder = $map.productionOrder;
		
		console.log($productionOrder);
		
		
		printBidList($bidList,$customList,$productionOrder);
		
		setInterval(function(){
			$('.whiteFont').toggleClass("blinkEle");
				 //   $(".blinkEle").css("color","white");
				  }, 400);
		$(document).on("click","#custom_btn",function(){
			location.href="/bachida/customize/custom_order?bidIdx="+$(this).attr("data-idx") + "&artisanId=" + $(this).attr("data-artisanId");
			
		});
		
		//정렬
		
		$(".bidStateList").on("click",function(){
			var orderBy=$(this).text();
			$bidList2 = $allBidList.filter(function(value, i, array) {
				if(value.state==orderBy)
					return true;
			});
			printBidList($bidList2,$customList,$productionOrder);
			$("#pagination").css("display","none");
		});
		
		$("#allList").on("click",function(){
			printBidList($bidList,$customList,$productionOrder);
			$("#pagination").css("display","block");
		});
		
		$(".customStateList").on("click",function(){
			var orderBy=$(this).text();
			$productionOrder2 = $productionOrder.filter(function(value, i, array) {
				if(value==null)
					return false
				else if(value.state==orderBy){
					return true;
				}
			})
		
			$bidList3 = []; 
			$productionOrder2.forEach(function(order, i, array) {
				var order_bidIdx = order.bidIdx;
				
				$allBidList.filter(function(bid, i, array) {
					if(bid.bidIdx==order_bidIdx){
						$bidList3.push(bid);
					}
						return true;
				})
			})
			printBidList($bidList3,$customList,$productionOrder);
			$("#pagination").css("display","none");
		});
		
		
		
		//페이징
		var ul = $("#pagination ul");
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/customize/bid_list?pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/bachida/customize/bid_list?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/bachida/customize/bid_list?pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/customize/bid_list?pageno='+ $pagination.next));
		}
		
	});
</script>
<style>
	.blinkEle{
		color: red;
	}
	
	.c_title{
	font-size: large;
    font-weight: bold;
	}
	td{
		min-width: 80px;
	}
	#bidIdxTd{
		min-width: 30px;
	}
	/* span{
	margin-right: 30px;
	margin-left: 30px;
	display: inline-block;
	width : 150px;
	white-space:nowrap; 
	overflow:hidden;

	text-overflow:ellipsis;
	} */
		
	#pagination  ul {
		maring: 0;
		padding: 0;
	}
	#pagination li {
		list-style: none;
		width: 35px;
		display: inline-block;
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
	.container{
width: 1000px !important;
}

</style>
</head>      
<body>       
<div class="container">  
	<div class="row">
	<div class="col s12">            
		<ul class="tabs tabs-fixed-width">
			<li class="tab col"><a class="active" href="#test1" id="allList">전체</a></li>
			<li class="tab col"><a href="#test2" class="bidStateList">입찰</a></li>
			<li class="tab col"><a href="#test3" class="bidStateList">마감</a></li>
			<li class="tab col"><a href="#test4" class="bidStateList">낙찰</a></li>
			<li class="tab col"><a href="#test4" class="customStateList">주문</a></li>
			<li class="tab col"><a href="#test4" class="customStateList">제작</a></li>
			<li class="tab col"><a href="#test4" class="customStateList">제작완료</a></li>
			<li class="tab col"><a href="#test4" class="customStateList">결제완료</a></li>
			<li class="tab col"><a href="#test4" class="customStateList">배송</a></li>
		</ul>
	</div>
	</div>
  
	<div>  
		<table class="bordered highlight responsive-table">
			<tbody id="list">
				<tr>
					<td rowspan="2">번호</td>
					<td colspan="5">제목</td>
				</tr>
				<tr>
					<td>입찰내용입찰내용입찰내용</td>
					<td>가격</td>
					<td>상태</td>
					<!-- 버튼 주문상태 -->
				</tr>
			</tbody>
		</table>


	</div>	  
	<div id="pagination">    
		<ul class="text-center">
		</ul>
	</div>
</div>
</body>
</html>