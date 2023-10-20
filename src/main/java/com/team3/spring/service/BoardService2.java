package com.team3.spring.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;



public interface BoardService2 {
	public ArrayList<BoardVO2> list(int page);
	
	public ArrayList<BoardVO2> listSearch(String searchKey, String word, int page);
	
	public void write(BoardVO2 gvo);
	
	public BoardVO2 read(long p_id);
	
	public void modify(BoardVO2 gvo);
	
	public int getStartIndex(int page);
	
	public int getTotalCount();
	
	public int getSearchTotalCount(String searchKey, String word);
	
	public int getTotalPage(String searchKey, String word);
	
	public int getTotalBlock(int totalPage);
	
	public void updateHitCount(long p_id);
	
	public Long getNextArticleId(Long currentArticleId);

	public Long getPreviousArticleId(Long currentArticleId);
	
	public void writeComment(CommentVO gvo);
	
	public ArrayList<CommentVO> getCommentData(long p_ori_id, int page);
	
	public int getCommentTotalCount(long p_ori_id);
	
	public int getTotalCommentPage(long p_ori_id);
	
	public int getTotalCommentBlock(int totalCommentPage);
	
	public void endAnswer(long p_id);
}
