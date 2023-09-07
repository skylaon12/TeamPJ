<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<a href="${cp}/guest/getList">방명록</a>
<a href="${cp}/api/w">날짜확인하기</a>
<a href="${cp}/api/address">주소검색하기</a>
<a href="${cp}/api/login">카톡으로 로그인하기</a>
<a href="${cp}/guest/testapi">ajax연습</a>


</body>
</html>
