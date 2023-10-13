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
</head>
<body>
	<%@include file="/WEB-INF/views/common/navbar.jsp"%>
	<section>
		<form id="signup_form" method="post">
			<div>
				<input type="hidden" id="accountCheck" value="false">
				<label class="control-label" for="account">아이디</label>
				<input class="account_input" type="text" id="account" name="account" />
				<input type="button" id="account-check" onclick="checkAccount()" value="중복확인">
			</div>

			<div>
				<label class="control-label" for="name">이름(실명)</label>
				<input class="name_input" type="text" id="name" name="name" />
			</div>

			<div>
				<label class="control-label" for="pwd">비밀번호</label> 
				<input class="password_input" type="password" id="pwd" name="pwd" />
			</div>
			<div>
				<label class="control-label" for="pwd">비밀번호 재입력</label> 
				<input class="password_input" type="password" id="pwd_re" name="pwd_re" />
			</div>

			<div>
				<label class="control-label" for="email1">이메일</label> 
				<input class="email_input" type="text" id="email1" name="email1" />
			</div>

			<div>
				<label class="control-label" for="email2">이메일도메인</label>
				<input class="email_domain_input" type="text" id="email2" name="email2"
					value="${email2}" />
					<select class="select" title="이메일 도메인 주소 선택" onclick="setemail2(this.values);return false;">
					<option value="">-선택-</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="hotmail.com">hotmail.com</option>
					<option value="korea.com">korea.com</option>
					<option value="nate.com">nate.com</option>
					<option value="yahoo.com">yahoo.com</option>
				</select>
			</div>

			<div>
				<label class="control-label" for="phonenumber">전화번호</label>
				<input class="form-control" type="text" id="phonenumber" name="phonenumber" />
			</div>

			<div>
				<label class="control-label" for="birth">생년월일</label>
				<input type="hidden" id="age" name="age">
				<input type="date" id="birth" name="birth"  placeholder="생년월일"/>
			</div>

			<div>
				<input type="button" onclick="validation()" id="signup_button" value="가입하기" />
			</div>
		</form>
	</section>


	<%@include file="../common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/errorModal.jsp"%>
	<script>
		function validation(){
			var id = $("#account").val();
			var isValid = $("#accountCheck").val();
			var name = $("#name").val();
			var pw = $("#pwd").val();
			var pw_re = $("#pwd_re").val();
			var email1 = $("#email1").val();
			var email2 = $("#email2").val();
			var phoneNumber = $("#phonenumber").val();
			var birth = $("#birth").val();
			
			// 체크용정규식
	        // id, pw
	        var regIdPw = /^[a-zA-Z0-9]{4,12}$/;
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
			if(isValid != "true"){// 중복확인 여부
				alert("아이디 중복확인이 완료되지 않았습니다.");
				return;
			}else if(name == ""){// 이름 공백
	        	alert("이름을 입력하세요");
	        	return;
	        }else if(!regName.test(name)){// 이름 정규식 체크
	        	alert("최소 2글자 이상, 한글과 영어만 입력해주십시오.");
	        	return;
	        }else if(!regIdPw.test(pw)){// pw 정규식 체크
	        	alert("올바른 비밀번호 형식을 입력하여 주십시오.(4~12자 영문 대소문자, 숫자)");
	        	return;
	        }else if(pw != pw_re){// 패스워드, 패스워드 재입력 체크
	        	alert("비밀번호가 일치하지 않습니다. 다시 입력해주십시오.")
	        	return;
	        }else if (!email1Regex.test(email1)) {// email 로컬주소 체크
	            alert("올바른 이메일 로컬 파트 형식이 아닙니다.");
	            return;
	        }else if (!email2Regex.test(email2)) {// email 도메인파트 체크
	            alert("올바른 이메일 도메인 형식이 아닙니다.");
	            return;
	        }else if(!phoneNumberRegex.test(phoneNumber)){
	        	alert("올바른 전화번호 형식이 아닙니다");
	        	return;
	        }else if (birth == ""){
	        	alert("생년월일을 입력해주십시오.");
	        	return;
	        }
			var birthDate = new Date(birth);
		    var currentDate = new Date();
		    var u_age = currentDate.getFullYear() - birthDate.getFullYear();
		    $("#age").val(u_age);
			// 아이디, 비밀번호, 공백 검사
			
			
			$("#signup_form").attr("action", "signup");
			$("#signup_form").submit();
		}
		
		function checkAccount(){
			var regIdPw = /^[a-zA-Z0-9]{4,12}$/;
			var account = $("#account").val();
			if(account == ''){
				alert("아이디를 입력해주세요");
				return;
			}else if(!regIdPw.test(account)){
				alert("4~12자 영문 대소문자, 숫자만 입력하세요.")
				return;
			}
			
			$.ajax({
				type:"POST",
				url: "/solcinema/member/checkAccount",
				data: JSON.stringify({account : account}),
				contentType: "application/json",
				success: function(data){
					if(data.success){
						$("#accountCheck").val("true");
						alert(data.message);
						console.log("중복검사 여부 : " + $("#accountCheck").val());
		            }else{
		            	alert(data.message);
		            }
					
				},
				error: function(){
					alert("에러발생");
				}
				
			})
		}
	</script>
</body>

</html>