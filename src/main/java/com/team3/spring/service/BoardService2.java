package com.team3.spring.service;

import java.sql.Timestamp;
import java.util.ArrayList;

import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;



public interface BoardService2 {
	// 리스트 ( 검색, 카테고리 )
	public ArrayList<BoardVO2> getLists(String p_category, String searchKey, String word, int page);
	
	// 쓰기
	public void write(BoardVO2 gvo);
	
	// 읽기
	public BoardVO2 read(long p_id);
	
	// 수정
	public void modify(BoardVO2 gvo);
	
	// 페이징 처리 관련
	public int getStartIndex(int page);
	
	public int getTotalCount();
	
	public int getTotalCountByCategory(String p_category);
	
	public int getSearchTotalCount(String searchKey, String word);
	
	public int getSearchTotalCountByCategory(String p_category, String searchKey, String word);
	
	public int getTotalPageCount(String p_category, String searchKey, String word);
	
	public int getTotalPage(int totalCount);
	
	public int getTotalBlock(int totalPage);
	
	// 조회수
	public void updateHitCount(long p_id);
	
	// 이전 글, 다음 글
	public Long getNextArticleId(Long currentArticleId);

	public Long getPreviousArticleId(Long currentArticleId);
	
	// 댓글 관련
	public void writeComment(CommentVO gvo);
	
	public ArrayList<CommentVO> getCommentData(long p_ori_id, int page);
	
	public int getCommentTotalCount(long p_ori_id);
	
	public int getTotalCommentPage(long p_ori_id);
	
	public int getTotalCommentBlock(int totalCommentPage);
	
	public void endAnswer(long p_id);
	
	public Timestamp getCommentCreatedTime(long p_ori_id);
}