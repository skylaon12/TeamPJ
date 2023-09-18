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
	href="resources/css/home.css?ver=<%=System.currentTimeMillis()%>">
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
		<div class="movie-list">
			<h2>상영 중인 영화</h2>
			<c:forEach var="list" items="${lists}">
				<div class="movie">
					<img src="resources/m_poster/${list.poster_url}" alt="영화 포스터">
					<h3>${list.name}</h3>
					<p>평점: 4.5</p>
					<a href="#">예매하기</a>
				</div>
			</c:forEach>
		</div>
	</main>

	<footer>
		<p>&copy; 2023 영화 예매 사이트</p>
	</footer>
</body>
</html>
