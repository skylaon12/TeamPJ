<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
	<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
	<link rel="stylesheet" href="../resources/css/tickethistory.css?ver=<%=System.currentTimeMillis()%>">
	<link rel="icon" href="../resources/images/logo/logo-s.png" type="image/x-icon">
    <title>SOL CINEMA</title>
    <style type="text/css">
    
    </style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/navbar.jsp"%>
	<div id="reservation-container">
		<c:if test="${empty tickets}">
			<div id="history-container">
        <div id="history-empty">
            <div id="cross-img"></div>
            <span>예매 내역이 존재하지 않습니다.</span>
        </div>
    </div>
		</c:if>
		<c:if test="${not empty tickets}">
			<c:forEach var="ticket" items="${tickets}">
			    <div id="history-container">
			        <div id="ticket-history-1" class="main-container">
			            <img src="${ticket.m_poster }" alt="포스터" class="movie-poster">
			            <div id="text-container-1" class="text-container">
			                <span class="movie-name">${ticket.m_title}</span>
			                <span class="text">${ticket.region_detail}</span>
			                <span class="text">${ticket.reserv_date} | ${ticket.str_hour}:${ticket.str_min} ~ ${ticket.end_hour}:${ticket.end_min}</span>
			                <span class="text">${ticket.seat_num}</span>
			                <span class="text"> 결제금액 ${ticket.cost}원</span>
							<div>
			                	<a href="myTicketInfo?id=${ticket.id}"><span id="payment-1" class="payment">결제상세</span></a>
							</div>
			            </div>
			        </div>
			    </div>
		</c:forEach>
		</c:if>
    </div>
    <%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script>
    /* (임시) 버튼 테스트용, db에서 값 받아와야 함 */
    let countLow = 1;
    let countHigh = countLow + 1;
	let $div = $("#reservation-container");
    

    function payment(id) {
        console.log(id + '결제 상세')
    }
</script>
</html>