package com.team3.spring.service;

import java.util.List;

import com.team3.spring.vo.MovieVO;

public interface MovieListService {
	public List<MovieVO> getMovieList();
	
	public MovieVO getMovie(int id);
}
