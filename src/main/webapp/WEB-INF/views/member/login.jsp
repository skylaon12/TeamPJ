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
<title>SOL CINEMA</title>
<style>
/* 로그인 폼 컨테이너 */
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
.forgot-links {
    width: 300px; /* 링크 너비를 폼과 동일하게 설정 */
    margin: 0 auto; /* 가운데 정렬 */
    text-align: center; /* 텍스트를 가운데 정렬 */
    margin-top: 10px; /* 폼과의 간격을 설정 (상단 여백) */
}

/* 링크 스타일 */
.forgot-links a {
    text-decoration: none; /* 링크 밑줄 제거 */
    color: #007bff; /* 링크 색상 설정 */
    margin: 0 10px; /* 링크 사이 여백 설정 */
}

.forgot-links .separator {
    color: #ccc; /* 구분선 색상 설정 */
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/navbar.jsp"%>
	<div class="login-container">
	    <div>
			<form class="login-form" action="${cp}/member/loginProc" method="post">
				<input class="form-input" type="text" name="username" id="account" placeholder="아이디" required>
				<input class="form-input" type="password" name="password" id="pwd" placeholder="비밀번호" required>
				<button class="login-btn" type="submit">로그인</button>
				<a href="${cp}/member/signup"><input type="button" class="login-btn" value="회원가입"></a>
				<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
			<div class="forgot-links">
				<a href="${cp}/member/findID">아이디 찾기</a>
				<span class="separator">|</span>
				<a href="${cp}/member/findPW">비밀번호 찾기</a>
			</div>
		</div>
	</div>
	<%@include file="../common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script type="text/javascript">
          $(document).ready(function(){ // 메세지 띄우기
              if(${param.error!=null}){
                  $("#messageType").attr("class", "modal-content panel-info");
                  $("#checkMessage").text("아이디와 비밀번호를 확인해주세요.");
                  $(".modal-title").text("실패 메세지");
                  $("#alertModal").modal("show");
              }
              if(${!empty msgType}){
      			$("#successModal").modal("show");
      		}
        });
</script>

</html>