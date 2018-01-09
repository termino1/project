<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바치:다 | 1:1제작요청</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
		// 1:1커스텀 목록
		var $map = ${map};
		var $list = $map.list;	// 1:1제작요청 게시글 목록
		var $table = $("table");
		var $pagination = $map.pagination;
		// 로케이션 오브젝트. search : 쿼리 스트링(?부터 나오는) 정보. ex)http://localhost:8081/bachida/pcustom/list_pcustom?pageno=4
		var search = $(location).attr("search");
		console.log($list);	// arrayList
		//console.log($list[0].id);	// id:mix
		//console.log($pagination);
		//console.log(search);
		
		//$table.empty();
		//$table.append('<tr><th>번호</th><th>요청작가</th><th>제목</th><th>작성자</th><th>작성일</th><th>상태</th></tr>');
		$.each($list, function(i, $pcustom) {	// 목록 리스트 뿌리기
			//console.log($pcustom);
			//if($id == $list[i].id || $id == $list[i].artisanId) {	// 내가 쓴 글 또는 나에게 쓴 글만 보기
				var $tr = $("<tr></tr>").appendTo($table);
				$("<td></td>").text($pcustom.pcustomIdx).appendTo($tr);
				$("<td></td>").text($pcustom.artisanId).appendTo($tr);
				var $title = $("<td></td>").text($pcustom.title).appendTo($tr);
				$("<td></td>").text($pcustom.id).appendTo($tr);
				$("<td></td>").text($pcustom.writeDate).appendTo($tr);
				$("<td></td>").text($pcustom.state).appendTo($tr);
				var $link = $("<a>").attr("href", "/bachida/pcustom/read_pcustom/" + $pcustom.pcustomIdx);
				$title.wrapInner($link);
			//}
		});
		
		
		// 1:1커스텀 글쓰러 가기
		/* $("#write").on("click", function() {
			location.href="/bachida/pcustom/insert_pcustom";
		}); */
		
		// 통합검색
		$("#searchBtn").on("click", function() {	// 검색버튼 클릭할 때
			var $form = $("<form></form>");
			$form.attr("action", "/bachida/pcustom/search_list_pcustom");
			$form.attr("method", "get");
			$("#search").wrap($form);
		});
		$("#keyword").on("keydown", function(e) {	// 검색 인풋창에서 엔터 누를 때
			if(e.keyCode == 13) {
				//console.log($("#keyword").val());	// 파란
				var $form = $("<form></form>").appendTo("body");
				$form.attr("action", "/bachida/pcustom/search_list_pcustom");
				$form.attr("method", "get");
				$("<input>").attr("type", "hidden").attr("name", "keyword").val($("#keyword").val()).appendTo($form);
				$form.submit();
			}
		});
		if($list.length==0) {	// 검색 결과 없을 경우
			var $tr = $("<tr></tr>").appendTo($table);
			var $td =  $("<td></td>").attr("colspan","6").appendTo($tr);
			$("<p></p>").text("결과가 없습니다.").addClass("text-center").appendTo($td);
		}
		
		// 목록 페이징, 검색 목록 페이징
		var ul = $("#pagination_ul");
		var li;
		// split : 문자열을 구분할 때 특정 구분자(Delimter)를 기준으로 나눠서 배열로 각각의 값을 담아 반환
		// 변수명.split('구분의 기준이 되는 문자열')
		var sSplit = search.split('&');
		//console.log(sSplit);	// ["?keyword=태양비누", "pageno=2"] ?keyword=태양비누&pageno=2
		
		if($pagination.prev>0) {	// 이전
			li = $("<li></li>").text('이전').appendTo(ul);
			if(search=="" || sSplit[0].match("pageno")) {	// 기본 : 주소에 ?뒤가 없거나 split구분 첫번째에 pageno가 있으면
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/list_pcustom?pageno=' + $pagination.prev));
			}  else if(sSplit[0].match("keyword")) {		// 검색 : 주소에 split구분 첫번째에 keyword가 있으면
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom'+sSplit[0] + '&pageno=' + $pagination.prev));
			}
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {	// 페이지 10개
			li = $("<li></li>").text(i).appendTo(ul);
			if(search=="" || sSplit[0].match("pageno")) {	// 기본 : 주소에 ?뒤가 없거나 split구분 첫번째에 pageno가 있으면
					// 그냥 목록의 페이징
				if($pagination.pageno==i) {
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/list_pcustom?pageno=' + i).css({"background-color":"#337ab7", "border":"1px solid #337ab7", "color":"white"}));
				}
				else {
					li.wrapInner($("<a></a").attr('href', '/bachida/pcustom/list_pcustom?pageno='+ i));
				}
			} else if(sSplit[0].match("keyword")) {			// 검색 : 주소에 split구분 첫번째에 keyword가 있으면
				// 검색한 목록의 페이징
				if($pagination.pageno==i){
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom'+sSplit[0] + '&pageno=' + i).css({"background-color":"#337ab7", "border":"1px solid #337ab7", "color":"white"}));
				}else{
					li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom'+sSplit[0] + '&pageno=' + i));
				}
			}
		}
		if($pagination.next>0) {	// 다음
			li = $("<li></li>").text('다음').appendTo(ul);
			if(search=="" || sSplit[0].match("pageno")) {	// 기본
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/list_pcustom?pageno=' + $pagination.next));
			}  else if(sSplit[0].match("keyword")) {		// 검색
				li.wrapInner($("<a></a>").attr('href', '/bachida/pcustom/search_list_pcustom' +sSplit[0] + '&pageno=' + $pagination.next));
			}
		}
		
		
		
		
	/* 	var $map1 = ${map1};
		var $list1 = $map1.list1;
		console.log($map1);
		console.log($list1);
		// 통합검색
		$("#searchBtn1").on("click", function() {	// 검색버튼 클릭할 때
			
		console.log("ttttttttttttttttttt");
			var $form = $("<form></form>");
			$form.attr("action", "/bachida/pcustom/search_list_pcustom1");
			$form.attr("method", "get");
			$("#search").wrap($form);
		});
		$.each($list1, function(i, $product) {	// 목록 리스트 뿌리기
			//console.log($pcustom);
			//if($id == $list[i].id || $id == $list[i].artisanId) {	// 내가 쓴 글 또는 나에게 쓴 글만 보기
				var $tr = $("<tr></tr>").appendTo($table);
				$("<td></td>").text($product.productIdx).appendTo($tr);
				$("<td></td>").text($product.artisanName).appendTo($tr);
				$("<td></td>").text($product.productName).appendTo($tr);
				$("<td></td>").text($product.writeDate).appendTo($tr);
			//}
		}); */
		
});
</script>
<style>
	#pagination ul {
		text-align: center;
		maring: 0;
		padding: 0;
	}
	#pagination li {
		list-style: none;
		display: inline-block;
		width: 35px;
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
	#clear {
		clear: both;
		height:0; 
		overflow:hidden;
	}
	th{
		color: rgb(245, 89, 128);
	}
	#search, #write {
		float: right;
	}
	#pcustom {
		text-decoration: none;
		color: rgb(245, 89, 128);
	}
</style>
</head>
<body>
	
	<hr>
	<h2><a href="/bachida/pcustom/list_pcustom" id="pcustom">1:1제작요청</a></h2>
	
	<!-- 검색바 -->
	<div id="search" class="form-inline">
		<input type="text" id="keyword" name="keyword" class="form-control" placeholder="제목+내용검색">
		<button type="submit" id="searchBtn" class="glyphicon glyphicon-search btn btn-default">검색</button>
	</div>
	
	<!-- 목록 내용 -->
	<table class="table table-hover">
		<tr>
		<th>번호</th><th>요청작가</th><th>제목</th><th>작성자</th><th>작성일</th><th>상태</th>
		<!-- <th>번호</th><th>작가</th><th>제목</th><th>작성일</th> -->
		</tr>
	</table>
	
	<!-- 페이징 -->
	<div id="pagination">
		<ul id="pagination_ul">
		</ul>
	</div>
	
	<div id="clear">
	</div>
	
	<!-- 글쓰기 버튼 -->
	<!-- <button id="write" class="glyphicon glyphicon-pencil btn btn-default">글쓰기</button>  --> 
	<hr>
	
	
	
	
	<!-- 검색바 -->
	<!-- <div id="search" class="form-inline">
		<input type="text" id="keyword" name="keyword" class="form-control" placeholder="제목+내용검색">
		<button type="submit" id="searchBtn1" class="glyphicon glyphicon-search btn btn-default">검색</button>
	</div> -->
</body>
</html>