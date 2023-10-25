package com.team3.spring.mapper;


import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;

public interface BoardMapper2 {
	// 리스트 ( 검색, 카테고리 )
	public ArrayList<BoardVO2> list(int page, @Param("p_writer")String account);
	
	public ArrayList<BoardVO2> listByCategory(@Param("p_category") String p_category, int page, @Param("p_writer")String account);
	
	public ArrayList<BoardVO2> listSearch(@Param("searchKey") String searchKey, 
			@Param("word") String word, 
			@Param("page") int page,
			@Param("p_writer")String account);
	
	public ArrayList<BoardVO2> listSearchByCategory(@Param("p_category") String p_category, 
			@Param("searchKey") String searchKey, 
			@Param("word") String word, 
			@Param("page") int page,
			@Param("p_writer")String account);
	
	// 쓰기
	public int write(BoardVO2 gvo);
	
	// 읽기
	public BoardVO2 read(long p_id);
	
	// 수정
	public int modify(BoardVO2 gvo);
	
	// 전체 글 수
	public int getTotalCount();
	
	public int getTotalCountByCategory(@Param("p_category") String p_category);
	
	public int getSearchTotalCount(@Param("searchKey") String searchKey, 
			@Param("word") String word);
	
	public int getSearchTotalCountByCategory(@Param("p_category") String p_category, 
			@Param("searchKey") String searchKey, 
			@Param("word") String word);
	
	// 조회수
	public void updateHitCount(long p_id);
	
	// 이전글 다음글
	public Long getNextArticleId(Long currentArticleId);
	
	public Long getPreviousArticleId(Long currentArticleId);
	
	// 댓글 관련
	public void writeComment(CommentVO gvo);
	
	public ArrayList<CommentVO> getCommentData(@Param("p_ori_id") long p_ori_id, @Param("page") int page);
	
	public int getCommentTotalCount(long p_ori_id);
	
	public void endAnswer(long p_id);
	
	public Timestamp getCommentCreatedTime(long p_ori_id);
}
