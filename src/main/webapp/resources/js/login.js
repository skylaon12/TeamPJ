
function checkLoginStatus(movieId){
	$.ajax({
        type: "GET",
        url: "/solcinema/member/checkLoginStatus", // 로그인 상태를 확인하는 서버 엔드포인트 URL
        success: function(response) {
            if (response.loggedIn) {
                // 로그인 상태인 경우 예매 페이지로 이동
                window.location.href = movieId;
            } else {
                // 로그인되지 않은 경우 로그인 화면으로 이동
                alert("로그인이 필요한 서비스입니다");
                window.location.href = "/solcinema/member/login"; // 로그인 화면 URL로 변경
            }
        }
    });
}