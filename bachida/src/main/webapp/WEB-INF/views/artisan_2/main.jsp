<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
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
	text-align: center;
}

#pagination li {
	list-style: none;
	float: left;
	width: 35px;
	text-align: center;
	height: 35px;
	line-height: 35px;
	font-size: 0.75em;
	border: 1px solid #ddd;
}

#pagination a {
	text-decoration: none;
	display: block;
	color: #ff4d94;
}

#pagination a:link, #pagination a:visited {
	color: #ff4d94;
}

#pagination {
	margin-top: 30px;
	text-align: center;
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
.writeDate{
	margin-left: 485px;
}

</style>
<script>
	$(function() {
		var $map = ${map};
		console.log($map);
		
		//var $artisanid = ${requestScope.list.artisanid};
		//console.log($artisanid);
		var $list = $map.list;
		console.log($list);
		

		var $artisan = $map.artisan;
		console.log($artisan);
		
		var $pagination = $map.pagination;
		var artisanId = $map.artisan.artisanId;
		console.log($artisan);
		
		//var $recommend_ico =$("<a></a>").attr("id","like").attr("data-value",list.ARTISAN_TIMELINE_IDX).addClass("glyphicon").addClass("glyphicon-heart").appendTo($timeline_recommend);
		
		var $artisanInfo = $("#artisanInfo");
		
		var $rowPanel = $("<div></div>").addClass("row").addClass("clearfix").addClass("well").appendTo($artisanInfo);
		
		var $InfoThum = $("<div></div>").addClass("col-md-2").addClass("img-thumbnail").appendTo($rowPanel);
		var $artisanSavedFile = $("<img>").attr("src","/artisan/artisanTimeline/artisanDisplayFile/"+$artisan.artisanId).css({"max-width":"100px","height":"100px","width":"100px"}).appendTo($InfoThum);
		
		var $infoContent = $("<div></div>").addClass("col-md-8").appendTo($rowPanel);
		var $artisanInfoContent = $("<blockquote></blockquote>").appendTo($infoContent);
		$("<p></p>").text($artisan.artisanName).appendTo($artisanInfoContent);
		$("<small></small>").text($artisan.artisanIntro).appendTo($artisanInfoContent);
		
		var $btn_group = $("<div></div>").addClass("col-md-2").appendTo($rowPanel);
		
		// var $artisanTopMeun = $list.ARTISANID;
		//console.log($artisanTopMeun);
		
		//var $writeTime = $("<button></button>").attr("type","button").attr("id","insertTimeline").addClass("btn").addClass("btn-default").addClass("btn-block").text("글작성").appendTo($btn_group);
		
		//var $write_OneAndOne = $("<button></button>").attr("type","button").attr("id","write_OneAndOne").addClass("btn").addClass("btn-default").addClass("btn-block").text("1:1 제작 요청").appendTo($btn_group);
		//var $addBookmark = $("<button></button>").attr("type","button").attr("id","addBookmark").addClass("btn").addClass("btn-default").addClass("btn-block").text("작가 즐겨찾기").appendTo($btn_group);
		//var $addBookmark = $("<button></button>").attr("type","button").attr("id","addBookmark").attr("data-toggle","tooltip").attr("title","추가").attr("data-artisanId",$artisan.artisanId).addClass("btn").addClass("btn-default").addClass("btn-block").text("작가 즐겨찾기").appendTo($btn_group);
		var $name = ${name};
		console.log($name);
		if($artisan.artisanId==$name){
			var $writeTime = $("<button></button>").attr("type","button").attr("id","insertTimeline").addClass("btn").addClass("btn-default").addClass("btn-block").text("글작성").appendTo($btn_group);
		}else if($artisan.artisanId==$name){
			var $write_OneAndOne = $("<button></button>").attr("type","button").attr("id","write_OneAndOne").addClass("btn").addClass("btn-default").addClass("btn-block").text("1:1 제작 요청").appendTo($btn_group);
			var $addBookmark = $("<button></button>").attr("type","button").attr("id","addBookmark").attr("data-toggle","tooltip").attr("title","추가").attr("data-artisanId",$artisan.artisanId).addClass("btn").addClass("btn-default").addClass("btn-block").text("작가 즐겨찾기").appendTo($btn_group);
		}
	/* 	var $arlist = $map.list.ARTISANID;
		console.log($arlist); */
		
		
		 
		 
 
		var $timeline = $("#timeline");
		$timeline.empty();
		$.each($list,function(i, list) {
			var $clo = $("<div></div>").attr("id","clo").addClass("Grid-cell").addClass("u-md-size1").addClass("span4").appendTo($timeline);
			var $timeline_cont = $("<div></div>").addClass("ProfileTimeline").appendTo($clo);
			var $stream = $("<div></div>").addClass("stream").appendTo($timeline_cont);
			var $stream_items = $("<div></div>").addClass("stream_items").appendTo($stream);
			var $stream_item_head = $("<div></div>").attr("id","stream_item_head").addClass("stream_item_head").addClass("pull-left").appendTo($stream_items);
			
			var $artisanName = $("<div></div>").attr("id","artisanName").text(list.ARTISANID).appendTo($stream_item_head);
			
			var $timeline_recommend = $("<p></p>").attr("id","recommendCnt").text("Like").addClass("pull-right").appendTo($artisanName);
			$("<span></span>").addClass("recommend").text(list.RECOMMEND).appendTo($timeline_recommend);
			$("<hr>").appendTo($artisanName);
			
			var $stream_item_body = $("<div></div>").addClass("stream_item_body").appendTo($stream_items);
			var $timeline_writeDate = $("<div></div>").addClass("writeDate").addClass("pull-right").text(list.WRITEDATE).appendTo($stream_item_body);
			if(list.SAVEDFILENAME!=null)
				var $timeline_img = $("<img>").attr("id", "timeline_img").attr("src","${pageContext.request.contextPath}/artisanTimeline/displayFile/"+list.SAVEDFILENAME+"/" + list.ARTISANTIMELINEIDX).appendTo($stream_item_body);
			
			var $contetn_body = $("<div></div>").addClass("contetn_body").appendTo($stream_item_body);
			$("<div></div>").attr("id","timeline_content").text(list.CONTENT).appendTo($contetn_body);
			$("<hr>").appendTo($stream_item_body);
			
			var $stream_item_footer = $("<div></div>").attr("id","stream_item_footer").addClass("stream_item_footer").appendTo($stream_items);
			
			var $name = list.ARTISANID;
			console.log($name);
			if($artisan.artisanId==$name){
				//로그인 사용자가 글 작성자라면 삭제 버튼 출력
				var $a_btn_delete = $("<a></a>").attr("href","#").addClass("pull-right").addClass("delete_timeline").attr("id","delete").attr("data-toggle","tooltip").attr("title","삭제").text("삭제").attr("data-artisanId",list.ARTISANTIMELINEIDX).appendTo($stream_item_footer);
			
			}else if($list.INFOID==$name){
				// 로그인 사용자가 글 작성자가 아니라면 추천 버튼 출력
				var $like_btn = $("<a></a>").attr("href","#").attr("id","like").addClass("pull-right").addClass("like_timeline").attr("data-toggle","tooltip").attr("data-artisanId",list.ARTISANTIMELINEIDX).text("추천").appendTo($stream_item_footer);
			} 
				
		});
		
		//글작성 페이지 이동		
		$("#insertTimeline").on("click", function() {
			location.href = "/bachida/artisanTimeline/timeline_insert";
		});
		
		//1:1 커스텀 신청 페이지 이동
		$("#write_OneAndOne").on("click", function	() {
			location.href = "/bachida/pcustom/list_pcustom";
		});
		
		//작가 즐겨찾기
		$("#addBookmark").on("click", function(){
			var $confirm = confirm("follow 하시겠습니까?");
			if($confirm==true){
				console.log($(this))
				var artisanId = $(this).attr('data-artisanId');
				console.log(artisanId);
				$.ajax({
					url : "${pageContext.request.contextPath}/artisanTimeline/add_artisan/?artisanId="+artisanId,
					type:"post",
					success:function() {
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
					url : "${pageContext.request.contextPath}/artisanTimeline/recommed_timeline/?artisanTimelineIdx="+artisanTimelineIdx,
					type:"post",
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
					url:"${pageContext.request.contextPath}/artisanTimeline/timeline_delete/?artisanTimelineIdx="+artisanTimelineIdx,
					type:"post",
					data : "${_csrf.parameterName}=${_csrf.token}", 
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
			li.wrapInner($("<a></a").attr('href', '/artisan/artisanTimeline/timeline_list?pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/artisan/artisanTimeline/timeline_list?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/artisan/artisanTimeline/timeline_list?pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('>>').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/artisan/artisanTimeline/timeline_list?pageno='+ $pagination.next));
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
				<div class="pagination" id="pagination">
					<ul class="text-center">
					</ul>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>