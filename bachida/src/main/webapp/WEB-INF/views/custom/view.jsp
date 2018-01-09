<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
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
 <script type="text/javascript" src="/bachida/js/slimbox2.js"></script>
<link rel="stylesheet" href="/bachida/css/slimbox2.css" type="text/css" media="screen" />
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
var $today = yyyy+'-'+mm+'-'+dd;
 function printBid($bidList,$attachList,$name,$writer,$artisan){
	// 입찰리스트 보여주기
	var $bid_div = $("#bid");
	$bid_div.empty();
	if($bidList.length==0)
		$("<p></p>").text("입찰내역이 없습니다.").css("font-weight",'bold').css("text-align","center").css("line-height","100px").appendTo($bid_div);
	
	$.each($bidList,function(idx,bid){
		var $div = $("<div></div>").appendTo($bid_div);
		$.each($artisan,function(index,a){
			if(bid.artisanId==a.artisanId)
				$("<span></span>").text(a.artisanName).appendTo($div);
		})
		$("<span></span><br>").text(bid.writeDate).css("margin-left","5px").appendTo($div);
		// 입찰attach 있는지 확인 -> 있으면 ul 생성
		for(var i=0; i<$attachList.length; i++){
			// bid.bid_idx==리스트[i].리스트[i].no??
			var $list = $attachList[i];
			if($list!=""){ 		// true 리스트 들어있음
				if(bid.bidIdx==$list[0].bidIdx){
					var $ul_div = $("<div></div>").appendTo($div);
					//var $ul_div = $("<div class='clearfix'></div>").appendTo($div);
				//	var $ul = $("<ul class='sliders'></ul>").appendTo($ul_div);
					$.each($list, function(i, attach){
	
						//$("<a></a>").text(attach.originalFileName).attr("rel","lightbox-"+attach.bidIdx).attr("href","/bachida/upload/"+attach.savedFileName).attr("title",attach.originalFileName).appendTo($ul_div);
		
						$("<img class='materialboxed'>").attr("src","/bachida/user/displayFile?savedFileName="+attach.savedFileName+"&originalFileName="+attach.originalFileName).attr("data-caption",attach.originalFilaName).css({"width":"60px" ,"float":"left","margin":"5px" }).appendTo($ul_div);
					});
				}
			}
		}
		var priceSpan = $("<span></span>").text("금액 : ").appendTo($div);
		$("<span></span>").text(bid.price).appendTo($div);
		$("<span></span>").text("원").appendTo($div);
		$("<div></div>").text(bid.content).appendTo($div);
		
		 
		// 글쓴사람 낙찰버튼 어떻게 보이게하징...
		if($name==$writer){ 	// 로그인한 사용자가 글 쓴 사람이라면
			$("<input type='button'>").addClass("bid_successful_btn btn pull-right").val("낙찰").attr("data-id",bid.bidIdx).css("margin-right","30px").insertBefore(priceSpan);
			$("<hr>").appendTo($div);
		}else
			$("<hr>").appendTo($div);
			
		
		if(bid.state=="낙찰"){
			$div.css("border","3px solid blue");
		}
	})
}

	$(function(){
		
		$("#search").hide();
		var $map = ${map};
		var $custom = $map.custom;
		var $bidList = $map.bidList;
		var $attachList = $map.attachList;
		var $name = ${name};		// 로그인한 사람 winter
		var $writer = $custom.id;
		var $artisan = $map.artisan;
		console.log($custom);
		$("#custom_title").text($custom.title);
		$("#custom_id").text($custom.id);
		$("#custom_write_date").text($custom.writeDate);
		$("#custom_state").text($custom.state);
		$("#custom_closing_date").text($custom.closingDate).css("font-size","large");
		
		var closingDate = $custom.closingDate;
		var dateArray = closingDate.split("-");
		var dateObj = new Date(dateArray[0],Number(dateArray[1])-1,dateArray[2]);
		var today = new Date();
		var betweenDay = (today.getTime() - dateObj.getTime()) / 1000 / 60 / 60 / 24;
		var dDay = parseInt(betweenDay)-1;
		console.log(dDay);
		if(dDay>=0){
			$("<div class='pull-right'></div>").text("D+"+(dDay+1)).css({"font-size":"xx-large","padding-right":"30px"}).appendTo("#closingDate_td");
		}else {
			$("<div class='pull-right'></div>").text("D"+dDay).css({"font-size":"xx-large","padding-right":"30px"}).appendTo("#closingDate_td");
		}
		
		
		$("#custom_wish_price").text($custom.wishPrice).css("font-size","large");
		
		if($custom.savedFileName!=null)
			$("#custom_attach").attr("src","/bachida/user/displayFile?savedFileName="+$custom.savedFileName+"&originalFileName="+$custom.originalFileName);
		
		$("#custom_content").html($custom.content);
		$("#custom_quantity").text($custom.quantity).css("font-size","large");
		// 입찰리스트 뿌리기
		printBid($bidList,$attachList,$name,$writer,$artisan);
		
		$("#bid_insert_btn").on("click",function(){
			var formData = new FormData($("#bid_form")[0]);
			formData.append("customIdx", $custom.customIdx);
			formData.append("_csrf", '${_csrf.token}');
			$.ajax({
				url : "/bachida/custom/write_bid",
				type:"post",
				data:formData,
				processData:false,	// FormData 전송에 필요한 설정
				contentType:false,	// FormData 전송에 필요한 설정
				success:function(bidList) {
					var $bidList = bidList.bidList;
					var $attachList = bidList.attachList;
					$("#price").val("");
					$("#content").val("").trigger('autoresize');
					$("#files").val("");
					$(".file-path").val("");
					printBid($bidList,$attachList,$name,$writer);
					location.reload(true);
				}
			})
		});
		
		if($custom.state!="요청" || dDay>=0){
			$(".bid_successful_btn").addClass("disabled").attr("disabled","disabled");
			$("#content, #files, #price").attr("disabled","disabled");
			
			$("#insert_bid").on("click",function(){
				alert("입찰 마감되었습니다");
			});
		}


		if($name==$writer && $bidList.length==0){
			
			var $info_btn = $("#info_btn");
			$("<button class='btn pull-right'></button>").attr("id","custom_update_btn").text("수정").appendTo($info_btn);
			$("<button class='btn pull-right'></button>").attr("id","custom_delete_btn").text("삭제").appendTo($info_btn);
			
		}
		
		
		// 낙찰
		
		$(document).on("click",".bid_successful_btn",function(e){
			e.preventDefault();
			if(confirm("낙찰하시겠습니까?")){
				$.ajax({
					url: "/bachida/custom/bid_successful", 
					type:"post",
					data: "bidIdx="+ $(this).attr("data-id") + "&${_csrf.parameterName}=" + "${_csrf.token}" ,
					success:function(result){
						if(result){
							$(".bid_successful_btn").attr("type","hidden");
							alert("낙찰되었습니다");
							location.reload(true);
						}
					}
				});
			}
			
			// 낙찰된 입찰글 -> 상태 업데이트(낙찰)
			// 나머지 입찰글 -> 상태 업데이트(마감)
			// 제작요청글 -> 상태 업데이트(낙찰)
		})
		
		// 수정, 삭제 버튼 (입찰글 없을때만)
		
		$(document).on("click","#custom_update_btn",function(e){
			e.preventDefault();
			if(confirm("수정하시겠습니까?")){
				location.href="/bachida/custom/update_custom?customIdx="+$custom.customIdx;
			}
			
		})
		
		$(document).on("click","#custom_delete_btn",function(e){
			e.preventDefault();
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
					url:"/bachida/custom/delete_custom",
					type:"post",
					data:"customIdx=" + $custom.customIdx + "&${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(result){
						if(result)
							location.replace("/bachida/custom/list");
					}
					
				});
			}
		})
		
		// 입찰 글쓰기 : 요청상태일때만
		$('.materialboxed').materialbox();
	});
</script>
<style>
.row .col{
	margin : 6px;
}
#insert_bid td{
	padding: 0;
}
input{

	padding:0;
}
.container{
width: 1000px !important;
}
</style>
</head>
<body>        
	<div class="container">  
	<div id="main">
		<div id="center">
			<h2 id="custom_title" style="text-align: center; margin: 50px 0 80px 0"></h2>
			<div id="info">
				<table class="bordered centered responsive-table" style="margin-bottom: 70px">
					<thead>
						<tr>
							<th>상태</th>                                      
							<th>아이디</th>
							<th>등록일</th>
							<td>
								<div class="pull-right" id="closingDate_div">
									<span>마감일</span><br>
									<span id="custom_closing_date"></span>
								</div>
							</td>
							<td id="closingDate_td">
								
							</td>  
						</tr>
					</thead>                           
					<tbody>
						<tr>
							<td id="custom_state"></td>
							<td id="custom_id"></td>
							<td id="custom_write_date"></td>
							<td>
								<div class="pull-right" style="padding-right: 37px">
									<span>희망금액</span><br>
									<span id="custom_wish_price"></span>
								</div>
							</td>
							<td>
								<div class="pull-right" style="padding-right: 40px">  
									<span>수량</span><br>                              
									<span id="custom_quantity"></span>
								</div>
							</td>
						</tr>
						
					</tbody>               
				</table>
				<div id="info_btn" class="clearfix">
					
				</div>
			</div>   
		</div>
		
		<div style="text-align:center">상세정보</div>
		<hr>
		<div >
		<img id="custom_attach"  class="materialboxed" width="300px">
		</div>
		<div id="custom_content" style="min-height: 200px">
		
		</div>   
	</div>      
	<div style="text-align:center">입찰내역</div>
	<hr>  
	<div id="artisan">
		<div id="bid" style="min-height: 100px">
		<!-- 입찰내역 -->                                       
		</div>    
		<hr>                  

	<sec:authorize access="hasRole('ROLE_MANAGER')">
		<div id="insert_bid">
			<form id="bid_form" action="/bachida/custom/write_bid" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td>
							<div class="input-field">
								<input id="price" name="price" type="number" class="validate"> 
								<label for="price">가격</label>
							</div>
						</td>
						<td>
							<div class="file-field input-field">
								<div class="btn">
									<span>File</span> <input type="file" id="files" name="files"
										multiple>
								</div>
								<div class="file-path-wrapper">
									<input class="file-path validate" type="text"
										placeholder="Upload one or more files">
								</div>
							</div>
						</td>             
						<td></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="input-field">
								<textarea id="content" name="content" class="materialize-textarea" ></textarea>
								<label for="content">내용</label>
							</div>
						</td>
						<td>
							<a class="waves-effect waves-light btn" id="bid_insert_btn" style="height: 60px; line-height: 60px;">등록</a>
						</td>
					</tr>
				</table>
			</form>  
		</div>    
	</sec:authorize>	
		
		
	</div>
	<a href="/bachida/custom/list" class="btn pull-right blue-grey lighten-1">목록으로</a>
	</div>
</body>   
</html>