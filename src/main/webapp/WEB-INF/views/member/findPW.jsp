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
<link rel="icon" href="../resources/images/logo/logo-s.png" type="image/x-icon">
<title>SOL CINEMA</title>
</head>
<body>
	<%@include file="/WEB-INF/views/common/navbar.jsp"%>
	<h1>비밀번호 찾기</h1>
	<!-- 사용자 정보 수정 폼 -->
	<form id="changPwForm" method="post">
		<table class="styled-table">
			<tr>
				<td><label class="control-label" style="width: 120%" for="account">아이디</label></td>
				<td>
					<input class="account_input" type="text" id="account"name="account" />
				</td>
			</tr>
			<tr>
				<td>
					<label class="control-label" style="width: 120%" for="email">이메일</label>
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
			<tr id="pwRow" style="display: none;">
				<td><label class="control-label" for="pwd" style="width: 120%">비밀번호</label></td>
				<td><input class="password_input" onkeyup="passwordCheck()" type="password" id="pwd" name="pwd" /></td>
			</tr>
			<tr id="pwReRow" style="display: none;">
				<td><label class="control-label" for="pwd">재입력</label></td>
				<td><input class="password_input" onkeyup="passwordCheck()" type="password" id="pwd_re" name="pwd_re" /> 
				<span id="passMessage" style="color: red"></span></td>
			</tr>
			<tr id="changePwRow" style="display: none;">
				<td></td>
				<td><input type="button" onclick="validation()" id="signup_button" value="변경하기"></td>
			</tr>
		</table>
		<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
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
		var account = $("#account").val();
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
			type: "POST",
			url : "${cp}/member/checkInfo",
			data: {
				account: account,
				email1: email1,
				email2: email2
			},
			beforeSend: function(xhr){
				xhr.setRequestHeader("X-CSRF-TOKEN", csrfTokenValue)
			},
			success: function(mem_cnt){
				if(mem_cnt == 1){
					console.log("통신 성공, 받은 데이터 : " + mem_cnt);
					console.log("전체 이메일 : " + email);
					$.ajax({
						type : "POST",
						url : "${cp}/member/findEmailAuth",
						data : {email : email},
						beforeSend: function(xhr){
							xhr.setRequestHeader("X-CSRF-TOKEN", csrfTokenValue)
						},
						success: function(result){
							email_auth_cd = result;
							pushModal("인증번호가 발송되었습니다.");
							console.log("인증번호 : " + email_auth_cd);
							$("#authNumRow").show();
							$("#authNum1").val(email_auth_cd);
						},
						error: function(result){
							pushModal("메일 발송에 실패했습니다.");
						}
					})
				}else{
					pushModal("존재하지 않는 정보입니다.");
					return;
				}
			},
			error: function(){
				pushModal("오류가 발생하였습니다. 관리자에게 문의하세요.");
				return;
			}
		})
	}
	
	function checkEmail(){
		var inputNum = $("#authNum1").val();
		var authNum = $("#authNum2").val();
		var $targetBtn = $("#email_auth_btn")
		if(inputNum == authNum && inputNum != ''){
			pushModal("인증이 완료되었습니다.");
			$("#emailChecked").val("true");
			$("#email1").val($("#input_email1").val());
			$("#email2").val($("#input_email2").val());
			$("#input_email1,#input_email2,#select-email").prop("readonly",true).prop("disabled",true);
			$targetBtn.removeAttr("onclick");
			$targetBtn.text("인증완료");
			$targetBtn.css("background-color", "gray");
			$("#pwRow").show();
			$("#pwReRow").show();
			$("#changePwRow").show();
		}else{
			pushModal("인증번호가 올바르지 않습니다.");
			return;
		}
	}
	
	function passwordCheck(){
		var memPassword1=$("#pwd").val();
		var memPassword2=$("#pwd_re").val();
		if(memPassword1 != memPassword2){
			$("#passMessage").html("비밀번호가 일치하지 않습니다."); // 비밀번호가 일치하지 않을때 메세지 출력
		}else{
			$("#passMessage").html("")
			$("#memPassword").val(memPassword1); // 일치하는 비밀번호 넣어주기
		}
	}
	
	// 회원가입 버튼 눌렀을 때 유효성 검사
	// js에서 유효성 검사하고 컨트롤러로 보냈을 때도 유효성 검사 한 번 더 시행
	function validation(){
		var account = $("#account").val();
		var pw = $("#pwd").val();
		var pw_re = $("#pwd_re").val();
		console.log("validation함수 실행");
		// 체크용정규식
        // pw
        var regPwd = /^[a-zA-Z0-9!@#\$%\^\&*\)\(+=._-]{4,12}$/;
      	// 유효성 검사
		if(pw == ""){
			pushModal("비밀번호를 입력하세요.")
			return;
		}else if(!regPwd.test(pw)){// pw 정규식 체크
        	pushModal("올바른 비밀번호 형식을 입력하여 주십시오.(4~12자 영문 대소문자, 숫자, 특수문자 가능)");
        	return;
        }else if(pw != pw_re){// 패스워드, 패스워드 재입력 체크
        	pushModal("비밀번호가 일치하지 않습니다. 다시 입력해주십시오.");
        	return;
        }

		$("#changPwForm").attr("action", "changePwProc");
		$("#changPwForm").submit();
	}
</script>
</html>