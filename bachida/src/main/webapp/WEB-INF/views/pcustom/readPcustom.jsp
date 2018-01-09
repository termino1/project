<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>바치:다 | 1:1제작요청 글보기</title>
<style type="text/css">
	textarea {
		resize: none;
	}
	th, h2{
		color: rgb(245, 89, 128);
	}
	#pcustom {
		text-decoration: none;
		color: rgb(245, 89, 128);
	}
	#topBtn {
    position: fixed;	/* 화면에 고정 */
    right: 2%;			/* 버튼 위치 설정 */
    bottom: 50px;
    display: none;		/* 화면에서 숨김 */
    z-index: 999;		/* 다른 태그들보다 위로 오도록 설정 */
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="/bachida/js/materialize.min.js"></script>
<script>

/* 1:1커스텀 글보기 */

// 댓글(1:1커스텀 의견조율) 가져오기
function printReply($pcustomOpinion) {
	var $id = ${id};		// 접속자 아이디
	var $pcustom = ${read};	// 1:1커스텀 요청글(게시글)
	if($id==$pcustom.id || $id==$pcustom.artisanId) {	// 댓글 내용은 글쓴이와 해당작가만 볼 수 있다
		var $replyDiv = $("#replyArea");
		$replyDiv.empty();
		$.each($pcustomOpinion, function(i, pcustomOpinion) {
			var $table = $("<table></table>").attr("class", "table table-bordered").appendTo($replyDiv);
			//console.log(pcustomOpinion.id);
			$("<span></span>").text(pcustomOpinion.id + " ").css("color", "rgb(245, 89, 128)").appendTo($table);
			$("<span></span>").text(pcustomOpinion.writeDate).appendTo($table);
			$("<tr></tr>").text(pcustomOpinion.content).appendTo($table);
			//console.log(pcustomOpinion.savedFileName);
			if(pcustomOpinion.savedFileName!=null) {	// 파일이 있을 경우
				// 사진 크기를 width=190px로 작게 만들기
				var $img = $("<img>").attr("class", "materialboxed").attr("width", "190").attr("src", "/bachida/pcustom/displayFileServe/" + pcustomOpinion.savedFileName + "/" + pcustomOpinion.pcustomOpinionIdx).appendTo($table);
			}
			// 이미지 클릭하면 원본 사이즈 이미지 띄우기
			$('.materialboxed').materialbox();
		});
	}
}

$(function() {
	var $id = ${id};		// 접속자 아이디
	console.log($id);
	var $pcustom = ${read};	// 1:1커스텀 요청글(게시글)
	console.log($pcustom);
	var $pcustomOpinion = ${readPcustomOpinion};	// 1:1커스텀 의견조율(댓글)
	console.log($pcustomOpinion);
	var $isRequestPcustom = ${isRequestPcustom};	// 1:1커스텀 요청 여부
	var $isByePcustom = ${isByePcustom};			// 1:1커스텀 거부 여부
	var $isPcustomEstimate = ${isPcustomEstimate};	// 견적서 유무
	var $isDownPaymentPcustom = ${isDownPaymentPcustom};// 계약금 결제 유무
	var $isFinallyPaymentPcustom = ${isFinallyPaymentPcustom};	// 잔금 결제 유무
	var $isDeliveryCompletedPcustom = ${isDeliveryCompletedPcustom};	// 배송완료 유무 확인
	//console.log("isRequestPcustom:"+$isRequestPcustom);
	//console.log("isByePcustom:"+$isByePcustom);
	//console.log("isPcustomEstimate:"+$isPcustomEstimate);
	//console.log("isDownPaymentPcustom:"+$isDownPaymentPcustom);
	//console.log("isFinallyPaymentPcustom:"+$isFinallyPaymentPcustom);
	//console.log("isDeliveryCompletedPcustom:"+$isDeliveryCompletedPcustom);
	
	// 게시글 읽어오기
	$("#title").val($pcustom.title);
	$("#pcustomIdx").text($pcustom.pcustomIdx);
	$("#id").text($pcustom.id);
	$("#artisanId").text($pcustom.artisanId);
	$("#writeDate").text($pcustom.writeDate);
	$("#state").text($pcustom.state);
	//$("#attach").text($pcustom.orginalFileName);
	$("#content").text($pcustom.content);
	var $ul = $("#attach");
	if($pcustom.savedFileName!=null)
		var $img = $("<img>").attr("src", "/bachida/pcustom/displayFileMain/" + $pcustom.savedFileName + "/" + $pcustom.pcustomIdx).appendTo($ul);
	$ul.wrapInner($img);

	// 글보기 페이지 버튼 컨트롤
	if($id==$pcustom.id){	// 글쓴이만 보이는 버튼
		// 글수정 버튼
		$("<button></button>").attr("id","updatePcustom").addClass("glyphicon").addClass("glyphicon-pencil").addClass("btn").addClass("btn-default").text("수정하기").appendTo("#writerBtnSpan");
		// 글삭제 버튼
		$("<button></button>").attr("id", "deletePcustom").addClass("glyphicon").addClass("glyphicon-trash").addClass("btn").addClass("btn-default").text("삭제").appendTo("#writerBtnSpan");
	}
	if($id==$pcustom.artisanId) {	// 해당작가만 보이는 버튼
		// 수락 버튼
		$("<button></button>").attr("id", "okPcustomBtn").addClass("btn").addClass("btn-default").text("수락").appendTo("#artisanBtnSpan");
		// 거부 버튼
		$("<button></button>").attr("id", "byePcustomBtn").addClass("btn").addClass("btn-default").text("거부").appendTo("#artisanBtnSpan");
		// 견적서작성 버튼
		$("<button></button>").attr("id", "insertEstimatePcustomBtn").addClass("glyphicon").addClass("glyphicon-pencil").addClass("btn").addClass("btn-default").text("견적서작성").appendTo("#artisanBtnSpan");
		// 견적서수정 버튼
		$("<button></button>").attr("id", "updatePcustomEstimateBtn").addClass("glyphicon").addClass("glyphicon-pencil").addClass("btn").addClass("btn-default").text("견적서수정").appendTo("#artisanBtnSpan");
	}
	if($id==$pcustom.id || $id==$pcustom.artisanId) {	// 글쓴이 또는 해당작가만 보이는 버튼
		// 견적서확인 버튼
		$("<button></button>").attr("id", "okEstimatePcustom").addClass("glyphicon").addClass("glyphicon-barcode").addClass("btn").addClass("btn-default").text("견적서확인").appendTo("#writerOrArtisanBtnSpan");
	}

	// 댓글 쓰기 폼
	if($id==$pcustom.id || $id==$pcustom.artisanId) {	// 댓글쓰기는 글쓴이와 해당작가만 쓸 수 있다
		var $form = $("<form></form>").appendTo("#insert_reply");
		$form.attr("action", "/bachida/pcustom/insert_pcustom_opinion");
		$form.attr("method", "post");
		$form.attr("id", "reply_form");
		$form.attr("enctype", "multipart/form-data");
		$("<textarea></textarea>").attr("id", "replyContent").attr("name", "content").attr("class", "form-control").attr("rows", "5").attr("cols", "80").attr("placeholder", "댓글을 입력해 주세요...").css("overflow","hidden").appendTo($form);
		//$("<br>").appendTo($form);
		$("<input>").attr("type", "file").attr("id", "file").attr("name", "file").attr("class", "btn btn-default").appendTo($form);
		$("<input>").attr("type", "button").attr("id", "insertReply").attr("class", "glyphicon glyphicon-pencil btn btn-default").val("댓글쓰기").appendTo($form);
		$("<input>").attr("type", "hidden").attr("name", "${_csrf.parameterName}").val("${_csrf.token}").appendTo($form);
	}
	printReply($pcustomOpinion);
 	$("#insertReply").on("click", function() {	// 댓글쓰기 버튼 클릭
		var formData = new FormData($("#reply_form")[0]);
		formData.append("pcustomIdx", $pcustom.pcustomIdx);
		$.ajax({
			url:"/bachida/pcustom/insert_pcustom_opinion",
			type:"post",
			data:formData,
			processData:false,	// FormData 전송에 필요한 설정
			contentType:false,	// FormData 전송에 필요한 설정
			success:function(listPcustomOpinion) {
				//console.log(listPcustomOpinion);
				$("#replyContent").val("");
				$("#file").val("");
				printReply(listPcustomOpinion);
			}
		});
		
	}); 
	
	// 글수정 폼으로 가기
	$("#updatePcustom").on("click", function() {
		//location.href="/bachida/pcustom/update_pcustom/"+$pcustom.pcustomIdx;
		var $form = $("<form></form>").appendTo("body");
		$form.attr("action", "/bachida/pcustom/update_pcustom/"+$pcustom.pcustomIdx);
		$form.attr("method", "post");
		$("<input>").attr("type", "hidden").attr("name", "title").val($("#title").val()).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name", "content").val($("#content").val()).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($pcustom.pcustomIdx).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name", "id").val($pcustom.id).appendTo($form);
		// Spring Security의 token값 설정
		$("<input>").attr("type", "hidden").attr("name", "${_csrf.parameterName}").val("${_csrf.token}").appendTo($form);
		$form.submit();
	});
	
	// 글삭제
	$("#deletePcustom").on("click", function() {
		var $form = $("<form></form>").appendTo("body");
		$form.attr("action", "/bachida/pcustom/delete_pcustom");
		$form.attr("method", "post");
		$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($pcustom.pcustomIdx).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name", "id").val($pcustom.id).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name","${_csrf.parameterName }").val("${_csrf.token}").appendTo($form);
		$form.submit();
		//토큰
	});
	
 	// 목록으로 가기...아냐 아냐...
	$("#listPcustom").on("click", function() {
		location.href="/bachida/pcustom/list_pcustom";
	});
	
	// 1:1커스텀 요청 여부 확인하고 요청이면 수락,거부 버튼 만들기
	if($isRequestPcustom==1) {
		// 요청상태면
		$("#okPcustomBtn").show();			// 수락 버튼 보이기
		$("#byePcustomBtn").show();			// 거부 버튼 보이기
	} else {
		// 요청상태가 아니면(수락 또는 거절)
		$("#okPcustomBtn").hide();
		$("#byePcustomBtn").hide();
	}
 	
	/* 나중에 자까만 수정 삭제 버튼 보이게.... */
	// 1:1커스텀 수락
	$("#okPcustomBtn").on("click", function() {
		var $confirm = confirm("1:1커스텀 요청을 수락합니다. 확인을 누르면 수정이 어렵습니다.");
		if($confirm==true) {
			var $form = $("<form></form>").appendTo("body");
			$form.attr("action", "/bachida/pcustom/ok_pcustom/"+$pcustom.pcustomIdx);
			$form.attr("method", "post");
			$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($pcustom.pcustomIdx).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name", "artisanId").val($pcustom.artisanId).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name","${_csrf.parameterName }").val("${_csrf.token}").appendTo($form);
			$form.submit();
		}
	});
	
	// 1:1커스텀 거부
	$("#byePcustomBtn").on("click", function() {
		var $confirm = confirm("1:1커스텀 요청을 거부합니다. 확인을 누르면 수정이 어렵습니다.");
		if($confirm==true) {
			var $form = $("<form></form>").appendTo("body");
			$form.attr("action", "/bachida/pcustom/bye_pcustom/"+$pcustom.pcustomIdx);
			$form.attr("method", "post");
			$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($pcustom.pcustomIdx).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name", "artisanId").val($pcustom.artisanId).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name","${_csrf.parameterName }").val("${_csrf.token}").appendTo($form);
			$form.submit();
		}
	});
	
	// 견적서 작성 폼으로 가기. 작가가...
	// 견적서를 쓰면 견적서 작성 없어져야...
 	$("#insertEstimatePcustomBtn").on("click", function() {
		var $form = $("<form></form>").appendTo("body");
			$form.attr("action", "/bachida/pcustom/insert_pcustom_estimate_go");
			$form.attr("method", "post");
			$("<input>").attr("type", "hidden").attr("name", "pcustomIdx").val($pcustom.pcustomIdx).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name", "artisanId").val($pcustom.artisanId).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name", "id").val($pcustom.id).appendTo($form);
			$("<input>").attr("type", "hidden").attr("name","${_csrf.parameterName }").val("${_csrf.token}").appendTo($form);
			$form.submit();
	});
	// 견적서 작성 팝업.....
	/* $("#insertEstimatePcustomBtn").on("click", function(e) {
		//console.log("견적서!!");
		e.preventDefault();
		window.open("/bachida/pcustom/insert_pcustom_estimate_go", "width=900, height=900");
	}); */
	
	// 견적서 수정 폼으로 가기
	$("#updatePcustomEstimateBtn").on("click", function() {
		var $form = $("<form></form>").appendTo("body");
		$form.attr("action", "/bachida/pcustom/update_pcustom_estimate_go/" + $pcustom.pcustomIdx);
		$form.attr("method", "post");
		$("<input>").attr("type", "hidden").attr("name", "artisanId").val($pcustom.artisanId).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name","${_csrf.parameterName }").val("${_csrf.token}").appendTo($form);
		$form.submit();
	});
	
	//견적서 확인
	$("#okEstimatePcustom").on("click", function() {
		var $form = $("<form></form>").appendTo("body");
		$form.attr("action", "/bachida/pcustom/read_pcustom_estimate/" + $pcustom.pcustomIdx);
		$form.attr("method", "post");
		$("<input>").attr("type", "hidden").attr("name", "id").val($pcustom.id).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name", "artisanId").val($pcustom.artisanId).appendTo($form);
		$("<input>").attr("type", "hidden").attr("name","${_csrf.parameterName }").val("${_csrf.token}").appendTo($form);
		$form.submit();
	});
	
	// 견적서 유무 확인하고 있으면 견적서 수정, 견적서 확인버튼 만들기
	// 1:1커스텀 거부 여부 확인하고 거부면 견적서 작성부터 모든 진행 버튼 안보이게
	if($isRequestPcustom==1 && $isByePcustom!==1 && $isPcustomEstimate!==1 && $isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom!==1)	{
		// 요청상태이고(수락/거부를 안했다) 견적서가 없으면
		$("#insertEstimatePcustomBtn").hide();		
		$("#updatePcustomEstimateBtn").hide();
		$("#okEstimatePcustom").hide();
	} else if($isRequestPcustom!==1 && $isByePcustom==1 && $isPcustomEstimate!==1 && $isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom!==1) {
		// 거부상태이면
		$("#insertEstimatePcustomBtn").hide();
		$("#updatePcustomEstimateBtn").hide();
		$("#okEstimatePcustom").hide();
	} else if ($isRequestPcustom!==1 && $isByePcustom!==1 && $isPcustomEstimate!==1 && $isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom!==1)  {
		// 수락상태이고(요청상태 처리) 견적서가 없으면
		$("#insertEstimatePcustomBtn").show();
		$("#updatePcustomEstimateBtn").hide();
		$("#okEstimatePcustom").hide();
	} else if ($isRequestPcustom!==1 && $isByePcustom!==1 && $isPcustomEstimate==1 && $isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom!==1) {
		// 수락상태이고(요청상태 처리) 견적서가 있으면
		$("#insertEstimatePcustomBtn").hide();	// 견적서 작성 숨기기
		$("#updatePcustomEstimateBtn").show();	// 견적서 수정 보이기
		$("#okEstimatePcustom").show();			// 견적서 확인 보이기
	} else if ($isRequestPcustom!==1 && $isByePcustom!==1 && $isPcustomEstimate==1 && $isDownPaymentPcustom==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom!==1){
		// 수락상태이고 견적서가 있고 계약금 결제완료면
		$("#insertEstimatePcustomBtn").hide();	// 견적서 작성 숨기기
		$("#updatePcustomEstimateBtn").hide();	// 견적서 수정 숨기기
		$("#okEstimatePcustom").show();			// 견적서 확인 보이기
	} else if ($isRequestPcustom!==1 && $isByePcustom!==1 && $isPcustomEstimate==1 && $isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom==1 && $isDeliveryCompletedPcustom!==1){
		// 수락상태이고 견적서가 있고 잔금 결제완료면
		$("#insertEstimatePcustomBtn").hide();	// 견적서 작성 숨기기
		$("#updatePcustomEstimateBtn").hide();	// 견적서 수정 숨기기
		$("#okEstimatePcustom").show();			// 견적서 확인 보이기
	} else if ($isRequestPcustom!==1 && $isByePcustom!==1 && $isPcustomEstimate==1 && $isDownPaymentPcustom!==1 && $isFinallyPaymentPcustom!==1 && $isDeliveryCompletedPcustom==1){
		// 수락상태이고 견적서가 있고 배송완료면
		$("#insertEstimatePcustomBtn").hide();	// 견적서 작성 숨기기
		$("#updatePcustomEstimateBtn").hide();	// 견적서 수정 숨기기
		$("#okEstimatePcustom").show();			// 견적서 확인 보이기
	}
	
	// 탑버튼
	/* $(window).scroll(function() {
		if($(this).scrollTop() > 500) {	// 스크롤함수
			$("#topBtn").fadeIn();	
		} else {
			$("#topBtn").fadeOut();
		}
	});
	$("#topBtn").on("click", function() {	// 탑버튼 이미지 클릭
		$('html, body').animate({	// animation으로 화면 맨 위로 올라가도록 설정
			scrollTop : 0
		}, 400);
		return false;
	}); */
	
});
</script>
</head>
<body>
	<div id="page">
		<!-- 글제목, .. -->
		<div id="header">
			<hr>
			<!-- <h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2> -->
			<h2>1:1제작요청</h2>
			<hr>
			<div id="first">
				<input type="text" id="title" name="title" class="form-control" readonly="readonly"><br>
				글번호:<span id="pcustomIdx"></span>&nbsp;
				작성자:<span id="id"></span>&nbsp;
				작가:<span id="artisanId"></span>&nbsp;
				<span id="writeDate" class="glyphicon glyphicon-time"></span>&nbsp;
				상태:<span id="state"></span>
				<!-- 첨부파일:<span id="attach"></span> -->
			</div>
			<hr>
		</div>
		
		<!-- 글본문 -->
		<div id="body">
			<!-- 글내용 -->
			<div id="content">
			</div>
			<!-- 글 첨부파일 -->
			<div id="file_div">
				<span id="attach"></span>
			</div>
		</div>
		
		<hr>
		<!-- 댓글영역. 댓글쓰고 보기는 글쓴이와 해당작가만 가능 -->
		<div id="replyDiv">
			<!-- 댓글쓰기 -->
			<div id="insert_reply">
				<%-- <form id="reply_form" action="/bachida/pcustom/insert_pcustom_opinion" method="post" enctype="multipart/form-data">
					<textarea id="replyContent" name="content" class="form-control" rows="5" cols="80" placeholder="댓글을 입력해 주세요..."></textarea><br>
					<input type="file" id="file" name="file" class="btn btn-default">
					<input type="button" id="insertReply" class="glyphicon glyphicon-pencil btn btn-default" value="댓글쓰기">
					<!-- Spring Security의 token값 설정 -->
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form> --%>
			</div>
			<hr>
			<!-- 댓글내용 -->
			<div id="replyArea">
			
			</div>

			<hr>
		</div>
		
		<!-- 버튼 -->
		<!-- <button id="listPcustom" class="glyphicon glyphicon-list-alt btn btn-default">목록</button> -->
		<!-- 글쓴이만 보이는 버튼 -->
	 	<span id="writerBtnSpan">
	 		<!-- <button id="updatePcustom" class="glyphicon glyphicon-pencil btn btn-default">수정하기</button> -->
			<!-- <button id="deletePcustom" class="glyphicon glyphicon-trash btn btn-default">삭제</button> -->
	 	</span>
		<!-- 글쓴이 또는 해당작가만 보이는 버튼 -->
		<span id="writerOrArtisanBtnSpan">
			<!-- <button id="okEstimatePcustom" class="glyphicon glyphicon-barcode btn btn-default">견적서확인</button> -->
		</span>
		<!-- 해당작가만 보이는 버튼 -->
		<span id="artisanBtnSpan">
			<!-- <button id="okPcustomBtn" class="btn btn-default">수락</button> -->
			<!-- <button id="byePcustomBtn" class="btn btn-default">거부</button> -->
			<!-- <button id="insertEstimatePcustomBtn" class="glyphicon glyphicon-pencil btn btn-default">견적서작성</button> -->
			<!-- <button id="updatePcustomEstimateBtn" class="glyphicon glyphicon-pencil btn btn-default">견적서수정</button> -->
		</span>
		
		<!-- 탑버튼 -->
		<!-- <img alt="top_button" src="/bachida/images/top_button.PNG" id="topBtn"> -->
		
		<hr>
	</div>
</body>
</html>