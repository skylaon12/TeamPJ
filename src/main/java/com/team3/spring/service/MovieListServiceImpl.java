package com.team3.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.mapper.MovieMapper;
import com.team3.spring.vo.MovieVO;

import lombok.Setter;

@Service
public class MovieListServiceImpl implements MovieListService{

	@Setter(onMethod_ = @Autowired)
	private MovieMapper mapper;

	@Override
	public List<MovieVO> getMovieList() {
		
		return mapper.getList();
	}
	
}
