<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
	.glyphicon {
		
	}
	.target { display: inline-block; width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;

 }
 

</style>
<script type="text/javascript">
	$(function () {
		
		
		var $map = ${map};
		console.log($map);
		
		var $product= $map.productList;
		console.log($product);
		var $writer = $map.artisan;
		var $artisanIdx = $map.artisanIdx;
		console.log($artisanIdx);
		var $pagination = $map.pagination;
		var $table = $("#list");
		$table.empty();
		$.each($product, function (i, list) {
			//작품번호	작품명 가격  작품 상세	좋아요	조회수	판매상태 등록일
			var $tr = $("<tr></tr>").appendTo($table);
			var checkbox = $("<td></td>").appendTo($tr);
			var checkboxP = $("<p></p>").appendTo(checkbox);
			$("<input type='checkbox' name='checkbox[]'>").attr("id","check"+list.PRODUCTIDX).val(list.PRODUCTIDX).appendTo(checkboxP);
			$("<label></label>").attr("for","check"+list.PRODUCTIDX).appendTo(checkboxP);
			$("<td></td>").text(list.PRODUCTIDX).appendTo($tr);
			var titleTd = $("<td></td>").text(list.PRODUCTNAME).appendTo($tr);//작품명 클릭시 상세페이지 이동 태그 설정 할 것
			var $link = $("<a></a>").attr("href","/bachida/product/getProduct/"+list.PRODUCTIDX);
			titleTd.wrapInner($link);
			$("<td></td>").text(list.PRODUCTPRICE).appendTo($tr);
			$("<td></td>").text(list.PRODUCTINFO).addClass("target").appendTo($tr);
			$("<td></td>").text(list.RECOMMEND).appendTo($tr);
			$("<td></td>").text(list.VIEWCNT).appendTo($tr);
			$("<td></td>").text(list.PRODUCTSTATE).appendTo($tr);
			$("<td></td>").text(list.WRITEDATE).appendTo($tr);
			var $update_ico = $("<td></td>").appendTo($tr)
			var $update_ico2 =$("<a></a>").attr("data-value",list.PRODUCTIDX).addClass("glyphicon").addClass("glyphicon-cog").appendTo($update_ico);
		
		});
		
		
		/* 
			작성자인 경우 버튼 표시
		var $btn_area = $("#btn_area");
		if ($map.artisanId==$writer){
			$("<button></button>").attr("id","delete").addClass("btn").addClass("btn-danger").addClass("col-md-2").text("삭제").appendTo($btn_area);
			$("<button></button>").attr("id","update").addClass("btn").addClass("btn-warning").addClass("col-md-2").text("수정").appendTo($btn_area);
		} */
		
		

	
		$("#delete").on("click",function(){
			var checkboxArray = Array(); 
			var array_cnt = 0;
			var checkbox = $("input[type=checkbox]:checked");
			if(checkbox.length<1)
				alert("삭제하실 작품 1개 이상 선택해주세요");
			else if(confirm("삭제하시겠습니까?")){
				for(i=0; i<checkbox.length;i++){
					if(checkbox[i].checked==true){
						checkboxArray[array_cnt] = checkbox[i].value;
						array_cnt++;
					}
				}
				console.log(checkboxArray);
				
				// ajax로 보내기 // 처리상태 delete 후 페이지 reload!
				$.ajax({
					url: "/bachida/artisan/product_delete" ,
					type: "post",
					data : {
						checkboxArray:checkboxArray,
						_csrf:'${_csrf.token}'
					},
					success:function(result){
						if(result)
							location.reload(true);
						else
							alert("다시 시도해주세요");
					}
				});
			}
				
		}); 
		$(".glyphicon-cog").on("click",function(e){
			e.preventDefault();
			console.log($(this).attr("data-value"));
			window.open("/bachida/artisan/product_update/?productIdx="+$(this).attr("data-value"),"상품수정","width=900,height=700");
		});
		
		$("#insert").on("click",function(){
			location.href="/bachida/artisan/product_insert";
		});
		
		
		
		var ul = $("#pagination ul");
		var li;
		if($pagination.prev>0) {
			li = $("<li></li>").text('<<').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/artisan/product_list?pageno='+ $pagination.prev))
		}
		for(var i=$pagination.startPage; i<=$pagination.endPage; i++) {
			li = $("<li></li>").text(i).appendTo(ul);
			if($pagination.pageno==i) 
				li.wrapInner($("<a></a").attr('href', '/bachida/artisan/product_list?pageno='+ i).css({"background-color":"#337ab7", "border" : "1px solid #337ab7", "color":"white"}));
			else
				li.wrapInner($("<a></a").attr('href', '/bachida/artisan/product_list?pageno='+ i))
		}
		if($pagination.next>0) {
			li = $("<li></li>").text('>>').appendTo(ul);
			li.wrapInner($("<a></a").attr('href', '/bachida/artisan/product_list?pageno='+ $pagination.next));
		}
		
		
	});
</script>
</head>
<body>
	
		<!--//경로-->
		<div class="page-header clearfix">
			<h3 style="color: rgb(245, 89, 128);">작품관리</h3>
		</div>
	<hr>
	<table class="table centered highlight bordered responsive-table">
		<thead>
			<tr>
				<th></th>
				<th>작품번호</th>                                  
				<th>작품명</th>
				<th>가격</th>
				<th>작품 상세</th>
				<th>좋아요</th>
				<th>조회수</th>    
				<th>판매상태</th>
				<th>등록일</th>  
				<th>상품수정</th>  
			</tr>
		</thead>    
		<tbody id="list">
			
		</tbody>
	</table>
	<div class="row stats" id="stats" >
		<a class="btn btn-danger" id="delete">삭제</a>
		<button id="insert"  class="btn btn-primary">등록</button>
	</div>
	<div id="pagination">    
		<ul class="text-center">
		</ul>
	</div>
	
</body>
</html>