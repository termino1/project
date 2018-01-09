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
		 var $cartlist =${cartlist};
		 var $cartProduct = $cartlist.product;
		 var $cartPList = $cartlist.CartProduct;
    	 var $cartList=$("#cartList");
		 var $artisanIdList=0;
		 var $result=0;
		
		$.each($cartProduct, function(i,product){
			$artisanIdList = $("[data-id="+product.artisanId+"]").size();
			console.log($artisanIdList);
			if($artisanIdList==0 ){ // 작가 이름이 같지 않으면
			var	$div = $("<div></div>").appendTo($cartList);
			$("<p></p>").text(product.artisanId +" 작가님").appendTo($div);
			var	$table = $("<table class='table table-board table-bordered'></table>").appendTo($div);
			var	$thead = $("<thead></thead>").appendTo($table);
			var	$tr = $("<tr></tr>").appendTo($thead);
			var	$th = $("<th></th>").css("width","50px").appendTo($tr);
			$("<input>").attr("data-name","selectAll").attr("type","checkbox").appendTo($th);
			$("<th></th>").text("작품정보").appendTo($tr);
			$("<th></th>").text("가격").css("width","120px").appendTo($tr);
			$("<th></th>").text("수량").css("width","80px").appendTo($tr);
			$("<th></th>").text("합계").css("width","120px").appendTo($tr);
			var	$tbody = $("<tbody></tbody>").attr("data-id",product.artisanId).appendTo($table);
			var	$tbody_tr = $("<tr></tr>").appendTo($tbody);
			var	$tbody_td = $("<td class='text-center'>").appendTo($tbody_tr);
			$("<input>").attr("type","checkbox").attr("name","cartProductIdx").attr("value",$cartPList[i].cartProductIdx).appendTo($tbody_td);
			var	$tbody_td2 = $("<td></td>").appendTo($tbody_tr);
			var	$media = $("<div></div>").addClass("mdeia").appendTo($tbody_td2);
			var	$media_left = $("<div></div>").addClass("media-left").appendTo($media);
			var	$a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + product.productIdx ).appendTo($media_left);
			$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+product.productIdx).attr("onError","this.src='${pageContext.request.contextPath}/images/no_image.jpeg'").css("width","50px").css("height","50px").appendTo($a);
			var	$media_body = $("<div></div>").addClass("media-body").appendTo($media);
			$("<h4></h4>").text(product.productName).appendTo($media_body);
			var $option = $cartPList[i].cartOptions;
				if($option!=null){
					for(j=0;j<$option.length;j++){
					var $p = $("<p></p>").text("옵션"+ (j+1) +" : " +$option[j].optionContent).appendTo($media_body);
						$("<span></span>").text(" [" + $option[j].optionQuantity +"]").appendTo($p);
				}				
			}
			$("<td></td>").addClass("text-right").text($cartPList[i].price).appendTo($tbody_tr);
			$("<td></td>").addClass("text-center").text($cartPList[i].quantity).appendTo($tbody_tr);
			$tbody_td5 = $("<td></td>").text($cartPList[i].price * $cartPList[i].quantity).addClass("text-right").addClass("totalCost").appendTo($tbody_tr);
			$div2 = $("<div class='clearfix'></div>").appendTo($cartList);
			$("<div></div>").addClass("pull-right").attr("id","price"+i).text($tablePrice+" 원").appendTo($div2);
				
			}else{ // 작가명이 같으면
				var	$tbody2 = $("[data-id="+product.artisanId+"]");
				var	$tbody_tr = $("<tr></tr>").appendTo($tbody2);
				var	$tbody_td = $("<td class='text-center'>").appendTo($tbody_tr);
				$("<input>").attr("type","checkbox").attr("name","cartProductIdx").attr("value",$cartPList[i].cartProductIdx).appendTo($tbody_td);
				var	$tbody_td2 = $("<td></td>").appendTo($tbody_tr);
				var	$media = $("<div></div>").addClass("mdeia").appendTo($tbody_td2);
				var	$media_left = $("<div></div>").addClass("media-left").appendTo($media);
				var	$a = $("<a></a>").attr("href","${pageContext.request.contextPath}/product/getProduct/" + product.productIdx ).appendTo($media_left);
				$("<img>").attr("src","${pageContext.request.contextPath}/user/displayFile/"+product.productIdx).css("width","50px").css("height","50px").appendTo($a);
				var	$media_body = $("<div></div>").addClass("media-body").appendTo($media);
				$("<h4></h4>").text(product.productName).appendTo($media_body);
				var $option = $cartPList[i].cartOptions;
					if($option!=null){
						for(j=0;j<$option.length;j++){
						var $p = $("<p></p>").text("옵션"+ (j+1) +" : " +$option[j].optionContent).appendTo($media_body);
							$("<span></span>").text(" [" + $option[j].optionQuantity +"]").appendTo($p);
					}			
				}
				$("<td></td>").addClass("text-right").text($cartPList[i].price).appendTo($tbody_tr);
				$("<td></td>").addClass("text-center").text($cartPList[i].quantity).appendTo($tbody_tr);
				$tbody_td5 = $("<td></td>").text($cartPList[i].price * $cartPList[i].quantity).addClass("text-right").addClass("totalCost").appendTo($tbody_tr);
			} 

		})
		// 처음 모두선택
		$("input[name=cartProductIdx]").attr("checked","checked");
		
		/* 토탈금액 */
		var t = $("#cartList>div").children("table");
		for (var i = 0; i < t.size(); i++) {
			var $tablePrice = 0;
			for (var k = 0; k < t[i].children[1].children.length; k++) {
				$result = $result + Number(t[i].children[1].children[k].lastChild.textContent)
				$tablePrice = $tablePrice + Number(t[i].children[1].children[k].lastChild.textContent)
			} 
			$("#price"+i).text($tablePrice + " 원");
		}
		$("#totalPrice").text($result);
		
		
		// 토탈금액 변화//
		$("input[type='checkbox']").on("click",function(){
			/* var td = $("input[name=cartProductIdx]:checked").parent("td");
			console.log(td);
			var totalCost = parseInt(td.siblings("td.totalCost").text());
			console.log(totalCost); */
			
			var checkbox = $("input[name=cartProductIdx]:checked");
			var td = $("input[name=cartProductIdx]:checked").parent("td");
			var checkedTd;
			var totalCost=td.siblings("td.totalCost");
			var totalCost2 = 0;
			for(i=0; i<checkbox.length;i++){
				if(checkbox[i].checked==true){
					checkedTd = parseInt(totalCost[i].innerText);
					totalCost2= totalCost2+checkedTd;
				}
				
			}
			$("#totalPrice").text(totalCost2);
		})
		
		
		
		
		
		// 선택삭제
		$("#deleteSelect").on("click", function(){
			var checkboxArray = Array(); 
			var array_cnt = 0;
			var checkbox = $("input[name=cartProductIdx]:checked");
			if(checkbox.length<1)
				alert("1개 이상 선택해주세요");
			else if(confirm("삭제하시겠습니까?")){
				for(i=0; i<checkbox.length;i++){
					if(checkbox[i].checked==true){
						checkboxArray[array_cnt] = checkbox[i].value;
						array_cnt++;
					}
				}
			}
				 $.ajax({
				 type:"post",
				 url:"${pageContext.request.contextPath}/product/delete_cart",
				 data : {
						checkboxArray:checkboxArray,"${_csrf.parameterName}": '${_csrf.token}'
					},
				 success:function() {
					 location.reload(true);
				}
			});   
			
		})
		// 전체삭제
		$("#deleteAll").on("click", function(){
			$("input[name=cartProductIdx]").prop('checked','checked');
			var checkboxArray = Array(); 
			var array_cnt = 0;
			var checkbox = $("input[name=cartProductIdx]:checked");
			 if(confirm("삭제하시겠습니까?")){
				for(i=0; i<checkbox.length;i++){
					if(checkbox[i].checked==true){
						checkboxArray[array_cnt] = checkbox[i].value;
						array_cnt++;
					}
				}
			}
				 $.ajax({
				 type:"post",
				 url:"${pageContext.request.contextPath}/product/delete_cart",
				 data : {
						checkboxArray:checkboxArray,"${_csrf.parameterName}": '${_csrf.token}'
					},
				 success:function() {
					 location.reload(true);
					 alert("삭제 되었습니다.")
				}
			});   
			
		})
		// 선택주문
		$("#selectOrder").on("click", function(){
			var checkboxArray = Array(); 
			var array_cnt = 0;
			var checkbox = $("input[name=cartProductIdx]:checked");
			var $confirm = confirm("주문 페이지로 이동 하시겠습니까?");
			if(checkbox.length<1)
				alert("1개 이상 선택해주세요");
			
			else if($confirm==true){
				for(i=0; i<checkbox.length;i++){
					if(checkbox[i].checked==true){
						checkboxArray[array_cnt] = checkbox[i].value;
						array_cnt++;
					}
				}
				var $form = $("#cartList").attr("method","get").attr("action","${pageContext.request.contextPath}/product/cart_order");
				 
				$("input[name=cartProductIdx]:checked").serializeArray();
				console.log($("input[name=cartProductIdx]:checked").serializeArray());
				$form.submit();
			}
		})
		// 전체주문
		$("#AllOrder").on("click", function(){
			$("input[name=cartProductIdx]").attr("checked","checked");
			var checkboxArray = Array(); 
			var array_cnt = 0;
			var checkbox = $("input[name=cartProductIdx]:checked");
			var $confirm = confirm("주문 페이지로 이동 하시겠습니까?");
			if($confirm==true){
				for(i=0; i<checkbox.length;i++){
					if(checkbox[i].checked==true){
						checkboxArray[array_cnt] = checkbox[i].value;
						array_cnt++;
					}
				}
				var $form = $("#cartList").attr("method","get").attr("action","${pageContext.request.contextPath}/product/cart_order");
				 
				$("input[name=cartProductIdx]:checked").serializeArray();
				console.log($("input[name=cartProductIdx]:checked").serializeArray());
				$form.submit();
			}
		})
		//전체 선택
		$("input[data-name=selectAll]").on("click", function(){
			$("input[name=cartProductIdx]").prop('checked',function(){
		        return !$(this).prop('checked');
			})
		 });
		
		
	})
	
</script>
</head>
<body>

	<div class="container">
		<ol class="breadcrumb">
			<li><a href="#"><span class="glyphicon glyphicon-home" aria-hidden="true"></span></a></li>
			<li class="active">장바구니</li>
		</ol>
		<!--//경로-->
		<div class="page-header clearfix">
			<h1>장바구니</h1>
		</div>
		<form id="cartList">
		
		</form>                          
		<div class="clearfix mgb20">
			<button id="deleteSelect" type="button">선택삭제</button>
			<button id="deleteAll" type="button">전체삭제</button>
		</div>	
		<div class="border-dashed mgb20">
		<h4 class="text-right mgb5">최종결제금액 <strong class="text-primary" id="totalPrice">0</strong>원</h4>
		<div class="text-right">
			<button class="btn btn-line btn-lg" type="button" id="selectOrder">선택한 작품구매</button> 
			<button class="btn btn-pink" type="button" id="AllOrder">전체 작품구매</button></div>
		</div> 
	</div>
	
</body>
	</html>