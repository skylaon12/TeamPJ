<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HTA CINEMA</title>
  	<script type="text/javascript" src="../resources/js/movie/movieFn.js"></script>
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
  	<link rel="stylesheet" href="../resources/css/movieDetail.css" />
  	<link rel="stylesheet" href="../resources/css/movieList.css" />
  	<link rel="stylesheet" href="../resources/css/navbar.css" />
  	<link rel="stylesheet" href="../resources/css/common.css" />
  	<link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon">
</head>
<style>
</style>
<body id="body">
	<%@include file="../common/tags.jsp" %>
	<%@include file="../common/navbar.jsp"%>
	<div>
		<div class="mt-3 bg-dark movie-head">
			<div class="container">
				<div class="row" id="movie-head">
					<div class="col ms-3 mt-5 mb-5">
						<h1 id="title">${title}</h1>
						<p id="original-title">${original_title}</p>
						<div class="row" style="margin-top: 310px;">
							<div class="col-3 rating-top">
								<p>개봉일</p>
								<span class="score">${openDate}</span>
							</div>
							<div class="col-3 score-top">
								<p>관람 평점</p>
								<span class="score">${voteAverage}</span>
							</div>
						</div>
					</div>
					<div class="col mt-5 mb-5">
						<img class="rounded" id="poster" src="${poster}" style="width: 18rem;">
						<button type='button' class='ticketing btn btn-primary mt-3'><a href="#">예매</a></button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div>
			<nav>
				<div class="nav nav-tabs nav-justified mt-5" id="nav-tab" role="tablist">
					<button class="nav-link active detail-info" id="nav-main-tab"
						data-bs-toggle="tab" data-bs-target="#nav-main" type="button"
						role="tab" aria-controls="nav-main" aria-selected="true">주요정보
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
							<span>출연진:
						</span><span id="actors"></span>
					</div>
				</div>
				
				<!-- 관람평 -->
				<div class="review-box">
				</div>
			</div>
			<div class="tab-pane fade" id="nav-video" role="tabpanel"
				aria-labelledby="nav-video-tab">
				<div class="row mt-3">
					<span style="font-weight: bold">메인 예고편</span>
					<iframe height="600px" src="https://www.youtube.com/embed/${video}"></iframe>
				</div>
			</div>
		</div>
	</div>

<%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
<%@include file="../common/errorModal.jsp"%>
</body>

</html>