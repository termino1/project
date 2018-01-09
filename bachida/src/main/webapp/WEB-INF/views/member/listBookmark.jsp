<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

#bookmark_img{
	width: 250px;
}
#btn_group{
	padding-top: 10px;
	padding-bottom: 5px;
}
.news-title{
	padding-top: 20px;
}
.col-md-3{
text-align: center;
padding-top: 10px;
padding-bottom: 10px;
}
</style>
<script type="text/javascript">
	$(function () {
		var $map = ${map};
		console.log($map);
		 var $bookmark = $map.bookmarkList;
		 console.log($bookmark);
		 var $artisan = $bookmark.id;
		 console.log($artisan);
		var $pagination = $map.pagination;
		var $list = $("#list");
		if($bookmark.length==0){
			$("<p></p>").text("해당 내역이 없습니다.").css({"font-weight": "bold"}).appendTo($list);
		}
		
		$.each($bookmark, function (i, list) {
			//등록번호, 작가명, 작가 소개, 저장파일 썸네일
			
			var $col = $("<div></div>").addClass("col-md-4").appendTo($list);
			var $card = $("<div></div>").addClass("card").appendTo($col);
			var $bookmark_img = $("<img>").attr("id","bookmark_img").attr("src","/bachida/artisantimeline/artisanDisplayFile/"+list.ARTISANID+"?artisanId" + list.SAVEDFILENAME).appendTo($card);
			
			var $card_overlay = $("<div></div>").addClass("card-img-overlay").appendTo($card);
			
			var $btn_group = $("<div></div>").attr("id","btn_group").addClass("col-md-2").appendTo($card_overlay);
			var $a_btn_delete = $("<a></a>").addClass("delete").addClass("btn").addClass("label").addClass("label-primary").attr("id","delete").attr("data-toggle","tooltip").attr("title","삭제").text("삭제").attr("data-bookmarkId",list.ARTISANBOOKMARKIDX).attr("data-id",$bookmark[i].ID).appendTo($btn_group);
			var $a_btn_home = $("<a></a>").addClass("artisanHome").addClass("btn").addClass("label").addClass("label-primary").addClass("artisanHome").attr("id","artisanHome").attr("data-toggle","tooltip").attr("data-artisanId",list.ARTISANID).attr("title","작가 홈으로 이동").text("작가홈").appendTo($btn_group);
			
			var $card_body = $("<div></div>").appendTo($card);
			$("<h2></h2>").addClass("news-title").text(list.ARISANNAME).appendTo($card_body);
			$("<small></small>").html(list.ARTISANINTRO).appendTo($card_body);
			
			
		});
		 
		//삭제
		$(".delete").on("click", function () {
			var $confirm = confirm("삭제 하시겠습니다?");
			if($confirm==true){
				/* var formData = new FormData();
				var id = $(this).attr('data-id');
				var artisanBookmarkIdx = $(this).attr('data-bookmarkId');
				formData.append("artisanBookmarkIdx",$(this).attr('data-bookmarkId'));
				console.log(id);
				console.log(artisanBookmarkIdx); */
				var artisanBookmarkIdx = $(this).attr('data-bookmarkId');
				$.ajax({
					url:"${pageContext.request.contextPath}/bookmarkArtisan/delete_bookmark/?artisanBookmarkIdx="+artisanBookmarkIdx,
					type:"post",
					data : "${_csrf.parameterName}=" + "${_csrf.token}",
					success:function() {
						location.reload(true);
					}
				});
			}
		});
		
		$(".artisanHome").on("click", function(e) {
			//작가 홈 이동 버튼
			e.preventDefault();
		window.open("${pageContext.request.contextPath}/artisantimeline/timeline_list?artisanId="+$(this).attr('data-artisanId'));
	})
	});
</script>
</head>             
<body>
	<div class="container">
		<!-- <ol class="breadcrumb">
			<li><a href="#"><span class="glyphicon glyphicon-home"
					aria-hidden="true"></span></a></li>
			<li><a href="#">마이페이지</a></li>
			<li class="active">작가 즐겨찾기</li>
		</ol> -->
		<!--//경로-->
		<div class="page-header" style="margin-top:0">
			<h3 style="color: rgb(245, 89, 128);">찜한작가</h3>
		</div>
		<!-- 즐겨찾는 작품목록 -->
		<div class="row" id="boobmarkArea">
				<div class="row bookmarkList" id="list">
				</div>
		</div>
	</div>
	
</body>
</html>