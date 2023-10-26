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
</head>
<body>
	<%@include file="../common/tags.jsp" %>
	<%@include file="../common/navbar.jsp"%>
	<div id="back-container">
        <div id="main-container">
            <%@include file="../common/boardSideBar.jsp"%>

            <article id="content-container">
                <h2 id="post-title" style="padding-bottom: 0.2em;">${article.p_title }</h2>

                <div id="detail-area" style="display: flex; border-bottom: 1px solid #cacaca; padding-top: 0.5em; padding-bottom: 1em; margin-bottom: 1em; font-size: 13px;">
                    <div>등록일</div>
                    <span id="post-date" class="post-detail">${article.p_created }</span>
                    <div>조회수</div>
                    <span id="post-view" class="post-detail">${article.p_hitcount }</span>
                    <div>작성자</div>
					<span id="post-status" class="post-detail">${article.p_writer }</span>
                </div>

                <div id="content-area">
                    <span>${articleContent }</span>
                </div>

                <div id="post-change-area">
                    <div id="post-prev" style="border-bottom: 1px solid #cacaca;">
                        <div style="width: 20%; background: #e4e4e4 url('../resources/images/supports/arrow-top.png') no-repeat center right 15px; background-size: 10%; line-height: 39px;">
                            <span style="margin-left: 20px;">이전 글</span>
                        </div>
                        <div style="line-height: 39px;">
                        	<c:choose>
				            	<c:when test="${not empty previousArticleUrl}">
                            		<a href="${previousArticleUrl}" style="margin-left: 20px;">${previousArticleTitle }</a>
                            	</c:when>
                            	<c:otherwise>
				                	<span style="margin-left: 20px;">이전 글이 없습니다.</span>
				            	</c:otherwise>
				            </c:choose>
                        </div>
                    </div>
                    <div id="post-next">
                        <div style="width: 20%; background: #e4e4e4 url('../resources/images/supports/arrow-bottom.png') no-repeat center right 15px; background-size: 10%; line-height: 39px;">
                            <span style="margin-left: 20px;">다음 글</span>
                        </div>
                        <div style="line-height: 39px;">
                        	<c:choose>
				            	<c:when test="${not empty nextArticleUrl}">
                            		<a href="${nextArticleUrl}" style="margin-left: 20px;">${nextArticleTitle }</a>
                            	</c:when>
					            <c:otherwise>
					                <span style="margin-left: 20px;">다음 글이 없습니다.</span>
					            </c:otherwise>
					        </c:choose>
                        </div>
                    </div>
                </div>

                <div id="button-area" style="display: flex; justify-content: flex-end; margin: 15px 0 15px 0px;">
                    <a id="post-list-btn" href="javascript:location.href='<%=cp%>/notice/list?page=${articleCurrentPage }';">목록</a>
                    <security:authorize access="hasRole('ADMIN')">
                    	<a id="edit" href="javascript:location.href='<%=cp%>/notice/modify?p_id=${article.p_id}&page=${articleCurrentPage }';">수정하기</a>
                    	<a id="del" href="javascript:location.href='<%=cp%>/notice/del?p_id=${article.p_id}&page=${articleCurrentPage }';">삭제하기</a>
                    </security:authorize>
                </div>
            </article>
        </div>
    </div>
    <%@include file="../common/footer.jsp"%>
</body>
<script>
$(document).ready(function(){
	$("#notice-bar").removeClass("select-last");
	$("#notice-bar").addClass("select");
})
</script>
</html>