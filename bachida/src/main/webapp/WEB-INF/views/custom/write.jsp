<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
 <script type="text/javascript" src="/bachida/js/materialize.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link type="text/css" rel="stylesheet" href="/bachida/css/materialize.min.css"  media="screen,projection"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
	$(function(){
		$("#search").hide();
		
		 $("#date").datepicker(
				{
					showOn : "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
					changeMonth : true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
					changeYear : true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
					minDate : '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
					nextText : '다음 달', // next 아이콘의 툴팁.
					prevText : '이전 달', // prev 아이콘의 툴팁.
					numberOfMonths : [ 1, 1 ], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
					//stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
					yearRange : 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
					showButtonPanel : true, // 캘린더 하단에 버튼 패널을 표시한다. 
					currentText : '오늘 날짜', // 오늘 날짜로 이동하는 버튼 패널
					closeText : '닫기', // 닫기 버튼 패널
					dateFormat : "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
					showAnim : "slide", //애니메이션을 적용한다.
					showMonthAfterYear : true, // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ], // 요일의 한글 형식.
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]
				// 월의 한글 형식.

				}); 
				
		 
		 $("#cancel_btn").on("click",function(){
			if(confirm("작성 취소하시겠습니까? 내용은 저장되지 않습니다.")){
				location.href="/bachida/custom/list";
			} 
		 });
		 
		 
		 $("#insert_btn").on("click",function(){
			 var textareaVal = $("textarea").val();
			 result = textareaVal.replace(/(\n|\r\n)/g, '<br>');
			$("#content").val(result);
			console.log($("#content").val());
			$("form").submit();
		 });
	})
</script>
<style>
	.ui-datepicker-trigger{
		display: none;
	}
	.container{
width: 1000px !important;
}
</style>
</head>
<body>
	<!-- <form action="/bachida/custom/write" method="post" enctype="multipart/form-data">
		제목<input type="text" name="title"><br>
		내용<input type="text" name="content"><br>
		희망가격<input type="text" name="wishPrice"><br>
		수량<input type="number" name="quantity"><br>
		마감기한<input type="date" name="closingDate"><br>
		첨부파일<input type="file" name="file" ><br>
		<hr>
		<button>요청하기</button>
	</form>
	 -->    
	 <div class="container">                               
    <form class="col s12" action="/bachida/custom/write" method="post" enctype="multipart/form-data">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<table>
			<tr>
				<td colspan="3">
					<div class="input-field s12">
						<input id="title" name="title" type="text" class="validate">
						<label for="title">제목*</label>
					</div>
				</td>
			</tr>               
			<tr>
				<td>
					 <div class="input-field">
         				<input id="wishPrice" name="wishPrice" type="number" class="validate">
      				    <label for="wishPrice">희망가격*</label>
     				</div>
				</td>
				<td>
					<div class="input-field">
						<input id="quantity" name="quantity" type="number" class="validate"> 
						<label for="quantity">수량*</label>
					</div>
				</td>
				<td>
					<div class="input-field">
						<label for="date" class="active">마감기한*</label>
						<input id="date" name="closingDate" type="date">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="input-field s12">  
          				<textarea id="content" name="content"  class="materialize-textarea" style="height: 300px"></textarea>
          				<label for="content">내용*</label>
        			</div>
				</td>
			</tr>                           
			<tr>
				<td colspan="2">
					<div class="file-field input-field">
						<div class="btn">
							<span>File</span> <input type="file" name="file">
						</div>
						<div class="file-path-wrapper">
							<input class="file-path validate" type="text">
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td></td>  
				<td>  
					<button class="btn waves-effect waves-light" type="button"  id="insert_btn" name="action" style="float: right">글 등록<i class="material-icons right">send</i></button>
				</td>
				<td>
					<a class="btn" id="cancel_btn" >작성취소</a>  
				</td>
			</tr>
		</table>
    </form>              
	</div>
</body>
</html>