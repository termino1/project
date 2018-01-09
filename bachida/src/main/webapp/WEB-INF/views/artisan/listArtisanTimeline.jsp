<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
.container{
width: 1000px !important;
}
#write{
	padding: 100px;
	padding-top: 50px;
}
#writeForm{
	padding-right: 30px;
	padding-left: 30px;
}
textarea{
	width: 800px;
}
.btn {
	background-color: #ff4d94; /* 마젠타? */
	color: white;
	
}
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
	
	
#clo{
	text-align: center;
	padding-left: 300px;
	padding-right: 300px;
	padding-top: 30px;
	max-height: 300px
}
#timeline_img{
	width: 500px;
    height: auto;
    padding-top: 20px;
    padding-bottom: 20px;
}
 #recommendCnt{
	padding-left: 460px;
} 
.recommend{
	padding-left: 15px;
}
#timeline_content{
	text-align: left;
}

#timeline{
    max-width: 80%;
    margin: 0 auto;
}
.like_timeline:hover , .delete_timeline:hover {
	cursor: pointer;
}
.glyphicon-thumbs-up:before {
    content: "\e125";
    color: #337ab7;
    border-color: #337ab7;
    padding-left: 10px;
}

</style>
<script>
	$(function() {
		var $map = ${map};
		
		var $list = $map.list;
		var $artisan = $map.artisan;
		var $pagination = $map.pagination;
		var artisanId = $map.artisan.artisanId;
		var $name = ${name};
		var isFollow = ${isFollow};
		
		//var $recommend_ico =$("<a></a>").attr("id","like").attr("data-value",list.ARTISAN_TIMELINE_IDX).addClass("glyphicon").addClass("glyphicon-heart").appendTo($timeline_recommend);
		
		var $artisanInfo = $("#artisanInfo");
		
		var $rowPanel = $("<div></div>").addClass("row").addClass("clearfix").addClass("well").appendTo($artisanInfo);
		
		var $InfoThum = $("<div></div>").addClass("col-md-2").addClass("img-thumbnail").appendTo($rowPanel);
		var $artisanSavedFile = $("<img>").attr("src","/bachida/artisantimeline/artisanDisplayFile/"+$artisan.artisanId).css({"height":"100px","width":"100%"}).appendTo($InfoThum);
		
		var $infoContent = $("<div></div>").addClass("col-md-8").appendTo($rowPanel);
		var $artisanInfoContent = $("<blockquote></blockquote>").appendTo($infoContent);
		$("<p></p>").text($artisan.artisanName).appendTo($artisanInfoContent);
		$("<small></small>").html($artisan.artisanIntro).appendTo($artisanInfoContent);
		
		var $btn_group = $("<div></div>").addClass("col-md-2").appendTo($rowPanel);
		
		// var $artisanTopMeun = $list.ARTISANID;
		//console.log($artisanTopMeun);
		
		//var $writeTime = $("<button></button>").attr("type","button").attr("id","insertTimeline").addClass("btn").addClass("btn-default").addClass("btn-block").text("글작성").appendTo($btn_group);
		
		//var $write_OneAndOne = $("<button></button>").attr("type","button").attr("id","write_OneAndOne").addClass("btn").addClass("btn-default").addClass("btn-block").text("1:1 제작 요청").appendTo($btn_group);
		//var $addBookmark = $("<button></button>").attr("type","button").attr("id","addBookmark").addClass("btn").addClass("btn-default").addClass("btn-block").text("작가 즐겨찾기").appendTo($btn_group);
		//var $addBookmark = $("<button></button>").attr("type","button").attr("id","addBookmark").attr("data-toggle","tooltip").attr("title","추가").attr("data-artisanId",$artisan.artisanId).addClass("btn").addClass("btn-default").addClass("btn-block").text("작가 즐겨찾기").appendTo($btn_group);
		
		if(artisanId==$name){
			var $writeTime = $("<button></button>").attr("type","button").css("width","initial").attr("id","insertTimeline").addClass("btn").addClass("btn-default").addClass("btn-block").text("글작성").appendTo($btn_group);
		}else {
			//var $write_OneAndOne = $("<button></button>").attr("type","button").attr("id","write_OneAndOne").addClass("btn").addClass("btn-default").addClass("btn-block").text("1:1 제작 요청").appendTo($btn_group);
			
			if(isFollow==null)
				var $addBookmark = $("<button></button>").attr("type","button").css("width","initial").attr("id","addBookmark").attr("data-toggle","tooltip").attr("title","추가").attr("data-artisanId",$artisan.artisanId).addClass("btn").addClass("btn-default").addClass("btn-block").text("작가 즐겨찾기").appendTo($btn_group);
			else
				var $addBookmark = $("<button></button>").attr("type","button").css("width","initial").attr("id","deleteBookmark").attr("data-toggle","tooltip").attr("title","추가").attr("data-bookmarkIdx",isFollow.artisanBookmarkIdx).attr("data-artisanId",$artisan.artisanId).addClass("btn").addClass("btn-default").addClass("btn-block").text("즐겨찾기 해제").appendTo($btn_group);
		}
	/* 	var $arlist = $map.list.ARTISANID;
		console.log($arlist); */
		 
 
		var $timeline = $("#timeline");
		$timeline.empty();
		$.each($list,function(i, list) {
			var $clo = $("<div></div>").attr("id","clo").addClass("Grid-cell").addClass("u-md-size1").addClass("span4").appendTo($timeline);
			var $timeline_cont = $("<div></div>").addClass("ProfileTimeline").appendTo($clo);
			var $stream = $("<div></div>").addClass("stream").css("margin-top","35px").appendTo($timeline);
			var $stream_items = $("<div></div>").addClass("stream_items").appendTo($stream);
			var $stream_item_head = $("<div></div>").attr("id","stream_item_head").addClass("stream_item_head").appendTo($stream_items);
			
			var $artisanName = $("<div></div>").attr("id","artisanName").text(list.artisanId).css("margin-top","20px").css("font-weight","bold").appendTo($stream_item_head);
			
			var $timeline_recommend = $("<p></p>").attr("id","recommendCnt").text("Like").addClass("pull-right").appendTo($artisanName);
			$("<span></span>").addClass("recommend").text(list.recommend).appendTo($timeline_recommend);
			$("<hr>").css("margin-top","0").appendTo($artisanName);
			
			var $stream_item_body = $("<div></div>").addClass("stream_item_body").appendTo($stream_items);
			var $timeline_writeDate = $("<div></div>").addClass("writeDate").addClass("pull-right").text(list.writeDate).appendTo($stream_item_body);
			if(list.savedFileName!=null)
				var $timeline_img = $("<img>").attr("id", "timeline_img").attr("src","${pageContext.request.contextPath}/artisantimeline/displayFile/"+list.savedFileName+"/" + list.artisanTimelineIdx).appendTo($stream_item_body);
			
			var $contetn_body = $("<div></div>").addClass("contetn_body").appendTo($stream_item_body);
			$("<div></div>").attr("id","timeline_content").html(list.content).appendTo($contetn_body);
			$("<hr>").css("margin-bottom","0").appendTo($stream_item_body);
			
			var $stream_item_footer = $("<div></div>").attr("id","stream_item_footer").addClass("stream_item_footer").appendTo($stream_items);
			
			if(list.artisanId==$name){
				//로그인 사용자가 글 작성자라면 삭제 버튼 출력
				var $a_btn_delete = $("<a></a>").addClass("pull-right").addClass("delete_timeline").attr("id","delete").attr("data-toggle","tooltip").attr("title","삭제").text("삭제").attr("data-artisanId",list.artisanTimelineIdx).appendTo($stream_item_footer);
			
			}else {
				// 로그인 사용자가 글 작성자가 아니라면 추천 버튼 출력
				var $like_btn = $("<a></a>").attr("id","like").addClass("pull-right").addClass("like_timeline").addClass("glyphicon").addClass("glyphicon-thumbs-up").attr("data-toggle","tooltip").attr("data-artisanId",list.artisanTimelineIdx).appendTo($timeline_recommend);
			} 
				
		});
		
		//글작성 페이지 이동		
		$("#insertTimeline").on("click", function() {
			location.href = "/bachida/artisantimeline/timeline_insert";
		});
		/* 
		//1:1 커스텀 신청 페이지 이동
		$("#write_OneAndOne").on("click", function	() {
			location.href = "/bachida/pcustom/list_pcustom";
		});
		 */
		//작가 즐겨찾기
		$("#addBookmark").on("click", function(){
			var $confirm = confirm("follow 하시겠습니까?");
			if($confirm==true){
				var artisanId = $(this).attr('data-artisanId');
				$.ajax({
					url : "${pageContext.request.contextPath}/artisantimeline/add_artisan/?artisanId="+artisanId,
					type:"post",
					data : "${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(result) {
						if(result!=0){
							$("#addBookmart").text("즐겨찾기 해제").attr("id","deleteBookmart").attr("data-bookmartIdx",result);
						}
						location.reload(true);
					}
				});
			}
		});
		
		 // 즐겨찾기 해제
		 $("#deleteBookmark").on("click",function(){
			 alert($(this).attr("data-bookmarkIdx"));
			 if(confirm("follow 해제 하시겠습니까?")){
				 var artisanBookmarkIdx = $(this).attr("data-bookmarkIdx");
				 $.ajax({
					url:"/bachida/bookmarkArtisan/delete_bookmark",
					type:"post",
					data : "artisanBookmarkIdx="+artisanBookmarkIdx+"&${_csrf.parameterName}=" + "${_csrf.token}",
					success:function(result){
						if(result==1)
							$("#addBookmart").text("작가 즐겨찾기").attr("id","addBookmart").removeAttr("data-bookmarkIdx");
						location.reload(true);
					}
				 });
			 }
				 
			 
		 });
		 
		 
		
		//타임라인 좋아요
		$(".like_timeline").on("click", function () {
			var $confirm = confirm("추천 하시겠습니까?");
			if($confirm==true){
				var artisanTimelineIdx = $(this).attr('data-artisanId');
				$.ajax({
					url : "${pageContext.request.contextPath}/artisantimeline/recommed_timeline/?artisanTimelineIdx="+artisanTimelineIdx,
					type:"post",
					data : "${_csrf.parameterName}=" + "${_csrf.token}",
					success:function() {
						location.reload(true);
					}
				});
			}
			
		});
		
		//삭제
		$(".delete_timeline").on("click", function () {
			var $confirm = confirm("삭제 하시겠습니까?");
			if($confirm==true){
				var artisanTimelineIdx = $(this).attr('data-artisanId');
				$.ajax({
					url:"${pageContext.request.contextPath}/artisantimeline/timeline_delete/?artisanTimelineIdx="+artisanTimelineIdx,
					type:"post",
					data : "${_csrf.parameterName}=" + "${_csrf.token}",
					success:function() {
						location.reload(true);
					}
				});
			}
		});
		
		//수정
		/* $("#update").on("click",function(e){
			e.preventDefault();
			console.log($(this).attr("data-value"));
			window.open("/artisan/artisanTimeline/timeline_update/?artisanTimelineIdx="+$(this).attr("data-value"),"수정","width=900,height=450");
		}); */
		var ul = $("#pagination ul");
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('<<').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/artisantimeline/timeline_list?artisanId='+artisanId+'&pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/bachida/artisantimeline/timeline_list?artisanId='+artisanId+'&pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/bachida/artisantimeline/timeline_list?artisanId='+artisanId+'&pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('>>').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/artisantimeline/timeline_list?artisanId='+artisanId+'&pageno='+ $pagination.next));
		}

	});
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="container-fluid ">
			<!--타임라인-->
			<div class="row">
                                
  
				<div id="timelineBody">

					<!-- 작가 정보 -->
					<div class="row">
						<div id="artisanInfo">
						</div>
					</div>

					<!-- 작가 타임라인 -->
					<div class="row">
					<div id="timeline">
						<div id="footer_btnaera"></div>
					</div>
					</div>
				</div>
				<!-- 페이징 -->
				<div id="pagination">
					<ul class="text-center">
					</ul>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>