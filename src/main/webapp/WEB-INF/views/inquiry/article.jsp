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
	
		function sendIt(){
			
			var f = document.myForm;
			var page = "${articleCurrentPage}";
			
			id = f.p_ori_id.value;
			
			str = f.p_writer.value;
			str = str.trim();
			if(!str){
				alert("\n이름을 입력하세요.");
				f.p_writer.focus();
				return;
			}		
			
			f.p_writer.value = str;
			
			str = f.p_comment.value;
			str = str.trim();
			if(!str){
				alert("\n내용을 입력하세요.");
				f.p_comment.focus();
				return;
			}
			f.p_comment.value = str;
			
			f.action = "<%=cp%>/inquiry/writeComment?p_id=" + id + "&page=" + page;
			f.submit();
			alert("댓글 등록이 완료 되었습니다.");
		}
		
		
		function endAnswer(id, page){
			if (!confirm("현재 문의 글을 마감 하시겠습니까?")) {
		        // 취소(아니오) 버튼 클릭 시 이벤트
		    } else {
		    	location.href = '<%=cp%>/inquiry/endAnswer?p_id=' + id + '&page=' + page;
		    }
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
                        <li class="left-nav select">
                            <a href="list?page=${articleCurrentPage }">내 문의 내역</a>
                        </li>
                        <li class="left-nav">
                            <a href="write?page=${articleCurrentPage }">1:1 문의</a>
                        </li>
                    </ul>
                </nav>
            </div>

            <article id="content-container">
                <h2 id="post-title" style="padding-bottom: 0.2em;">[${article.p_category }] ${article.p_title }</h2>

                <div id="detail-area" style="display: flex; border-bottom: 1px solid #cacaca; padding-top: 0.5em; padding-bottom: 1em; margin-bottom: 1em; font-size: 13px;">
                    <div>등록일</div>
                    <span id="post-date" class="post-detail">${article.p_created }</span>
                    <div>조회수</div>
                    <span id="post-view" class="post-detail">${article.p_hitcount }</span>
                    <div>답변 상태 :</div>
                    <c:choose>
						<c:when test="${article.p_status == 'T'}">
							<span id="post-status" class="post-detail">완료</span>
						</c:when>
						<c:otherwise>
							<span id="post-status" class="post-detail">접수</span>
						</c:otherwise>
					</c:choose>
                </div>

                <div id="content-area">
                    <span>${articleContent }</span>
                </div>

                <span id="comment-total">전체 댓글 ${commentTotalCount }개</span>

                <div id="comment-area">
                	<c:choose>
	                	<c:when test="${commentTotalCount != 0}">
		                	<c:forEach var="dto" items="${commentLists}">
			                    <div class="comment">
			                        <span class="comment-author">${dto.p_writer }</span>
			                        <span class="comment-date">(${dto.p_created })</span>
			                        <span class="comment-text">${dto.p_comment }</span>
			                    </div>
			                </c:forEach>
			            </c:when>
			            <c:otherwise>
			            	<div class="comment">
								<span class="comment-text">등록된 댓글이 없습니다.</span>
							</div>
						</c:otherwise>
			        </c:choose>
                </div>
				
				<c:if test="${article.p_status == 'F'}">
	                <div id="paging-area" style="display: flex; justify-content: center; margin-bottom: 10px;">
	                    <c:if test="${commentTotalCount != 0}">
							<c:choose>
								<c:when test="${commentHasPrev}">
									<a href="${cp}/inquiry/article?p_id=${article.p_id }&page=${articleCurrentPage }&coPage=${commentPrevPage}" class="paging-prev">이전</a>
								</c:when>
								<c:otherwise>
									<a href="#" class="paging-prev">이전</a>
								</c:otherwise>
							</c:choose>
		
							<c:forEach var="p" begin="${commentBlockStartNo}" end="${commentBlockEndNo}">
								<c:choose>
									<c:when test="${commentCurrentPage == p}">
										<a href="${cp}/inquiry/article?p_id=${article.p_id }&page=${articleCurrentPage }&coPage=${p}" class="paging paging-on">${p}</a>
									</c:when>
									<c:otherwise>
										<a href="${cp}/inquiry/article?p_id=${article.p_id }&page=${articleCurrentPage }&coPage=${p}" class="paging">${p}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:choose>
								<c:when test="${commentHasNext}">
									<a href="${cp}/inquiry/article?p_id=${article.p_id }&page=${articleCurrentPage }&coPage=${commentNextPage}" class="paging-next">다음</a>
								</c:when>
								<c:otherwise>
									<a href="#" class="paging-next">다음</a>
								</c:otherwise>
							</c:choose>
						</c:if>
	                </div>
	             </c:if>
                
                <c:choose>
					<c:when test="${article.p_status == 'T'}">
						<div class="comment" >
							<span class="comment-text" style="margin-top: 0;">문의가 마감되었습니다.</span>
						</div>
					</c:when>
					<c:otherwise>
		               	<form action="" method="post" name="myForm" id="comment-write-area">
		               		<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
		               	
		                    <input type="text" name="p_writer" id="write-author-set" placeholder="이름">
		                    
		                    <input type="hidden" name ="p_ori_id" value="${article.p_id }">
		                    
		                    <div style="width: 100%; max-width: 100%; display: flex; flex-direction: column; align-items: center;" >
		                        <textarea name="p_comment" id="write-area" placeholder="댓글 입력"></textarea>
		                        <input type="submit" name="write-submit" id="write-submit" value="등록" onclick="sendIt();">
		                    </div>
		               </form>
		           </c:otherwise>
		        </c:choose>

                <div id="post-change-area">
                    <div id="post-prev" style="border-bottom: 1px solid #cacaca;">
                        <div style="width: 20%; background: #e4e4e4 url('../resources/images/supports/arrow-top.png') no-repeat center right 15px; background-size: 10%; line-height: 39px;">
                            <span style="margin-left: 20px;">이전 글</span>
                        </div>
                        <div style="line-height: 39px;">
                        	<c:choose>
				            	<c:when test="${not empty previousArticleUrl}">
                            		<a href="${previousArticleUrl}" style="margin-left: 20px;">[${previousArticleCategory }] ${previousArticleTitle }</a>
                            	</c:when>
                            	<c:otherwise>
				                	<span style="margin-left: 20px;">이전 글이 없습니다.</span>
				            	</c:otherwise>
				            </c:choose>
                        </div>
                    </div>
                    <div id="post-next">
                        <div style="width: 20%; background: #e4e4e4 url('../resources/images/supports/arrow-bottom.png') no-repeat center right 15px; background-size: 10%; line-height: 39px;">
                            <span style="margin-left: 20px;">다음 글</span>
                        </div>
                        <div style="line-height: 39px;">
                        	<c:choose>
				            	<c:when test="${not empty nextArticleUrl}">
                            		<a href="${nextArticleUrl}" style="margin-left: 20px;">[${nextArticleCategory }] ${nextArticleTitle }</a>
                            	</c:when>
					            <c:otherwise>
					                <span style="margin-left: 20px;">다음 글이 없습니다.</span>
					            </c:otherwise>
					        </c:choose>
                        </div>
                    </div>
                </div>

                <div id="button-area" style="display: flex; justify-content: flex-end; margin: 15px 0 15px 0px;">
                    <a id="post-list-btn" href="javascript:location.href='<%=cp%>/inquiry/list?page=${articleCurrentPage }';">목록</a>
                    <c:if test="${article.p_status == 'F'}">
                    	<a id="edit" href="javascript:location.href='<%=cp%>/inquiry/modify?p_id=${article.p_id}&page=${articleCurrentPage }';">수정하기</a>
                    	<input type="button" id="edit" value="문의 마감" onclick="endAnswer(${article.p_id}, ${articleCurrentPage});">
                    </c:if>
                </div>
            </article>
        </div>
    </div>
</body>
</html>