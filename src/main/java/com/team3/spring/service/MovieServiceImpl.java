package com.team3.spring.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.team3.spring.mapper.MovieMapper;
import com.team3.spring.vo.Item;
import com.team3.spring.vo.MovieActorCast;
import com.team3.spring.vo.MovieActorVO;
import com.team3.spring.vo.MovieCommentVO;
import com.team3.spring.vo.MovieDetailVO;
import com.team3.spring.vo.MovieVO;
import com.team3.spring.vo.MovieYoutubeVO;

import lombok.Setter;

@Service
public class MovieServiceImpl implements MovieService {
	
	@Setter(onMethod_ = @Autowired)
	private MovieMapper mapper;
	
	// TMDB 개인 api 키
	private String API_KEY = "dfdad57da9c250e542f415cb5b4b16a1";
	// 기본 APIURL
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

		List<Item> movie = new ArrayList<Item>();
		// 상위 4개만 가져오기
		for (int i = 0; i < 4; i++) {
			movie.add(mvo.getResults().get(i));
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
	
	// 영화 평가 서비스
	@Override
	public ArrayList<MovieCommentVO> getMovieComment(int id) {
		return mapper.list(id);
	}

	// 영화 검색 서비스
	@Override
	public List<Item> getSearchMovie(String word) {
		String searchURL = "https://api.themoviedb.org/3/search/movie?api_key=" + API_KEY + "&language=ko-KR&query=" + word;
		String imageURL = "https://image.tmdb.org/t/p/w500";
		URI uri = null;
		RestTemplate resTemplate = new RestTemplate();
		
		try {
			uri = new URI(searchURL);
		}catch(URISyntaxException e) {
			e.printStackTrace();
		}
		
		MovieVO mvo = resTemplate.getForObject(uri, MovieVO.class);
		List<Item> movies = new ArrayList<Item>();
		
		
		for(int i = 0; i < mvo.getResults().size(); i++) {
			movies.add(mvo.getResults().get(i));
			movies.get(i).setPoster_path(imageURL + movies.get(i).getPoster_path());
		}
		
		return movies;
	}
	
	
}
