<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
 <link rel="stylesheet" href="/bachida/css/bootstrap.css">
<script type="text/javascript" src="/bachida/js/bootstrap.js"></script>
 <script type="text/javascript" src="/bachida/js/materialize.min.js"></script>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link type="text/css" rel="stylesheet" href="/bachida/css/materialize.min.css"  media="screen,projection"/>
 <script type="text/javascript" src="/bachida/js/slimbox2.js"></script>
<link rel="stylesheet" href="/bachida/css/slimbox2.css" type="text/css" media="screen" />

<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
var today=new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();
if(dd<10) {
    dd='0'+dd
} 
if(mm<10) {
    mm='0'+mm
} 
var $today = yyyy+'-'+mm+'-'+dd;
console.log(today);

	function printList($list,$today){

		var $table = $("table tbody");
		$table.empty();
		if($list.length==0){
			var $info = $("<tr></tr>").appendTo($table);
			$("<td colspan='5'></td>").text("해당 글이 없습니다").appendTo($info);
		}else{
		$.each($list,function(i,cr){
			var $tr = $("<tr></tr>").appendTo($table);
			$("<td></td>").text(cr.customIdx).appendTo($tr);
			var $td = $("<td></td>").text(cr.title).attr("data-id",cr.id).appendTo($tr);
			
			var link = $("<a class='dropdown-button'></a>").attr("data-activates","dropdown2").attr("data-beloworigin","true").attr("href","#");
			link.attr("data-id",cr.id);
			
			var $id = $("<td></td>").text(cr.id).appendTo($tr);
			
			$id.wrapInner(link);
			
			if(cr.writeDate==$today)
				$("<span></span>").addClass("new").addClass("badge").addClass("red").text(" ").appendTo($td);
			
			if(cr.state=='낙찰')
				$("<span></span>").addClass("badge").addClass("blue").addClass("new").attr("data-badge-caption","낙찰").text(" ").appendTo($td);
			
			$("<td></td>").text(cr.writeDate).appendTo($tr);
			
			var closingDate = cr.closingDate;
			var dateArray = closingDate.split("-");
			var dateObj = new Date(dateArray[0],Number(dateArray[1])-1,dateArray[2]);
			var today = new Date();
			var betweenDay = (today.getTime() - dateObj.getTime()) / 1000 / 60 / 60 / 24; 
			var dDay = parseInt(betweenDay)-1;
			if(dDay>=0){
				$("<td></td>").text("마감").appendTo($tr);
			}else{
				$("<td></td>").text("D"+dDay).appendTo($tr);
			}
			$("<td></td>").text(cr.state).appendTo($tr);
			$("<td></td>").text(cr.viewCnt).appendTo($tr);
			var $link = $("<a class='viewBtn'></a>").attr("data-idx",cr.customIdx).attr("href","/bachida/custom/view?customIdx="+cr.customIdx + "&writer="+ cr.id);
			$td.wrapInner($link);
		});
		}
	}
	
	function paging($pagination){
		// 페이징
		var ul = $("#pagination ul");
		ul.empty();
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/custom/list?pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/bachida/custom/list?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/bachida/custom/list?pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/custom/list?pageno='+ $pagination.next));
		}	
	}
	
	// ajax로 불러온 리스트 페이징할때...  ajax 실행할때 preventDefault()!!!! 필수
	// $href < 안중요함..없어도 됨...
	// $className -> ajax 실행하는 버튼에 걸려있던 class... 혹은 id
	// $data_id -> ajax 실행할때 필요한 데이터 값
	function ajaxPaging($pagination, $href , $className, $data_id){
		var ul = $("#pagination ul");
		ul.empty();
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('이전으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', $href+'pageno='+ $pagination.prev).attr("pageno",$pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', $href+'pageno='+ i).attr("pageno",i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', $href+'pageno='+ i).attr("pageno",i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('다음으로').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', $href + 'pageno='+ $pagination.next).attr("pageno",$pagination.next));
		}
		
		$("#pagination a").addClass($className).attr("data-submit",$data_id);
	}
	

	$(function(){
		$("#search").hide();
		
		var $map = ${map};
		var $list = $map.list;
		var $pagination = $map.pagination;
		
		printList($list,$today);
		paging($pagination);
		
		$("#write").on("click",function(){
			location.href="write";
		});
		
		
	
		$("body").on("click",".change_list",function(e){
			e.preventDefault();
			var pageno = $(this).attr("pageno");
			if(pageno==null)
				pageno=1;
			var submitState = $(this).attr("data-submit");
			$.ajax({
				url : "/bachida/custom/state",
				type: "get",
				data : "state="+ submitState + "&pageno=" + pageno ,
				success:function(map){
					var newMap=map;
					var newList = newMap.list;
					var newPagination = newMap.pagination;
					printList(newList,$today);
					ajaxPaging(newPagination,"/bachida/custom/state?","change_list",submitState);
				}
			});
		});
		var session = ${sessionScope.user};
		
		$(".viewBtn").on("click",function(e){
			e.preventDefault();
			var titleTd = $(this).parent("td");
			console.log(titleTd.attr("data-id"));
			if(titleTd.attr("data-id") != session.id && session.authorities.length==1){
				alert("본인 글만 볼 수 있습니다.")
			}else{
				location.href="/bachida/custom/view?customIdx="+$(this).attr("data-idx") + "&writer="+ session.id;
			}
		});
		
		

		// 쪽지드롭다운
		$("#dropdown2").on("click",".msgDrop",function(){
			var receiver = $("td").find("a.active").attr("data-id");
			window.open("/bachida/user/msgWriteForm?receiver="+receiver,"쪽지함","width=850,height=500");			
			//window.open("/bachida/user/msgWriteForm?receiver="+receiver);
		});
		
		// 신고 드롭다운
		$("#dropdown2").on("click",".reportDrop",function(){
			var reportId = $("td").find("a.active").attr("data-id");
			//var receiver = $("td").find("a.active").attr("data-id");
			window.open("/bachida/user/writeReport/"+reportId,"회원신고","width=850,height=500");			
			//window.open("/bachida/user/msgWriteForm?receiver="+receiver);
		});
		
		
		$('.dropdown-button').dropdown({
		      inDuration: 300,
		      outDuration: 225,
		      constrainWidth: false, // Does not change width of dropdown to that of the activator
		      hover: false, // Activate on hover
		      gutter: 0, // Spacing from edge
		      belowOrigin: true, // Displays dropdown below the button
		      alignment: 'right', // Displays dropdown with edge aligned to the left of button
		      stopPropagation: false // Stops event propagation
		    }
		  );
	});
</script>
<style>
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
	.dropdown-content li>a{
		font-size : 13px;
		padding: 5px 6px 0 8px;
	}
	#dropdown1{
		min-width: 47px;
	}
	.dropdown-content li{
		min-height: 0;
	}
	#write{
		    margin: 15px 20px 0 0;
	}
	.breadcrumb2 {
    padding: 8px 15px;
    margin-bottom: 20px;
    list-style: none;
    background-color: #f5f5f5;
    border-radius: 4px;
}
	a{
		color:black;
		text-decoration: none;
	}
	a:hover {
	font-weight: bold;
}
.container{
	width: 1000px !important;
}
#dropdown2{
	min-width: 42px;
}
</style>
</head>
<body>
	                                                                 
	                                   
	<div class="container">
                                                                           
	<h4 style="line-height: center color: rgb(245, 89, 128);">제작요청</h4>	           
	           
	   <!-- dropdown -->        
	<ul id="dropdown2" class="dropdown-content">  
		<li><a class='msgDrop'>쪽지</a></li>    
		<li><a class='reportDrop'>신고</a></li>
	</ul>
                              
	                   
	<table class="bordered centered highlight">
		<thead>  
		<tr><th>글번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>마감일</th><th><a class="dropdown-button" data-activates='dropdown1' href="#">상태<i class="material-icons">arrow_drop_down</i></a></th><th>조회수</th></tr>
		</thead>
		<tbody>             
		</tbody>       
	</table>
	<button id="write" class="waves-effect waves-light btn pull-right">글쓰기</button>
	<div id="pagination">        
		<ul class="text-center">
		</ul>
	</div>  
	                             
	      
	                       
	<!-- dropdown -->
	<ul id="dropdown1" class="dropdown-content">
		<li><a href="/bachida/custom/list" >전체</a></li>
		<li><a href="#" class="change_list" data-submit="요청">요청</a></li>    
		<li><a href="#" class="change_list" data-submit="낙찰">낙찰</a></li>
		<li><a href="#" class="change_list" data-submit="유찰">유찰</a></li>
	</ul>
	</div>
</body>
</html>