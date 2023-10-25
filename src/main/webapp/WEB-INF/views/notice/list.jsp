<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MEET PLAY SHARE, 솔 시네마</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<link rel="stylesheet" href="${cp}/resources/css/board.css" />
	<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
  	<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
	<script type="text/javascript">
		function sendIt(){
			var f = document.searchForm;
			var curPage = f.page.value;
			var sKey = "${searchKey}";
			var sWord = "${word}";
			
			f.action = "<%=cp%>/notice/list?page="+ curPage +"&searchKey="+ sKey +"&word="+ sWord;
			f.submit();
		}
	</script>

</head>
<body>
	<%@include file="../common/tags.jsp" %>
	<%@include file="../common/navbar.jsp"%>
	<div id="back-container">
        <div id="main-container">
            <%@include file="../common/boardSideBar.jsp"%>

            <article id="content-container">
                <h2 style="padding-bottom: 0.5em;">공지사항</h2>
                <div id="category-area" style="border-top: 1px solid #cacaca; padding: 0.3em 0;">
                    <ul style="display: flex;">
                        <li><button id="cate-all" class="category category-on">전체</button></li>
                        <span style="margin-left: auto; font-size: 12px;">전체 글 수 : </span>
                        <span style="padding: 0 0.3em; font-size: 12px" id="total-post">${totalCount}</span>
                    </ul>
                </div>
                <table style="border-collapse: collapse;">
                    <colgroup>
                        <col style="width: 6%">
                        <col>
                        <col style="width: 10%">
                        <col style="width: 20%">
                        <col style="width: 6%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:choose>
							<c:when test="${totalCount != 0}">
		                    	<c:forEach var="dto" items="${lists}">
			                        <tr>
			                            <td class="text-align-center"><span>${dto.p_id }</span></td>
			                            <td><a href="${articleUrl}${dto.p_id }&page=${currentPage }">${dto.p_title }</a></td>
			                            <td class="text-align-center">${dto.p_writer }</td>
			                            <td class="text-align-center"><span>${dto.p_created }</span></td>
			                            <td class="text-align-center"><span>${dto.p_hitcount }</span></td>
			                        </tr>
			                    </c:forEach>
			              	</c:when>

				            <c:otherwise>
				            	<td>&nbsp</td>
								<td style="margin-left: auto;">등록된 게시물이 없습니다.</td>
								<td>&nbsp</td>
								<td>&nbsp</td>
								<td>&nbsp</td>
							</c:otherwise>
						</c:choose>
                    </tbody>
                </table>
                
               	<form action="" method="get" name="searchForm" id="button-area" style="display: flex; justify-content: flex-end; margin: 15px 0 15px 0px;">
               		<input type="hidden" name ="page" value="${currentPage }">
					
                    <select name="searchKey" id="keyword">
                        <option value="p_title">제목</option>
                        <option value="p_writer">작성자</option>
                        <option value="p_text">내용</option>
                    </select>
                    
                    <input type="text" id="search" name="word">
                    
                    <button id="search-btn" onclick="sendIt()"></button>
                    
                    <a id="post-list-btn" href="list?page=${currentPage }">목록</a>
                    <security:authorize access="hasRole('ADMIN')">
                   		<a id="write" href="write?page=${currentPage}">글쓰기</a>
                   	</security:authorize>
                </form>
                    

                <div id="paging-area" style="display: flex; justify-content: center;">
                	<c:if test="${totalCount != 0}">
						<c:choose>
							<c:when test="${hasPrev}">
								<a href="${cp}/notice/list?page=${prevPage}" class="paging-prev">이전</a>
							</c:when>
							<c:otherwise>
								<a href="#" class="paging-prev">이전</a>
							</c:otherwise>
						</c:choose>
	
						<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
							<c:choose>
								<c:when test="${currentPage == p}">
									<c:choose>
										<c:when test="${not empty word}">
											<a href="${cp}/notice/list?page=${p}&searchKey=${searchKey}&word=${word}" class="paging paging-on">${p}</a>
										</c:when>
										<c:otherwise>
											<a href="${cp}/notice/list?page=${p}" class="paging paging-on">${p}</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${not empty word}">
											<a href="${cp}/notice/list?page=${p}&searchKey=${searchKey}&word=${word}" class="paging">${p}</a>
										</c:when>
										<c:otherwise>
											<a href="${cp}/notice/list?page=${p}" class="paging">${p}</a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${hasNext}">
								<a href="${cp}/notice/list?page=${nextPage}" class="paging-next">다음</a>
							</c:when>
							<c:otherwise>
								<a href="#" class="paging-next">다음</a>
							</c:otherwise>
						</c:choose>
					</c:if>
                </div>
            </article>
        </div>
    </div>
    <%@include file="../common/footer.jsp"%>
</body>
</html>