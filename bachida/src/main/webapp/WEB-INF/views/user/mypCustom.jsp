<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
	$(function(){
		var $map = ${map};
		var $list = $map.list;
		var $pagination = $map.pagination;
		var $table = $("#list")
		if($list.length==0){
			var $tr = $("<tr></tr>").appendTo($table);
			$("<td colspan='5'></td>").text("해당 내역이 없습니다.").css({"text-align": "center","font-weight": "bold"}).appendTo($tr);
		}
		$.each($list, function(i, pcustom) {
			var $tr = $("<tr>").addClass("tdata").appendTo($table);
			$("<td>").text(pcustom.pcustomIdx).appendTo($tr);
			$("<td>").text(pcustom.title).appendTo($tr);
			$("<td>").text(pcustom.writeDate).appendTo($tr);
			$("<td>").text(pcustom.artisanId).appendTo($tr);
			$("<td>").text(pcustom.state).appendTo($tr);
		});
		$(".tdata").on("click",function(){
			var $idx = $(this).children().eq(0).text();
			location.href = "/bachida/pcustom/read_pcustom/"+$idx;
		});
		
		var ul = $("#paginationUl");
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/user/myPcustom?pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/bachida/user/myPcustom?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/bachida/user/myPcustom?pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/user/myPcustom?pageno='+ $pagination.next));
		}	
	});
</script>
<style>
	
	#paginationUl {
		display: table;
  		margin-left: auto;
  		margin-right: auto;
  		padding : 0;
	}
	#pagination li {
		list-style: none;
		display : inline-block;
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
	tbody > tr {cursor: pointer;}
</style>
</head>
<body>
	<h3 style="color: rgb(245, 89, 128);">1:1제작요청내역</h3>
	<div class="container">
		<div class="row">
			<table class="table table-hover">
			<thead>
				<tr class="active">
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>요청한작가</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
		</table>
		</div>
		<div id="pagination">
			<ul id="paginationUl">
			</ul>
		</div>
	</div>
</body>
</html>