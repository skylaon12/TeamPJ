<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="shortcut icon"
		href="https://www.megabox.co.kr/static/pc/images/favicon.ico">
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MEET PLAY SHARE, 솔 시네마</title>
	
	<link rel="stylesheet" type="text/css" href="${cp}/resources/css/style.css?ver=<%=System.currentTimeMillis()%>"/>
	<link rel="stylesheet" type="text/css" href="${cp}/resources/css/list.css?ver=<%=System.currentTimeMillis()%>"/>
	<link rel="stylesheet" type="text/css" href="${cp}/resources/css/main_files/megabox.min.css?ver=<%=System.currentTimeMillis()%>" media="all">
	<link rel="stylesheet" href="${cp}/resources/css/navbar.css" />
	<link rel="stylesheet" href="${cp}/resources/css/common.css" />
</head>
<body>
	<div class="container has-lnb">
		<div class="page-util fixed">
			<div class="inner-wrap">
				<div class="location">
					<a href="${cp}" title="메인 페이지 이동"><span>Home</span></a>
					<a href="https://www.megabox.co.kr/support" title="고객센터 페이지로 이동">고객센터</a>
					<a href="list?page=${articleCurrentPage }" title="공지사항 페이지로 이동">공지사항</a>
					<a href="article?p_id=${article.p_id}" title="글">${article.p_title }</a>
				</div>
	
			</div>
		</div>

		<div class="inner-wrap">
			<div class="lnb-area addchat location-fixed">
				<nav id="lnb">
					<p class="tit"><a href="https://www.megabox.co.kr/support" title="고객센터">고객센터</a></p>
					<ul>
						<li><a href="https://www.megabox.co.kr/support" title="고객센터 홈">고객센터 홈</a></li>
						<li class="on"><a href="list?page=${articleCurrentPage }" title="공지사항">공지사항</a></li>
						<li><a href="${cp}/inquiry/write?page=1" title="1:1문의">1:1 문의 하기</a></li>
						<li><a href="${cp}/inquiry/list?page=1" title="1:1문의">내 문의 내역</a></li>
					</ul>
				</nav>
			</div>

			<div id="contents" class="location-fixed">
				<h2 class="tit">공지사항</h2>

				<div class="table-wrap">
					<div class="board-view">
						<div class="tit-area">
							<p class="tit">	${article.p_title }</p>
						</div>

						<div class="info">
							<p>
								<span class="tit">작성자</span>
								<span class="txt">${article.p_writer }</span>
							</p>
							
							<p>
								<span class="tit">등록일</span>
								<span class="txt">${article.p_created }</span>
							</p>
							
							<p>
								<span class="tit">조회수</span>
								<span class="txt">${article.p_hitcount }</span>
							</p>
						</div>

						<div class="cont">${articleContent }</div>
					</div>
				</div>
				
				<div class="prev-next">
				    <div class="line prev">
				        <p class="tit">이전</p>
				        <c:choose>
				            <c:when test="${not empty previousArticleUrl}">
				                <a href="${previousArticleUrl}" class="link moveBtn" title="이전 글">${previousArticleTitle }</a>
				            </c:when>
				            <c:otherwise>
				                <p class="link">이전글이 없습니다.</p>
				            </c:otherwise>
				        </c:choose>
				    </div>
				    <div class="line next">
				        <p class="tit">다음</p>
				        <c:choose>
				            <c:when test="${not empty nextArticleUrl}">
				                <a href="${nextArticleUrl}" class="link moveBtn" title="다음 글">${nextArticleTitle }</a>
				            </c:when>
				            <c:otherwise>
				                <p class="link">다음글이 없습니다.</p>
				            </c:otherwise>
				        </c:choose>
				    </div>
				</div>

				<div class="btn-group pt40">
					<a href="javascript:location.href='<%=cp%>/notice/modify?p_id=${article.p_id}&page=${articleCurrentPage }';" class="button large listBtn" title="수정">수정</a>
					<a href="javascript:location.href='<%=cp%>/notice/del?p_id=${article.p_id}&page=${articleCurrentPage }';" class="button large listBtn" title="삭제">삭제</a>
					<a href="javascript:location.href='<%=cp%>/notice/list?page=${articleCurrentPage }';" class="button large listBtn" title="리스트">리스트</a>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
</html>