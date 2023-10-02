package com.team3.spring.mapper;

import java.util.ArrayList;

import com.team3.spring.vo.MovieCommentVO;

public interface MovieMapper {

	public ArrayList<MovieCommentVO> list(int m_id);
	
}
