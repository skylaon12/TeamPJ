// 로그인한 사용자가 좋아요 한 영화 리스트
function showMyMovies() {
	$.ajax({
		type: "get",
		url: "/rest/myMovies",
		success: function(response) {
			if (response.status) {
				let movieNo = (response.items.map(item => item.movieNo));
				$.each(movieNo, function(index, movie) {
					$("#btn-"+movie).find('img').attr('src', "/resources/images/movie/like.png");
				})
			}
		}
	})
};