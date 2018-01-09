<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
		var $apply = ${apply};
		var $attach = $apply.attach;
		var slide = 0;
		var $imgPage = $("#imgPage");
		var $img = $("#img");
		console.log($attach);
		$("#id").text(" "+$apply.id);
		$("#applyDate").text("신청일 : "+$apply.applyDate+" ");
		$("#artisanTel").text("연락처 : "+$apply.artisanTel+" ");
		$("#artisanEmail").text("이메일 : "+$apply.artisanEmail+" ");
		$("#state").text("처리상태 : "+$apply.state+" ");
		$("#artisanIntro").text($apply.artisanIntro);
		$("#craftIntro").text($apply.craftIntro);
		$.each($attach, function(i, attach) {
			if(slide==0){
				$("<li></li>").attr("data-target","#myCarousel").attr("data-slide-to",slide).addClass("active").appendTo($imgPage);
						/* <img src="" style="width: 100%" alt=""> */
				var $item = $("<div></div>").addClass("item active").appendTo($img);
				$("<img>").attr("src","/bachida/user/displayFile?savedFileName="+attach.savedFileName+"&originalFileName="+attach.originalFileName).css({"width":"750px","height":"550px"}).appendTo($item);
			}else{
				$("<li></li>").attr("data-target","#myCarousel").attr("data-slide-to",slide).appendTo($imgPage);
				/* <img src="" style="width: 100%" alt=""> */
				var $item = $("<div></div>").addClass("item").appendTo($img);
				$("<img>").attr("src","/bachida/user/displayFile?savedFileName="+attach.savedFileName+"&originalFileName="+attach.originalFileName).css({"width":"750px","height":"550px"}).appendTo($item);
			}slide++;
			
		});
		
		$("#permitApplyBtn").on("click",function(){
			if(confirm("신청을 허가하시겠습니까?")){
				var $form = $("<form>").appendTo("body");
				$("<input>").attr("name","id").attr("type","hidden").val($apply.id).appendTo($form);
				$("<input>").attr("name","artisanApplyIdx").attr("type","hidden").val($apply.artisanApplyIdx).appendTo($form);
				$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
				var $formData = $form.serialize();
				$.ajax({
					url : "/bachida/admin/permitApply",
					data : $formData,
					type : "post",
					success: function(){
						alert("신청이 허가되었습니다.");
						location.reload();
					}
				});
			}
		});
		
		$("#returnApplyBtn").on("click",function(){
			if(confirm("신청을 반려하시겠습니까?")){
				var $form = $("<form>").appendTo("body");
				$("<input>").attr("name","artisanApplyIdx").attr("type","hidden").val($apply.artisanApplyIdx).appendTo($form);
				$("<input>").attr("name","${_csrf.parameterName }").attr("type","hidden").val("${_csrf.token}").appendTo($form);
				var $formData = $form.serialize();
				$.ajax({
					url : "/bachida/admin/returnApply",
					data : $formData,
					type : "post",
					success: function(){
						alert("신청이 반려되었습니다.");
						location.reload();
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<!-- Page Content -->
	<div class="container">
		<h3 style="color: rgb(245, 89, 128);">작가신청</h3>
		<div class="row">

			<!-- Post Content Column -->
			<div class="col-lg-8">

				<!-- Author -->
				<p class="lead">
					by<a href="#" id="id"> </a>
				</p>

				<hr>

				<!-- Date/Time -->
				<p>
					<span id="applyDate">Posted on January 1, 2017 at 12:00 PM</span><br>
					<span id="artisanTel"></span>
					<span id="artisanEmail"></span>
					<span id="state" class="pull-right"></span>
				</p>

				<hr>

				<!-- Preview Image -->
				<div id="myCarousel" class="carousel slide" data-ride="carousel">

						<!--페이지-->
						<ol id="imgPage" class="carousel-indicators">
							<!-- <li data-target="#myCarousel" data-slide-to="0" class="active"></li> -->
						</ol>
						<!--페이지-->
						
							<div id="img" class="carousel-inner">
							</div>

						<!--이전, 다음 버튼-->
						<a class="left carousel-control" href="#myCarousel" data-slide="prev">
							<span class="glyphicon glyphicon-chevron-left"></span>
						</a>
						<a class="right carousel-control" href="#myCarousel" data-slide="next">
							<span class="glyphicon glyphicon-chevron-right"></span>
						</a>
				</div>
				<hr>
				<h3>작가 소개</h3>
				<p id="artisanIntro"></p>
				<hr>
				<h3>작품 소개</h3>
				<p id="craftIntro"></p>

				<a class="btn btn-default pull-right" id="permitApplyBtn">신청 허가</a>
				<a class="btn btn-default pull-right" id="returnApplyBtn">신청 반려</a>
			</div>
			
		</div>
	</div>
</body>
</html>