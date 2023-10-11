<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="../resources/css/seat.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon">
<script src="${cp}/resources/js/login.js"></script>
<title>SOL CINEMA</title>
</head>
<body>
<%@include file="/WEB-INF/views/common/navbar.jsp"%>
    <!-- 영화 예매 div -->
    <div id="movie-reserv-box">
        <div id="movie-reserv-topline">
            <div id="movie-reserv-step1" class="movie-reserv-stepbox">
                <img class="step-img" src="../resources/images/movie/step-1.png" alt="1.">
                <span class="reserv-text">영화관 선택</span>
            </div>
    
            <div id="movie-reserv-step2" class="movie-reserv-stepbox">
                <img class="step-img" src="../resources/images/movie/step-2.png" alt="2.">
                <span class="reserv-text">관람일 선택</span>
            </div>
    
            <div id="movie-reserv-step3" class="movie-reserv-stepbox">
                <img class="step-img" src="../resources/images/movie/step-3.png" alt="3.">
                <span class="reserv-text">관람시간 선택</span>
            </div>
    
            <div id="movie-reserv-step4" class="movie-reserv-stepbox">
                <img class="step-img" src="../resources/images/movie/step-4.png" alt="4.">
                <span class="reserv-text">잔여석 확인</span>
            </div>
        </div>
    
        <!-- 선택 div 요소 box -->
        <div id="reserv-select-box">
            <!-- 영화관 선택 -->
            <div id="select-cinema" class="reserv-select-box">
                <select onchange="selectRegion(this)" id="region" name="reserv-location-1" id="reserv-location-1" class="select-reserv">
                    <option value="seoul">서울</option>
                    <option value="gyeonggi">경기</option>
                    <option value="incheon">인천</option>
                    <option value="chungcheong">대전/충청/세정</option>
                    <option value="gyeongsang">부산/대구/경상</option>
                    <option value="jeolla">광주/전라</option>
                    <option value="gangwon">강원</option>
                </select>

                <select onchange="selectScreen(this)" id="detail-region" name="reserv-location-2" id="reserv-location-2" class="select-reserv" style="margin: -5px 0px 10px 10px;">
                    <option>지역을 선택해주세요</option>
                </select>
            </div>
    
            <!-- 관람일 선택 -->
            <div id="select-date" class="reserv-select-box">
                <input name="select-date" type="date" id="reserv-date" class="select-reserv">

                <script>
                    const Today = new Date();
                    const year = Today.getFullYear();
                    let month = (Today.getMonth() + 1).toString().padStart(2, '0');
                    let day = Today.getDate().toString().padStart(2, '0');
                    document.getElementById("reserv-date").value = `${year}-${month}-${day}`;
                </script>
            </div>
    
            <!-- 관람시간 선택 -->
            <div id="select-time" class="reserv-select-box">
                <select name="reserv-time" id="reserv-time" class="select-reserv">
                    <option value="1200">12시 00분</option>
                    <option value="1300">13시 00분</option>
                    <option value="1400">14시 00분</option>
                    <option value="1500">15시 00분</option>
                    <option value="1600">16시 00분</option>
                    <option value="1700">17시 00분</option>
                    <option value="1800">18시 00분</option>
                </select>
            </div>
    
			<div id="select-screen" class="reserv-select-box">
                <select onchange="createSeat()" name="select-theater" id="select-theater" class="select-reserv">
                    <option>상영관 선택</option>
                </select>
            </div>
    	</div>

    <!-- 좌석 선택 box -->
    <div id="select-seat-box" class="select-seat-box">
<!-- 		여기 좌석 들어감 -->
    </div>
    <input type="hidden" id="m_title" value="${title}">
    <input type="hidden" id="m_runtime" value="${runtime}">
    <input type="hidden" id="m_poster" value="${poster}">
    <input type="hidden" id="u_id" value="${LOGIN_USER.id}">
    <input type="hidden" id="u_name" value="${LOGIN_USER.name}">
    
    
    <button onclick="openPopup()">팝업창띄우기</button>
</div>
    

<%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
<%@include file="../common/errorModal.jsp"%>
   
</body>
<script>
	var popup;
	var initialColor = 'rgb(169, 169, 169)';
	
	function selectRegion(e){
        var region = ["지역을 선택해주세요"];
		var region_seoul = ["영화관 선택","강남","강남대로(씨티)","강동"];
		var region_gyeonggi = ["영화관 선택","고양스타필드","광명AK플라자","김포한강신도시"];
		var region_incheon = ["영화관 선택","검단","송도","영종"];
		var region_chungcheong = ["영화관 선택","공주","논산","대전"];
		var region_gyeongsang = ["영화관 선택","경북도청","경산하양","구미강동"];
		var region_jeolla = ["영화관 선택","광주상무","광주하남","목포하당(포르모)"];
		var region_gangwon = ["영화관 선택","속초","원주"];
		let target = document.getElementById("detail-region");
		let d_region;
		
		if(e.value == "region") d_region = region;
		else if(e.value == "seoul") d_region = region_seoul;
		else if(e.value == "gyeonggi") d_region = region_gyeonggi;
		else if(e.value == "incheon") d_region = region_incheon;
		else if(e.value == "chungcheong") d_region = region_chungcheong;
		else if(e.value == "gyeongsang") d_region = region_gyeongsang;
		else if(e.value == "jeolla") d_region = region_jeolla;
		else if(e.value == "gangwon") d_region = region_gangwon;
		
		target.options.length = 0;
		
		for(x in d_region){
			var opt = document.createElement("option");
			opt.value = d_region[x];
			opt.innerHTML = d_region[x];
			target.appendChild(opt);
		}
	}
	
	
	/* 상영관 선택 */
    function selectScreen(x){
        var nonCinema = ["상영관 선택"];
        var defaultCinema = ["상영관 선택","1관","2관","3관"];
        var seoul_gangnam = ["상영관 선택", "1관","2관","3관", "4관", "5관"];
        var seoul_gangnam_city = ["상영관 선택", "1관","2관","3관", "4관"];
        var seoul_gangdong = ["상영관 선택", "1관","2관","3관", "4관", "MX 1관"];
        var gyeonggi_goyang_starfield = ["상영관 선택", "1관","2관","3관"];
        var gyeonggi_gwangmyeong_akplaza = ["상영관 선택", "1관","2관","3관", "4관", "5관"];
        var incheon_songdo = ["상영관 선택", "1관","2관","3관", "4관", "Dolby Cinema 1관", "MX 1관"];
        let target = document.getElementById("select-theater");
        let screen;

        if (x.value == "영화관 선택") screen = nonCinema;
        else if (x.value == "강남") screen = seoul_gangnam;
        else if (x.value == "강남대로(씨티)") screen = seoul_gangnam_city;
        else if (x.value == "강동") screen = seoul_gangdong;
        else if (x.value == "고양스타필드") screen = gyeonggi_goyang_starfield;
        else if (x.value == "광명AK플라자") screen = gyeonggi_gwangmyeong_akplaza;
        else if (x.value == "송도") screen = incheon_songdo;
        else screen = defaultCinema;

        target.options.length = 0;

        for (x in screen) {
            var screenOption = document.createElement("option");
            screenOption.value = screen[x];
            screenOption.innerHTML = screen[x];
            target.appendChild(screenOption);
        }
    }
	let seatCount = 0;      // 실질적인 좌석 선택, 예매단계까지 활용되는 count
	let lockCount = 0;      // HTML 화면에 띄워주기만 하는 count
	let selected = [];      // 선택된 좌석 배열
	// 좌석선택 function
	function seatClicked(seatID) {
		let $targetDiv = $(seatID);
		let id = $targetDiv.attr("id");
		if($targetDiv.hasClass("select-seat-row")){
			seatCount++;
			if(seatCount > lockCount){
				seatCount--;
				alert("인원수에 맞게 선택하십시오.");
				return;
			}
			$targetDiv.removeClass("select-seat-row");
		    $targetDiv.addClass("select-seat-row-selected");
			selected.push(id);
		    console.log("lockcount : " + lockCount);
			console.log("seatcount : " + seatCount);

		}else{
			$targetDiv.removeClass("select-seat-row-selected");
		    $targetDiv.addClass("select-seat-row");	
			seatCount--;
			const index = selected.indexOf(id);
            if (index !== -1) {
                selected.splice(index, 1);
            }
			console.log("lockcount : " + lockCount);
			console.log("seatCOunt : " + seatCount);
		}
		console.log("선택된 좌석 : " + selected);
	}
	
	// m_movietotal 테이블에서
	// 영화관 지점명(ex.고양스타필드),
	// 상영관 번호(ex.1관,2관..),
	// 상영 날짜(ex.2023-10-10),
	// 상영 시간(ex.13:00)
	// 영화 제목이 겹치는 데이터는 이미 예매가 완료된 좌석이므로 해당 좌석은 'booked'라는 클래스를 추가해주고
	// booked 클래스는 css에서 일반 좌석과 다른 효과를 넣을 예정임.
	function showCantBookSeat(){
		var detailRegion = "솔시네마 " + $("#detail-region").val();//영화관 지점명
		var theater_num = $("#select-theater").val();// 상영관 번호
		var reservDate = $("#reserv-date").val();// 상영 날짜
		var reservTime = $("#reserv-time").val();// 상영 시간
		var str_hour = reservTime/100;
		var m_title = $("#m_title").val();	// 영화 제목
		
		console.log("detailregion : " + detailRegion);
		console.log("theaeter_num : " + theater_num);
		console.log("reservDate : " + reservDate);
		console.log("reservTime : " + reservTime);
		console.log("m_title : " + m_title);
		$.ajax({
			url: "/solcinema/ticketing/getBookedSeat",
			type: "POST",
			dataType: "json",
			data: JSON.stringify({
				theater_num: theater_num,
				region_detail: detailRegion,
				reserv_date: reservDate,
				str_hour: str_hour,
				m_title: m_title
			}),
			contentType: "application/json",
			success: function(seatNumbers){
				for(let i = 0; i < seatNumbers.length; i++){
					var seatNumber = seatNumbers[i];
					var $targetDiv = $("#" + seatNumber);
					console.log($targetDiv);
					if ($targetDiv.length > 0){
						$targetDiv.addClass("booked");
						$targetDiv.text('X');
						$targetDiv.removeAttr("onclick");
					}
				}
			},
			error: function(xhr, status, error){
				console.error("Ajax요청 실패: " + error);
			}
		})
	}
	
	/* 인원 선택 */
    function plusCount() {
		lockCount++;
        lockCount = Math.max(0, Math.min(8, lockCount));
        document.getElementById('temp-02').innerText = lockCount;
    }

    function minusCount() {
		lockCount--;
		if(selected != null && seatCount > lockCount){
			seatClicked("#"+selected.pop());
		}
        lockCount = Math.max(0, Math.min(8, lockCount));
		seatCount = Math.max(0, Math.min(8, seatCount));
        document.getElementById('temp-02').innerText = lockCount;
    }
	
	// 좌석확인 버튼
	function createSeat() {
		lockCount = 0;
		seatCount = 0;
		// 좌석 뿌려주기
	    let $div = $(".select-seat-box");
	    $div.empty();
		let countScreen = "";
        countScreen += "<div id='seat-count-box' style='order: 1;'>"
        countScreen += "    <div id='seat-count'>"
        countScreen += "        <span id='temp-02'>0</span>"
        countScreen += "        <span>명</span>"
        countScreen += "    </div>"
        countScreen += "    <button onclick='plusCount()' id='seatCount'>+</button>"
        countScreen += "    <button onclick='minusCount()' id='seatCount'>-</button>"
        countScreen += "    <button onclick='sell()' id='temp-03'>결제하기</button>"
        countScreen += "    <span id='temp-01'>일반석 : 54/54석</span>"
        countScreen += "    <p class='select-reserv-max'>※ 최대 8명 선택 가능</p>"
        countScreen += "</div>"
        countScreen += "<div id='screen-box'>SCREEN</div>"
			
	    // 알파벳 A부터 F까지 반복
	    for (let row = 'A'.charCodeAt(0); row <= 'F'.charCodeAt(0); row++) {
	        let columnHTML = "<div class='select-seat-column'>";
	        // 숫자 1부터 8까지 반복
	        for (let seatNum = 1; seatNum <= 8; seatNum++) {
	            let seatID = String.fromCharCode(row) + seatNum;
	            columnHTML += "<div id='"+seatID+"' onclick='seatClicked("+seatID+")' value='"+seatID+"' class='select-seat-row'>"+seatID+"</div>";
	        }
	        columnHTML += "</div>";
	        $div.append(columnHTML);
	    }
	    // 스크린 추가
	    $div.prepend(countScreen);
		// 이미 예약된 좌석은 클릭 못하도록 해야함.	    
	    showCantBookSeat();
	}
	
	
	// 결재하기 버튼임
	// 팝업 띄우면서 입력한 데이터 DB에 넣어야함
	function sell() {
		if(seatCount != lockCount){
			alert("좌석 선택이 올바르지 않습니다.");
			return;
		}
		var u_id = $("#u_id").val();			// 유저 id
		var u_name = $("#u_name").val();		// 유저 이름
		var ticket_cnt = seatCount;// 티켓 수
		var cost = 14000 * ticket_cnt;			// 티켓 가격
		var m_title = $("#m_title").val();		// 영화 제목
		var m_poster = $("#m_poster").val();	// 포스터 url
		var m_runtime = $("#m_runtime").val();	// 영화 runtime
		var detail_region = "솔시네마 " + $("#detail-region").val();//영화관 지점명
		var theater_num = $("#select-theater").val();// 상영관 번호
		var reserv_date = $("#reserv-date").val();// 상영 날짜
		var reservTime = $("#reserv-time").val();// 상영 시간

		
		/*-------클릭된 좌석 번호 추출-------*/
		// 좌석번호 selected로 가져오기
		selected.sort();
		let seat_num = "";
		for(let i = 0; i < selected.length; i++){
			seat_num +=selected[i];
		}
		console.log(seat_num);
		/*-------클릭된 좌석 번호 추출 끝-------*/
		
		/*-------영화 시작시간, 종료시간-------*/
		// ex) 14:00로 선태갛면 reservTime 값이 1400으로 나옴 
		// 영화 종료 시간 = 시작시간 + runtime
		var str_hour = reservTime / 100; // 14
		var str_min = reservTime % 100;	// 00
		var end_hour = str_hour + Math.floor(m_runtime/60);
		var end_min = str_min + (m_runtime%60);
		// 영화종료 분이 60넘으면 hour 1증가
		if(end_min > 60){
			end_hour++;
		}
		// 영화종료 시각이 24넘으면 ex)25 이면 01로 변경
		if(end_hour > 24){
			end_hour %= 24;
		}
		/*-------영화 시작시간, 종료시간 끝-------*/
		
		/*-------팝업창 뿌려주기-------*/
		// 화면 중앙에 위치하도록 계산된 X, Y 좌표를 설정
	    var screenWidth = window.screen.width;
	    var screenHeight = window.screen.height;
	    var popupWidth = 400;
	    var popupHeight = 400;
	    var popupLeft = (screenWidth - popupWidth) / 2;
	    var popupTop = (screenHeight - popupHeight) / 2;
		
	    var popup = window.open(
	    	    'popup?' +
	    	    'user_id=' + encodeURIComponent(u_id) +
	    	    '&user_name=' + encodeURIComponent(u_name) + 
	    	    '&ticket_cnt=' + encodeURIComponent(ticket_cnt)+
	    	    '&cost=' + encodeURIComponent(cost) +
	    	    '&m_title=' + encodeURIComponent(m_title) +
	    	    '&m_poster=' + encodeURIComponent(m_poster) +
	    	    '&m_runtime=' + encodeURIComponent(m_runtime) +
	    	    '&region_detail=' + encodeURIComponent(detail_region) +
	    	    '&theater_num=' + encodeURIComponent(theater_num) +
	    	    '&seat_num=' + encodeURIComponent(seat_num) +
	    	    '&reserv_date=' + encodeURIComponent(reserv_date) +
	    	    '&str_hour=' + encodeURIComponent(str_hour) +
	    	    '&str_min=' + encodeURIComponent(str_min) +
	    	    '&end_hour=' + encodeURIComponent(end_hour) +
	    	    '&end_min=' + encodeURIComponent(end_min),
	    	    '팝업 창',
	    	    'width=400,height=400,left=' + popupLeft + ',top=' + popupTop
	    	);
	    
	    // 2초 후에 팝업 창을 닫기 위한 타이머 시작
	    setTimeout(function () {
	        if (popup && !popup.closed) {
	            popup.close();
	            //window.location.href = "check?m_title="+m_title;
	        }
	    }, 2000);
    }	
</script>
</html>