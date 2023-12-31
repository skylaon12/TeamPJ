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

input[type="text"],
input[type="email"],
input[type="date"] {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ddd;
}

input[type="button"] {
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
<h1>회원 정보 수정</h1>

<!-- 사용자 정보 수정 폼 -->
<form id="modify_form" method="post">
	<input type="hidden" id="id" name="id" value="${LOGIN_USER.id}">
	<input type="hidden" id="account" name="account" value="${LOGIN_USER.account}">
	<input type="hidden" id="pwd" name="pwd" value="${LOGIN_USER.pwd}">
	<div>
		<label class="control-label" for="name">이름(실명)</label>
		<input class="name_input" type="text" id="name" name="name" value="${LOGIN_USER.name }"/>
	</div>
    
	<div>
	    <label class="control-label" for="email">이메일</label>
	    <input class="email_input" type="text" value="${LOGIN_USER.email1}@${LOGIN_USER.email2}" readonly="readonly"/>
	</div>
	<div>
		<label class="control-label" for="phonenumber">전화번호</label>
		<input class="form-control" type="text" id="phonenumber" name="phonenumber" value="${LOGIN_USER.phonenumber }"/>
	</div>

	<div>
		<label class="control-label" for="birth">생년월일</label>
		<input type="hidden" id="age" name="age">
		<input type="date" id="birth" name="birth"  placeholder="생년월일"/>
	</div>
	<a href="pwdModify"><input type="button" value="비밀번호 변경"></a>
    <a href="info"><input type="button" value="돌아가기"></a>
    <input type="button" onclick="validation()" id="signup_button" value="수정하기">
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

<%@include file="../common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
// select에서 선택하면 저절로 email2에 작성됨
	// 수정사항 유효성 검사
	function validation(){
		var name = $("#name").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var phoneNumber = $("#phonenumber").val();
		var birth = $("#birth").val();
		
		var regName = /^[가-힣a-zA-Z]{2,15}$/;
		// 전화번호
		var phoneNumberRegex = /^010-\d{4}-\d{4}$/;
        // 년도
        var regYear = /^[1-2]{1}[0-9]{0,4}$/;
        var birthDate = new Date(birth);
	    var currentDate = new Date();
	    var u_age = currentDate.getFullYear() - birthDate.getFullYear();
     // 유효성 검사
		if(name == ""){// 이름 공백
        	pushModal("이름을 입력하세요");
        	return;
        }else if(!regName.test(name)){// 이름 정규식 체크
        	pushModal("최소 2글자 이상, 한글과 영어만 입력해주십시오.");
        	return;
        }else if(!phoneNumberRegex.test(phoneNumber)){
        	pushModal("올바른 전화번호 형식이 아닙니다");
        	return;
        }else if (birth == ""){
        	pushModal("생년월일을 입력해주십시오.");
        	return;
        }else if(u_age < 3){
        	pushModal("만 4세 이상부터 가입이 가능합니다.");
        	return;
        }
	    $("#age").val(u_age);
	    $("#modify_form").attr("action", "userModifyProc");
		$("#modify_form").submit();
	}


</script>
</html>