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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MEET PLAY SHARE, 솔 시네마</title>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<link rel="stylesheet" href="${cp}/resources/css/board.css" />
	<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
  	<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
	
	<script type="text/javascript">
	
		function sendIt(){
			
			var f = document.myForm;
			
			var page = "${articleCurrentPage}";
			
			var category = f.p_category.value; // 선택한 카테고리 값을 가져옴
			
			num = f.p_id.value;
			
			str = f.p_title.value;
			str = str.trim();
			if(!str){
				alert("\n제목을 입력하세요.");
				f.p_title.focus();
				return;
			}
			f.p_title.value = str;
			
			str = f.p_text.value;
			str = str.trim();
			if(!str){
				alert("\n내용을 입력하세요.");
				f.p_text.focus();
				return;
			}
			f.p_text.value = str;
			
			f.p_category.value = category; // 선택한 카테고리 값을 다시 설정
			
			f.action = "<%=cp%>/inquiry/modify?p_id=" + num + "&page=" + page;
			f.submit();
			alert("글 수정이 완료 되었습니다.");
			
		}
	
	</script>
</head>
<body>
	<%@include file="../common/tags.jsp" %>
	<%@include file="../common/navbar.jsp"%>
	<div id="back-container">
        <div id="main-container">
            <%@include file="../common/boardSideBar.jsp"%>

            <article id="content-container">
                <h2 style="padding-bottom: 0.5em; border-bottom: 1px solid #cacaca;">문의 수정</h2>
                
                <form action="" method="post" name="myForm" id="post-write-area">
                	<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
                	
                	<input type="hidden" name ="p_id" value="${article.p_id }">
                	
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
                                <input type="text" name="p_title" id="write-post-title" class="write-category" style="padding-right: 0px;" value="${article.p_title }">
                            </div>
                        </div>
                    </div>
                    <div id="write-text-area" style="border-bottom: 1px solid #cacaca;">
                        <div class="write-category-text" style="width: 20%;">
                            <span style="margin-left: 15px;">내용<span style="color: red;">*</span></span>
                        </div>
                        <div style="display: flex; align-items: center;">
                            <textarea name="p_text" id="text-area" cols="30" rows="10" maxlength="20">${article.p_text }</textarea>
                        </div>
                    </div>

	                <div id="btn-area" style="display: flex; justify-content: center;">
	                    <button class="write-btn-class" id="write-btn" onclick="sendIt();">수정하기</button>
	                    <a href="javascript:location.href='<%=cp%>/inquiry/list?page=${articleCurrentPage}';" class="write-btn-class">돌아가기</a>
	                </div>
	           	</form>
            </article>
        </div>
    </div>
    <%@include file="../common/footer.jsp"%>
</body>
</html>