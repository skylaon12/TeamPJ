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
<link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon">
<title>SOL CINEMA</title>
</head>
<style>
  /* 선택되지 않은 경우 버튼의 투명도를 낮춥니다. */
  #cancel-button button[disabled] {
    opacity: 0.5; /* 투명도를 조절합니다. 0은 완전 투명, 1은 불투명 */
  }
</style>
<body>
<%@include file="/WEB-INF/views/common/navbar.jsp"%>
영화취소화면입니다<br>
현재 로그인되어있는 유저 이름 : ${LOGIN_USER.name}<br>
티켓 일련번호 : ${ticket.id}<br>
티켓 예매한 유저 id : ${ticket.user_id}<br>
티켓 예매한 유저 이름 : ${ticket.user_name}<br>
결제한 티켓 수 : ${ticket.ticket_cnt}<br>
결제 금액 : ${ticket.cost}<br>
영화 제목 : ${ticket.m_title}<br>
영화 포스터 url : ${ticket.m_poster }<br>
영화 런타임 : ${ticket.m_runtime}<br>
영화관 상세지역 : ${ticket.region_detail}<br>
상영관 번호 : ${ticket.seat_num }<br>
영화 상영 날짜 : ${ticket.reserv_date}<br>
영화 시작 시간 : ${ticket.str_hour}:${ticket.str_min}<br>
영화 종료 시간 : ${ticket.end_hour}:${ticket.end_min}<br>
<br>
여기에 유의사항에 대한 체크박스 만들어서<br>
ex)예매 취소 후에는 다시 예매합니다.<br>
환불은 취소 후 카드사 영업일 기준 3~5일 소요 될 수 있습니다 <br>
이런 내용 넣고 체크가 되면 비활성화 되어있는 취소하기 버튼을 활성화<br>
<fieldset>
  <legend>유의사항</legend>
  - 예매 취소 후에는 다시 예매합니다.<br>
  - 환불은 취소 후 카드사 영업일 기준 3~5일 소요 될 수 있습니다 <br>
  - 이런 내용 넣고 체크가 되면 비활성화 되어있는 취소하기 버튼을 활성화<br>	
  <div>
    <input type="checkbox" id="scales" name="scales" />
    <label for="scales" id="scales-label">상기 내용을 확인하였습니다.</label>
  </div>
</fieldset>
<a href="cancelProc?id=${ticket.id}" id="cancel-button"><button disabled>취소하기</button></a>

<%@include file="../common/footer.jsp"%>
<!-- 오류 모달 -->
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script>
	const scalesCheckbox = document.getElementById('scales');
	const cancelButton = document.getElementById('cancel-button');
	const scalesLabel = document.getElementById('scales-label');
	
	scalesCheckbox.addEventListener('change', function() {
	  if (scalesCheckbox.checked) {
	    // 체크박스가 선택되었을 때 버튼을 활성화
	    cancelButton.querySelector('button').removeAttribute('disabled');
	  } else {
	    // 체크박스가 선택되지 않았을 때 버튼을 비활성화
	    cancelButton.querySelector('button').setAttribute('disabled', 'disabled');
	  }
	});
	
	// 사용자가 레이블을 클릭해도 체크박스 상태를 변경할 수 있도록 설정
	scalesLabel.addEventListener('click', function() {
	  scalesCheckbox.checked = !scalesCheckbox.checked;
	  // 체크박스 상태 변경 후 버튼 상태 업데이트
	  if (scalesCheckbox.checked) {
	    cancelButton.querySelector('button').removeAttribute('disabled');
	  } else {
	    cancelButton.querySelector('button').setAttribute('disabled', 'disabled');
	  }
	});
</script>
</html>
