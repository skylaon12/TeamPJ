<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="tags.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="memberVO" value="${SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities}"/>
<div id="header">
	<div class="container">
		<nav class="navbar navbar-expand-lg navbar-light bg-top p-0"
			id="navbar-top">
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a href="${cp}/notice/list" class="nav-link">1대1문의 및 공지사항</a></li>
				</ul>
				<security:authorize access="isAnonymous()"><!-- 인증확인 태그 / 인증이 되지않은 사용자용 --> 
				<ul class="navbar-nav">
						<li class="nav-item"><a href="${cp}/member/login" class="nav-link">로그인</a></li>
						<li class="nav-item"><a href="${cp}/member/signup" class="nav-link">회원가입</a></li>
				</ul>				
				</security:authorize>
				<security:authorize access="isAuthenticated()"><!-- 인증된 사용자 -->
					<ul class="navbar-nav">
						<security:authorize access="hasRole('ADMIN')">
							<li class="nav-item"><a href="${cp}/admin/main" class="nav-link">관리자 페이지</a></li>
						</security:authorize>					
						<li class="nav-item"><a href="${cp}/member/navLogout" class="nav-link">로그아웃</a></li>
					</ul>				
				</security:authorize>
			</div>
		</nav>

		<nav class="navbar navbar-expand-lg navbar-light" id="navbar-2">
			<div class="collapse navbar-collapse justify-content-start">
				<ul class="navbar-nav util-list">
					<li class="nav-item"><a class="nav-link" href="#">
						<img src="${cp}/resources/images/nav/ico-sitemap.png"></a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						<img src="${cp}/resources/images/nav/ico-search.png"></a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown" style="">
							<div class="search-box p-3">
								<form action="${cp}/movie/search">
									<input class="form-control" type="search" name="keyword" value="" placeholder="영화를 검색하세요!" aria-label="Search">
									<button class="btn btn-sm" type="submit">
										<img src="${cp}/resources/images/nav/ico-search.png">
									</button>
								</form>
							</div>
						</ul>
					</li>
				</ul>
			</div>
			<div class="collapse navbar-collapse justify-content-center"
				id="navbarNav">
				<ul class="navbar-nav ">
					<li class="nav-item"><a class="nav-link" href="#">영화</a></li>
					<li class="nav-item"><a class="nav-link" href="#">예매</a></li>
					<li class="nav-item"><a class="nav-link" href="#">극장</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/" style="font-family: 'Alfa Slab One'; font-weight: 400;">SOL CINEMA</a></li>
					<li class="nav-item"><a class="nav-link" href="#">이벤트</a></li>
					<li class="nav-item"><a class="nav-link" href="#">스토어</a></li>
					<li class="nav-item"><a class="nav-link" href="#">혜택</a></li>
				</ul>
			</div>
			<div class="collapse navbar-collapse justify-content-end">
				<ul class="navbar-nav util-list">
					<security:authorize access="isAuthenticated()"><!-- 인증된 사용자 -->
					<li class="nav-item">
						<a class="nav-link" href="${cp}/ticketing/reservationInfo">
							<img src="${cp}/resources/images/nav/ico-schedule.png">
						</a>
					</li>
					</security:authorize>
					<li class="nav-item">
						<a class="nav-link" href="${cp}/member/info">
							<img src="${cp}/resources/images/nav/ico-mymega.png">
						</a>
					</li>
				</ul>
			</div>
		</nav>
	</div>
</div>