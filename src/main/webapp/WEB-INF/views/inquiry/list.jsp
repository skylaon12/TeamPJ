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
			var curPage = f.page.value;
			var curCategory = f.p_category.value;
			var sKey = "${searchKey}";
			var sWord = "${word}";
			
			if (curCategory == null || curCategory === '') {
				f.action = "<%=cp%>/inquiry/list?page="+ curPage +"&searchKey="+ sKey +"&word="+ sWord;
			} else {
				f.action = "<%=cp%>/inquiry/list?page="+ curPage +"&p_category="+ curCategory +"&searchKey="+ sKey +"&word="+ sWord;
			}
			
			f.submit();
		}
		
		function sendList(){
			var curPage = "${currentPage}";
		    // 페이지 이동
			window.location.href = "<%=cp%>/inquiry/list?page="+ curPage;
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
					<a href="list?page=${currentPage}" title="내 문의로 이동">내 문의 내역</a>
				</div>
			</div>
		</div>
	
		<div class="inner-wrap">
			<div class="lnb-area addchat location-fixed">
				<nav id="lnb">
					<p class="tit"><a href="https://www.megabox.co.kr/support" title="고객센터">고객센터</a></p>
					<ul>
						<li><a href="https://www.megabox.co.kr/support" title="고객센터 홈">고객센터 홈</a></li>
						<li><a href="${cp}/notice/list?page=1" title="공지사항">공지사항</a></li>
						<li><a href="write?page=${currentPage }" title="1:1문의">1:1 문의 하기</a></li>
						<li class="on"><a href="list?page=${currentPage }" title="1:1문의">내 문의 내역</a></li>
					</ul>
				</nav>
			</div>
	
			<div id="contents" class="location-fixed">
				<h2 class="tit">내 문의 내역</h2>
				
				<div class="tab-block mb30">
				    <ul>
				        <c:choose>
				            <c:when test="${empty param.p_category or param.p_category eq '전체'}">
				                <li class="on tabBtn"><a href="list?page=${currentPage }" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="전체 내 문의 내역">전체</button></a></li>
				                <li class="tabBtn"><a href="list?page=${currentPage }&p_category=결제/환불" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="결제/환불">결제/환불</button></a></li>
								<li class="tabBtn"><a href="list?page=${currentPage }&p_category=영화관" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="영화관">영화관</button></a></li>
				            </c:when>
				            <c:when test="${param.p_category eq '결제/환불'}">
				            	<li class="tabBtn"><a href="list?page=${currentPage }" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="전체 내 문의 내역">전체</button></a></li>
				                <li class="on tabBtn"><a href="list?page=${currentPage }&p_category=결제/환불" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="결제/환불">결제/환불</button></a></li>
				                <li class="tabBtn"><a href="list?page=${currentPage }&p_category=영화관" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="영화관">영화관</button></a></li>
				            </c:when>
				            <c:when test="${param.p_category eq '영화관'}">
				            	<li class="tabBtn"><a href="list?page=${currentPage }" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="전체 내 문의 내역">전체</button></a></li>
								<li class="tabBtn"><a href="list?page=${currentPage }&p_category=결제/환불" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="결제/환불">결제/환불</button></a></li>
				                <li class="on tabBtn"><a href="list?page=${currentPage }&p_category=영화관" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="영화관">영화관</button></a></li>
				            </c:when>
				            <c:otherwise>
				                <li class="tabBtn"><a href="list?page=${currentPage }" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="전체 내 문의 내역">전체</button></a></li>
								<li class="tabBtn"><a href="list?page=${currentPage }&p_category=결제/환불" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="결제/환불">결제/환불</button></a></li>
								<li class="tabBtn"><a href="list?page=${currentPage }&p_category=영화관" title="카테고리"><button type="button" class="btn tabBtn" data-no="" title="영화관">영화관</button></a></li>
				            </c:otherwise>
				        </c:choose>
				    </ul>
				</div>
	
				<div id="bbsList">
					<div id="bbsList_header">
						<div id="leftHeader">
							<form action="" method="get" name="searchForm">
								<input type="hidden" name ="page" class="input-text w150px" value="${currentPage }">
								<input type="hidden" name ="p_category" class="input-text w150px" value="${p_category }">
								<select name="searchKey" class="selectField">
									<option value="p_title">제목</option>
									<option value="p_text">내용</option>
								</select>
								<input type="text" name="word" class="textField"/>
								<input type="button" value=" 검 색 " class="btn2" 	
								onclick="sendIt()"/>
								<input type="button" value=" 리 스 트 " class="btn2" 	
								onclick="sendList()"/>
							</form>
						</div>
						<div id="rightHeader">
							전체 글 수: ${totalCount}
						</div>	
					</div>
					<div id="bbsList_list">
						<div id="title">
							<dl>
								<dt class="num">번호</dt>
								<dt class="subject">제목</dt>
								<dt class="name">문의 상태</dt>
								<dt class="created">작성일</dt>
								<dt class="hitCount">조회수</dt>
							</dl>
						</div>
						<div id="lists">
						<c:forEach var="dto_inquiry" items="${lists}"> <%-- BoardDTO : lists와 동일 EL로 받은것  --%>
							<dl>								<%-- EL로 받은것은 변수명을 게터로받지않고 그대로 사용 그렇다고 DAO의 게터세터를 지우면안됌. --%>
								<dd class="num">${dto_inquiry.p_id }</dd> 
								<dd class="subject">
									<c:choose>
										<c:when test="${dto_inquiry.newComment}">
											[${dto_inquiry.p_category }] <a href="${articleUrl}${dto_inquiry.p_id }&page=${currentPage }">
											${dto_inquiry.p_title } </a> [${dto_inquiry.commentCount}] NEW
										</c:when>
										<c:otherwise>
											[${dto_inquiry.p_category }] <a href="${articleUrl}${dto_inquiry.p_id }&page=${currentPage }">
											${dto_inquiry.p_title } </a> [${dto_inquiry.commentCount}]
										</c:otherwise>
									</c:choose>
								</dd>
								<c:choose>
									<c:when test="${dto_inquiry.p_status == 'T'}">
										<dd class="name">완료</dd>
									</c:when>
									<c:otherwise>
										<dd class="name">진행 중...</dd>
									</c:otherwise>
								</c:choose>
								<dd class="created">${dto_inquiry.p_created }</dd>
								<dd class="hitCount">${dto_inquiry.p_hitcount }</dd>
							</dl>
						</c:forEach>
						</div>
						<div nav class="pagination" id="footer">
							<c:choose>
								<c:when test="${totalCount != 0}">
									<c:choose>
										<c:when test="${hasPrev}">
											[<a href="${cp}/inquiry/list?page=${prevPage}&p_category=${p_category}"><b>이전</b></a>]
										</c:when>
										<c:otherwise>
											[이전]
										</c:otherwise>
									</c:choose>
				
									<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
										<c:choose>
											<c:when test="${word != null}">
												[<a href="${cp}/inquiry/list?page=${p}&p_category=${p_category}&searchKey=${searchKey}&word=${word}">${p}</a>]
											</c:when>
											<c:otherwise>
												[<a href="${cp}/inquiry/list?page=${p}&p_category=${p_category}">${p}</a>]
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<c:choose>
										<c:when test="${hasNext}">
											[<a href="${cp}/inquiry/list?page=${nextPage}&p_category=${p_category}"><b>다음</b></a>]
										</c:when>
										<c:otherwise>
											[다음]
										</c:otherwise>
									</c:choose>
								</c:when>
								
								<c:otherwise>
									등록된 게시물이 없습니다.
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					
					<div class="btn-group right">
						<a href="write?page=${currentPage}" class="button purple" id="myQnaBtn" title="1:1 문의 남기기">문의 하기</a><!-- btn-layer-open -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
</html>