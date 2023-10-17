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
	
		function sendIt(){
			
			var f = document.myForm;
			
			var page = "${articleCurrentPage}";
			
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
			
			f.action = "<%=cp%>/inquiry/modify?p_id=" + num + "&page=" + page;
			f.submit();
			alert("글 수정이 완료 되었습니다.");
			
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
					<a href="list?page=${articleCurrentPage}" title="내 문의로 이동">내 문의 내역</a>
					<a href="article?p_id=${article.p_id}&page=${articleCurrentPage}" title="글">${article.p_title }</a>
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
						<li class="on"><a href="list?page=${articleCurrentPage }" title="1:1문의">1:1문의</a></li>
					</ul>
				</nav>
			</div>
	
			<div id="contents" class="location-fixed">
				<h2 class="tit">내 문의 내역 수정</h2>
	
				<div class="btn-group right">
					<a href="list" class="button purple" id="myQnaBtn" title="내 문의 내역 이동">내 문의 내역</a><!-- btn-layer-open -->
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
									<td><input type="hidden" name ="p_id" class="input-text w150px" value="${article.p_id }"></td>
								</tr>
								
								<tr>
									<th scope="row"><label for="name">이름</label> <em class="font-orange">*</em></th>
									<td><input type="text" name ="p_writer" class="input-text w150px" value="${article.p_writer }" maxlength="15" readonly></td>
								</tr>
										
								<tr>
									<th scope="row"><label for="qnaCustInqTitle">제목</label> <em class="font-orange">*</em></th>
									<td colspan="3"><input type="text" name="p_title" value="${article.p_title }" class="input-text" maxlength="100"></td>
								</tr>
								
								<tr>
									<th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
									<td colspan="3">
										<div class="textarea">
											<textarea name="p_text" rows="5" cols="30" title="내용입력" class="input-textarea">${article.p_text }</textarea>
											<div class="util">
												<p class="count">
													
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
						<input type="button" value=" 수정하기 " class="button purple large" onclick="sendIt();"/>
						<input type="button" value=" 수정취소 " class="button purple large" 
						onclick="javascript:location.href='<%=cp%>/inquiry/list?page=${articleCurrentPage}';"/>
					</div>
				
				</form>
			</div>
		</div>
	</div>
	
		<%@include file="../common/footer.jsp"%>
	<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
</html>