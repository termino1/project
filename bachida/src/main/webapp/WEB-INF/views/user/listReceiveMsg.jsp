<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="/bachida/js/bootstrap.js"></script>
<link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script>
	$(function(){
		var $map = ${list};
		var $list = $map.list;
		var $pagination = $map.pagination;
		var $tbody = $("#tbody");
		$.each($list, function(i, message) {
			var $tr = $("<tr></tr>").appendTo($tbody);
			var $td = $("<td></td>").appendTo($tr);
			$("<input>").attr("type","checkbox").attr("name","messageIdx").attr("value",message.messageIdx).appendTo($td);
			$("<td></td>").text(message.sender).appendTo($tr);
			var $content = $("<td></td>").text(message.messageContent).appendTo($tr);
			var $link = $("<a>").attr("href", "/bachida/user/recieveMsgView/" + message.messageIdx);
			$content.wrapInner($link);
			$("<td></td>").text(message.sendDate).appendTo($tr);
			if(message.confirm=="0")
				$("<td></td>").text("미확인").appendTo($tr);
			else
				$("<td></td>").text("확인").appendTo($tr);
		})
		$("#allCheck").on("change",function(){
			if($("#allCheck").is(":checked"))
				$("input[type='checkbox']").prop("checked",true);
			else
				$("input[type='checkbox']").prop("checked",false);
		});
		
		$("#messageDelete").on("click",function(){
			$("#deleteFrm").attr("action","/bachida/user/msgDelete").attr("method","get");
			$("#deleteFrm").submit();
		});
		
		$("#closeMsg").on("click",function(){
			opener.parent.location.reload(true);
			window.close();
		});
		
		var ul = $("#paginationUl");
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/user/receiveMsgList?pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/bachida/user/receiveMsgList?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/bachida/user/receiveMsgList?pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/user/receiveMsgList?pageno='+ $pagination.next));
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
		<h3 style="color: rgb(245, 89, 128);">내 쪽지함</h3>
		<div class="row">
			<div class="col-md-4">
				<nav class="navbar navbar-default">
					<div class="container">
						<div id="navbar" class="text-white collapse navbar-collapse">
							<ul class="nav navbar-nav">
								<li class="active"><a href="#">받은쪽지함</a></li>
								<li><a href="/bachida/user/sendMsgList">보낸쪽지함</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8"> 
				<button class="btn btn-default pull-right" type="button" id="messageDelete">삭제</button>
				<form id="deleteFrm">
					<table class="table table-hover">
						<thead>
						<tr class="active">
							<th>
								<input type="checkbox" id="allCheck">
							</th>
							<th>보낸사람</th>
							<th>내용</th>
							<th>날짜</th>
							<th>확인</th>
						</tr>
						</thead>
						<tbody id="tbody">
						</tbody>
					</table>
				</form>
				<div id="pagination">
					<ul id="paginationUl">
					</ul>
				</div>
				<button class="btn btn-default pull-right" type="button" id="closeMsg">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>