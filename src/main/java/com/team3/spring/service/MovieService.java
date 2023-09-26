package com.team3.spring.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team3.spring.vo.Item;
import com.team3.spring.vo.MovieActorCast;
import com.team3.spring.vo.MovieBookDetailVO;
import com.team3.spring.vo.MovieDetailVO;

public interface MovieService {
	// 상위 4개의 영화 가져오기
	List<Item> getTop4Movies();
	// 특정 영화 상세정보
	MovieDetailVO getMovieDetail(int id);
	// 특정 영화의 연기자
	ArrayList<MovieActorCast> getMovieActor(int id);
	// 특정 영화의 트레일러 url
	String getMovieTrailer(int id);
	// 특정 영화의 쿠키 가져오기
	MovieBookDetailVO getCookie(HttpServletRequest req);
	// 등록되어 있는 쿠키(영화정보) 삭제
	void deleteCookie(HttpServletResponse res);
}
