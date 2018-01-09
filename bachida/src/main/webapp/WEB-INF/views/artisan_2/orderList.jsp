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
	var today=new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	if(dd<10) {
	    dd='0'+dd
	} 
	if(mm<10) {
	    mm='0'+mm
	} 
	today = yyyy+'-'+mm+'-'+dd;

	function printOrderList($list,$optionList,today){

		 var $table = $("#list");
		 $table.empty();
		 if($list.length==0){
				$("<p></p>").text("해당 내역이 없습니다.").css("font-size","large").appendTo($table);
			}
		 
		var $tr="";
		var rowspanIdx="";	// 주문번호
		var rowspanCnt=0;	// 주문번호별 rowspan 할 개수
		var badge="";	// 주문일
		var rowspanName="";
		$.each($list,function(i,op){
			if ($tr!="")
				var dataIdx =  $tr.attr("data-ordersIdx");
			
			if(dataIdx!=op.ordersIdx){ 	// 새로 만드는 주문번호tr
				rowspanCnt=0;			
				$tr = $("<tr class='checkIdx'></tr>").attr("data-ordersIdx",op.ordersIdx+"").appendTo($table);
				var checkbox = $("<td></td>").appendTo($tr);
				var checkboxP = $("<p></p>").appendTo(checkbox);
				var checkboxInput = $("<input type='checkbox' name='checkbox'>").attr("id","check"+op.orderProductIdx).val(op.orderProductIdx).appendTo(checkboxP);
				if(op.state!="주문")
					checkboxInput.attr("disabled","disabled");
				$("<label></label>").attr("for","check"+op.orderProductIdx).appendTo(checkboxP);
				
				badge = $("<td></td>").text(op.orderDate).css("width","150px").appendTo($tr);
				if(op.orderDate==today)
					$("<span></span>").addClass("new").addClass("badge").addClass("red").text(" ").appendTo(badge);
				
				rowspanIdx = $("<td></td>").text(op.ordersIdx).appendTo($tr);
				var idxLink = $("<a href='#modalOrder'></a>");
				rowspanIdx.wrapInner(idxLink);
				
				$("<td></td>").text(op.productIdx).appendTo($tr);
				$("<td></td>").text(op.productName).appendTo($tr);
				var $optionName = $("<td></td>").appendTo($tr);//옵션
				for(i=0;i<$optionList.length;i++){
					var optionListByIdx = $optionList[i];
					if(optionListByIdx!=""){
						if(optionListByIdx[0].orderProductIdx==op.orderProductIdx){
							$.each(optionListByIdx,function(i,option){
								$("<div></div>").text(option.optionContent + " " + option.optionQuantity).appendTo($optionName);
							})
							break;	
						}
					}
				}
				$("<td></td>").text(op.quantity).appendTo($tr);
				var stateTd = $("<td class='stateTd'></td>").text(op.state).attr("data-ordersIdx",op.ordersIdx).appendTo($tr);
				
				if(op.state=='주문')
					stateTd.css("color","blue");
				else if(op.state=='제작'){
					stateTd.css("color","crimson");
				}else
					stateTd.css("color","green");
				
				rowspanName = $("<td></td>").text(op.orderName).appendTo($tr);
				if(op.state=='제작'){
					var modalBtn = $("<td colspan='2'></td>").appendTo($tr);
					$("<button></button>").addClass("btn").text("배송입력").addClass("parcelBtn").attr("data-target","modal1").attr("data-Idx",op.orderProductIdx).attr("data-ordersIdx",op.ordersIdx).appendTo(modalBtn);
				}else{
					$("<td></td>").text(op.parcelName).appendTo($tr);
					$("<td></td>").text(op.parcelIdx).appendTo($tr);	
				}
				
			}else{	// tr 새로
				rowspanCnt++;
				var $tr2 = $("<tr></tr>");
			
				var checkbox = $("<td></td>").appendTo($tr2);
				var checkboxP = $("<p></p>").appendTo(checkbox);
				var checkboxInput = $("<input type='checkbox' name='checkbox'>").attr("id","check"+op.orderProductIdx).val(op.orderProductIdx).appendTo(checkboxP);
				if(op.state!="주문")
					checkboxInput.attr("disabled","disabled");
				$("<label></label>").attr("for","check"+op.orderProductIdx).appendTo(checkboxP);
				$("<td></td>").text(op.productIdx).appendTo($tr2);
				$("<td></td>").text(op.productName).appendTo($tr2);
				var $optionName = $("<td></td>").appendTo($tr2);//옵션
				for(i=0;i<$optionList.length;i++){
					var optionListByIdx = $optionList[i];
					if(optionListByIdx!=""){
						if(optionListByIdx[0].orderProductIdx==op.orderProductIdx){
							$.each(optionListByIdx,function(i,option){
								$("<div></div>").text(option.optionContent + " " + option.optionQuantity).appendTo($optionName);
							})
							break;	
						}
					}
				}
				$("<td></td>").text(op.quantity).appendTo($tr2);
				var stateTd = $("<td class='stateTd'></td>").text(op.state).attr("data-ordersIdx",op.ordersIdx).appendTo($tr2);
				
				if(op.state=='주문')
					stateTd.css("color","blue");
				else if(op.state=='제작'){
					stateTd.css("color","crimson");
				}else
					stateTd.css("color","green");
				
				if(op.state=='제작'){
					var modalBtn = $("<td colspan='2'></td>").appendTo($tr2);
					$("<button></button>").addClass("btn").text("배송입력").addClass("parcelBtn").attr("data-target","modal1").attr("data-Idx",op.orderProductIdx).attr("data-ordersIdx",op.ordersIdx).appendTo(modalBtn);
				}else{
					$("<td></td>").text(op.parcelName).appendTo($tr2);
					$("<td></td>").text(op.parcelIdx).appendTo($tr2);	
				}
				$tr.after($tr2);
				rowspanIdx.attr("rowspan",rowspanCnt+1);
				badge.attr("rowspan",rowspanCnt+1);
				rowspanName.attr("rowspan",rowspanCnt+1);
			}
			
		}) 
	}
	
	function paging($pagination,$href){
		//페이징
		var ul = $("#pagination ul");
		ul.empty();
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', $href+'pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', $href+'pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', $href+'pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/artisan/orderManagement/list?pageno='+ $pagination.next));
		}
	}
	
	// ajax로 불러온 리스트 페이징할때...  ajax 실행할때 preventDefault()!!!! 필수
	// $href < 안중요함..없어도 됨...
	// $className -> ajax 실행하는 버튼에 걸려있던 class... 혹은 id
	// $data_id -> ajax 실행할때 필요한 데이터 값
	function ajaxPaging($pagination, $href , $className, $data_id){
		var ul = $("#pagination ul");
		ul.empty();
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', $href+'pageno='+ $pagination.prev).attr("pageno",$pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', $href+'pageno='+ i).attr("pageno",i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', $href+'pageno='+ i).attr("pageno",i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', $href + 'pageno='+ $pagination.next).attr("pageno",$pagination.next));
		}
		
		$("#pagination a").addClass($className).attr("data-submit",$data_id);
	}
	

	$(function(){
		var $map = ${map};
		var $list = $map.list;
		var $optionList = $map.optionList;
		var $pagination = $map.pagination;
		var $totalOrderCnt = $map.totalOrderCnt;
		var $orderStateCnt = $map.orderStateCnt;
		var $productionStateCnt = $map.productionStateCnt;
		var $deliveryStateCnt = $map.deliveryStateCnt;
		var newList=null;
		var newOptionList=null;
		var newMap = null;
		
		var checkTest = $(".stateTd").attr("data-ordersIdx");
		
		$("#totalOrderCnt").text($totalOrderCnt+" 개");
		$("#orderCnt").text($orderStateCnt+" 개");
		$("#productionCnt").text($productionStateCnt+" 개");
		$("#deliveryCnt").text($deliveryStateCnt+" 개");
		
		printOrderList($list,$optionList,today);
		paging($pagination,"/bachida/artisan/orderManagement/list?");
		
		
		 $('select').material_select();
		
		 
		 // 상태변화
		 
		 $("body").on("change click",".changeState",function(e){
			 e.preventDefault();
			 var selectValue = $("#changeState").val();
				var pageno = $(this).attr("pageno");
				if(pageno==null)
					pageno=1;
			  $.ajax({
				url:"/bachida/artisan/orderManagement/listByState",
				type:"post",
				data:"state="+selectValue +"&pageno="+pageno + "&${_csrf.parameterName}=" + "${_csrf.token}",
				success:function(map){
					newMap=map;
					newList = newMap.list;
					newOptionList = newMap.optionList;
					var orderCntByState = newMap.orderCntByState;
					var newPagination = newMap.pagination;
					printOrderList(newList,newOptionList,today);
					ajaxPaging(newPagination,"/bachida/artisan/orderManagement/listByState?","changeState",selectValue);
					$("#dateCnt").empty();
					$("<td colspan='6'></td>").text("선택 상태 개수 : "+orderCntByState +" 개").css("font-weight","bold").appendTo("#dateCnt");
				}
			 }); 
			 
		 });
		 
		 //제작처리 
		$("#production_btn").on("click",function(){
			var checkboxArray = Array(); 
			var array_cnt = 0;
			var checkbox = $("input[name=checkbox]:checked");
			if(checkbox.length<1)
				alert("1개 이상 선택해주세요");
			else if(confirm("제작처리하시겠습니까?")){
				for(i=0; i<checkbox.length;i++){
					if(checkbox[i].checked==true){
						checkboxArray[array_cnt] = checkbox[i].value;
						array_cnt++;
					}
				}
				
				// ajax로 보내기 // 처리상태 update 후 페이지 reload!
				$.ajax({
					url: "/bachida/artisan/orderManagement/production_process" ,
					type: "post",
					data : {
						checkboxArray:checkboxArray,
						_csrf:'${_csrf.token}'
					},
					success:function(result){
						if(result)
							location.reload(true);
						else
							alert("다시 시도해주세요");
					}
				});
			}
		})
		 
		// 기간검색
		$("body").on("click",".dateSearch",function(e){
			e.preventDefault();
			var pageno = $(this).attr("pageno");
			if(pageno==null)
				pageno=1;
			var searchDate = $(this).attr("data-submit");
			$.ajax({
				url:"/bachida/artisan/orderManagement/listByDate",
				type:"get",
				data: "searchDate="+searchDate +"&pageno="+pageno,
				success:function(map){
					newMap=map;
					newList = newMap.list;
					newOptionList = newMap.optionList;
					var orderCntByDate = newMap.orderCntByDate;
					var newPagination = newMap.pagination;
					printOrderList(newList,newOptionList,today);
					ajaxPaging(newPagination,"/bachida/artisan/orderManagement/listByDate?","dateSearch",searchDate);
					$("#dateCnt").empty();
					$("<td colspan='6'></td>").text("선택한 기간 주문 개수 : "+orderCntByDate +" 개").css("font-weight","bold").appendTo("#dateCnt");
				}
			});
			
		});
		$("#allList").on("click",function(){
			location.href="/bachida/artisan/orderManagement/list";
		});
		
		var orderDate = 'desc';	// asc
		var ordersIdx = 'desc';
		var productIdx = 'desc';
		
		// 정렬
		$("body").on("click",".orderby",function(e){
			e.preventDefault();
			var orderby = $(this).attr("data-orderby");
			if(orderby==null){
				orderby=$(this).attr("data-submit");
			}
			var pageno = $(this).attr("pageno");
			if(pageno==null)
				pageno=1;
			var sort="";
			var where = $("#changeState option:selected").val();
			
			if(where==""){
				alert("주문상태를 먼저 선택해주세요!");
			}else {
				if(orderby==orderDate){
					sort=orderDate;
					orderDate=='desc'? orderDate='asc':orderDate='desc';
				}else if(orderby==ordersIdx){
					sort=ordersIdx;
					ordersIdx=='desc'? ordersIdx='asc':ordersIdx='desc';
				}else{
					sort=productIdx;
					productIdx=='desc'? productIdx='asc':productIdx='desc';
				}
					
				
				$.ajax({
					url:"/bachida/artisan/orderManagement/sort",
					type:"post",
					data:"orderby="+orderby+"&sort="+sort+"&state="+where+"&pageno="+pageno + "&${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(map){
						newMap=map;
						newList = newMap.list;
						newOptionList = newMap.optionList;
						var newPagination = newMap.pagination;
						printOrderList(newList,newOptionList,today);
						ajaxPaging(newPagination,"/bachida/artisan/orderManagement/sort?","orderby",orderby);
					}
				});	
			}
		})
		// 모달 띄우기! 배송
		
		$("body").on("click",".parcelBtn",function(){
			var idx = $(this).attr("data-idx");
			var orderIdx = $(this).attr("data-ordersIdx");
			var checkTest = $("td.stateTd");
			var checkArray = Array();
			var checkCnt=0;
			
			$.each(checkTest,function(i,td){
				var idx = td.dataset.ordersidx;
				var text = td.innerText;
				
				if(idx==orderIdx){
					checkArray[checkCnt] = text ;
					checkCnt++;
				}
			});
			var isPossible = true;
			for(var i=0; i<checkArray.length; i++){
				if(checkArray[i]=='주문'){
					isPossible = false;
					break;
				}
			}
			if(!isPossible){
				$("#parcelTotal").attr("disabled","disabled");
				$("#parcelP").text("※제작중이 아닌 상품이 있어요ㅠㅠ").css({"font-size":"small","color":"darkgrey"});
			}
			$("#modal1 #delivery_btn").attr("data-idx",idx).attr("data-ordersIdx",orderIdx);
			$('#modal1').modal('open');
		});
		
		$("#modal1").on("click","#delivery_btn",function(){
			var idx = $(this).attr("data-idx");
			var orderIdx = $(this).attr("data-ordersIdx");
			
			 if(confirm("배송처리 할까요?")){
				var $delevery_form = $("#delivery_form");
				$("<input type='hidden' name='orderProductIdx'>").val(idx).appendTo($delevery_form);
				$("<input type='hidden' name='ordersIdx'>").val(orderIdx).appendTo($delevery_form);
				$.ajax({
					url:"/bachida/artisan/orderManagement/delivery_insert" ,
					type: "post" ,
					data: $delevery_form.serialize(),
					success:function(result){
						if(result){
							alert("처리완료!");
							$("#modal1").modal("close");
							location.reload(true); 	
						}
					}
				});	 
			} 
			 
		});
		
		
		// 체크박스 전체 선택/ 해제
		$("#allCheck").on("click",function(){
			 if($("#allCheck").prop("checked")){
		            $("input[name=checkbox").each(function(){
		            	var opt = $(this).prop("disabled");
		            	if(!opt){
		            		$(this).prop("checked",true);
		            	}
		            });
		        }else{
		            $("input[name=checkbox]").prop("checked",false);
		        }
		});
		
		
		// 주문번호 클릭하면 주문 확인/
		$("body").on("click","#list a", function(){
			var ordersIdx = $(this).text();
			$.ajax({
				url:"/bachida/artisan/orderManagement/listByOrdersIdx",
				type:"post",
				data:"ordersIdx="+ordersIdx + "&${_csrf.parameterName}=" + "${_csrf.token}",
				success:function(map){
					// modal에 내용 전달
					var $modalMap = map;
					var $modalList = $modalMap.list;
					var $modalOrder = $modalMap.order;
					var $modalOptionList = $modalMap.optionList;
					$(".m_data").empty();
					
					$("#m_orderDate").text($modalOrder.orderDate);
					$("#m_ordersIdx").text($modalOrder.ordersIdx);
					
					$("#m_id").text($modalOrder.id);
					
					$("#m_name").text($modalList[0].orderName);
					$("#m_tel").text($modalList[0].orderTel);
					$("#m_email").text($modalList[0].orderEmail);
					$("#m_addr").text($modalOrder.address);
					
					
					
					var modalList = $("#modalList");
					modalList.empty();
					$.each($modalList,function(i,op){
						$tr = $("<tr class='checkIdx'></tr>").attr("data-ordersIdx",op.ordersIdx+"").appendTo(modalList);
					
						/* 
						var checkbox = $("<td></td>").appendTo($tr);
						var checkboxP = $("<p></p>").appendTo(checkbox);
						var checkboxInput = $("<input type='checkbox' name='checkbox'>").attr("id","check"+op.orderProductIdx).val(op.orderProductIdx).appendTo(checkboxP);
						if(op.state!="주문")
							checkboxInput.attr("disabled","disabled");
						$("<label></label>").attr("for","check"+op.orderProductIdx).appendTo(checkboxP);
						 */
						
						$("<td></td>").text(op.productIdx).appendTo($tr);
						$("<td></td>").text(op.productName).appendTo($tr);
						var $optionName = $("<td></td>").appendTo($tr);//옵션
						for(i=0;i<$optionList.length;i++){
							var optionListByIdx = $optionList[i];
							if(optionListByIdx!=""){
								if(optionListByIdx[0].orderProductIdx==op.orderProductIdx){
									$.each(optionListByIdx,function(i,option){
										$("<div></div>").text(option.optionContent + " " + option.optionQuantity).appendTo($optionName);
									})
									break;	
								}
							}
						}
						$("<td></td>").text(op.quantity).appendTo($tr);
						var stateTd = $("<td></td>").text(op.state).appendTo($tr);
						
						if(op.state=='주문')
							stateTd.css("color","blue");
						else if(op.state=='제작')
							stateTd.css("color","crimson");
						else
							stateTd.css("color","green");
						
						if(op.state=='제작'){
							var modalBtn = $("<td colspan='2'></td>").appendTo($tr);
							$("<button></button>").addClass("btn").text("배송입력").addClass("parcelBtn").attr("data-target","modal1").attr("data-Idx",op.orderProductIdx).attr("data-ordersIdx",op.ordersIdx).appendTo(modalBtn);
						}else{
							$("<td></td>").text(op.parcelName).appendTo($tr);
							$("<td></td>").text(op.parcelIdx).appendTo($tr);	
						}
					});
				}
			});
			$("#modalOrder").modal('open');
		})
		
		$('.modal').modal();
	})
</script>
<style>
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
	a:link , .orderby:hover {
		text-decoration: none;
		cursor: pointer;
	}
	#modalOrder{
		width : 85% !important;
		height: 90% !important;
	}
		.container{
width: 1000px !important;
}
</style>
</head>
<body>
	  <div class="container"> 
	<div class="row">
	<table class="col s12">  
		<tr>
			<td><button class="btn #78909c blue-grey lighten-1" id="allList">전체</button></td>
			<td><button class="btn dateSearch #78909c blue-grey lighten-1" data-submit="0">하루</button></td>
			<td><button class="btn dateSearch #78909c blue-grey lighten-1" data-submit="7">일주일</button>	</td>  
			<td><button class="btn dateSearch #78909c blue-grey lighten-1" data-submit="30">한달</button></td>
			<td><button class="btn dateSearch #78909c blue-grey lighten-1" data-submit="90">세달</button></td>
			<td><select onchange="" id="changeState" class="changeState">
					<option value="" disabled selected>주문상태</option>
					<option value="주문" id="orderSelect">주문</option>
					<option value="제작" id="productionSelect">제작</option>
					<option value="배송" id="deliverySelect">배송</option>
				</select>  
			</td>

		</tr>
		<tr id="dateCnt">
		</tr>
	</table>   
	
	</div> 
	<div class="row">
		<div class="col s2">
			총 개수 : <span id="totalOrderCnt">00 개</span>
		</div>
		<div class="col s2">
			주문 : <span id="orderCnt">00 개</span>
		</div>
		<div class="col s2">
			제작 : <span id="productionCnt">00 개</span>
		</div>
		<div class="col s2">
			배송 : <span id="deliveryCnt">00 개</span>
		</div>
	</div>
	<table class="centered highlight bordered responsive-table">
		<thead>
			<tr>
				<th><input type='checkbox' id="allCheck"><label for="allCheck"></label></th>  
				<th><a class="orderby" data-orderby="orderDate">주문일</a></th>
				<th><a class="orderby" data-orderby="ordersIdx">주문번호</a></th>
				<th><a class="orderby" data-orderby="productIdx">상품번호</a></th>
				<th>상품명</th>
				<th>옵션</th>
				<th>총수량</th>  
				<th>상태</th>
				<th>구매자명</th>
				<th>택배명</th>
				<th>송장번호</th>    
			</tr>
		</thead>
		<tbody id="list">
			
		</tbody>
	</table>
	<div id="pagination">    
		<ul class="text-center">
		</ul>
	</div>
	
	<a class="waves-effect waves-light btn-large" id="production_btn">제작처리</a>
	

	   
	   <!--  개별주문모달 -->
	
	<div id="modalOrder" class="modal">
   
     <div class="modal-content">
        <div class="modal-header">     
          <h4 class="modal-title">주문상세</h4>
        </div>
        <div class="modal-body" id="">
        	<h5 class="text-center">주문자정보</h5>
        	<table style="width:300px; margin:0 auto;">         
        		<tbody>
        			
        			<tr>
        				<th style="width: 70px">주문일</th><td id="m_orderDate" class="m_data"></td>
        			</tr>
        			
        			<tr>             
        				<th>주문번호</th><td id="m_ordersIdx" class="m_data"></td>
        			</tr>
        			<tr>
        				<th>아이디</th><td id="m_id" class="m_data"></td>
        			</tr>
        			<tr>
        				<th>이름</th><td id="m_name" class="m_data"></td>
        			</tr>
        			<tr>
        				<th>전화번호</th><td id="m_tel" class="m_data"></td>
        			</tr>
        			<tr>
        				<th>이메일</th><td id="m_email" class="m_data"></td>
        			</tr>
        			<tr>
        				<th>주소</th><td id="m_addr" class="m_data"></td>
        			</tr>
        		</tbody>
        	</table>
        	<hr>
        	<h5 class="text-center">주문정보</h5>
        	
        	<table>
        		<thead>
        			<tr>
        				<!-- <th><input type='checkbox' id="allCheck"><label for="allCheck"></label></th>   -->
						<th>상품번호</th>
						<th>상품명</th>
						<th>옵션</th>
						<th>총수량</th>  
						<th>상태</th>
						<th>택배명</th>
						<th>송장번호</th>
        			</tr>                              
        		</thead>
        		<tbody id="modalList">
        		
        		</tbody>
        	</table>
        </div>                       
        <div class="modal-footer">
          <button type="button" class="btn modal-close" >Close</button>
        </div>     
      </div>   
  </div>
	   
	
	<!-- 배송 모달! -->
	
	<div id="modal1" class="modal" style="z-index: 1007 !important">
   
     <div class="modal-content">
        <div class="modal-header">     
          <h4 class="modal-title">배송입력</h4>
        </div>
        <div class="modal-body" id="delivery_modal">
        <form id="delivery_form">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <div class="input-field">
        	<div>※같은 주문 상품 확인해 주세요!※</div>
          <select name="parcelName" id="parcelName">  
          	<option value="" disabled selected id="default">택배명 선택</option>
          	<option value="우체국택배">우체국택배</option>
          	<option value="CJ대한통운">CJ대한통운</option>
          	<option value="로젠택배">로젠택배</option>
          	<option value="한진택배">한진택배</option>
          	<option value="현대택배">현대택배</option>
          </select>
          </div>
          <br>
          <input type="number" placeholder="운송장번호" name="parcelIdx" id="parcelIdx"><br> 
          <input type="checkbox" id="parcelTotal" name="parcelTotal" value="일괄배송">
          <label for="parcelTotal">같은 주문 일괄배송</label><br>
          <p id="parcelP"></p>
          <input type="button" id="delivery_btn" class="btn" value="배송 처리">	
          </form>
        </div>                       
        <div class="modal-footer">
          <button type="button" class="btn modal-close" >Close</button>
        </div>     
      </div>   
  </div>
	  </div>
</body>
</html>