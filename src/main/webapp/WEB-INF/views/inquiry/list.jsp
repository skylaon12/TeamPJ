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
		window.onload = function() {
		    // 현재 페이지 URL에서 파라미터를 읽어옴
		    var urlParams = new URLSearchParams(window.location.search);
		    var category = urlParams.get("p_category");
	
		    // 선택된 버튼에 해당하는 ID를 찾아서 클래스를 추가
		    if (category === "결제/환불") {
		        document.getElementById('cate-pay').classList.add('category-on');
		    } else if (category === "영화관") {
		        document.getElementById('cate-cinema').classList.add('category-on');
		    } else {
		    	document.getElementById('cate-all').classList.add('category-on');
		    }
		    // 기타 버튼에 대한 처리도 추가 가능
		};
		
		function sendIt(){
			var f = document.searchForm;
			var curPage = f.page.value;
			var curCategory = f.p_category.value;
			var sKey = "${searchKey}";
			var sWord = "${word}";
			
			if (curCategory == null || curCategory === '') {
				f.action = "<%=cp%>/inquiry/list?page="+ curPage +"&searchKey="+ sKey +"&word="+ sWord;
			} else {
				f.action = "<%=cp%>/inquiry/list?page="+ curPage +"&p_category="+ curCategory +"&searchKey="+ sKey +"&word="+ sWord;
			}
			
			f.submit();
		}
		
		function cateChange(id) {
	        let all = document.getElementById('cate-all');
	        let pay = document.getElementById('cate-pay');
	        let cinema = document.getElementById('cate-cinema');
	        
	        var newUrl = "";
	        
	        var curPage = "${currentPage}";
			
	     	// 모든 버튼 클래스 제거
	        all.classList.remove('category-on');
	        pay.classList.remove('category-on');
	        cinema.classList.remove('category-on');

	     	// 선택한 버튼에 클래스 추가
	        if (id == "cate-all") {
	        	newUrl = "<%=cp%>/inquiry/list?page=" + curPage;
	            all.classList.add('category-on');
	        } else if (id == "cate-pay") {
	        	newUrl = "<%=cp%>/inquiry/list?page=" + curPage + "&p_category=결제/환불";
	            pay.classList.add('category-on');
	        } else if (id == "cate-cinema") {
	        	newUrl = "<%=cp%>/inquiry/list?page=" + curPage + "&p_category=영화관";
	            cinema.classList.add('category-on');
	        } else return;
	     	
	     	// URL을 업데이트하여 선택한 카테고리 정보를 유지
	        history.pushState(null, "", newUrl);
	     	
	        window.location.replace(newUrl);
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
                <h2 style="padding-bottom: 0.5em;">내 문의 내역</h2>
                <div id="category-area" style="border-top: 1px solid #cacaca; padding: 0.3em 0;">
                    <ul style="display: flex;">
                        <li><button id="cate-all" onclick="cateChange(this.id)" class="category">전체</button></li>
                        <li><button id="cate-pay" onclick="cateChange(this.id)" class="category">결제/환불</button></li>
                        <li><button id="cate-cinema" onclick="cateChange(this.id)" class="category">영화관</button></li>
                        <span style="margin-left: auto; font-size: 12px;">전체 글 수 : </span>
                        <span style="padding: 0 0.3em; font-size: 12px" id="total-post">${totalCount}</span>
                    </ul>
                </div>
                <table style="border-collapse: collapse;">
                    <colgroup>
                        <col style="width: 6%">
                        <col>
                        <col style="width: 10%">
                        <col style="width: 20%">
                        <col style="width: 6%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>문의 상태</th>
                            <th>작성일</th>
                            <th>조회</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:choose>
							<c:when test="${totalCount != 0}">
		                    	<c:forEach var="dto_inquiry" items="${lists}">
			                        <tr>
			                            <td class="text-align-center"><span>${dto_inquiry.p_id }</span></td>
			                            <td>
				                            <c:choose>
				                            	<c:when test="${dto_inquiry.newComment}">
						                            [${dto_inquiry.p_category }] 
						                            <a href="${articleUrl}${dto_inquiry.p_id }&page=${currentPage }" title=${dto_inquiry.p_title }>${dto_inquiry.p_title }</a>
						                             [${dto_inquiry.commentCount}] New
						                        </c:when>
						                        <c:otherwise>
						                        	[${dto_inquiry.p_category }] 
						                            <a href="${articleUrl}${dto_inquiry.p_id }&page=${currentPage }" title=${dto_inquiry.p_title }>${dto_inquiry.p_title }</a>
						                             [${dto_inquiry.commentCount}]
						                        </c:otherwise>
											</c:choose>
										</td>
			                            <td class="text-align-center">
			                            	<c:choose>
												<c:when test="${dto_inquiry.p_status == 'T'}">
													<span>완료</span>
												</c:when>
												<c:otherwise>
													<span>진행 중...</span>
												</c:otherwise>
											</c:choose>
			                            </td>
			                            <td class="text-align-center"><span>${dto_inquiry.p_created }</span></td>
			                            <td class="text-align-center"><span>${dto_inquiry.p_hitcount }</span></td>
			                        </tr>
			                    </c:forEach>
			              	</c:when>

				            <c:otherwise>
				            	<td>&nbsp</td>
								<td style="margin-left: auto;">등록된 게시물이 없습니다.</td>
								<td>&nbsp</td>
								<td>&nbsp</td>
								<td>&nbsp</td>
							</c:otherwise>
						</c:choose>
                    </tbody>
                </table>
                
               	<form action="" method="get" name="searchForm" id="button-area" style="display: flex; justify-content: flex-end; margin: 15px 0 15px 0px;">
               		<input type="hidden" name ="page" value="${currentPage }">
					<input type="hidden" name ="p_category" value="${currentCate }">
					
                    <select name="searchKey" id="keyword">
                        <option value="p_title">제목</option>
                        <option value="p_text">내용</option>
                    </select>
                    
                    <input type="text" id="search" name="word">
                    
                    <button id="search-btn" onclick="sendIt()"></button>
                    
                    <a id="post-list-btn" href="list?page=${currentPage }">목록</a>
                   	<a id="write" href="write?page=${currentPage}">글쓰기</a>
                </form>
                    

                <div id="paging-area" style="display: flex; justify-content: center;">
                	<c:if test="${totalCount != 0}">
						<c:choose>
							<c:when test="${hasPrev}">
								<c:choose>
									<c:when test="${not empty currentCate}">
										<a href="${cp}/inquiry/list?page=${prevPage}&p_category=${currentCate}" class="paging-prev">이전</a>
									</c:when>
									<c:otherwise>
										<a href="${cp}/inquiry/list?page=${prevPage}" class="paging-prev">이전</a>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<a href="#" class="paging-prev">이전</a>
							</c:otherwise>
						</c:choose>
	
						<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
							<c:choose>
								<c:when test="${currentPage == p}">
									<c:choose>
										<c:when test="${not empty currentCate && not empty word}">
											<a href="${cp}/inquiry/list?page=${p}&p_category=${currentCate}&searchKey=${searchKey}&word=${word}" class="paging paging-on">${p}</a>
										</c:when>
										<c:when test="${empty currentCate && not empty word}">
											<a href="${cp}/inquiry/list?page=${p}&searchKey=${searchKey}&word=${word}" class="paging paging-on">${p}</a>
										</c:when>
										<c:when test="${not empty currentCate && empty word}">
											<a href="${cp}/inquiry/list?page=${p}&p_category=${currentCate}" class="paging paging-on">${p}</a>
										</c:when>
										<c:otherwise>
											<a href="${cp}/inquiry/list?page=${p}" class="paging paging-on">${p}</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${not empty currentCate && not empty word}">
											<a href="${cp}/inquiry/list?page=${p}&p_category=${currentCate}&searchKey=${searchKey}&word=${word}" class="paging">${p}</a>
										</c:when>
										<c:when test="${empty currentCate && not empty word}">
											<a href="${cp}/inquiry/list?page=${p}&searchKey=${searchKey}&word=${word}" class="paging">${p}</a>
										</c:when>
										<c:when test="${not empty currentCate && empty word}">
											<a href="${cp}/inquiry/list?page=${p}&p_category=${currentCate}" class="paging">${p}</a>
										</c:when>
										<c:otherwise>
											<a href="${cp}/inquiry/list?page=${p}" class="paging">${p}</a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:choose>
							<c:when test="${hasNext}">
								<c:choose>
									<c:when test="${not empty currentCate}">
										<a href="${cp}/inquiry/list?page=${nextPage}&p_category=${currentCate}" class="paging-next">다음</a>
									</c:when>
									<c:otherwise>
										<a href="${cp}/inquiry/list?page=${nextPage}" class="paging-next">다음</a>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<a href="#" class="paging-next">다음</a>
							</c:otherwise>
						</c:choose>
					</c:if>
                </div>
            </article>
        </div>
    </div>
    <%@include file="../common/footer.jsp"%>
</body>
<script>
$(document).ready(function(){
	$("#notice-bar").removeClass("select");
	$("#my-inquiry-bar").addClass("select");
})
</script>
</html>