<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		var $map = ${list};
		var $list = $map.list;
		var $pagination = $map.pagination;
		var $tbody = $("#tbody");
		if($list.length==0){
			var $tr = $("<tr></tr>").appendTo($tbody);
			$("<td colspan='5'></td>").text("해당 내역이 없습니다.").css({"text-align": "center","font-weight": "bold"}).appendTo($tr);
		}
		$.each($list, function(i, report) {
			var $tr = $("<tr></tr>").addClass("tdata").appendTo($tbody);
			$("<td></td>").text(report.reportIdx).appendTo($tr);
			$("<td></td>").text(report.reportId).appendTo($tr);
			$("<td></td>").text(report.reportContent).appendTo($tr);
			$("<td></td>").text(report.writeDate).appendTo($tr);
			$("<td></td>").text(report.reportState).appendTo($tr);
		})
		var ul = $("#paginationUl");
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/user/listReport?pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/bachida/user/listReport?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/bachida/user/listReport?pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/user/listReport?pageno='+ $pagination.next));
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
</style>
</head>
<body>  

	<div class="container">
		<div class="row">
			<h3 style="color: rgb(245, 89, 128);">신고내역</h3>
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
					<tr class="active">
						<th>신청번호</th><th>신고아이디</th><th>내용</th><th>신고일자</th><th>상태</th>
					</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>
				<div id="pagination">
					<ul id="paginationUl">
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>