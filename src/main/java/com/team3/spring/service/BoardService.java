package com.team3.spring.service;

import java.util.ArrayList;

import com.team3.spring.vo.BoardVO;



public interface BoardService {
	public ArrayList<BoardVO> list();
	
	public void write(BoardVO gvo);
	
	public BoardVO read(long p_id);
	
	public void del(long p_id);
	
	public void modify(BoardVO gvo);
	
	public int test();

	
}
