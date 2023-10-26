<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  	<meta charset="utf-8">
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  	<link rel="stylesheet" href="../resources/css/movieDetail.css" />
  	<link rel="stylesheet" href="../resources/css/movieList.css" />
  	<link rel="stylesheet" href="../resources/css/navbar.css" />
  	<link rel="stylesheet" href="../resources/css/common.css" />
	<link rel="icon" href="../resources/images/logo/logo-s.png" type="image/x-icon">
<title>SOL CINEMA</title>
</head>
<body>
<%@include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="mt-5">
			<h1>전체 영화</h1>
		</div>
		<nav>
			<div class="nav nav-tabs nav-justified mt-5" id="nav-tab" role="tablist">
				<button class="nav-link active" id="nav-boxoffice-tab" data-bs-toggle="tab" data-bs-target="#nav-boxoffice" type="button"
					role="tab" aria-controls="nav-boxoffice" aria-selected="true">박스오피스</button>
				<button class="nav-link" id="nav-upcoming-tab" data-bs-toggle="tab" data-bs-target="#nav-upcoming" type="button" role="tab"
					aria-controls="nav-upcoming" aria-selected="false">상영예정작</button>
				<button class="nav-link" id="nav-trending-tab" data-bs-toggle="tab" data-bs-target="#nav-trending" type="button" role="tab"
					aria-controls="nav-trending" aria-selected="false">인기 영화</button>
			</div>
		</nav>
		<form class="row ms-3 mt-3 g-3 d-flex justify-content-between">
			<div class="col mt-3">
				<span id="search-txt"><strong id="count"></strong> 개의 영화가 검색되었습니다.</span>
			</div>
			<div class="col-auto">
				<input id="search-input" type="text" class="form-control" placeholder="영화명 검색">
			</div>
			<div class="col-auto">
				<button type="button" class="btn btn-sm mb-3 search-btn">
					<img src="../resources/images/nav/ico-search.png">
				</button>
			</div>
		</form>
		<div id="movie-lists" class="tab-content" id="nav-tabContent">
			<div class="ms-4 tab-pane fade show active" id="nav-boxoffice" role="tabpanel" aria-labelledby="nav-boxoffice-tab">
				<div class="row mt-3 poster">
				</div>
			</div>
			<div class="ms-4 tab-pane fade" id="nav-upcoming" role="tabpanel" aria-labelledby="nav-upcoming-tab">
				<div class="row mt-3 poster">
				</div>
			</div>
			<div class="ms-4 tab-pane fade" id="nav-trending" role="tabpanel" aria-labelledby="nav-trending-tab">
				<div class="row mt-3 poster">
				</div>
			</div>
		</div>
		<div class="mt-1 mb-3">
		<div class="container">
			<button id="searchMore" class="btn btn-light col-sm-12">더보기
				<img alt="" src="/resources/images/movie/ico-btn-more-arr.png">
			</button>
		</div>
	</div>
</div>
<%@include file="../common/footer.jsp"%>
	<%@include file="../common/alertModal.jsp" %>
</body>
<script src="../resources/js/alertModal.js"></script>
<script type="text/javascript">
	$(function () {
		
		let $div = $("#movie-lists .poster");// 영화 리스트들을 담을 div 변수 선언
		let currentPage = 1;
		let currentMovieUrl = "https://api.themoviedb.org/3/movie/now_playing";	// 박스오피스 url
		let imageUrl = "https://image.tmdb.org/t/p/w500/";						// 포스터 이미지 url
		let searchUrl = "https://api.themoviedb.org/3/search/movie";			// 검색 url
		let apiKey = "dfdad57da9c250e542f415cb5b4b16a1";
		let totalPage = 0;
		
		getMovieList();
		
		function getMovieList() {
			$.ajax({					
				type: 'get',			// get 방식으로
				url: currentMovieUrl,	// https://api.themoviedb.org/3/movie/now_playing에다가
				data: {					// api키, 한국어, page를 파라미터로 넣어서
					"api_key": apiKey,
					language: "ko-KR",
					region: "KR",
					page: currentPage,
				},
				dataType: 'json',		// json 형식으로 받아옴
				success: function(response) {// 성공적으로 받아오면
					// 영화 수(결과값) 
					let resultCount = response.total_results;
					// 100건이 넘어가면 100개만
					if (resultCount > 100) {
						resultCount = 100;
						totalPage = Math.ceil(resultCount/20);	// 100개니까 전체 페이지는 5페이지가 된다.
						$("#count").text(100);					// count 개의 영화가 검색되었습니다.
						
					} else {
						totalPage = Math.ceil(resultCount/20);
						$("#count").text(resultCount);
					}
					
					showLists(response);
				}
			});	
		}
		// 실제 영화 데이터를 보여주는 함수
		function showLists(response) {
			let movieList = response.results;
			
			$.each(movieList, function(index, movie) {
				
				let poster = imageUrl+movie.poster_path; 						
				let output = "";
				
				output += "<div class='col-3 mb-5' style='padding-left: 0px;'>";
				output += "<a href='${cp}/movie/detail?no="+movie.id+"'>";
				if (movie.poster_path) {
					output += "<img src = '" +poster+ "'class='rounded card-img-top' style='width: 17rem; height:440px;'/>";
				} else {
					output += "<img src ='/resources/images/movie/none.jpg' class='rounded card-img-top' style='width: 17rem; height:440px;'/>";
				}
				output += "</a>";
				if (movie.title) {
					output += "<p class='mt-2 title-txt'>" + movie.title + "</p>";
				} else {
					output += "<p class='mt-2 title-txt'>"+ movie.name +"</p>";
				}
				if (movie.release_date) {
					output += "<span class='openDt-txt'> 개봉일 | "+ movie.release_date +"</span>";
				} else {
					output += "<span class='openDt-txt'> 개봉일 |  미정</span>";
				}
				output += "<div class='d-flex'>";
				output += "<a href='${cp}/ticketing/screenList?no="+movie.id+"'><button type='button' class='btn btn-primary ticket col-5 mt-1 float-end'>예매</button></a>";
				output += "</div>";
				output += "</div>";
				
				$div.append(output);
			});
		}
		// 각 탭(박스오피스, 상영예정작, 인기영화)을 누르면 검색명, 페이지 초기화
		function refreshMovie() {
			$("#searchMore").removeAttr("disabled");
			$("#search-input").val('');
			currentPage = 1;
			$div.empty();
			
			getMovieList();
		}
		// 각 탭을 누를때마다 api url주소를 다르게 넣어줌으로써 다른 데이터들이 나오도록 한다.
		// 박스오피스 탭
		$('#nav-boxoffice-tab').click(function() {
			currentMovieUrl = "https://api.themoviedb.org/3/movie/now_playing";
			refreshMovie();
		});
		// 상영예정작 탭
		$('#nav-upcoming-tab').click(function() {
			currentMovieUrl = "https://api.themoviedb.org/3/movie/upcoming";
			refreshMovie();
		});
		// 인기영화 탭
		$('#nav-trending-tab').click(function() {
			currentMovieUrl = "https://api.themoviedb.org/3/trending/all/day";
			refreshMovie();
		});
		
		// 더보기 버튼 클릭 시
		// 페이지 번호를 하나씩 추가해줌
		$("#searchMore").click(function() {
			if (currentPage < totalPage) {
				currentPage++;
				getMovieList();
			} else {
				this.disabled = true;
			}
		})
		
		// 영화 검색 기능
		$(".search-btn").click(function() {
			let keyword = $("#search-input").val();
			$.ajax({
				type: 'get',
				url: searchUrl,
				data: {
					"api_key": apiKey,
					language: "ko-KR",
					page: currentPage,
					query: keyword
				},
				success: function(response) {
					let resultCount = response.total_results;
					totalPage = Math.ceil(resultCount/20);
					$("#count").text(resultCount);
					
					$("#searchMore").removeAttr("disabled");
					$div.empty();
					showLists(response);
				}
			})
		});
	})
</script>
</html>