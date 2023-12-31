<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SOL CINEMA</title>
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  	<link rel="stylesheet" href="../resources/css/movieDetail.css?ver=<%=System.currentTimeMillis()%>" />
  	<link rel="stylesheet" href="../resources/css/movieList.css??ver=<%=System.currentTimeMillis()%>" />
  	<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
  	<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
  	<link rel="icon" href="../resources/images/logo/logo-s.png" type="image/x-icon">
  	<script src="../resources/js/login.js"></script>
</head>
<style>
</style>
<body id="body">
	<%@include file="../common/tags.jsp" %>
	<%@include file="../common/navbar.jsp"%>
	<div>
		<div class="mt-3 bg-dark movie-head">
			<div class="container" style="backdrop-filter: blur(10px);">
				<div class="row" id="movie-head">
					<div class="col ms-3 mt-5 mb-5">
						<h1 id="title">${title}</h1>
						<p id="original-title">${original_title}</p>
						<div class="row" style="margin-top: 310px;">
							<div class="title-score rating-top">
								<p>개봉일</p>
								<span class="score" style="color: white;">${openDate}</span>
							</div>
							<div class="title-score score-top">
								<p>관람 평점</p>
								<span class="score">${voteAverage}</span>
							</div>
						</div>
					</div>
					<div class="col mt-5 mb-5" style="display: flex; flex-direction: column; justify-content: center;">
						<img class="rounded" id="poster" src="${poster}" style="width: 18rem;">
						<a href="${cp}/ticketing/screenList?no=${id}"><button type='button' id="bookButton" class='ticketing btn btn-primary mt-3' style="width: 18rem;">예매</button></a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div>
			<nav>
				<div class="nav nav-tabs nav-justified mt-5" id="nav-tab" role="tablist">
				
				
					<button class="nav-link active detail-info" id="nav-main-tab" data-bs-toggle="tab"
						data-bs-target="#nav-main" type="button" role="tab"
						aria-controls="nav-main" aria-selected="true">주요정보
					</button>
					<button class="nav-link detail-info" id="nav-review-tab" data-bs-toggle="tab"
						data-bs-target="#nav-review" type="button" role="tab"
						aria-controls="nav-review" aria-selected="false">실관람평
					</button>
					<button class="nav-link detail-info" id="nav-video-tab" data-bs-toggle="tab"
						data-bs-target="#nav-video" type="button" role="tab"
						aria-controls="nav-video" aria-selected="false">예고편
					</button>
					
					
				</div>
			</nav>
		</div>
		<div id="error">
			<span></span>
		</div>
		<div id="info-lists" class="tab-content" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-main" role="tabpanel"
				aria-labelledby="nav-main-tab">
				<div class="row mt-5 mb-5 ms-1">
					<div class="col">
						<span id="tagline">${original_title}</span><br><br>
						<span id="overview">${overview }</span><br>
						<br><span>장르:${genre} | </span>
						<span id="runtime"></span> 상영시간:${runtime}분 | 개봉일: ${openDate}<br>
						<span>출연진</span><br>
						<div class="actors">
						    <c:forEach var="actor" items="${actors}">
	        					<div class="actor-item">
						            <img class="actor" alt="사진이 없습니다." src="${actor.profile_path}">
						            <div class="actor-info">
						                <span>${actor.original_name}</span><br>
						                <span>배역 : ${actor.character}</span>
						            </div>
						        </div>
						    </c:forEach>
						</div>
					</div>
				</div>
			</div>
			<!-- 관람평 -->
			<!-- todo : 영화에 따라 db에서 댓글 정보 가져오기 -->
			<div class="tab-pane fade review-box" id="nav-review" role="tabpanel"
			aria-labelledby="nav-review-tab">
				<div class="cmt_list">
		        <!-- 댓글 목록이 여기에 표시됩니다. -->
		        <!-- 댓글 목록 예시 -->
		       	<c:forEach var="com" items="${comments}">
		        	<div class="comment-item">
		        		<p class="comment-text">댓글내용: ${com.r_text}</p>
        				<span class="comment-author">작성자: ${com.u_name}</span><br>
        				<span class="comment-date">작성일자: ${com.created}</span>
	        		</div>
		       	</c:forEach>
			    </div>
			    <security:authorize access="isAuthenticated()"><!-- 인증된 사용자 -->
			    	<form id="comment-form" action="${cp}/movie/setComment" method="POST" class="comment-form">
    					<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
    					<input type="hidden" id="m_id" name="m_id" value="${id}"/>
    					<input type="hidden" id="u_name" name="u_name" value="${LOGIN_USER.name}"/>
    					<input type="hidden" id="u_account" name="u_account" value="${LOGIN_USER.account}"/>
    					<div id="comment-input">
        					<textarea id="r_text" name="r_text" placeholder="댓글을 입력하세요..."></textarea>
        					<button id="comment-submit" type="submit" class="btn btn-dark">등록</button>
    					</div>
					</form> <!-- 126행까지 -->
			    </security:authorize>
			</div>
			
			
			<div class="tab-pane fade" id="nav-video" role="tabpanel"
				aria-labelledby="nav-video-tab">
				<div class="row mt-3">
					<span>메인 예고편</span>
					<iframe height="600px" src="https://www.youtube.com/embed/${video}"></iframe>
				</div>
			</div>
		</div>
	</div>

<%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
<%@include file="../common/alertModal.jsp" %>

</body>
<script src="../resources/js/alertModal.js"></script>
<script>
$(document).ready(function(){ // 메세지 띄우기
	if(${!empty msgType}){
		$("#successModal").modal("show");
	}
});

// $(function(){
// 	$(document).on("click", "#bookButton", function(){
// 		var movieId = $(this).data("no");	// data-no인 movie.id를 가져옴
// 		//console.log("MovieID : " + movieId);
// 		checkLoginStatus("${cp}/ticketing/screenList?no="+movieId);
// 	});
// })
</script>
</html>