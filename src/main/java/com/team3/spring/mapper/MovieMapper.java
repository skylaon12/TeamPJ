package com.team3.spring.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.MovieCommentVO;

public interface MovieMapper {

	public ArrayList<MovieCommentVO> list(int m_id);
	public void userInfoModify(@Param("u_name")String u_name, @Param("u_account")String u_account);
	public void setComment(MovieCommentVO vo);
}
