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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet"
	href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet"
	href="../resources/css/login.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="icon" href="../resources/images/favicon.ico"
	type="image/x-icon">
<title>SOL CINEMA</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/navbar.jsp"%>
	<h1>회원 가입</h1>
	<!-- 사용자 정보 수정 폼 -->
		<table class="styled-table">
			<tr>
				<td><label class="control-label" style="width: 120%" for="name">이름</label></td>
				<td><input class="name_input" type="text" id="name" name="name" /></td>
			</tr>
			<tr>
				<td>
					<label class="control-label" style="width: 120%"  for="email">이메일</label>
				</td>
				<td>
					<input type="hidden" id="email1" name="email1"/>
					<input type="hidden" id="email2" name="email2"/>
					<input class="email_input" type="text" id="input_email1" name="input_email1" />@ 
					<input class="email_input" type="text"	id="input_email2" name="input_email2" />
					<select class="select" id="select-email" title="이메일 도메인 주소 선택" onchange="setEmail2(this.value)">
						<option value="">-선택-</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="korea.com">korea.com</option>
						<option value="nate.com">nate.com</option>
						<option value="yahoo.com">yahoo.com</option>
					</select>
					<input type="button" value="인증번호 받기" id="email_send_btn" onclick="sendEmail()" style="width: auto"/>
				</td>
			</tr>
			<tr id="authNumRow" style="display: none;">
				<td></td>
				<td>
					<input type="hidden" id="emailChecked">
					<input type="hidden" id="authNum1">
					<input type="text" id="authNum2" placeholder="인증번호를 입력하세요.">
					<input type="button" id="email_auth_btn" onclick="checkEmail()" value="인증하기"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<a href="${cp}/member/login">로그인하러 가기</a>
					<span>|</span>
					<a href="${cp}/member/findPW">비밀번호 찾기</a>
				</td>
			</tr>
		</table>

	
	<%@include file="../common/footer.jsp"%>
	<!-- alert 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ready(function(){ // 메세지 띄우기
		if(${!empty msgType}){
			$("#messageType").attr("class", "modal-content panel-warning");
			$("#myMessage").modal("show");
		}
	});

	// select에서 선택하면 저절로 email2에 작성됨
	function setEmail2(e){
		var $email = $("#input_email2");
		var $s_email = $("#select-email");
		$email.val($s_email.val());
	}
	
	function sendEmail(){
		var email_auth_cd = "";
		var email1 = $("#input_email1").val();
		var email2 = $("#input_email2").val();
		var email1Regex = /^[\w-]+$/; // 이메일 로컬 파트의 유효성 검사 정규 표현식
		var email2Regex = /^(naver\.com|gmail\.com|hanmail\.net|hotmail\.com|korea\.com|nate\.com|yahoo\.com)$/; // 이메일 도메인의 유효성 검사 정규 표현식
		
		if(email1 == "" || email2 == ""){
			pushModal("이메일을 입력해주세요");
			return;
		}else if (!email1Regex.test(email1)) {// email 로컬주소 체크
        	pushModal("올바른 이메일 로컬 파트 형식이 아닙니다.");
        	return;
        }else if (!email2Regex.test(email2)) {// email 도메인파트 체크
            pushModal("올바른 이메일 도메인 형식이 아닙니다.");
            return;
        }
		var email = email1 + "@" + email2;
		
		$.ajax({
			type : "POST",
			url : "${cp}/member/findEmailAuth",
			data : {email : email},
			beforeSend: function(xhr){
				xhr.setRequestHeader("X-CSRF-TOKEN", csrfTokenValue)
			},
			success: function(data){
				email_auth_cd = data;
					pushModal("인증번호가 발송되었습니다.");
					$("#authNumRow").show();
					$("#authNum1").val(email_auth_cd);
			},
			error: function(){
				pushModal("메일 발송에 실패했습니다.");
			}
		})		
	}
	
	function checkEmail(){
		var name = $("#name").val();
		var email1 = $("#input_email1").val();
		var email2 = $("#input_email2").val();
// 		여기까지했음....
		var inputNum = $("#authNum1").val();
		var authNum = $("#authNum2").val();
		var $targetBtn = $("#email_auth_btn")
		console.log("입력한 이름 : " + name);
		console.log("입력한 email1 : " + email1);
		console.log("입력한 email2 " + email2);
		if(inputNum == authNum && inputNum != ''){
			pushModal("인증이 완료되었습니다");
			$targetBtn.removeAttr("onclick");
			$targetBtn.text("인증완료");
			$targetBtn.css("background-color", "gray");
			
			$.ajax({
				type : "POST",
				url : "${cp}/member/getAccount",
				data : {
					name : name,
					email1 : email1,
					email2 : email2
				},
				beforeSend: function(xhr){
					xhr.setRequestHeader("X-CSRF-TOKEN", csrfTokenValue)
				},
				success: function(data){
					if(data != ""){
						pushModal("아이디는 " + data + "입니다.");
					}else{
						pushModal("등록된 계정이 없습니다.")
					}
					return;
				},
				error: function(){
					pushModal("오류가 발생하였습니다. 관리자에게 문의하세요.");
					return;
				}
			})
		}else{
			pushModal("인증번호가 올바르지 않습니다.");
			return;
		}
	}
	
</script>
</html>