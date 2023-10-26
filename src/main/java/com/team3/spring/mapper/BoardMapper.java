package com.team3.spring.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.BoardVO;
import com.team3.spring.vo.MemberVO;

public interface BoardMapper {
	//  리스트
	public ArrayList<BoardVO> list(int page);
	
	public ArrayList<BoardVO> listSearch(@Param("searchKey") String searchKey, @Param("word") String word, @Param("page") int page);
	
	public int write(BoardVO gvo);
	
	public BoardVO read(long p_id);
	
	public int del(long p_id);
	
	public int modify(BoardVO gvo);
	
	public int getTotalCount();
	
	public int getSearchTotalCount(@Param("searchKey") String searchKey, @Param("word") String word);
	
	public void updateHitCount(long p_id);
	
	public Long getNextArticleId(Long currentArticleId);
	
	public Long getPreviousArticleId(Long currentArticleId);
	
	public MemberVO getMemberInfo(String account);
	public String getMemberAuth(String account);
}
