<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html oncontextmenu="return false">
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="../resources/css/navbar.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="../resources/css/common.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet" href="../resources/css/seat.css?ver=<%=System.currentTimeMillis()%>" />
<link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon">
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
                	<c:forEach var="region" items="${regions}">
                		<option value="${region.id}" data-region="${region.region}">${region.region}</option>
                	</c:forEach>
                </select>

                <select onchange="selectScreen(this)" id="detail-region" name="reserv-location-2" id="reserv-location-2" class="select-reserv" style="margin: -5px 0px 10px 10px;">
                    <option>지역을 선택하세요</option>
                </select>
            </div>
    
            <!-- 관람일 선택 -->
            <div id="select-date" class="reserv-select-box">
                <input name="select-date" type="date" id="reserv-date" class="select-reserv" onkeydown="return false">

                <script>
				    const today = new Date();
				
				    const datePicker = document.getElementById("reserv-date");
				
				    const minDate = today.toISOString().split("T")[0]; // 현재 날짜를 ISO 8601 형식(YYYY-MM-DD)으로 변환
				    datePicker.setAttribute("min", minDate);
				    datePicker.value = minDate;
				</script>
            </div>
    
            <!-- 관람시간 선택 -->
            <div id="select-time" class="reserv-select-box">
                <select name="reserv-time" id="reserv-time" class="select-reserv">
                	<option>시간 선택</option>
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
    <input type="hidden" id="u_account" value="${LOGIN_USER.account}">
    <input type="hidden" id="u_name" value="${LOGIN_USER.name}">
</div>
    
<%@include file="../common/footer.jsp"%>
<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
	
//글로벌 변수 설정
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	var popup;
	var initialColor = 'rgb(169, 169, 169)';
	
	function selectRegion(e){
		selected.length = 0;
		var regionID = $("#region").val();
		var regionName = $("#region option:selected").data("region");
		console.log("id : " + regionID);
		console.log("지역명 : " + regionName);
		$.ajax({
			type: "GET",
			url: "${cp}/ticketing/getDetailRegion",
			data: {region_id: regionID},
			success: function(data){
				let target = document.getElementById("detail-region");
				target.options.length = 0;
				data.forEach(function (detailRegion) {
		            var opt = document.createElement("option");
		            opt.value = detailRegion.id;
		            opt.innerHTML = detailRegion.detail_region;
		            opt.setAttribute("data-detail-region", detailRegion.detail_region);
		            target.appendChild(opt);
		        });
				
			}
		})
	}
	
	
	/* 상영관 선택 */
    function selectScreen(x){
    	selected.length = 0;
    	var detailRegionID = $("#detail-region").val();
		var detailRegionName = $("#detail-region option:selected").data("detail-region");
		console.log("선택된 상세지역 id : " + detailRegionID);
		console.log("선택된 상세지역명 : " + detailRegionName);
		
		$.ajax({
			type: "GET",
			url: "${cp}/ticketing/getTheater",
			data: {detail_region_id: detailRegionID},
			success: function(data){
				let target = document.getElementById("select-theater");
				target.options.length = 0;
				data.forEach(function (theater) {
		            var opt = document.createElement("option");
		            opt.value = theater.theater;
		            opt.innerHTML = theater.theater;
		            target.appendChild(opt);
		        });
				
			}
		})
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
			console.log(seatCount);
			if(seatCount > lockCount){
				console.log(seatCount);
				seatCount--;
				console.log("인원수에 맞게 선택");
				$("#checkMessage").html("인원수에 맞게 선택해주세요");
				$("#alertModal").modal("show");
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
		var detailRegion = "솔시네마 " + $("#detail-region option:selected").data("detail-region");//영화관 지점명
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
			beforeSend: function(xhr){// Spring security ajax 적용
				xhr.setRequestHeader("X-CSRF-TOKEN", csrfTokenValue)
         },
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
        countScreen += "    <span id='temp-01'>일반석 : 48/48석</span>"
        countScreen += "    <p class='select-reserv-max'>※ 최대 8명 선택 가능</p>"
        countScreen += "</div>"
        countScreen += "<div id='screen-box'>SCREEN</div>"
        	// 스크린 추가
    	$div.prepend(countScreen);
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
		// 이미 예약된 좌석은 클릭 못하도록 해야함.	    
	   	showCantBookSeat();
	}
	
	
	// 결재하기 버튼임
	// 팝업 띄우면서 입력한 데이터 DB에 넣어야함
	function sell() {
		if(seatCount != lockCount){
			pushModal("좌석 선택이 올바르지 않습니다.");
			return;
		}else if(seatCount == 0){
			pushModal("최소한 한 명 이상은 선택해야 합니다.")
			return;
		}
		var u_account = $("#u_account").val();	// 유저 id
		var u_name = $("#u_name").val();		// 유저 이름
		var ticket_cnt = seatCount;// 티켓 수
		var cost = 14000 * ticket_cnt;			// 티켓 가격
		var m_title = $("#m_title").val();		// 영화 제목
		var m_poster = $("#m_poster").val();	// 포스터 url
		var m_runtime = $("#m_runtime").val();	// 영화 runtime
		var detail_region = "솔시네마 " + $("#detail-region option:selected").data("detail-region");//영화관 지점명
		var theater_num = $("#select-theater").val();// 상영관 번호
		var reserv_date = $("#reserv-date").val();// 상영 날짜
		var reservTime = $("#reserv-time").val();// 상영 시간
		if(reservTime === '시간 선택'){
			pushModal("시간을 선택해주세요");
			return;
		}
		
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
		if(str_hour/10 == 0){
			str_hour = "0"+str_hour;
		}
		if(str_min/10 == 0){
			str_min = "0"+str_min;
		}
		if(end_hour/10 == 0){
			end_hour = "0"+end_hour;
		}
		if(end_min/10 == 0){
			end_min = "0" + end_min;
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
	    	    'u_account=' + encodeURIComponent(u_account) +
	    	    '&u_name=' + encodeURIComponent(u_name) + 
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
	    
// 	    2초 후에 팝업 창을 닫기 위한 타이머 시작
	    setTimeout(function () {
	        if (popup && !popup.closed) {
	            popup.close();
	            window.location.href = "check";
	        }
	    }, 2000);
    }	
</script>
</html>