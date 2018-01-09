<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	$(".artisanHome").on("click",function(e){
		e.preventDefault();
		location.href="/bachida/artisantimeline/timeline_list?artisanId="+$(this).attr("data-id");
	});
})

</script>
</head>
<body>
	<div class="collapse navbar-collapse" id="allNav">	        
			<ul class='nav nav-tabs' style="margin-top: 30px">
				<li role="presentation"><a href="#" class="artisanHome">메인</a></li>
				<li role="presentation"><a href="/bachida/artisan/sale/sales_list" class="salesList">판매작품</a></li>
				<li role="presentation"><a href="/bachida/pcustom/insert_pcustom">1:1제작요청</a></li>
			</ul>
		</div>
</body>
</html>