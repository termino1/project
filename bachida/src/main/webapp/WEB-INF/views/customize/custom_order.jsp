<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="/bachida/js/materialize.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="/bachida/css/materialize.min.css"  media="screen,projection"/>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function printOpinion($opinionList,$bid,$name,$artisan){
	var $div0 = $("#chat");
	$div0.empty();
	$div0.css("background-color","aliceblue");
	console.log($bid);
	console.log("작가정보!!");
	console.log($artisan);
	
	$.each($opinionList,function(i,opinion){
		var $div_clear = $("<div></div>").appendTo($div0);
		var $div = $("<div></div>").appendTo($div_clear);
				 
		 if($name==opinion.id){ // 로그인한 사람이 쓴 글 : 오른쪽
			 $div.addClass("pull-right");
			 $div_clear.addClass("clearfix");
			 
			 if(opinion.originalFileName!=null){
					$("<img class='materialboxed'>").attr("src","/bachida/user/displayFile?savedFileName="+opinion.savedFileName+"&originalFileName="+opinion.originalFileName).css("width","300px").appendTo($div);
					$("<br>").appendTo($div);
				}
			 $("<span></span>").text(opinion.writeDate).css({"font-size":"smaller","margin-right":"5px"}).appendTo($div);
			 var content_div = $("<div></div>").appendTo($div);
				content_div.css({"background-color":"yellow","margin-right": "15px",
			    "padding": "6px","display":"inline-block","max-width":"300px"});
				$("<span></span>").text(opinion.content).appendTo(content_div);
				
				$("<br><br>").appendTo($div);
				
		 } else{
			 var link = $("<a class='dropdown-button'></a>").attr("data-activates","dropdown2").attr("data-beloworigin","true").attr("href","#").appendTo($div);
			 var $idDiv = $("<div class='chip'></div>").appendTo(link);
			 link.attr("data-id",opinion.id);
			 $("<br>").appendTo($div);
			
			 if(opinion.id==$bid.artisanId){ // 작성자가 작가라면... 썸네일 사진추가 artisan 정보 가져오기..
					console.log("실행@@");
				 $("<img>").attr("src","/bachida/user/displayFile?savedFileName="+$artisan.savedFileName+"&originalFileName="+$artisan.originalFileName).appendTo($idDiv);
			 	console.log($artisan);
					$("<span></span>").text(opinion.id).appendTo($idDiv);
			 }else{
				 console.log("유저부분");
				 $("<img>").attr("src","https://loremflickr.com/80/80").appendTo($idDiv);
				 $("<span></span>").text(opinion.id).appendTo($idDiv);
			 }
			 
			 if(opinion.originalFileName!=null){
					$("<img class='materialboxed'>").attr("src","/bachida/user/displayFile?savedFileName="+opinion.savedFileName+"&originalFileName="+opinion.originalFileName).css("width","300px").appendTo($div);
					$("<br>").appendTo($div);
				}
				var content_div = $("<div></div>").appendTo($div);
				content_div.css({"background-color":"white","margin-left": "61px",
			    "padding": "6px","display":"inline-block","max-width":"300px"});
				$("<span></span>").text(opinion.content).appendTo(content_div);
				$("<span></span>").text(opinion.writeDate).css({"font-size":"smaller","margin-left":"5px"}).appendTo($div);
				$("<br><br>").appendTo($div);
		 }
	});
	var objDiv = document.getElementById("chat"); 
	 objDiv.scrollTop = objDiv.scrollHeight;
}


$(function(){
	var $map = ${map};
	console.log($map);
	var $bid = $map.bid;
	console.log($bid);
	var $custom = $map.custom;
	var $opinionList = $map.opinionList;
	var $attach = $map.attach;
	var $order = $map.order;
	var $name=${name};
	var $artisan = $map.artisan;
	// 요청글 채워넣기
	
	$("#c_title").text($custom.title).css({"font-size":"large","font-weight":"bold","margin-left":"150px"});
	var c_id = $("#c_id").text($custom.id);
	var $drop_link = $("<a class='dropdown-button'></a>").attr("data-activates","dropdown2").attr("data-beloworigin","true").attr("href","#");
	c_id.wrapInner($drop_link);
	$("#c_wishPrice").text($custom.wishPrice);
	$("#c_closingDate").text($custom.closingDate);
	// append? 첨부파일;
	if($custom.savedFileName!=null)
		$("#c_attach").attr("src","/bachida/user/displayFile?savedFileName="+$custom.savedFileName+"&originalFileName="+$custom.originalFileName);
	$("#c_content").text($custom.content);
	
	// 입찰글
	$("#b_id").text($bid.artisanId);
	$("#b_price").text($bid.price);
	//$("#b_attach").text();
	$("#b_content").text($bid.content);
	var bidAttach = $("#b_attach");
	$.each($attach,function(i,attach){
		$("<img class='materialboxed'>").attr("src","/bachida/user/displayFile?savedFileName="+attach.savedFileName+"&originalFileName="+attach.originalFileName).attr("data-caption",attach.originalFilaName).css({"width":"60px" ,"float":"left","margin":"5px" }).appendTo(bidAttach);
		//$("<a></a>").text(attach.originalFileName).attr("href","/bachida/upload/"+$custom.savedFileName).attr("rel","lightbox").appendTo(bidAttach);	
	});
	
	printOpinion($opinionList,$bid,$name,$artisan);
	
	$("#chat_btn").on("click",function(){
		var formData = new FormData($("#chat_form")[0]);
		formData.append("bidIdx", $bid.bidIdx);
		formData.append("content",$("#op_content").val());
		formData.append("_csrf","${_csrf.token}");
		$.ajax({
			url : "/bachida/customize/write_opinion",
			type:"post",
			data:formData,
			processData:false,	// FormData 전송에 필요한 설정
			contentType:false,	// FormData 전송에 필요한 설정
			success:function(opinionList) {
				console.log(opinionList);
				$("#op_content").val("");
				$("#file").val("");
				$(".file-path").val("");
				$("#op_content").focus();
				printOpinion(opinionList,$bid,$name);
			}
		})
	});
	
	$("#op_content").on("keydown",function(e){
		if(e.keyCode==13){
			$(this).blur();
			$("#chat_btn").focus().click();
		}
	})
	
	// 의견조율 웹소켓 설정?!
			
	if($order==null){ 	// 주문서 작성 전  -> order_form,deposit,payment 비활성화 .. 작가 : order_form활성화
		if($bid.artisanId==$name){ 	// principal 에서 비교하기
			$("#deposit,#payment").attr("disabled","disabled");
			$("#order_form_div").removeClass("order_progress");
			setInterval(function() {
				$("#order_form_div").hasClass("order_progress_ing")==true? $("#order_form_div").removeClass("order_progress_ing"):$("#order_form_div").addClass("order_progress_ing");
			}, 700)
		}else{		// 일반 유저라면..
			$("#order_form,#deposit,#payment").attr("disabled","disabled");
		}
	}else if($order.state=="주문"){ // 계약금 결제 전
		if($bid.artisanId==$name){ // 작가라면
			$("#deposit,#payment").attr("disabled","disabled");
			$("#order_form_div").addClass("order_progress_ing");
		}else{
			$("#payment").attr("disabled","disabled");
			if($order.address==null){				// 주소입력전
				$("#order_form_div").removeClass("order_progress");
				setInterval(function() {
					$("#order_form_div").hasClass("order_progress_ing")==true? $("#order_form_div").removeClass("order_progress_ing"):$("#order_form_div").addClass("order_progress_ing");
				}, 700)
				$("#deposit").attr("disabled","disabled");
			}else{ 
				$("#order_form_div").addClass("order_progress_ing");
				$("#div1").css("background-color","lightcoral");
				$("#deposit_div").removeClass("order_progress");
				setInterval(function() {
					$("#deposit_div").hasClass("order_progress_ing")==true? $("#deposit_div").removeClass("order_progress_ing"):$("#deposit_div").addClass("order_progress_ing");
					}, 700)
				}
		}
	}else if($order.state=="제작"){	// 계약금 입금 후
		if($bid.artisanId==$name){ // 작가라면
			$("#deposit_img").text("check");
			$("#deposit").text("제작완료").attr("id","making").removeAttr("data-target");		// 클릭하면 -> 상태 업데이트 (작가가 누르면//) id변경?12/06
			$("#payment").attr("disabled","disabled");
			$("#div1").css("background-color","lightcoral");
			$("#order_form_div ,#deposit_div").addClass("order_progress_ing");
			/* setInterval(function() {
				$("#deposit_div").hasClass("order_progress_ing")==true? $("#deposit_div").removeClass("order_progress_ing"):$("#deposit_div").addClass("order_progress_ing");
				}, 700) */
			
		}else{
			// 계약금 이미지 체크표시
			$("#deposit_img").text("check");
			$("#order_form_div").addClass("order_progress_ing");
			$("#deposit_div").addClass("order_progress_ing");
			$("#deposit,#payment").attr("disabled","disabled");	
		}
	
	}else if($order.state=="제작완료"){
		if($bid.artisanId==$name){
			$("#deposit_img").text("check");
			$("#deposit").text("제작완료");
			$("#payment,#deposit").attr("disabled","disabled");
			$("#div1").css("background-color","lightcoral");
			$("#order_form_div,#deposit_div").addClass("order_progress_ing");
			$("#payment_div").removeClass("order_progress");
			setInterval(function() {
				$("#payment_div").hasClass("order_progress_ing")==true? $("#payment_div").removeClass("order_progress_ing"):$("#payment_div").addClass("order_progress_ing");
				}, 700)
		}else{
			$("#deposit_img").text("check");
			$("#order_form_div,#deposit_div").addClass("order_progress_ing");
			$("#div2,#div1").css("background-color","lightcoral");
			$("#deposit").attr("disabled","disabled").text("제작완료");	
			$("#payment_div").removeClass("order_progress");
			setInterval(function() {
				$("#payment_div").hasClass("order_progress_ing")==true? $("#payment_div").removeClass("order_progress_ing"):$("#payment_div").addClass("order_progress_ing");
				}, 700)
		}
	}else if($order.state=="결제완료"){
		if($bid.artisanId==$name){
			$("#deposit_img , #payment_img").text("check");
			$("#order_form_div,#deposit_div").addClass("order_progress_ing");
			$("#div2,#div1").css("background-color","lightcoral");
			$("#payment").text("배송").attr("id","delivery").attr("data-target","myModel4");
			$("#payment_div").text("결제완료");
			$("#deposit").attr("disabled","disabled").text("제작완료");	
			$("#payment_div").removeClass("order_progress");
			setInterval(function() {
				$("#payment_div").hasClass("order_progress_ing")==true? $("#payment_div").removeClass("order_progress_ing"):$("#payment_div").addClass("order_progress_ing");
				}, 700)
		}else{
			$("#deposit_img, #payment_img").text("check");
			$("#order_form_div,#deposit_div,#payment_div").addClass("order_progress_ing");
			$("#div2,#div1").css("background-color","lightcoral");
			$("#deposit,#payment").attr("disabled","disabled");	
			$("#payment,#payment_div").text("결제완료");
		}
	}else if($order.state=="배송"){
		if($bid.artisanId==$name){
			$("#deposit_img , #payment_img").text("check");
			$("#order_form_div,#deposit_div,#payment_div").addClass("order_progress_ing");
			$("#div2,#div1").css("background-color","lightcoral");
			$("#payment_div").text("배송");
			$("#deposit_div").text("결제완료");
			$("#deposit").attr("disabled","disabled");
			$("#deposit").text("제작완료");
			$("#payment").text("운송장 정보").attr("id","parcel_check").attr("data-target","myModal4");
		}else{
			$("#deposit_img , #payment_img").text("check");
			$("#order_form_div,#deposit_div,#payment_div").addClass("order_progress_ing");
			$("#div2,#div1").css("background-color","lightcoral");
			$("#payment_div").text("배송");
			$("#payment").text("운송장 정보").attr("id","parcel_check").attr("data-target","myModal4");
			$("#deposit_div").text("제작완료");
			$("#deposit").attr("disabled","disabled");
			$("#deposit").text("결제완료");
		}
	}
	
	
	// 주문(작) -> 제작(고) -> 제작완료(작) -> 결제완료(고) -> 배송(작) -> 배송완료(고)
	// 작가 : 주문서 폼 올리기 (모달)
	$("#order_form").click(function(){
		$("#id").val($custom.id);
		$("#artisanId").val($bid.artisanId);
		if($bid.artisanId==$name){		// 작가가 클릭 	principal.getName();
			if($order!=null){
				$("#price").val($order.price);
		        $("#quantity").val($order.quantity);
		        $("#content").val($order.content);
		        $("#address").val($order.address);
		        $("#insert_order_btn").val("주문서 수정").attr("id","update_order_btn");
			}
			
			if($order.state=='결제완료' || $order.state=='배송'){
				$("#price").attr("readonly","readonly");
		        $("#quantity").attr("readonly","readonly");
		        $("#content").attr("readonly","readonly");
		        $("#addressArea").hide();
			}	
			$("#myModal").modal('open');
		}else{										//일반유저
			console.log("실행@@@#@#")
			$("#price").val($order.price).attr("readonly","readonly");
	        $("#quantity").val($order.quantity).attr("readonly","readonly");
	        $("#content").val($order.content).attr("readonly","readonly");
	        $("#address").val($order.address);	
	        $("#insert_order_btn").val("주소입력").attr("id","insert_address");
	        if($order.state=="배송"){
	        	console.log($order.state);
	        	/* $("#address").attr("readonly","readonly"); */				//배송 후엔 주소변경 금지...
	        	$("#addressArea").hide();
	        	$("#insert_address").attr("disabled","disabled");
	        }
	        	       
	        $("#myModal").modal('open');	
		}
		
    });
	
	// ajax? -> 작성완료! -> 모달 종료 -> 페이지 리로드?
	 $("#modal-body").on("click","#insert_order_btn",function(e){
		e.preventDefault();
		if(confirm("작성하시겠습니까?")){
			$("<input type='hidden' name='bidIdx'>").val($bid.bidIdx).appendTo($("#form"));
			 $.ajax({
				url:"/bachida/customize/write_productionOrder" ,
				type:"post" ,
				data: $("#form").serialize()  ,
				success:function(result){
					alert("작성완료!");
					// 모달종료 , 페이지 리로드;
					$("#myModal").modal("close")
					location.reload(true); 		
				}
			});
		}
	}); 
	
	// 고객 : 견적서(주문서) 보기, 주소입력
	$("#modal-body").on("click","#insert_address",function(e){
		e.preventDefault();
		if(confirm("작성하시겠습니까?")){
			// input에 배송지(address) 합치기 : (우편번호)주소, 상세주소 
			$("<input type='hidden' name='address' value='"+ "(" + $("#sample6_postcode").val() + ")" + $("#sample6_address").val() + ", " + $("#sample6_address2").val() +"'>").appendTo($addr_form);
			var $addr_form = $("<form></form>").appendTo($("#modal-body"));
			$("<input type='hidden' name='productionOrderIdx'>").val($order.productionOrderIdx).appendTo($addr_form);
			$("<input type='hidden' name='address'>").val($("#address").val()).appendTo($addr_form);
			$("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>").appendTo($addr_form);
			 $.ajax({
				url:"/bachida/customize/write_address_productionOrder" ,
				type:"post" ,
				data: $addr_form.serialize()  ,
				success:function(result){
					alert("작성완료!");
					// 모달종료 , 페이지 리로드;
					$("#myModal").modal("close")
					location.reload(true); 		
				}
			}); 
		}
	});
	
	
	// 주문서 수정
	$("#modal-body").on("click","#update_order_btn",function(e){
		e.preventDefault();
		if(confirm("주문서 수정하시겠습니까?")){
			$("<input type='hidden' name='address' value='"+ "(" + $("#sample6_postcode").val() + ")" + $("#sample6_address").val() + ", " + $("#sample6_address2").val() +"'>").appendTo($("#form"));
			$("<input type='hidden' name='productionOrderIdx'>").val($order.productionOrderIdx).appendTo($("#form"));
			 $.ajax({
				url:"/bachida/customize/update_productionOrder" ,
				type:"post" ,
				data: $("#form").serialize()  ,
				success:function(result){
					alert("수정완료!");
					// 모달종료 , 페이지 리로드;
					$("#myModal").modal("close")
					location.reload(true); 		
				}
			});
		}
	})
	
	
	
	// 고객 : 계약금 결제 -> 상태 변화 (제작)
	$("#deposit").on("click",function(){
		$.ajax({
			// order 에서 총액,계약금// user정보 가져오기(cash)
			url:"/bachida/customize/user_cash" ,
			success:function(cash){
				$("#total_price").text($order.price);
				$("#deposit_price").text(parseInt($order.price/10));
				$("#user_cash").text(cash);
				$("#myModal2").modal('open');
			}
			
		});
		 
	});
	
	$("#deposit_payment").on("click",function(){
		var cash = parseInt($("#user_cash").text());
		var deposit_price = parseInt($("#deposit_price").text());
		var balance = cash-deposit_price;
		if(balance<0)
			alert("캐시 충전 후 결제 해주세요");
		else{
			if(confirm("계약금 결제 고?")){
				//var $deposit_form = $("<form></form>").appendTo("#deposit_modal");
				$.ajax({
					url:"/bachida/customize/deposit_payment" ,
					type: "post" ,
					data: "cash="+ $("#deposit_price").text()+"&productionOrderIdx="+$order.productionOrderIdx + "&${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(result){
						if(result){
							alert("결제완료!");
							$("#myModal2").modal("close")
							location.reload(true); 	
						}
					}
				});	
			}
			
		}
	});
	
	// 작가 : 제작완료 후 클릭 -> 제작완료 상태 변화, 잔금결제 활성화
	
	$(document).on("click","#making",function(){
		if(confirm("제작완료 처리하시겠습니까?")){
			$.ajax({
				url:"/bachida/customize/complete_production",
				type:"post",
				data:"productionOrderIdx="+$order.productionOrderIdx + "&${_csrf.parameterName}=" + "${_csrf.token}",
				success:function(result){
					if(result)
						alert("처리완료");
					location.reload(true);
				}
			});
		}
	})
	
	
	// 고객 : 잔금결제 -> 상태변화(결제완료)
	$("#payment").on("click",function(){
		$.ajax({
			// order 에서 총액,계약금// user정보 가져오기(cash)
			url:"/bachida/customize/user_cash" ,
			success:function(cash){
				var total = $order.price; 
				var depositPrice = parseInt($order.price/10)
				$("#total_price2").text(total+" 원");
				$("#deposit_price2").text(depositPrice+" 원");
				$("#user_cash2").text(cash+" 원");
				$("#balance_price2").text(total-depositPrice+" 원");
				$("#payment_price").text(total-depositPrice);
				$("#myModal3").modal('open');
			}
			
		});
		 
	});
	
	$("#balance_payment").on("click",function(){
		var cash = parseInt($("#user_cash2").text());
		var payment_price = parseInt($("#payment_price").text());
		var total_price2 = parseInt($("#total_price2").text());
		var left = cash-payment_price;
		if(left<0)
			alert("캐시 충전 후 결제 해주세요");
		else{
			if(confirm("잔금 결제 고?")){
				$.ajax({
					url:"/bachida/customize/balance_payment" ,
					type: "post" ,
					data: "balance="+ $("#payment_price").text()+"&productionOrderIdx="+$order.productionOrderIdx + "&totalPrice="+total_price2 + "&artisanId="+$bid.artisanId + "&${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(result){
						if(result){
							alert("결제완료!");
							$("#myModal3").modal("close")
							location.reload(true); 	
						}
					}
				});	 
			}
			
		}
	});
	
	// 작가 : 배송 누르면 -> 택배이름, 운송장 입력후 확인 -> 주문상태 [배송], 택배 업데이트//
	$(document).on("click","#delivery",function(){
		$("#myModal4").modal('open');	
	});
	$("#delivery_btn").on("click",function(){
		if(confirm("배송처리 할까요?")){
			var $delevery_form = $("#delivery_form");
			$("<input type='hidden' name='productionOrderIdx'>").val($order.productionOrderIdx).appendTo($delevery_form);
			$.ajax({
				url:"/bachida/customize/parcel_update" ,
				type: "post" ,
				data: $delevery_form.serialize(),
				success:function(result){
					if(result){
						alert("처리완료!");
						$("#myModal4").modal("close")
						location.reload(true); 	
					}
				}
			});	 
		}
	});
	// 운송장 정보 클릭
	$(document).on("click","#parcel_check",function(){
		if($bid.artisanId==$name){
			$("#parcelIdx").val($order.parcelIdx);
			$("#parcelName").val($order.parcelName).attr("selected","selected");
			$("#delivery_btn").val("배송정보 수정");
		}else{
			$("#parcelIdx").val($order.parcelIdx).attr("readonly","readonly");
			$("#parcelName").val($order.parcelName).attr("selected","selected").attr("readonly","readonly");
			$("#parcelName").attr("disabled","disabled");
			$("#delivery_btn").attr("type","hidden");
		}
		 $('select').material_select();
		$("#myModal4").modal('open');	
	});
	
	// 쪽지드롭다운
	$("#dropdown2").on("click",".msgDrop",function(e){
		e.preventDefault();
		var receiver = $("#chat").find("a.active").attr("data-id");
		window.open("/bachida/user/msgWriteForm?receiver="+receiver,"쪽지함","width=850,height=500");			
		//window.open("/bachida/user/msgWriteForm?receiver="+receiver);
	});
	
	// 신고 드롭다운
	$("#dropdown2").on("click",".reportDrop",function(e){
		e.preventDefault();
		var reportId = $("#chat").find("a.active").attr("data-id");
		//var receiver = $("td").find("a.active").attr("data-id");
		window.open("/bachida/user/writeReport/"+reportId,"회원신고","width=850,height=500");			
		//window.open("/bachida/user/msgWriteForm?receiver="+receiver);
	});
	 
	$('.dropdown-button').dropdown({
		      inDuration: 300,
		      outDuration: 225,
		      constrainWidth: false, // Does not change width of dropdown to that of the activator
		      hover: false, // Activate on hover
		      gutter: 0, // Spacing from edge
		      belowOrigin: true, // Displays dropdown below the button
		      alignment: 'right', // Displays dropdown with edge aligned to the left of button
		      stopPropagation: false // Stops event propagation
		    }
		  );
	$('select').material_select();
	$('.materialboxed').materialbox();
	$('.modal').modal();
})
// 다음 주소 api
function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
<style>
	
	#chat{
		height: 450px;
		width: 850px;
		border: 1px solid grey;
		overflow-y:auto;
		margin: 0 auto;
	}
	.order_state{
		width:200px;
		height: 250px;
		border: 1px solid grey;
		float: left;
		margin-right: 30px;
	}
	.order_img{
		width: 200px;
		height: 100px;
		border-bottom: 1px solid grey;
		text-align: center;
    line-height: 100px;
		
	}
	.basic_style{
		width: 200px;
		height: 50px;
		border-bottom: 1px solid grey;
		text-align: center;
  		  line-height: 50px;
	}
	.order_progress{
  		  background-color: darkgray;
	}
	
	.order_progress_ing{
  		 color:white;
		background-color : lightcoral;
	}
	
	div button{
		width: -webkit-fill-available;
   		height: 60px;
        margin-top: 20px;
	}
	.progress{
		width: 5px;
		height: 5px;
		background-color:darkgray; 
		float: left;
		margin-right: 30px;
		margin-top: 125px;
	}
	th{
		width:70px;
	}
	.row{
		    margin-left: auto;
    margin-right: auto;
    margin-bottom: 20px;
	}
	#content{
		height: inherit;
	}
		.container{
width: 1000px !important;
}
#dropdown2{
	min-width: 42px;
}
	.dropdown-content li{
		min-height: 0;
	}
		.dropdown-content li>a{
		font-size : 13px;
		padding: 5px 6px 0 8px;
	}
</style>
</head>
<body>      
<div class="container">  
	<ul class="collapsible" data-collapsible="expandable">
    <li>
      <div class="collapsible-header" style="font-weight: bold">요청글  CLICK</div>
      <div class="collapsible-body">
      	<span>작성자 : </span><span id="c_id">요청인</span> <span id="c_title">글제목</span> 
      	<table class="responsive-table">
      		<tr><th>희망금액</th><td id="c_wishPrice">1000</td><th>마감기한</th><td id="c_closingDate">12/20</td></tr>
      		<tr><th>내용</th><td colspan="3"><img id="c_attach" class="materialboxed" width="300px"><div id="c_content"></div></td></tr>
      	</table>
      </div>
    </li>
    <li>
      <div class="collapsible-header" style="font-weight: bold">낙찰글  CLICK</div>
      <div class="collapsible-body">
      	<span>작성자 : </span> <a class="dropdown-button" data-activates='dropdown2' href="#"  id="b_id"></a>
      	<table class="responsive-table">
      		<tr><th>금액</th><td id="b_price">10000</td><th>첨부</th><td id="b_attach"></td></tr>
      		<tr><th>내용</th><td colspan="3" id="b_content"> </td></tr>
      	</table>
      
      </div>
    </li>
   
    
  </ul>
	  
	   
    <!-- dropdown -->     
	<ul id="dropdown2" class="dropdown-content">  
		<li><a class='msgDrop'>쪽지</a></li>    
		<li><a class='reportDrop'>신고</a></li>
	</ul>
      
    
	<hr>
	<div style="width:280px; margin:0 auto ;margin-bottom: 30px;" id="orderStateDiv">
		<a href="#orderStateDiv" style="padding:10px;"><i class="small material-icons">build</i>제작상황</a>
        <a href="#chatDiv" style="padding:10px;"><i class="small material-icons">chat_bubble_outline</i>의견조율</a>
	</div>  
   <div class="clearfix" style="width:760px; margin:0 auto " >
		<div class="order_state">
			<div class="order_img"><i class="medium material-icons" style="line-height: inherit">description</i></div>
			<div class="order_progress basic_style" id="order_form_div">주문서</div>
			<button id="order_form"  data-target="myModal" class="modal-trigger btn-large">주문서</button>
		</div>
		<div id="div1" class="progress order_state"></div>
		<div class="order_state">
			<div class="order_img" ><i class="medium material-icons" style="line-height: inherit" id="deposit_img">payment</i></div>
			<div class="order_progress basic_style" id="deposit_div">계약금</div>
			<button id="deposit" data-target="myModal2" class="modal-trigger btn-large">계약금</button>
		</div>
		<div id="div1" class="progress order_state"></div>
		<div class="order_state">
			<div class="order_img" ><i class="medium material-icons" style="line-height: inherit" id="payment_img">payment</i></div>
			<div class="order_progress basic_style" id="payment_div">제작완료</div>
			<button id="payment" data-target="myModal3" class="modal-trigger btn-large">잔금결제</button>
		</div>
	</div>
	  
	<hr>             
	<div style="width:280px; margin:0 auto ;margin-bottom: 30px;" id="chatDiv">
		<a href="#orderStateDiv" style="padding:10px;"><i class="small material-icons">build</i>제작상황</a>
        <a href="#chatDiv" style="padding:10px;" ><i class="small material-icons">chat_bubble_outline</i>의견조율</a>
	</div>  
	<div id="chatDiv">
	<div id="chat">
		입력화면    
		
	</div>
	<div class="clearfix">
	<div class="row">
		<form class="col s10" id="chat_form" action="/bachida/customize/write_opinion" method="post" enctype="multipart/form-data" style="margin-left: 170px;">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="file-field input-field row" style="margin-left: 7px;">    
					<div class="btn">
						<span>File</span> <input type="file"  id="file" name="file" >
					</div>
					<div class="file-path-wrapper">
						<input class="file-path validate" type="text">
					</div>  
			</div>
			<div class="row" style="margin-top: -41px;">
				<div class="input-field col s9">
					<textarea id="op_content" class="materialize-textarea"></textarea>
					<label for="op_content">내용</label>
				</div>
				<a class="waves-effect waves-light btn col s1" id="chat_btn" style="margin-top: 53px;">입력</a> 
			</div>
			
			
		</form>
	</div>
	</div>
	</div>
<!-- Modal -->  

      
	<div class="modal" id="myModal" role="dialog">  
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px;">
					<h4> 
						주문서
					</h4>
				</div>
				<div class="modal-body" style="padding: 40px 50px;" id="modal-body">
					<form id="form">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						구매자<input type="text" name="id" id="id" readonly="readonly"><br>
						판매자<input type="text" name="artisanId" id="artisanId" readonly="readonly"><br>
						가격<input type="number" id="price" name="price"><br>
						수량<input type="number" id="quantity" name="quantity"><br>
						내용<textarea rows="5px" cols="60px" id="content" name="content"> ※자세히 작성해주세요
마감기한 : 
상세내역 : </textarea><br>
						기존주소<input type="text" id="address" readonly="readonly">
						<div id="addressArea">
						<input type="text" id="sample6_postcode" class="form-control" placeholder="우편번호">
								<input type="button" onclick="sample6_execDaumPostcode()" class="btn btn-default" value="우편번호 찾기"><br>
								<input type="text" id="sample6_address" class="form-control" placeholder="주소">
								<input type="text" id="sample6_address2" class="form-control" placeholder="상세주소">
						<input type="button" id="insert_order_btn" class="btn btn-success" value="주문서 작성">
						</div>
					</form>
				</div>  
				<div class="modal-footer">  
					<button type="submit" class="btn modal-close">
						<span class="glyphicon glyphicon-remove"></span> cancle
					</button>
					
				</div>
			</div>   
	</div>            
                                       
<!--계약금 결제 Modal2 -->
  <div class="modal" id="myModal2" role="dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">계약금 결제</h4>
        </div>
        <div class="modal-body" id="deposit_modal">
          <table>
			<tr><td>총액</td><td id="total_price"></td></tr>
			<tr><td>계약금</td><td id="deposit_price"></td></tr>
          </table>
          <hr>
          <div>  
          	보유캐시 : <span id="user_cash"></span>
          </div>
          <button id="deposit_payment" class="btn">계약금 결제</button>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn modal-close" >Close</button>
        </div>
      </div>
                
    </div>

     
<!--잔금 결제 Modal3 -->
  <div class="modal" id="myModal3" role="dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">잔금 결제</h4>
        </div>
        <div class="modal-body" id="deposit_modal">                  
          <table>
			<tr><td>총액 : </td><td id="total_price2"></td></tr>   
			<tr><td>계약금 : </td><td id="deposit_price2"></td></tr>
			<tr><td>잔금 : </td><td id="balance_price2"></td></tr>
          </table>
          <hr>
          <div>
          	결제금액 : <span id="payment_price" name="balance"></span><span> 원</span>
          </div>
          <hr>  
             
          <div>  
          	보유캐시 : <span id="user_cash2"></span>
          </div>
          <button id="balance_payment" class="btn">잔금 결제</button>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn modal-close" >Close</button>
        </div>
      </div>
                
  </div>   

<!--배송 Modal4 -->
  <div class="modal" id="myModal4" role="dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">     
          <h4 class="modal-title">배송</h4>
        </div>
        <div class="modal-body" id="delivery_modal">
        <form id="delivery_form">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <div class="input-field">
          <select name="parcelName" id="parcelName">  
          	<option value="" disabled selected id="default">Choose your option</option>
          	<option value="우체국택배">우체국택배</option>
          	<option value="CJ대한통운">CJ대한통운</option>
          	<option value="로젠택배">로젠택배</option>
          	<option value="한진택배">한진택배</option>
          	<option value="현대택배">현대택배</option>
          </select>
          </div>
          <br>
          <input type="number" placeholder="운송장번호" name="parcelIdx" id="parcelIdx"><br> 
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