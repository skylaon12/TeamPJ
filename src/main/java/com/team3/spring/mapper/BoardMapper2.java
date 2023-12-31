package com.team3.spring.mapper;


import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;

public interface BoardMapper2 {
	// 게시글 작성자 아이디 가져오기
	public String getWriter(@Param("p_id")Long p_id);
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
	public BoardVO2 read(@Param("p_id")long p_id, @Param("p_writer")String account);
	
	// 수정
	public int modify(BoardVO2 gvo);
	
	// 전체 글 수
	public int getTotalCount(@Param("p_writer")String p_writer);
	
	public int getTotalCountByCategory(@Param("p_category") String p_category, @Param("p_writer")String p_writer);
	
	public int getSearchTotalCount(@Param("searchKey") String searchKey, 
			@Param("word") String word, @Param("p_writer")String p_writer);
	
	public int getSearchTotalCountByCategory(@Param("p_category") String p_category, 
			@Param("searchKey") String searchKey, 
			@Param("word") String word,
			@Param("p_writer")String p_writer);
	
	// 조회수
	public void updateHitCount(long p_id);
	
	// 이전글 다음글
	public Long getNextArticleId(@Param("currentArticleId")long currentArticleId, @Param("p_writer")String account);
	
	public Long getPreviousArticleId(@Param("currentArticleId")long currentArticleId, @Param("p_writer")String account);
	
	// 댓글 관련
	public int writeComment(CommentVO gvo);
	
	public ArrayList<CommentVO> getCommentData(@Param("p_ori_id") long p_ori_id, @Param("page") int page);
	
	public int getCommentTotalCount(long p_ori_id);
	
	public void endAnswer(long p_id);
	
	public Timestamp getCommentCreatedTime(long p_ori_id);
}
