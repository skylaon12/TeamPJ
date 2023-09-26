// sessionStorage에서 movieInfo를 읽어옴
var movieInfoString = sessionStorage.getItem("movieInfo");
var movieInfo;

if (movieInfoString) {
    // JSON 문자열을 객체로 변환
    movieInfo = JSON.parse(movieInfoString);
	var title = movieInfo.title;
	var poster = movieInfo.poster;
	var openDate = movieInfo.openDate;
	var runtime = movieInfo.runtime;
	console.log(title);
	console.log(poster);
	console.log(openDate);
	console.log(runtime);
    // movieInfo 객체를 사용하여 필요한 작업 수행
    // 다른 작업
} else {
    // movieInfo가 없는 경우 처리
    console.log("movieInfo가 sessionStorage에 없습니다.");
}