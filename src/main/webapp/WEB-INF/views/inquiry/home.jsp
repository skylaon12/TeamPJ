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

            <div id="content-container">
                <h2 style="border-bottom: 1px solid #cacaca; padding-bottom: 0.5em; margin-bottom: 0.5em;">고객센터 홈</h2>
                <div id="service-container">
                	<security:authorize access="hasRole('USER')">
                    <div class="home-content">
                        <a href="${cp}/inquiry/write?page=1" class="block">
                            <h2 class="service">1:1 문의</h2>
                            <span>1:1 문의로 문의주세요</span>
                        </a>
                    </div>
                    </security:authorize>
                    <div class="home-content">
                        <a href="${cp}/notice/list?page=1" class="block">
                            <h2 class="service">공지사항</h2>
                            <span>솔시네마의 공지사항 이예요</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../common/footer.jsp"%>
</body>
<script>
$(document).ready(function(){
	$("#notice-bar").removeClass("select-last");
	$("#home-bar").addClass("select");
})
</script>
</html>