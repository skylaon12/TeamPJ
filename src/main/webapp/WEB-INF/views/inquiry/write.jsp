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
	<title>SOL CINEMA</title>
	
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<link rel="icon" href="../resources/images/logo/logo-s.png" type="image/x-icon">
	<link rel="stylesheet" href="${cp}/resources/css/board.css" />
	<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
  	<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
	<script type="text/javascript">
		function checkConfirmation(){
			var checkBox = document.getElementById("write-check-agree");
			var modifyBtn = document.getElementById("write-btn");
			
			if(checkBox.checked){
				modifyBtn.classList.remove("btn-disable");
				modifyBtn.classList.add("write-btn-class");
			}else{
				modifyBtn.classList.remove("write-btn-class");
				modifyBtn.classList.add("btn-disable");
			}
		}
	
		
		function isAgreementChecked() {
	    	return document.getElementById('write-check-agree').checked;
		}
	
		function sendIt(){
			
			var f = document.myForm;
			
			var page = "${writeCurrentPage}";
			
			// 개인 정보 수집 동의 체크 확인
		    if (!isAgreementChecked()) {
		        pushModal("개인정보 수집에 대한 동의가 필요합니다.");
		        f.p_title.focus();
		        return;
		    }
			
		    var category = f.p_category.value; // 선택한 카테고리 값을 가져옴
			
			str = f.p_title.value;
			str = str.trim();
			if(!str){
				pushModal("\n제목을 입력하세요.");
				f.p_title.focus();
				return;
			}
			f.p_title.value = str;
			
			str = f.p_writer.value;
			str = str.trim();
			if(!str){
				pushModal("\n이름을 입력하세요.");
				f.p_writer.focus();
				return;
			}		
			
			f.p_writer.value = str;
			
			
			str = f.p_text.value;
			str = str.trim();
			if(!str){
				pushModal("\n내용을 입력하세요.");
				f.p_text.focus();
				return;
			}
			f.p_text.value = str;
			
			f.p_category.value = category; // 선택한 카테고리 값을 다시 설정
			
			f.action = "<%=cp%>/inquiry/write?page=" + page;
			f.submit();
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
                <h2 style="padding-bottom: 0.5em; border-bottom: 1px solid #cacaca;">문의하기</h2>
                
                <form action="" method="post" name="myForm" id="post-write-area">
                	<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
                	
                	<input type="hidden" name ="p_writer" value="${LOGIN_USER.account}">
                	
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
                                <input type="text" name="p_title" id="write-post-title" class="write-category" style="padding-right: 0px;" placeholder="제목 작성" maxlength="50">
                            </div>
                        </div>
                    </div>
                    <div id="write-text-area" style="border-bottom: 1px solid #cacaca;">
                        <div class="write-category-text" style="min-width: 20%;">
                            <span style="margin-left: 15px;">내용<span style="color: red;">*</span></span>
                        </div>
                        <div style="display: flex; align-items: center; width: 100%;">
                            <textarea name="p_text" id="text-area" placeholder="문의 내용 작성"></textarea>
                        </div>
                    </div>

	                <div id="check-agree-container">
					    <div id="check-box-line">
					        <label for="write-check-agree" id="agree-label"><input type="checkbox" value="write-check-agree" id="write-check-agree" onchange="checkConfirmation()"> [필수] 개인정보 수집에 대한 동의</label>
					    </div>
					    <div>
					        <div id="agree-content">
					            <span>귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집 · 이용에 대한 본인 동의가 필요한 항목입니다.</span>
					            <strong>[개인정보의 수집 및 이용목적]</strong>
					            <span>회사는 1:1 문의 내역의 확인, 요청사항의 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다.</span>
					            <strong>[필수 수집하는 개인정보의 항목]</strong>
					            <span>이름, 휴대전화, 이메일, 문의내용</span>
					            <strong>[개인정보의 보유기간 및 이용기간]</strong>
					            <span>문의 접수 ~ 처리 완료 후 6개월</span>
					            <span>(단, 관계 법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)</span>
					            <span>자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</span>
					            <strong>* 원활한 서비스 이용을 위한 최소한의 개인정보이므로, 동의하지 않을 경우 서비스를 이용하실 수 없습니다.</strong>
					        </div>
					    </div>
					</div>
	                <div id="btn-area" style="display: flex; justify-content: center;">
	                    <input type="button" class="btn-disable" id="write-btn" onclick="sendIt()" value="등록"/>
	                    <a href="javascript:location.href='<%=cp%>/inquiry/list?page=${writeCurrentPage}';" class="write-btn-class">돌아가기</a>
	                </div>
	           	</form>
            </article>
        </div>
    </div>
    <%@include file="../common/footer.jsp"%>
    <%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
$(document).ready(function(){
	$("#notice-bar").removeClass("select");
	$("#write-inquiry-bar").addClass("select");
})
</script>
</html>