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
	<h1>회원 가입</h1>
	<!-- 사용자 정보 수정 폼 -->
	<form id="signup_form" method="post">
		<table class="styled-table">
			<tr>
				<td><label class="control-label" for="account">아이디</label></td>
				<td><input class="account_input" type="text" id="account"name="account" />
					<input type="hidden" id="accountCheck">
					<input type="hidden" id="isChecked">
					<input	class="styled-button" type="button" id="account-check" onclick="checkAccount()" value="중복확인">
				</td>
			</tr>
			<tr>
				<td><label class="control-label" for="pwd">비밀번호</label></td>
				<td><input class="password_input" onkeyup="passwordCheck()"
					type="password" id="pwd" name="pwd" /></td>
			</tr>
			<tr>
				<td><label class="control-label" for="pwd">비밀번호 재입력</label></td>
				<td><input class="password_input" onkeyup="passwordCheck()" type="password" id="pwd_re" name="pwd_re" /> 
				<span id="passMessage" style="color: red"></span></td>
			</tr>
			<tr>
				<td><label class="control-label" for="name">이름(실명)</label></td>
				<td><input class="name_input" type="text" id="name" name="name" /></td>
			</tr>
			<tr>
				<td>
					<label class="control-label" for="birth">생년월일</label>
				</td>
				<td>
					<input type="hidden" id="age" name="age"> 
					<input type="date" id="birth" name="birth" placeholder="생년월일" />
				</td>
			</tr>
			<tr>
				<td>
					<label class="control-label" for="email">이메일</label>
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
				<td>
					<label class="control-label" for="phonenumber">전화번호</label>
				</td>
				<td>
					<input class="form-control" type="text" id="phonenumber" name="phonenumber" value="${LOGIN_USER.phonenumber }" />
				</td>
			</tr>
		</table>
		
		<input type="button" onclick="validation()" id="signup_button" value="회원가입">
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
	// 컨트롤러까지 전부 통과
	function checkAccount(){
		var account=$("#account").val();
		var regId = /^[a-zA-Z0-9]{4,12}$/;
		if(!regId.test(account)){
			pushModal("올바른 형식으로 입력하여 주십시오.(4~12자 영문 대소문자, 숫자)");
			return;
		}
		$.ajax({
			url : "${cp}/member/checkAccount",
			type : "get",
			data : {"account" : account},
			success : function(result){
				// 중복체크 출력		ex): (result=1 : 사용가능 아이디, result=0 : 사용불가능 아이디)
				// alert(result);
				if(result!=1){
					$("#accountCheck").val(account);
					$("#isChecked").val("true");
					$("#checkMessage").html("사용할 수 있는 아이디입니다.");
				}else{
					$("#checkMessage").html("사용할 수 없는 아이디입니다.");
				}
				$("#alertModal").modal("show"); // 다이얼로그 출력
			},
			error : function(){ alert("error"); }
		});
	}
	// 통과!
	// 패스워드 위아래로 다르면 표시
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
	//가람님

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
			url : "${cp}/member/emailAuth",
			data : {email : email},
			beforeSend: function(xhr){
				xhr.setRequestHeader("X-CSRF-TOKEN", csrfTokenValue)
			},
			success: function(data){
				email_auth_cd = data;
				if(email_auth_cd == "false"){
					pushModal("이미 존재하는 이메일입니다.")
				}else{
					pushModal("인증번호가 발송되었습니다.");
					$("#authNumRow").show();
					$("#authNum1").val(email_auth_cd);
				}
			},
			error: function(data){
				pushModal("메일 발송에 실패했습니다.");
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
		}else{
			pushModal("인증번호가 올바르지 않습니다.");
			return;
		}
	}
	
	// 회원가입 버튼 눌렀을 때 유효성 검사
	// js에서 유효성 검사하고 컨트롤러로 보냈을 때도 유효성 검사 한 번 더 시행
	function validation(){
		var id = $("#account").val();
		var passAccount = $("#accountCheck").val();
		var isChecked = $("#isChecked").val();
		var name = $("#name").val();
		var pw = $("#pwd").val();
		var pw_re = $("#pwd_re").val();
		var email1 = $("#email1").val();
		var email2 = $("#email2").val();
		var emailChecked = $("#emailChecked").val();
		var phoneNumber = $("#phonenumber").val();
		var birth = $("#birth").val();
		var birthDate = new Date(birth);
	    var currentDate = new Date();
	    var u_age = currentDate.getFullYear() - birthDate.getFullYear();		
		// 체크용정규식
        // pw
        var regPwd = /^[a-zA-Z0-9!@#\$%\^\&*\)\(+=._-]{4,12}$/;
        // 이름
        var regName = /^[가-힣a-zA-Z]{2,15}$/;
        // 이메일
        var email1Regex = /^[\w-]+$/; // 이메일 로컬 파트의 유효성 검사 정규 표현식
		var email2Regex = /^(naver\.com|gmail\.com|hanmail\.net|hotmail\.com|korea\.com|nate\.com|yahoo\.com)$/; // 이메일 도메인의 유효성 검사 정규 표현식
		// 전화번호
		var phoneNumberRegex = /^010-\d{4}-\d{4}$/;
        // 년도
        var regYear = /^[1-2]{1}[0-9]{0,4}$/;
		
      	// 유효성 검사
      	if(id == ""){
      		pushModal("아이디를 입력하세요.");
      		return;
      	}else if(passAccount != id || isChecked != "true"){				// 중복확인 여부
      		pushModal("아이디 중복확인이 완료되지 않았습니다.");
      		return;
		}else if(pw == ""){
			pushModal("비밀번호를 입력하세요.")
			return;
		}else if(!regPwd.test(pw)){// pw 정규식 체크
        	pushModal("올바른 비밀번호 형식을 입력하여 주십시오.(4~12자 영문 대소문자, 숫자, 특수문자 가능)");
        	return;
        }else if(pw != pw_re){// 패스워드, 패스워드 재입력 체크
        	pushModal("비밀번호가 일치하지 않습니다. 다시 입력해주십시오.");
        	return;
        }else if(name == ""){// 이름 공백
			pushModal("이름을 입력하세요.");
			return;
        }else if(!regName.test(name)){// 이름 정규식 체크
        	pushModal("최소 2글자 이상, 한글과 영어만 입력해주십시오.");
        	return;
        }else if (birth == ""){
        	pushModal("생년월일을 입력해주십시오.");
        	return;
        }else if (!email1Regex.test(email1)) {// email 로컬주소 체크
        	pushModal("올바른 이메일 로컬 파트 형식이 아닙니다.");
        	return;
        }else if (!email2Regex.test(email2)) {// email 도메인파트 체크
            pushModal("올바른 이메일 도메인 형식이 아닙니다.");
            return;
        }else if(emailChecked != "true"){
        	pushModal("이메일 인증이 완료되지 않았습니다.");
        	return;
        }else if(!phoneNumberRegex.test(phoneNumber)){
        	pushModal("올바른 전화번호 형식이 아닙니다");
        	return;
        }else if(u_age < 3){
        	pushModal("만 4세 이상부터 가입이 가능합니다.");
        	return;
        }
	    
	    $("#age").val(u_age);
	    console.log("이메일 호스트 : " + $("[name='email1']").val());

	    console.log("이메일 호스트 : " + $("[name='email2']").val());

		$("#signup_form").attr("action", "signup");
		$("#signup_form").submit();
	}
</script>
</html>