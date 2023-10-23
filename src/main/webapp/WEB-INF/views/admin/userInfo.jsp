<%@page import="java.util.List"%>
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
	<link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon">
<title>SOL CINEMA</title>
<style>
/* 페이지 스타일 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f0f0f0; /* 배경색 */
    color: #333; /* 글자색 */
    margin: 0;
    padding: 0;
}

h1 {
    background-color: #fff; /* 제목 배경색 */
    padding: 20px;
    text-align: center;
    margin: 0;
}

form {
    background-color: #fff; /* 폼 배경색 */
    width: 60%;
    margin: 20px auto;
    padding: 20px;
    border: 1px solid #ddd;
}

label {
    font-weight: bold;
}

input[type="text"]
 {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ddd;
}

input[type="button"],
input[type="submit"] {
    background-color: #007bff; /* 배경색 */
    color: #fff; /* 글자색 */
    border: none;
    padding: 10px 20px;
    margin: 10px 0;
}

input[type="button"]:hover {
    background-color: #0056b3; /* 마우스 오버 시 배경색 */
}
select {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ddd;
}


</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/navbar.jsp"%>
<%String auth = (String)request.getAttribute("auth"); %>
<h1>회원 정보 수정</h1>

<!-- 사용자 정보 수정 폼 -->
<form id="modify_form" action="userModifyProc" method="post" >
	<input type="hidden" id="account" name="account" value="${member.account}">
	<div>
		<label class="control-label" for="name">이름(실명)</label>
		<input class="name_input" type="text" value="${member.name }" readonly="readonly"/>
	</div>
    
	<div>
	    <label class="control-label" for="email">이메일</label>
	    <input class="email_input" type="text" value="${member.email1}@${member.email2}" readonly="readonly"/>
	</div>
	<div>
		<label class="control-label" for="phonenumber">전화번호</label>
		<input class="form-control" type="text" id="phonenumber" name="phonenumber" value="${member.phonenumber }" readonly="readonly"/>
	</div>

	<div>
		<label class="control-label" for="auth">사용자 권한 상태 : </label>
		<input type="checkbox" name="authList[0].auth" value="ROLE_USER" <%= auth.equals("ROLE_USER") ? "checked" : "" %> /> ROLE_USER
		<input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER" <%= auth.equals("ROLE_MANAGER") ? "checked" : "" %> /> ROLE_MANAGER
		<input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN" <%= auth.equals("ROLE_ADMIN") ? "checked" : "" %> /> ROLE_ADMIN
	</div>
    <a href="${cp}/admin/memberList"><input type="button" value="돌아가기"></a>
    <input type="submit" id="signup_button" value="수정하기">
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<%@include file="../common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
	// 수정사항 유효성 검사
// 	function validation(){
// 	    $("#modify_form").attr("action", "userModifyProc");
// 		$("#modify_form").submit();
// 	}


</script>
</html>