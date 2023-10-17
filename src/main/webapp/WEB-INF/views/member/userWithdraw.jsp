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
<!-- CSS 스타일 추가 -->
<style>
    .disclaimer {
        font-size: 14px;
        color: #888;
        margin-top: 20px;
    }

    .confirm-check {
        margin-top: 10px;
    }
    .confirm-input{
    	display: none;
    }
    .confirm-button {
    display: none; /* 초기에는 숨김 */
    color: #fff; /* 텍스트 색상을 흰색(white)으로 설정 */
    background-color: #d9534f; /* 배경 색상을 빨간색(danger)으로 설정 */
    border-color: #d43f3a; /* 테두리 색상 설정 */
}

.confirm-button:hover {
    background-color: #c9302c; /* 마우스 오버 시 배경 색상 변경 */
}
</style>

</head>
<body>
<%@include file="/WEB-INF/views/common/navbar.jsp"%>
<div class="container">
    <h1>회원 탈퇴</h1>
<p class="disclaimer">회원 탈퇴 시 사용자의 모든 데이터가 삭제됩니다.</p>
    <p class="disclaimer">삭제되는 데이터</p>
    <p class="disclaimer">사용자의 기본 정보</p>
    <p class="disclaimer">게시물 작성 이력 (아직안함)</p>
    <p class="disclaimer">영화 관람평 작성 이력</p>
    <p class="disclaimer">예매 및 결제 내역</p>
    <p class="disclaimer">탈퇴하는 즉시 모든 데이터는 복구 할 수 없습니다.</p>
    <div class="form-check confirm-check">
        <input type="checkbox" class="form-check-input" id="confirmationCheckbox" onchange="checkConfirmation()">
        <label class="form-check-label" for="confirmationCheckbox">회원 탈퇴에 동의합니다.</label>
    </div>
    <!-- 비밀번호 입력란과 확인 버튼를 나란히 배치 -->
	<form id="withdraw_form" method="post">
	<input id="id" name="id" type="hidden" value="${LOGIN_USER.id}">
	    <div class="row">
	        <div class="col-md-6">
	            <div class="form-group">
	                <input id="pwdInput" type="password" class="form-control confirm-input" placeholder="비밀번호를 입력하세요.">
	            </div>
	        </div>
	        <div class="col-md-6">
	            <div class="form-group">
	                <input id="checkPwdButton" type="button" class="btn btn-danger confirm-button" onclick="checkPassword()" value="비밀번호 확인">
	            </div>
	        </div>
	    </div>
	    <div class="form-group">
	        <input id="withdrawButton" type="button" class="btn btn-danger confirm-button disabled" onclick="withdraw()" value="탈퇴하기" disabled>
	    </div>
	</form>
    
</div>

<%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
    // 사용자가 확인란 체크하면 버튼 활성화
    function checkConfirmation() {
        var confirmationCheckbox = document.getElementById("confirmationCheckbox");
        var pwdInput = document.getElementById("pwdInput");
        var checkPwdButton = document.getElementById("checkPwdButton");
        var withdrawButton = document.getElementById("withdrawButton");

        if (confirmationCheckbox.checked) {
            pwdInput.style.display = "block";
            checkPwdButton.style.display = "block";
            withdrawButton.style.display = "block";
        } else {
            pwdInput.style.display = "none";
            checkPwdButton.style.display = "none";
            withdrawButton.style.display = "none";
        }
    }

    // 사용자가 비밀번호 확인 버튼을 누를 때 호출되는 함수
    function checkPassword() {
        // 비밀번호 확인 로직 작성
        var enteredPassword = document.getElementById("pwdInput").value;
        var currentPassword = "${LOGIN_USER.pwd}"; // 서버에서 가져온 사용자의 현재 비밀번호
        var withdrawButton = document.getElementById("withdrawButton");

        if (enteredPassword === currentPassword) {
            withdrawButton.classList.remove("disabled");
            withdrawButton.removeAttribute("disabled");
        } else {
        	pushModal("비밀번호가 일치하지 않습니다.");
            withdrawButton.classList.add("disabled");
            withdrawButton.setAttribute("disabled", "disabled");
        }
    }

    // 사용자가 탈퇴 버튼을 누를 때 호출되는 함수
    function withdraw() {
        $("#withdraw_form").attr("action","userDelete");
        $("#withdraw_form").submit();
    }
</script>
</html>