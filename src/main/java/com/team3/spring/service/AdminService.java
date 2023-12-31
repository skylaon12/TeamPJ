package com.team3.spring.service;

import java.util.ArrayList;

import com.team3.spring.vo.AuthVO;
import com.team3.spring.vo.BoardVO;
import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.MemberVO;
import com.team3.spring.vo.TicketingVO;

public interface AdminService {
	public MemberVO loadInfo(String account);
	public int getMemberCnt();
	public int getReserveCnt();
	public int getUnAnsweredCnt();
	public String getMonthRevenue();
	
	// 회원 관련
	public ArrayList<MemberVO> getMemberList();
	public MemberVO getMember(int id);
	public String getAuth(String account);
	public void authDelete(String account);
	public int authInsert(AuthVO vo);
	public int deleteUser(String account);
	
	//공자시항 관련
	public ArrayList<BoardVO> getBoardList(int page);
	public int getTotalPage();
	public int getStartBoardIndex(int page);
	public BoardVO read(int p_id);
	public int write(BoardVO vo);
	public int boardDel(int p_id);
	public int boardModify(BoardVO vo);
	
	// QnA관련
	public ArrayList<BoardVO2> getLists(String p_category, String searchKey, String word, int page, String status);
//	public ArrayList<BoardVO2> list(int page);
//	public ArrayList<BoardVO2> listSearch(String searchKey, String word, int page);
	public int getStartIndex(int page);
	public int getTotalCount(String status);
	public int getTotalCountByCategory(String p_category, String status);
	public int getSearchTotalCountByCategory(String p_category, String searchKey, String word, String status);
	public int getTotalPageCount(String p_category, String searchKey, String word, String status);
	public int getSearchTotalCount(String searchKey, String word, String status);
	public int getTotalPage(int totalCount);
	public int getTotalBlock(int totalPage);
	
	public int completQna(int p_id);
	public int delQna(int p_id);
	// QnA관련 끝
	
	// 예매 관련
	public ArrayList<TicketingVO> getTicketList();
	public int delTicket(int id);
}
