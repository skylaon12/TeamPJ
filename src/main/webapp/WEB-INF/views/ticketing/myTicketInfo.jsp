<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon">
<script src="${cp}/resources/js/login.js"></script>
<title>SOL CINEMA</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700&display=swap');

    @font-face {
    font-family: 'NanumSquareNeo';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/NanumSquareNeo-Variable.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
    }

    body {
        margin: 0px;
        padding: 0px;
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: rgb(200, 200, 200);
    }

    img {
        overflow: hidden;
    }

    button:hover {
        cursor: pointer;
    }

    .detail-text {
        padding: 0.15em 0em;
        width: 100px;
        text-wrap: nowrap;
        font-family: Noto Sans KR;
        font-size: 90%;
    }

    .cinema-comment {
        margin: 0px;
        font-family: Noto Sans KR;
        font-size: 75%;
        margin-left: 5px;
    }

    .payment {
        width: 60px;
        height: 50px;
        border-top: 2px solid rgba(110, 110, 110, 0.1);
        font-family: Noto Sans KR;
        font-weight: 500;
        font-size: 90%;
        line-height: 50px;
        text-wrap: nowrap;
    }

    .payment-number {
        width: 100px;
        height: 50px;
        border-top: 2px solid rgba(110, 110, 110, 0.1);
        font-family: Noto Sans KR;
        font-weight: 500;
        font-size: 90%;
        line-height: 50px;
        text-wrap: nowrap;
        text-align: end;
    }

    .payment-img {
        width: auto;
        height: 50px;
        padding: 0em 0.7em;
        border-top: 2px solid rgba(110, 110, 110, 0.1);
        font-size: 90%;
        line-height: 55px;
    }

    .payment-means {
        font-family: Noto Sans KR;
        font-weight: 500;
        font-size: 70%;
        line-height: 25px;
        text-wrap: nowrap;
        
    }
    .ticket-status {
        font-family: Noto Sans KR, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
        font-size: 13px;
        width: 250px;
        border: 1px solid #ececec;
        height: 50px;
        margin: 10px 10px 0 -50px;
        border-radius: 30px;
    }

    .hidden { display: none; }
    .not-used { background: green; }
    .used { background: #c41313 }
    
</style>
<body>

<%@include file="/WEB-INF/views/common/navbar.jsp"%>
    <!-- 메인 컨테이너 -->
    <div style="width: 70%; min-width: 550px; max-width: 780px; height: 100%; color: black; display: flex; flex-direction: column; align-items: center;">

        <!-- 결제 완료 이미지 -->
        <div style="display: flex; flex-direction: column; align-items: center;">
            <img src="../resources/images/movie/card.png" alt="결제 완료" style="height: 120px; margin-top: 20px; margin-bottom: -10px;"><br>
            <span style="margin-bottom: 20px; font-family: NanumSquareNeo; font-weight: 600; font-size: 90%; letter-spacing: 1px;">결제가 성공적으로 완료되었습니다.</span>
        </div>

        <!-- 영화 상세 및 결제 수단 컨테이너 -->
        <div style="display: flex; flex-direction: column; width: 100%; height: 480px; background-color: white; align-items: center;">
            <div style="display: flex; justify-content: center; width: 100%; height: 350px;">

                <!-- 예매 영화 상세 -->
                <div id="movie-poster">
                    <img src="${ticket.m_poster}" alt="영화 포스터" style="height: 300px; width: auto; margin: 20px;">
                </div>
                <div style="display: flex;">
                    <div style="margin: 20px 0px 10px 10px;">
                        <div id="reserve-no" class="detail-text" style="padding: 0px 0px 10px 0px; border-bottom: 2px solid black;">예매번호</div>
                        <div id="date-time" class="detail-text" style="padding: 0px; margin: 10px 0px 0.15em 0px;">상영일시</div>
                        <div id="cinema-screen" class="detail-text">상영관</div>
                        <div id="count" class="detail-text">관람인원</div>
                        <div id="seat" class="detail-text">좌석</div>
                    </div>

                    <div style="margin: 20px 10px 10px 0px;">
                        <div id="reserve-no" class="detail-text" style="width: 200px; padding: 0px 0px 10px 0px; border-bottom: 2px solid black;">reserve-no | ${ticket.id}</div>
                        <div id="date-time" class="detail-text" style="width: 200px; padding: 0px; margin: 10px 0px 0.15em 0px;">date-time | ${ticket.reserv_date} | ${ticket.str_hour}시${ticket.str_min}분</div>
                        <div id="cinema-screen" class="detail-text" style="width: 200px;">cinema-screen | ${ticket.region_detail}점 ${ticket.theater_num}</div>
                        <div id="count" class="detail-text" style="width: 200px;">count | 성인 ${ticket.ticket_cnt}명</div>
                        <div id="seat" class="detail-text" style="width: 200px;">seat | ${ticket.seat_num}</div>
                        <button id="phone-ticket" style="border-radius: 10px; border: none; color: white; background-color: rgb(222, 0, 0); padding: 0.7em 2.5em; line-height: 20px; margin: 20px 10px 10px -30px;">카카오톡으로 티켓받기</button>
                        <div id="ticket-status-not" class="ticket-status not-used hidden">
                            <span style="padding: 10px;">아직 상영시간 전이에요!</span>
                        </div>
                        <div id="ticket-status-used" class="ticket-status used hidden">
                            <span style="padding: 10px;">이미 사용한 티켓이에요!</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 결제 금액 및 결제 수단 -->
            <div style="width: 500px;">
                <div style="display: flex; justify-content: center; vertical-align: middle;">
                    <div class="payment" id="order-cost" style="padding-left: 10px;">주문금액</div>
                    <div class="payment-number" id="order-cost-number">${ticket.cost}원</div>
                    <div class="payment-img">
                        <img style="width: 15px;" src="../resources/images/movie/payment-img-01.png" alt="-">
                    </div>
                    <div class="payment" id="discount-cost">할인금액</div>
                    <div class="payment-number" id="discount-cost-number">0원</div>
                    <div class="payment-img">
                        <img style="width: 15px;" src="../resources/images/movie/payment-img-02.png" alt="=">
                    </div>
                    <div class="payment" id="total-amount">총 결제 금액</div>
                    <div class="payment-number" id="total-amount-number" style="padding-right: 10px;">${ticket.cost}원</div>
                </div>
                <div style="display: flex; justify-content: flex-end;">
                    <div style="display: flex;">
                        <div class="payment-means" id="payment-means" style="background-color: darkgray; color: white; text-align: center; border-radius: 15px; width: 60px; height: auto; margin-right: 20px;">결제수단</div>
                        <div class="payment-means" id="payment-means-detail" style="text-align: end; margin-right: 10px;">신용/체크카드</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 안내 사항 -->
        <div style="width: 100%; height: auto; text-align: left; margin-top: 5px;">
            <p class="cinema-comment" style="color: red;"> · 예매 취소는 상영 시작 20분 전까지 온라인에서 가능합니다.</p>
            <p class="cinema-comment" style="color: red;"> · 상영 시작 20분 전부터는 현장에서만 취소가 가능합니다.</p>
            <p class="cinema-comment" style="color: red;"> · 무대인사 예매 취소는 상영 시작 24시간 전까지 가능합니다.</p>
            <p class="cinema-comment"> · 예고편 상영 등 상영관 사정으로 인해 영화 시작 시간이 10여분 차이 날 수 있습니다.</p>
            <p class="cinema-comment"> · 개인정보 보호 정책에 따라 회원 정보로는 예매 정보를 찾아드릴 수 없습니다.</p>
            <p class="cinema-comment"> · 스토어에서 구매한 상품은 마이페이지 > 예매/구매 내역에서 확인 및 사용할 수 있습니다.</p>
        </div>
        <div>
            <div style="display: flex;"></div>
            <a href="${cp}/"><button id="redirect-home" style="border-radius: 10px; border: none; color: white; background-color: rgb(222, 0, 0); padding: 0.7em 2.5em; line-height: 20px; margin: 20px 50px 20px 20px;">홈으로 돌아가기</button></a>
            <a href="${cp}/ticketing/bookCancel?id=${ticket.id}"><button id="cancelBtn" style="border-radius: 10px; border: none; color: white; background-color: rgb(222, 0, 0); padding: 0.7em 2.5em; line-height: 20px; margin: 20px 20px 20px 50px;">예약 취소</button></a>
        </div>
    </div>
<%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
// ticket 정보를 JavaScript 객체로 파싱
var ticket = {
  reserv_date: "${ticket.reserv_date}",
  str_hour: "${ticket.str_hour}",
  str_min: "${ticket.str_min}"
};

// 현재 날짜와 시간 정보 얻기
var currentDate = new Date();
var currentYear = currentDate.getFullYear();
var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 더합니다.
var currentDay = currentDate.getDate();
var currentHour = currentDate.getHours();
var currentMinute = currentDate.getMinutes();

// 예매 정보의 날짜와 시간 얻기
var reservedDate = new Date(ticket.reserv_date);
var reservedYear = reservedDate.getFullYear();
var reservedMonth = reservedDate.getMonth() + 1;
var reservedDay = reservedDate.getDate();
var reservedHour = parseInt(ticket.str_hour);
var reservedMinute = parseInt(ticket.str_min);

// 예매 정보의 시간을 20분 앞당겨야함.
reservedDate.setMinutes(reservedDate.getMinutes() - 20);

// 날짜 및 시간 비교
if (currentDate < reservedDate) {
  // 아직 상영시간 전인 경우
  var notUsedStatus = document.getElementById("ticket-status-not");
  notUsedStatus.classList.remove("hidden");
} else {
  // 이미 사용한 티켓인 경우
//   var cancelButton = documentc.
  var usedStatus = document.getElementById("ticket-status-used");
  usedStatus.classList.remove("hidden");
  document.getElementById("cancelBtn").style.display = "none"; // 또는 "inline-block", "inline", 등으로 변경 가능
}
</script>
</html>