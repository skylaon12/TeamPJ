package com.team3.spring.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.MovieCommentVO;

public interface MovieMapper {

	public ArrayList<MovieCommentVO> list(int m_id);
	public void userInfoModify(@Param("u_name")String u_name, @Param("u_id")int u_id);
	public void setComment(MovieCommentVO vo);
	public void userDelete(@Param("u_id")int u_id);
}
