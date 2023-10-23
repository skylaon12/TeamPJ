<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 403에러 페이지 꾸며주기 -->
	<h2>Access Denied - You are not authorized to access this resource.</h2>
	<hr>
	<a href="${cp}">Back to Home Page</a>
</body>
</html>