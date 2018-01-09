<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		var $map = ${map};
		var $list = $map.list;
		var $pagination = $map.pagination;
		var $tbody = $("#tbody");
		$.each($list, function(i, user) {
			var $tr = $("<tr></tr>").addClass("tdata").appendTo($tbody);
			$("<td></td>").text(user.id).appendTo($tr);
			$("<td></td>").text(user.name).appendTo($tr);
			$("<td></td>").text(user.tel).appendTo($tr);
			$("<td></td>").text(user.joinDate).appendTo($tr);
			if(user.enable==true){
				$("<td></td>").text("활동회원").appendTo($tr);
			}
			else if(user.enable==false)
				$("<td></td>").text("차단회원").appendTo($tr);
		});
		
		var ul = $("#paginationUl");
		var li;
		if($map.onlyBlockUser==0){
			$("<a>").addClass("btn").addClass("btn-default").addClass("pull-right").attr("href","/bachida/admin/blockUserList").text("차단회원보기").appendTo($("#userDiv"));
			if($pagination.prev>0) {
				li = $("<li></li>").text('이전').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '/bachida/admin/userList?pageno='+ $pagination.prev))
			}
			for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
				li = $("<li></li>").text(i).appendTo(ul);
				if($pagination.pageno==i) 
					li.wrapInner($("<a></a").attr('href', '/bachida/admin/userList?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
				else
					li.wrapInner($("<a></a").attr('href', '/bachida/admin/userList?pageno='+ i))
			}
			if($pagination.next>0) {
				li = $("<li></li>").text('다음').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '/bachida/admin/userList?pageno='+ $pagination.next));
			}	
		}else if($map.onlyBlockUser==1){
			$("<a>").addClass("btn").addClass("btn-default").addClass("pull-right").attr("href","/bachida/admin/userList").text("전체회원보기").appendTo($("#userDiv"));
			if($pagination.prev>0) {
				li = $("<li></li>").text('이전으로').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '/bachida/admin/blockUserList?pageno='+ $pagination.prev))
			}
			for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
				li = $("<li></li>").text(i).appendTo(ul);
				if($pagination.pageno==i) 
					li.wrapInner($("<a></a").attr('href', '/bachida/admin/blockUserList?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
				else
					li.wrapInner($("<a></a").attr('href', '/bachida/admin/blockUserList?pageno='+ i))
			}
			if($pagination.next>0) {
				li = $("<li></li>").text('다음으로').appendTo(ul);
				li.wrapInner($("<a></a").attr('href', '/bachida/user/blockUserList?pageno='+ $pagination.next));
			}	
		}
		
		
		$(".tdata").on("click",function(){
			var $id = $(this).children().eq(0).text();
			console.log($id);
			var $form = $("<form>").attr("action","/bachida/admin/userView").attr("method","post").appendTo("body");
			$("<input>").attr("type","hidden").attr("name","id").val($id).appendTo($form);
			$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
			$form.submit();
		});
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
			<h3 style="color: rgb(245, 89, 128);">회원목록</h3>
			<br>
			<div class="col-md-10" id="userDiv">
				<table class="table table-hover">
					<thead>
					<tr class="active">
						<th>아이디</th><th>이름</th><th>연락처</th><th>가입일</th><th>회원상태</th>
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