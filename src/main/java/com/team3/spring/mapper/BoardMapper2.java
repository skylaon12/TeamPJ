package com.team3.spring.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;

public interface BoardMapper2 {
	//  리스트
	public ArrayList<BoardVO2> list(int page);
	
	public ArrayList<BoardVO2> listSearch(@Param("searchKey") String searchKey, @Param("word") String word, @Param("page") int page);
	
	public void write(BoardVO2 gvo);
	
	public BoardVO2 read(long p_id);
	
	public void modify(BoardVO2 gvo);
	
	public int getTotalCount();
	
	public int getSearchTotalCount(@Param("searchKey") String searchKey, @Param("word") String word);
	
	public void updateHitCount(long p_id);
	
	public Long getNextArticleId(Long currentArticleId);
	
	public Long getPreviousArticleId(Long currentArticleId);
	
	public void writeComment(CommentVO gvo);
	
	public ArrayList<CommentVO> getCommentData(@Param("p_ori_id") long p_ori_id, @Param("page") int page);
	
	public int getCommentTotalCount(long p_ori_id);
}
