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
	
	<link rel="stylesheet" type="text/css" href="${cp}/resources/css/style.css?ver=<%=System.currentTimeMillis()%>"/>
	<link rel="stylesheet" type="text/css" href="${cp}/resources/css/list.css?ver=<%=System.currentTimeMillis()%>"/>
	<link rel="stylesheet" type="text/css" href="${cp}/resources/css/main_files/megabox.min.css?ver=<%=System.currentTimeMillis()%>" media="all">
	<link rel="stylesheet" href="${cp}/resources/css/navbar.css" />
	<link rel="stylesheet" href="${cp}/resources/css/common.css" />
	
	<script type="text/javascript" src="/resources/js/util.js"></script>
	<script type="text/javascript">
		function isAgreementChecked() {
	    	return document.getElementById('chk').checked;
		}
	
		function sendIt(){
			
			var f = document.myForm;
			
			var page = "${writeCurrentPage}";
			
			// 개인 정보 수집 동의 체크 확인
		    if (!isAgreementChecked()) {
		        alert("개인정보 수집에 대한 동의가 필요합니다.");
		        return;
		    }
			
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
			
			f.action = "<%=cp%>/inquiry/write?page=" + page;
			f.submit();
			alert("글 등록이 완료 되었습니다.");
		}
	
	</script>
</head>
<body>
	<!-- container -->
	<div class="container has-lnb">
		<div class="page-util fixed">
			<div class="inner-wrap">
				<div class="location">
					<a href="${cp}" title="메인 페이지 이동"><span>Home</span></a>
					<a href="https://www.megabox.co.kr/support" title="고객센터 페이지로 이동">고객센터</a>
					<a href="list?page=${writeCurrentPage}" title="내 문의로 이동">내 문의 내역</a>
					<a href="write?page=${writeCurrentPage}" title="문의 등록">문의 등록</a>
				</div>
	
			</div>
		</div>
		<div class="inner-wrap">
			<div class="lnb-area addchat location-fixed">
				<nav id="lnb">
					<p class="tit"><a href="https://www.megabox.co.kr/support" title="고객센터">고객센터</a></p>
					<ul>
						<li><a href="https://www.megabox.co.kr/support" title="고객센터 홈">고객센터 홈</a></li>
						<li><a href="${cp}/notice/list?page=1" title="공지사항">공지사항</a></li>
						<li class="on"><a href="list?page=${writeCurrentPage }" title="1:1문의">1:1문의</a></li>
					</ul>
				</nav>
			</div>
	
			<div id="contents" class="location-fixed">
				<h2 class="tit">1:1 문의 등록</h2>
				
				<div class="agree-box">
					<dl>
						<dt>
							<span class="bg-chk mr10">
								<input type="checkbox" id="chk">
								<label for="chk"><strong>개인정보 수집에 대한 동의</strong></label>
							<span class="font-orange">[필수]</span></span>
	
							
						</dt>
						<dd style="font-size:13px;">
							귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다.<br><br>
	
							[개인정보의 수집 및 이용목적]<br>
							회사는 1:1 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다.<br><br>
	
							[필수 수집하는 개인정보의 항목]<br>
							이름, 휴대전화, 이메일, 문의내용<br><br>
	
							[개인정보의 보유기간 및 이용기간]<br>
							<span class="ismsimp">문의 접수 ~ 처리 완료 후 6개월<br>
							(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)<br>
							자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</span>
						</dd>
					</dl>
				</div>
				<br/>
				<p class="reset mt10">* 원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다</p>
				
				<div class="btn-group right">
					<a href="list?page=${writeCurrentPage}" class="button purple" id="myQnaBtn" title="문의 리스트 이동">내 문의 내역</a><!-- btn-layer-open -->
				</div>
	
				<form action="" method="post" name="myForm">
					<div id="bbsCreated">
						<table class="board-form va-m">
							<colgroup>
								<col style="width:150px;">
								<col>
								<col style="width:150px;">
								<col>
							</colgroup>
							
							<tbody>
								<tr>
									<th scope="row"><label for="name">이름</label> <em class="font-orange">*</em></th>
									<td><input type="text"  name ="p_writer" class="input-text w150px" value="" maxlength="15"></td>
								</tr>
										
								<tr>
									<th scope="row"><label for="qnaCustInqTitle">제목</label> <em class="font-orange">*</em></th>
									<td colspan="3"><input type="text" name="p_title"  class="input-text" maxlength="100"></td>
								</tr>
								
								<tr>
									<th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
									<td colspan="3">
										<div class="textarea">
											<textarea name="p_text" rows="5" cols="30" title="내용입력" placeholder="※ 문의 내역을 남겨주세요." class="input-textarea"></textarea>
											<div class="util">
												<p class="count">
													<span id="textareaCnt">0</span> / 2000
												</p>
											</div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				
					<br/>	<br/>	
					<div id="bbsCreated_footer" align="center">
						<input type="button" value=" 등록하기 " class="button purple large" onclick="sendIt();"/>
						<input type="reset" value=" 다시입력 " class="button purple large" 
						onclick="document.myForm.subject.focus();"/>
						<input type="button" value=" 작성취소 " class="button purple large" 
						onclick="javascript:location.href='<%=cp%>/inquiry/list?page=${writeCurrentPage}';"/>
					</div>
				
				</form>
			</div>
		</div>
	</div>
	
	<%@include file="/WEB-INF/views/common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="/WEB-INF/views/common/errorModal.jsp"%>
</body>
</html>