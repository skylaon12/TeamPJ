package com.team3.spring.service;

import java.util.ArrayList;

import com.team3.spring.vo.BoardVO;



public interface BoardService {
	public ArrayList<BoardVO> list(int page);
	
	public ArrayList<BoardVO> listSearch(String searchKey, String word, int page);
	
	public void write(BoardVO gvo);
	
	public BoardVO read(long p_id);
	
	public void del(long p_id);
	
	public void modify(BoardVO gvo);
	
	public int getStartIndex(int page);
	
	public int getTotalCount();
	
	public int getSearchTotalCount(String searchKey, String word);
	
	public int getTotalPage(String searchKey, String word);
	
	public int getTotalBlock(int totalPage);

	
}
