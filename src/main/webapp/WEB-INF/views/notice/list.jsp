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


	<script type="text/javascript">
		function sendIt(){
			var f = document.searchForm;
			f.action = "<%=cp%>/movie/list";
			f.submit();
		}
	</script>

</head>
<body>
	<!-- container -->
	<div class="container has-lnb">
		<div class="page-util fixed">
			<div class="inner-wrap">
				<div class="location">
					<a href="${cp}" title="메인 페이지 이동"><span>Home</span></a>
					<a href="https://www.megabox.co.kr/support" title="고객센터 페이지로 이동">고객센터</a>
					<a href="list?page=${currentPage}" title="공지사항 페이지로 이동">공지사항</a>
				</div>
			</div>
		</div>
	
		<div class="inner-wrap">
			<div class="lnb-area addchat location-fixed">
				<nav id="lnb">
					<p class="tit"><a href="https://www.megabox.co.kr/support" title="고객센터">고객센터</a></p>
					<ul>
						<li><a href="http://localhost:8080/movie/list" title="고객센터 홈">고객센터 홈</a></li>
						<li ><a href="http://localhost:8080/movie/list" title="자주 묻는 질문">자주 묻는 질문</a></li>
						<li class="on"><a href="list?page=${currentPage}" title="공지사항">공지사항</a></li>
						<li><a href="http://localhost:8080/movie/created2" title="1:1문의">1:1문의</a></li>
						<li><a href="http://localhost:8080/movie/list" title="단체관람 및 대관문의">단체관람 및 대관문의</a></li>
						<li><a href="http://localhost:8080/movie/list" title="분실물 문의">분실물 문의</a></li>
						<li><a href="http://localhost:8080/movie/list" title="이용약관">이용약관</a></li>
						<li><a href="http://localhost:8080/movie/list" title="위치기반서비스이용약관">위치기반서비스이용약관</a></li>
						<li><a href="http://localhost:8080/movie/list" title="개인정보처리방침">개인정보처리방침</a></li>
						<li><a href="http://localhost:8080/movie/list" style="border-radius: 0 0 10px 10px;" title="스크린배정수에관한기준">스크린배정수에관한기준</a></li>
					</ul>
				</nav>
			</div>
	
			<div id="contents" class="location-fixed">
				<h2 class="tit">공지사항</h2>
	
				<div class="tab-block mb30">
					<ul>
						<li class="on tabBtn"><button type="button" class="btn tabBtn" data-no="" title="전체공지 보기">전체</button></li>
					</ul>
				</div>
	
				<div id="bbsList">
					<div id="bbsList_header">
						<div id="leftHeader">
						<form action="" method="post" name="searchForm">
							<select name="searchKey" class="selectField">
								<option value="subject">제목</option>
								<option value="name">작성자</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="searchValue" class="textField"/>
							<input type="button" value=" 검 색 " class="btn2" 	
							onclick="sendIt()"/>		
						</form>				
						</div>
						<div id="rightHeader">
							
						</div>	
					</div>
					<div id="bbsList_list">
						<div id="title">
							<dl>
								<dt class="num">번호</dt>
								<dt class="subject">제목</dt>
								<dt class="name">작성자</dt>
								<dt class="created">작성일</dt>
								<dt class="hitCount">조회수</dt>
							</dl>
						</div>
						<div id="lists">
						<c:forEach var="dto" items="${lists}"> <%-- BoardDTO : lists와 동일 EL로 받은것  --%>
							<dl>								<%-- EL로 받은것은 변수명을 게터로받지않고 그대로 사용 그렇다고 DAO의 게터세터를 지우면안됌. --%>
								<dd class="num">${dto.p_id }</dd> 
								<dd class="subject">
								<a href="${articleUrl}${dto.p_id }&page=${currentPage }">
								${dto.p_title }</a>
								</dd>
								<dd class="name">${dto.p_writer }</dd>
								<dd class="created">${dto.p_created }</dd>
								<dd class="hitCount">${dto.p_hitcount }</dd>
							</dl>
						</c:forEach>
						</div>
						<div nav class="pagination" id="footer">
							<c:if test="${dataCount!=0 }">
								${pageIndexList }
							</c:if>
							<c:if test="${dataCount==0 }">
								등록된 게시물이 없습니다.
							</c:if>
						</div>
					</div>
					
					<div class="btn-group right">
						<a href="write?page=${currentPage}" class="button purple" id="myQnaBtn" title="공지사항 등록">공지사항 등록</a><!-- btn-layer-open -->
					</div>
					
					<c:if test="${hasPrev == true}" >
						[<a href="${cp}/notice/list?page=${prevPage}"><b>이전</b></a>]
					</c:if>

					<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
						[<a href="${cp}/notice/list?page=${p}">${p}</a>]
					</c:forEach>
					
					<c:if test="${hasNext == true}" >
						[<a href="${cp}/notice/list?page=${nextPage}"><b>다음</b></a>]
					</c:if>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="/WEB-INF/views/common/errorModal.jsp"%>
</body>
</html>