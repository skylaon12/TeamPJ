package com.team3.spring.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.team3.spring.vo.Item;
import com.team3.spring.vo.MovieActorCast;
import com.team3.spring.vo.MovieActorVO;
import com.team3.spring.vo.MovieBookDetailVO;
import com.team3.spring.vo.MovieDetailVO;
import com.team3.spring.vo.MovieVO;
import com.team3.spring.vo.MovieYoutubeVO;

@Service
public class MovieServiceImpl implements MovieService {

	private String API_KEY = "dfdad57da9c250e542f415cb5b4b16a1";
	private String API_URL = "https://api.themoviedb.org/3/movie/";

	// Top4 영화 서비스
	@Override
	public List<Item> getTop4Movies() {
		String movieListUrl = API_URL + "popular?language=ko-KR&api_key=" + API_KEY;
		URI uri = null;
		RestTemplate restTemplate = new RestTemplate();
		try {
			uri = new URI(movieListUrl);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		MovieVO mvo = restTemplate.getForObject(uri, MovieVO.class);
		System.out.println("id : " + mvo.results.get(0).title);

		List<Item> movie = new ArrayList<Item>();
		// 상위 4개만 가져오기
		for (int i = 0; i < 4; i++) {
			movie.add(mvo.results.get(i));
		}
		// 비즈니스 로직 구현
		return movie;
	}

	// 영화 상세정보 서비스
	@Override
	public MovieDetailVO getMovieDetail(int id) {
		String movieDetailUrl = API_URL + id + "?language=ko-KR&region=KR&api_key=" + API_KEY;
		URI detailUri = null;

		RestTemplate resTemplate = new RestTemplate();

		try {
			detailUri = new URI(movieDetailUrl);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		MovieDetailVO dmvo = resTemplate.getForObject(detailUri, MovieDetailVO.class);

		return dmvo;
	}

	// 영화 배우명 서비스
	@Override
	public ArrayList<MovieActorCast> getMovieActor(int id) {
		String movieActorUrl = API_URL + id + "/credits?api_key=" + API_KEY;
		String imageUrl = "https://image.tmdb.org/t/p/w500/";
		URI actorUri = null;
		RestTemplate resTemplate = new RestTemplate();

		try {
			actorUri = new URI(movieActorUrl);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		MovieActorVO amvo = resTemplate.getForObject(actorUri, MovieActorVO.class);
		ArrayList<MovieActorCast> actors = new ArrayList<MovieActorCast>();

		for (int i = 0; i < 5; i++) {
			amvo.cast.get(i).setProfile_path(imageUrl + amvo.cast.get(i).getProfile_path());
			actors.add(amvo.cast.get(i));
		}

		return actors;
	}

	// 유튜브 영상 서비스
	@Override
	public String getMovieTrailer(int id) {
		String videoUrl = API_URL + id + "/videos?api_key=" + API_KEY;

		URI videoUri = null;

		RestTemplate resTemplate = new RestTemplate();

		try {
			videoUri = new URI(videoUrl);
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		MovieYoutubeVO ymvo = resTemplate.getForObject(videoUri, MovieYoutubeVO.class);

		return ymvo.results.get(0).key;
	}

	// 쿠키에 저장되어 있는 영화데이터를 가져옴
	@Override
	public MovieBookDetailVO getCookie(HttpServletRequest req) {
		String movieInfoJSON = null;
		Cookie[] cookies = req.getCookies();
		MovieBookDetailVO vo = null;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("movieInfo".equals(cookie.getName())) {
					System.out.println("쿠키 같은거 찾음");
					movieInfoJSON = cookie.getValue();
					try {
						movieInfoJSON = java.net.URLDecoder.decode(movieInfoJSON, "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					break;
				}
			}
		}
		if (movieInfoJSON != null) {
			// ObjectMapper를 이용하여 JSON문자열을 JAVA객체로 변환
			ObjectMapper objectmapper = new ObjectMapper();
			try {
				vo = objectmapper.readValue(movieInfoJSON, MovieBookDetailVO.class);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return vo;
	}

	@Override
	public void deleteCookie(HttpServletResponse res) {
		Cookie cookie = new Cookie("movieInfo","");
		cookie.setMaxAge(0);
		res.addCookie(cookie);
	}

}
