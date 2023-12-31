<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="icon" href="../resources/images/logo/logo-s.png" type="image/x-icon">
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
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0px;
        padding: 0px;
    }

    img { overflow: hidden; }

    button:hover { cursor: pointer; }

    button.cancel-button-disable {
        border-radius: 10px;
        border: none;
        color: white;
        background-color: rgb(150, 150, 150);
        padding: 0.7em 2.5em;
        line-height: 20px;
        margin: 20px 20px 20px 50px;
        cursor: default;
    }

    button.cancel-button-enable {
        border-radius: 10px;
        border: none;
        color: white;
        background-color: rgb(222, 0, 0);
        padding: 0.7em 2.5em;
        line-height: 20px;
        margin: 20px 20px 20px 50px;
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
        color: red;
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
        line-height: 45px;
    }

    .payment-means {
        font-family: Noto Sans KR;
        font-weight: 500;
        font-size: 70%;
        line-height: 25px;
        text-wrap: nowrap;
    }

    #main-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 70%;
        min-width: 550px;
        max-width: 780px;
        height: 100%;
    }

    #detail-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        border: 1px solid #555555;
        border-radius: 5px;
        width: 100%;
        height: 480px;
    }

    .flex-col-align-cen {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .flex-center {
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/navbar.jsp"%>
<!-- 메인 컨테이너 -->
    <div id="main-container">
        <!-- 결제 완료 이미지 -->
        <div class="flex-col-align-cen">
            <img src="../resources/images/movie/card.png" alt="결제 완료" style="height: 120px; margin-top: 20px; margin-bottom: -10px;"><br>
            <span style="margin-bottom: 20px; font-family: NanumSquareNeo; font-weight: 600; font-size: 90%; letter-spacing: 1px;">예매 취소 전 확인해주세요!</span>
        </div>

        <!-- 영화 상세 및 결제 수단 컨테이너 -->
        <div id="detail-container">
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
                    </div>
                </div>
            </div>

            <!-- 결제 금액 및 결제 수단 -->
            <div style="width: 500px;">
                <div style="display: flex; justify-content: center; vertical-align: middle;">
                    <div class="payment" id="order-cost" style="padding-left: 10px;">결제금액</div>
                    <div class="payment-number" id="order-cost-number">${ticket.cost}원</div>
                    <div class="payment-img">
                        <img style="width: 15px;" src="../resources/images/movie/payment-img-01.png" alt="-">
                    </div>
                    <div class="payment" id="fee-cost">취소수수료</div>
                    <div class="payment-number" id="fee-cost-number">0원</div>
                    <div class="payment-img">
                        <img style="width: 15px;" src="../resources/images/movie/payment-img-02.png" alt="=">
                    </div>
                    <div class="payment" id="total-amount">예상 환불액</div>
                    <div class="payment-number" id="total-amount-number" style="padding-right: 10px;">${ticket.cost}원</div>
                </div>
                <div style="display: flex; justify-content: flex-end;">
                    <div style="display: flex;">
                        <div class="payment-means" id="payment-means" style="background-color: darkgray; color: white; text-align: center; border-radius: 15px; width: 60px; height: auto; margin-right: 20px;">결제수단</div>
                        <div class="payment-means" id="payment-means-detail" style="text-align: end; margin-right: 10px;">신용/체크카드</div>
                    </div>
                </div>
                <div></div>
            </div>
        </div>

        <!-- 안내 사항 -->
        <div style="width: 100%; height: auto; text-align: left; margin-top: 5px;">
            <p class="cinema-comment"> · 예매 취소는 상영 시작 20분 전까지 온라인에서 가능합니다.</p>
            <p class="cinema-comment"> · 상영 시작 20분 전부터는 현장에서만 취소가 가능합니다.</p>
            <p class="cinema-comment"> · 무대인사 예매 취소는 상영 시작 24시간 전까지 가능합니다.</p>
            <p class="cinema-comment"> · 결제수단에 따라, 환불까지 최소 1일 ~ 최대 14일이 소요될 수 있습니다.</p>
            <div style="margin-top: 10px;">
                <input onclick="check()" type="checkbox" name="cancel-check" id="cancel-check" style="scale: 120%;">
                <label for="cancel-check" class="cinema-comment" style="color: black; position: relative; left: -10px; top: -2px; font-size: 90%;">상기 내용을 확인하였습니다.</label>
            </div>
        </div>
        <div>
            <div style="display: flex;"></div>
            <button id="redirect-home" style="border-radius: 10px; border: none; color: white; background-color: rgb(222, 0, 0); padding: 0.7em 2.5em; line-height: 20px; margin: 20px 50px 20px 20px;">홈으로 돌아가기</button>
            <a id="cancelLink"><button id="cancel-button" class="cancel-button-disable">취소확인</button></a>
        </div>
    </div>
</body>
<script>
    let checkBox = false;
    let button = document.getElementById('cancel-button');
	var link = document.getElementById('cancelLink');
    function check() { 
        checkBox = !checkBox;
        if (checkBox == true) {
        	link.href = "cancelProc?id=" + ${ticket.id};
            button.classList.remove('cancel-button-disable');
            button.classList.add('cancel-button-enable');
        } else {
            button.classList.remove('cancel-button-enable');
            button.classList.add('cancel-button-disable');
        }
    }
</script>
</html>
