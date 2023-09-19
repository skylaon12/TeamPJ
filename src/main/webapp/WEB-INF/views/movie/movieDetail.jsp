<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 예매 사이트</title>
<link rel="stylesheet"
	href="../resources/css/home.css?ver=<%=System.currentTimeMillis()%>">
</head>
<body>
	<header>
		<h1>영화 예매 사이트</h1>
		<nav>
			<ul>
				<li><a href="#">홈</a></li>
				<li><a href="#">영화 목록</a></li>
				<li><a href="#">예매 내역</a></li>
				<li><a href="${cp}/notice/list">공지사항</a></li>
				<li><a href="#">로그인</a></li>
				<li><a href="#">회원가입</a></li>
			</ul>
		</nav>
	</header>

	<main>
		<div class="movie-detail-page">
			<div class="bg-img"
				style="background-image: url('https://img.megabox.co.kr/SharedImg/2023/09/06/pvp0aae1G11CUCBtP2ynLNg5hRCiKqeq_570.jpg');"></div>
			<div class="bg-pattern"></div>
			<div class="bg-mask"></div>

			<!-- movie-detail-cont -->
			<div class="movie-detail-cont">

				<!-- 개봉 예매가능-->
				<p class="title">${movie.name}</p>
				<!--// info -->

				<div class="poster">
					<div class="wrap">

						<p class="movie-grade age-15">15세 이상 관람가</p>
						<img
							src="../resources/m_poster/${movie.poster_url }"
							onerror="noImg(this)" alt="영화포스터">
						${movie.trailer_url}
					</div>
					
				</div>
				<div class="reserve screen-type col-2">
					<div class="reserve">
						<a href="javascript:fn_bookingForm('23069500','basic');"
							class="btn reserve" title="영화 예매하기">예매</a> 
							<a href="javascript:fn_bookingForm('23069500','DBC');" class="btn dolby">
							<img src="/static/pc/images/common/btn/mov_detail_db_btn.png" alt="dolby 버튼">
						</a>
						
					</div>
				</div>
			</div>
			<!--// movie-detail-cont -->
		</div>
	</main>

	<footer>
		<p>&copy; 2023 영화 예매 사이트</p>
	</footer>
</body>
</html>
