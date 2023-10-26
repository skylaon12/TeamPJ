<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet"
	href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
	<link rel="icon" href="../resources/images/logo/logo-s.png" type="image/x-icon">
<title>SOL CINEMA</title>
<style>
/* 로그인 폼 컨테이너 */
h1 {
	    background-color: #fff; /* 제목 배경색 */
	    padding: 20px;
	    text-align: center;
	    margin: 0;
	}
.login-container {
	width: 100%;
	height: 100vh; /* 화면 높이를 100%로 설정 */
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	align-items: center; /* 수직 가운데 정렬 */
}

/* 로그인 폼 스타일 */
.login-form {
	width: 300px; /* 폼의 너비를 조절하세요 */
	padding: 20px;
	border: 1px solid #ccc;
	background-color: #f9f9f9;
}

/* 입력 필드 스타일 */
.form-input {
	width: 100%;
	padding: 10px;
	margin-bottom: 10px;
}

/* 로그인 버튼 스타일 */
.login-btn {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: #fff;
	border: none;
	cursor: pointer;
	margin: 5px;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/navbar.jsp"%>
	<div class="login-container">
		<h1>비밀번호를 입력해주세요</h1><br>
		<form class="login-form" action="${cp}/member/checkUserPwProc" method="POST">
			<input type="hidden" id="s_pwd" name="s_pwd" value="${LOGIN_USER.pwd}">
			<input class="form-input" id="pwd" name="password" type="password" placeholder="비밀번호" required>
			<button class="login-btn" type="submit">제출</button>
			<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
		
	</div>
	<%@include file="../common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
$(document).ready(function(){ // 메세지 띄우기
	if(${!empty msgType}){
		$("#successModal").modal("show");
	}
});
</script>
</html>