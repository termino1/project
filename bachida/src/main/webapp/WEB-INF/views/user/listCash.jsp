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
		var $userCash = $map.userCash;
		var $idx = $list.length;
		var $tbody = $("#tbody");
		$("#cash").text("사용가능한 캐쉬 : "+$userCash);
		console.log($idx);
		console.log($userCash);
		if($list.length==0){
			var $tr = $("<tr></tr>").appendTo($tbody);
			$("<td colspan='4'></td>").text("해당 내역이 없습니다.").css({"text-align": "center","font-weight": "bold"}).appendTo($tr);
		}
		
		$.each($list, function(i, cash) {
			console.log(cash);
			console.log("왜두번돌아 ㅡㅡ")
			var $tr = $("<tr></tr>").appendTo($tbody);
			$("<td></td>").text($idx).appendTo($tr);
			$("<td></td>").text(cash.content).appendTo($tr);
			if(cash.content.match("충전")||cash.content.match("환불")||cash.content.match("입금")){
				$("<td></td>").text(cash.updateCash+"원").appendTo($tr);
			}else if(cash.content.match("결제")){
				$("<td></td>").text("-"+cash.updateCash+"원").appendTo($tr);
			}
			$("<td></td>").text(cash.updateDate).appendTo($tr);
			$idx--;
		});
	});
</script>
</head>
<body>
<h3 style="color: rgb(245, 89, 128);">내 캐쉬내역</h3>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div id="cash" class="pull-right">
				</div>
				<table class="table table-hover">
					<thead>
					<tr class="active">
						<th>내역번호</th><th>내용</th><th>금액</th><th>날짜</th>
					</tr>
					</thead>
					<tbody id="tbody">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>