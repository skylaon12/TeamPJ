<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	  	<meta charset="utf-8">
	<!--   	<meta name="viewport" content="width=device-width, initial-scale=1"> -->
	  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  	<link rel="stylesheet" href="resources/css/navbar.css" />
	  	<link rel="stylesheet" href="resources/css/common.css" />
	  	<link rel="icon" href="resources/images/favicon.ico" type="image/x-icon">
	<title>SOL CINEMA</title>
</head>
<style>

p, a {
	font-family: 'Nanum Gothic', sans-serif;
}

a { color: #fff; text-decoration: none;}

a:hover { color: #fff; text-decoration: underline;}

</style>
<body>
<%@include file="/WEB-INF/views/common/navbar.jsp"%>
	<div class="mt-3 bg-dark movie-head">
		<div class="container">
			<div class="row" id="movie-head">
				<div class="row mt-3 poster">
					<!-- 여기 div에 movie top 4 들어감 -->					
				</div>
			</div>
			<div class="row text-center">
				<div class="col-4 mb-5">
					<a href="">
						<img alt="" src="resources/images/main/ico-schedule-main.png">
					상영시간표 
					</a>
				</div>
				<div class="col-4 mb-5">
					<a href="${cp}/movie/list">
						<img alt="" src="resources/images/main/ico-boxoffice-main.png">
					박스오피스
					</a>
				</div>
				<div class="col-4 mb-5">
					<a href="/ticketing/screenList">
						<img alt="" src="resources/images/main/ico-quick-reserve-main.png">
					빠른예매 
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
	 	<div class="container mt-5 text-center">
	 		<div class="row">
	 			<h4>궁금하신 점이 있으신가요?</h4>
	 			<p>고객센터에 문의해 보세요.</p>
	 		</div>
			<div class="row text-center mt-3">
				
				<div class="col">
					<a href="${cp}/notice/list"><img alt="" src="resources/images/supports/ico-oneandone.png">
						<p style="color:black;" class="mt-3">1:1 문의</p>
					</a>
				</div>
				<div class="col"></div>
			</div>
		</div> 
	</div>
<%@include file="common/footer.jsp"%>
<!-- 오류 모달 -->
<%@include file="common/errorModal.jsp"%>
</body>
<script type="text/javascript">
	$(function() {
		
		var errorModal = new bootstrap.Modal(document.getElementById("modal-info-error"), {
			keyboard: false
		});
		// 이미지 API URL
		let imageUrl = "https://image.tmdb.org/t/p/w500/";
		let $div = $(".poster");
		
		function showTop4() {
			// /solcinema/rest/top4에 요청
			// 성공시 function(response)함수 실행
			$.getJSON('/solcinema/rest/top4', function(response) {
				// index : 반복되는 요소 또는 속성의 인덱스 값
				// movie : 반복되는 요소 또는 속성의 값, 즉 실제 데이터
				$.each(response, function(index, movie) {
					// 포스터 apiurl
					let poster = imageUrl + movie.poster_path;
					
					let output = "";
					// 가져온 데이터를 토대로 div에 심어줄 코드 반복 삽입
					output += "<div class='col-3 mt-5 mb-5' style='padding-left: 0px;'>";
					output += "<a href='${cp}/movie/detail?no="+movie.id+"'>";
					output += "<img src = '"+poster+"'class='rounded card-img-top' style='width: 17rem; height:440px;'/>";
					output += "</a>";
					output += "<div class='d-flex mt-3'>";
					output += "<a href='${cp}/ticketing/screenList?no="+movie.id+"'><button data-no='"+ movie.id +"' type='button' class='btn btn-primary col-5 mt-1 float-end'>예매</button></a>";
					output += "</div>";
					output += "</div>";
					
					$div.append(output);
				})
			});
		}
		showTop4();
	})
</script>
</html>