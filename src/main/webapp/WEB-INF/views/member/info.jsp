<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon">
<script src="${cp}/resources/js/login.js"></script>
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
	
	table {
	    background-color: #fff; /* 표 배경색 */
	    width: 60%;
	    margin: 20px auto;
	    border-collapse: collapse;
	}
	
	th, td {
	    border: 1px solid #ddd;
	    padding: 10px;
	}
	
	th {
	    background-color: #f0f0f0; /* 표 헤더 배경색 */
	    text-align: left;
	}
	
	/* 링크 스타일 */
	a {
	    color: #007bff; /* 링크 색상 */
	    text-decoration: none;
	}
	
	a:hover {
	    text-decoration: underline;
	}
	.edit-button {
    background-color: #007bff; /* 배경색 */
    color: #fff; /* 글자색 */
    border: none;
    padding: 10px 20px;
    margin-right: 10px;
}

.edit-button:hover {
    background-color: #0056b3; /* 마우스 오버 시 배경색 */
}

/* 탈퇴하기 버튼 스타일 */
.delete-button {
    background-color: #dc3545; /* 배경색 */
    color: #fff; /* 글자색 */
    border: none;
    padding: 10px 20px;
}

.delete-button:hover {
    background-color: #c82333; /* 마우스 오버 시 배경색 */
}

/* 버튼 컨테이너 스타일 */
.button-container {
    margin-top: 20px;
    text-align: center;
}
</style>
</head>
<body>
<%@include file="/WEB-INF/views/common/navbar.jsp"%>
<h1>회원 정보</h1>
<c:choose>
	<c:when test="${not empty LOGIN_USER}">
        <table>
            <tr>
                <th>ID:</th>
                <td>${LOGIN_USER.id}</td>
            </tr>
            <tr>
                <th>아이디:</th>
                <td>${LOGIN_USER.account}</td>
            </tr>
            <tr>
                <th>이름:</th>
                <td>${LOGIN_USER.name}</td>
            </tr>
            <tr>
                <th>이메일:</th>
                <td>${LOGIN_USER.email1}@${LOGIN_USER.email2}</td>
            </tr>
            <tr>
                <th>전화번호:</th>
                <td>${LOGIN_USER.phonenumber}</td>
            </tr>
            <tr>
                <th>나이:</th>
                <td>${LOGIN_USER.age}</td>
            </tr>
        </table>
		<div class="button-container">
            <a href="checkUserPw"><button class="btn edit-button">수정하기</button></a>
            <a href="userDelete?id=${LOGIN_USER.id}"><button class="btn delete-button">탈퇴하기</button></a>
        </div>
    </c:when>
	<c:otherwise>
		<script>
			alert("로그인이 필요합니다.");
			window.location.replace("${cp}/member/login");
		</script>
		
	</c:otherwise>
</c:choose>
    
<%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
<%@include file="../common/errorModal.jsp"%>
</body>
</html>