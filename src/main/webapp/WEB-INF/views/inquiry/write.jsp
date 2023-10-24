<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<link rel="shortcut icon"
		href="https://www.megabox.co.kr/static/pc/images/favicon.ico">
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MEET PLAY SHARE, 솔 시네마</title>
	
	<link rel="stylesheet" href="${cp}/resources/css/board.css" />
	
	<script type="text/javascript">
		function isAgreementChecked() {
	    	return document.getElementById('write-check-agree').checked;
		}
	
		function sendIt(){
			
			var f = document.myForm;
			
			var page = "${writeCurrentPage}";
			
			// 개인 정보 수집 동의 체크 확인
		    if (!isAgreementChecked()) {
		        alert("개인정보 수집에 대한 동의가 필요합니다.");
		        f.p_title.focus();
		        return;
		    }
			
		    var category = f.p_category.value; // 선택한 카테고리 값을 가져옴
			
			str = f.p_title.value;
			str = str.trim();
			if(!str){
				alert("\n제목을 입력하세요.");
				f.p_title.focus();
				return;
			}
			f.p_title.value = str;
			
			str = f.p_writer.value;
			str = str.trim();
			if(!str){
				alert("\n이름을 입력하세요.");
				f.p_writer.focus();
				return;
			}		
			
			f.p_writer.value = str;
			
			
			str = f.p_text.value;
			str = str.trim();
			if(!str){
				alert("\n내용을 입력하세요.");
				f.p_text.focus();
				return;
			}
			f.p_text.value = str;
			
			f.p_category.value = category; // 선택한 카테고리 값을 다시 설정
			
			f.action = "<%=cp%>/inquiry/write?page=" + page;
			f.submit();
			alert("글 등록이 완료 되었습니다.");
		}
	</script>
</head>
<body>
	<div id="back-container">
        <div id="main-container">
            <div id="left-nav-bar">
                <span style="display: flex; justify-content: center; padding: 30px 20px; border-radius: 10px 10px 0 0; background-color: #8b0bd6; letter-spacing: 1px; font-weight: 500;">고객센터</span>
                <nav id="left-nav-column">
                    <ul>
                        <li class="left-nav">
                            <a href="home">고객센터 홈</a>
                        </li>
                        <li class="left-nav">
                            <a href="${cp}/notice/list?page=1">공지사항</a>
                        </li>
                        <li class="left-nav">
                            <a href="list?page=${writeCurrentPage }">내 문의 내역</a>
                        </li>
                        <li class="left-nav select-last">
                            <a href="write?page=${writeCurrentPage }">1:1 문의</a>
                        </li>
                    </ul>
                </nav>
            </div>

            <article id="content-container">
                <h2 style="padding-bottom: 0.5em; border-bottom: 1px solid #cacaca;">문의하기</h2>
                
                <form action="" method="post" name="myForm" id="post-write-area">
                	<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
                	
                	<input type="hidden" name ="p_writer" value="테스트">
                	
                    <div id="category-select">
                        <div id="select-area-1">
                            <div class="write-category-text">
                                <span style="margin-left: 15px;">카테고리<span style="color: red;">*</span></span>
                            </div>
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <select name="p_category" id="write-category-select" class="write-category">
                                    <option value="결제/환불">결제/환불</option>
                                    <option value="영화관">영화관</option>
                                </select>
                            </div>
                        </div>
                        <div id="select-area-2">
                            <div class="write-category-text">
                                <span style="margin-left: 15px;">제목<span style="color: red;">*</span></span>
                            </div>
                            <div style="display: flex; justify-content: center; align-items: center;">
                                <input type="text" name="p_title" id="write-post-title" class="write-category" style="padding-right: 0px;">
                            </div>
                        </div>
                    </div>
                    <div id="write-text-area" style="border-bottom: 1px solid #cacaca;">
                        <div class="write-category-text" style="width: 20%;">
                            <span style="margin-left: 15px;">내용<span style="color: red;">*</span></span>
                        </div>
                        <div style="display: flex; align-items: center;">
                            <textarea name="p_text" id="text-area" cols="30" rows="10" maxlength="20"></textarea>
                        </div>
                    </div>

	                <label for="write-check-agree"><input type="checkbox" value="write-check-agree" id="write-check-agree">임시 체크박스 | write-agree</label>
	                <div id="btn-area" style="display: flex; justify-content: center;">
	                    <button class="write-btn-class" id="write-btn" onclick="sendIt();">등록</button>
	                    <a href="javascript:location.href='<%=cp%>/inquiry/list?page=${writeCurrentPage}';" class="write-btn-class">돌아가기</a>
	                </div>
	           	</form>
            </article>
        </div>
    </div>
</body>
</html>