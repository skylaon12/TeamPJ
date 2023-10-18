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
	
	<script type="text/javascript" src="/resources/js/util.js"></script>
	<script type="text/javascript">
	
		function sendIt(){
			
			var f = document.myForm;
			var page = "${articleCurrentPage}";
			
			id = f.p_ori_id.value;
			
			str = f.p_writer.value;
			str = str.trim();
			if(!str){
				alert("\n이름을 입력하세요.");
				f.p_writer.focus();
				return;
			}		
			
			f.p_writer.value = str;
			
			str = f.p_comment.value;
			str = str.trim();
			if(!str){
				alert("\n내용을 입력하세요.");
				f.p_comment.focus();
				return;
			}
			f.p_comment.value = str;
			
			f.action = "<%=cp%>/inquiry/writeComment?p_id=" + id + "&page="+ page;
			f.submit();
			alert("댓글 등록이 완료 되었습니다.");
		}
	
	</script>
</head>
<body>
	<div class="container has-lnb">
		<div class="page-util fixed">
			<div class="inner-wrap">
				<div class="location">
					<a href="${cp}" title="메인 페이지 이동"><span>Home</span></a>
					<a href="https://www.megabox.co.kr/support" title="고객센터 페이지로 이동">고객센터</a>
					<a href="list?page=${articleCurrentPage }" title="내 문의로 이동">내 문의 내역</a>
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
						<li><a href="${cp}/notice/list?page=1" title="공지사항">공지사항</a></li>
						<li><a href="write?page=${articleCurrentPage }" title="1:1문의">1:1 문의 하기</a></li>
						<li class="on"><a href="list?page=${articleCurrentPage }" title="1:1문의">내 문의 내역</a></li>
					</ul>
				</nav>
			</div>

			<div id="contents" class="location-fixed">
				<h2 class="tit">내 문의 내역</h2>

				<div class="table-wrap">
					<div class="board-view">
						<div class="tit-area">
							<p class="tit">	${article.p_title }</p>
						</div>

						<div class="info">
							<p>
								<span class="tit">등록일</span>
								<span class="txt">${article.p_created }</span>
							</p>
							
							<p>
								<span class="tit">조회수</span>
								<span class="txt">${article.p_hitcount }</span>
							</p>
							
							<p>
								<span class="tit">답변 상태</span>
								<c:choose>
									<c:when test="${article.p_status == 'T'}">
										<span class="txt">O</span>
									</c:when>
									<c:otherwise>
										<span class="txt">X</span>
									</c:otherwise>
								</c:choose>
							</p>
						</div>

						<div class="cont">${articleContent }</div>
						
						<br/>	<hr/>	<br/>
						
						<form action="" method="post" name="myForm">
							이름: <input type="text"  name ="p_writer" class="input-text w150px" value="" maxlength="15">
							
							<input type="hidden" name ="p_ori_id" class="input-text w150px" value="${article.p_id }">
							
							<div class="textarea">
								<textarea name="p_comment" rows="5" cols="10" title="내용입력" placeholder="※ 댓글을 써주세요." class="input-textarea"></textarea>
								<div class="util">
									<p class="count">
										<span id="textareaCnt">0</span> / 2000
									</p>
								</div>
							</div>
							
							<input type="button" value=" 등록하기 " class="button purple large" onclick="sendIt();"/>
							<input type="reset" value=" 다시입력 " class="button purple large" 
							onclick="document.myForm.p_comment.focus();"/>
						</form>
						
						
						<br/>
						
						<div id="lists">
							<c:forEach var="dto" items="${commentLists}">
								<div class="cont">${dto.p_writer } | ${dto.p_created } -> ${dto.p_comment }</div>
							</c:forEach>
						</div>
						
						<br/>
						
						<c:choose>
							<c:when test="${commentTotalCount != 0}">
								<c:choose>
									<c:when test="${commentHasPrev}">
										[<a href="${cp}/inquiry/article?p_id=${article.p_id }&page=${articleCurrentPage }&coPage=${commentPrevPage}"><b>이전</b></a>]
									</c:when>
									<c:otherwise>
										[이전]
									</c:otherwise>
								</c:choose>
			
								<c:forEach var="p" begin="${commentBlockStartNo}" end="${commentBlockEndNo}">
									[<a href="${cp}/inquiry/article?p_id=${article.p_id }&page=${articleCurrentPage }&coPage=${p}">${p}</a>]
								</c:forEach>
								
								<c:choose>
									<c:when test="${commentHasNext}">
										[<a href="${cp}/inquiry/article?p_id=${article.p_id }&page=${articleCurrentPage }&coPage=${commentNextPage}"><b>다음</b></a>]
									</c:when>
									<c:otherwise>
										[다음]
									</c:otherwise>
								</c:choose>
							</c:when>
							
							<c:otherwise>
								<div class="cont">등록된 댓글이 없습니다.</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<br/>
				
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
					<a href="javascript:location.href='<%=cp%>/inquiry/modify?p_id=${article.p_id}&page=${articleCurrentPage }';" class="button large listBtn" title="수정">수정</a>
					
					<a href="javascript:location.href='<%=cp%>/inquiry/list?page=${articleCurrentPage }';" class="button large listBtn" title="리스트">리스트</a>
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