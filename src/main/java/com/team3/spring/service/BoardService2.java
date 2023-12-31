package com.team3.spring.service;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.springframework.ui.Model;

import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;
import com.team3.spring.vo.MemberVO;



public interface BoardService2 {
	// 회원정보 가져오기
	public MemberVO getUserInfo(String account);
	// 작성자 id 가져오기
	public String getWriter(Long p_id);
	// 리스트 ( 검색, 카테고리 )
	public ArrayList<BoardVO2> getLists(String p_category, String searchKey, String word, int page, String account);
	
	// 쓰기
	public int write(BoardVO2 gvo);
	
	// 읽기
	public BoardVO2 read(long p_id, String account);
	
	// 수정
	public int modify(BoardVO2 gvo);
	
	// 페이징 처리 관련
	public int getStartIndex(int page, boolean comment);
	
	public int getTotalCount(String p_writer);
	
	public int getTotalCountByCategory(String p_category, String p_writer);
	
	public int getSearchTotalCount(String searchKey, String word, String p_writer);
	
	public int getSearchTotalCountByCategory(String p_category, String searchKey, String word, String p_writer);
	
	public int getTotalPageCount(String p_category, String searchKey, String word, String p_writer);
	
	public int getTotalPage(int totalCount);
	
	public int getTotalBlock(int totalPage);
	
	public void updateModelWithPageInfo(Model model, int page, String p_category, String searchKey, String word, String p_writer);
	
	// 조회수
	public void updateHitCount(long p_id);
	
	// 이전 글, 다음 글
	public Long getNextArticleId(long currentArticleId, String account);

	public Long getPreviousArticleId(long currentArticleId, String account);
	
	// 댓글 관련
	public int writeComment(CommentVO gvo);
	
	public ArrayList<CommentVO> getCommentData(long p_ori_id, int page);
	
	public int getCommentTotalCount(long p_ori_id);
	
	public int getTotalCommentPage(long p_ori_id);
	
	public int getTotalCommentBlock(int totalCommentPage);
	
	public void calculateCommentPagingInfo(Model model, int coPage, long p_id);
	
	public void endAnswer(long p_id);
	
	public Timestamp getCommentCreatedTime(long p_ori_id);
	
	public void updateCommentInfo(ArrayList<BoardVO2> boards);
}
