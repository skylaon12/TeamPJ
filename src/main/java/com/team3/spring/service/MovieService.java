package com.team3.spring.service;

import java.util.ArrayList;
import java.util.List;

import com.team3.spring.vo.Item;
import com.team3.spring.vo.MovieActorCast;
import com.team3.spring.vo.MovieDetailVO;

public interface MovieService {
	List<Item> getTop4Movies();
	MovieDetailVO getMovieDetail(int id);
	ArrayList<MovieActorCast> getMovieActor(int id);
	String getMovieTrailer(int id);
}
