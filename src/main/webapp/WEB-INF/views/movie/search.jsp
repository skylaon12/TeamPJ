<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/movieDetail.css" />
<link rel="stylesheet" href="../resources/css/movieList.css" />
<link rel="stylesheet" href="../resources/css/navbar.css" />
<link rel="stylesheet" href="../resources/css/common.css" />
<!--   	<script type="text/javascript" src="../resources/js/movie/movieFn.js"></script> -->
<link rel="icon" href="../resources/images/favicon.ico"
	type="image/x-icon">
<title>SOL CINEMA</title>
</head>
<body>
	<%@include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="mt-5">
			<h1>전체 영화</h1>
		</div>
		<div id="movie-lists" class="tab-content" id="nav-tabContent">
		<div class="row mt-3 poster">
			<c:forEach var="movie" items="${movies}">
				<div class='col-3 mb-5' style='padding-left: 0px;'>
					<a href="${cp}/movie/detail?no=${movie.id}"> <img
						src='${movie.poster_path}' class='rounded card-img-top'
						style='width: 17rem; height: 440px;'>
					</a>
					<p class='mt-2 title-txt'>${movie.title}</p>
					<span class='openDt-txt'> 개봉일 | ${movie.release_date}</span>
					<div class='d-flex'>
							<a href='${cp}/ticketing/screenList?no=${movie.id}'>
							<input type='button' class='btn btn-primary ticket col-5 mt-1 float-end' value="예매">
							</a>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
</div>
</body>
</html>