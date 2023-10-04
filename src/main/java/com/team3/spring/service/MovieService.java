package com.team3.spring.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.team3.spring.vo.Item;
import com.team3.spring.vo.MovieActorCast;
import com.team3.spring.vo.MovieBookDetailVO;
import com.team3.spring.vo.MovieCommentVO;
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
	// 특정 영화의 관람평 정보 가져오기
	ArrayList<MovieCommentVO> getMovieComment(int id);
	// 영화 검색
	List<Item> getSearchMovie(String word);
}
