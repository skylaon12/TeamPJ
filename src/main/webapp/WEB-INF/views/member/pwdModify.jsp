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
		<form id="pwModifyForm" method="post" class="login-form">
			<input id="account" name="account" type="hidden" value="${LOGIN_USER.account}">
			<input class="form-input" id="pwd_ori" type="hidden" name="pwd_ori" value="${LOGIN_USER.pwd}">
			<input class="form-input" id="pwd_input" type="password" name="pwd_input" placeholder="현재 비밀번호 입력" required>
			<input class="form-input" id="pwd" type="password" name="pwd" placeholder="변경할 비밀번호 입력" required>
			<input class="form-input" id="pwd_new_re" type="password" name="pwd_re" placeholder="변경할 비밀번호 재입력" required>
			<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
			<input class="login-btn" onclick="checkUserPw()" type="button" value="제출">
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
// 세션에 저장되어 있는 유저 pw와 사용자가 직접 입력하는 pw와 비교
function checkUserPw(){
	let pw_ori = $("#pwd_ori").val();
	let pw_input = $("#pwd_input").val();
	let pw_new = $("#pwd").val();
	let pw_new_re = $("#pwd_new_re").val();
	console.log("userid : " + $("#id").val());
	console.log("세션에 등록된 비밀번호 : " + pw_ori);
	console.log("사용자가 입력한 현재 비밀번호 : " + pw_input);
	console.log("사용자가 입력한 바꾸려는 비밀번호 : " + pw_new);
	
	var regPw = /^[a-zA-Z0-9]{4,12}$/; // 신규 비밀번호 체크용정규식
	
	if(pw_new == pw_new_re){
		if(regPw.test(pw_new)){
			$("#pwModifyForm").attr("action","setPwdProc");
			$("#pwModifyForm").submit();
		}else{
			pushModal("올바른 비밀번호 형식을 입력하여 주십시오.(4~12자 영문 대소문자, 숫자)");
			return;
		}
	}else{
		pushModal("비밀번호가 일치하지 않습니다.");
		return;
	}
}
</script>
</html>