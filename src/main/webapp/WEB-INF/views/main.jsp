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
	  	<script src="${cp}/resources/js/login.js"></script>
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
					<a href="${cp}/notice/list?page=1"><img alt="" src="resources/images/supports/ico-oneandone.png">
						<p style="color:black;" class="mt-3">1:1 문의</p>
					</a>
				</div>
				<div class="col"></div>
			</div>
		</div> 
	</div>
	
	
		<!-- 현구 -->
	<!-- 성공했을 때 뜨는 모달 -->
	<div class="modal fade" id="successModal" role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 모달창의 헤더부분의 시작 -->
				<div class="modal-header panel-heading">
					<h4 class="modal-title">메세지 확인</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- 모달창의 헤더부분의 끝 -->
				<!-- 모달창의 바디부분의 시작 바디부분이 모달창에서 표시하고자하는 컨텐츠를 입력한다.-->
				<div class="modal-body">
					<!-- Modal content-->
					<div id="messageType" class="modal-content panel-info">
						<div class="modal-body">
							<p id="checkMessage"></p>
						</div>
					</div>
				</div>
				<!-- 모달창의 바디부분의 끝 -->
				<!-- 모달창의 푸터부분의 시작 -->
				<!-- 푸터부에는 닫기부분이 위치하게 된다.  -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
				<!-- 모달창의 푸터부분의 끝 -->
			</div>
		</div>
	</div>
	<!-- 실패했을 때 뜨는 모달 -->
	<div class="modal fade" id="failedModal" role="dialog" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- 모달창의 헤더부분의 시작 -->
				<div class="modal-header panel-heading">
					<h4 class="modal-title">메세지 확인</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- 모달창의 헤더부분의 끝 -->
				<!-- 모달창의 바디부분의 시작 바디부분이 모달창에서 표시하고자하는 컨텐츠를 입력한다.-->
				<div class="modal-body">
					<!-- Modal content-->
					<div id="messageType" class="modal-content panel-info">
						<div class="modal-body">
							<p>${msg}</p>
						</div>
					</div>
				</div>
				<!-- 모달창의 바디부분의 끝 -->
				<!-- 모달창의 푸터부분의 시작 -->
				<!-- 푸터부에는 닫기부분이 위치하게 된다.  -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
				<!-- 모달창의 푸터부분의 끝 -->
			</div>
		</div>
	</div>
	
<%@include file="common/footer.jsp"%>
<!-- 오류 모달 -->
<%@include file="common/errorModal.jsp"%>
</body>
<script type="text/javascript">
	
$(document).ready(function(){ // 메세지 띄우기
	if(${!empty msgType}){
		$("#messageType").attr("class", "modal-content panel-warning");
		$("#failedModal").modal("show");
	}
});

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
					console.log(index);
					let output = "";
					// 가져온 데이터를 토대로 div에 심어줄 코드 반복 삽입
					output += "<div class='col-3 mt-5 mb-5' style='padding-left: 0px;'>";
					output += "<a href='${cp}/movie/detail?no="+movie.id+"'>";
					output += "<img src = '"+poster+"'class='rounded card-img-top' style='width: 17rem; height:440px;'/>";
					output += "</a>";
					output += "<div class='d-flex mt-3'>";
					output += "<button data-no='"+ movie.id +"' type='button' id='bookButton' class='btn btn-primary col-5 mt-1 float-end'>예매</button>";
					output += "</div>";
					output += "</div>";
					
					$div.append(output);
				})
			});
		}
		
		showTop4();
		// 예매 버튼이 페이지 로딩 시에 렌더링되지 않고, JavaScript 코드 내에서 동적으로 생성되는 경우가 있습니다.
		//이 경우, 이벤트 핸들러를 등록할 때 이 버튼을 참조해야 합니다.
		//이 경우 jQuery의 .on() 함수를 사용하여 이벤트를 위임할 수 있습니다. -chat GPT-  
		$(document).on("click", "#bookButton", function(){
			var movieId = $(this).data("no");	// data-no인 movie.id를 가져옴
			//console.log("MovieID : " + movieId);
			checkLoginStatus("${cp}/ticketing/screenList?no="+movieId)
		});

	})
</script>
</html>