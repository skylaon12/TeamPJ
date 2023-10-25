package com.team3.spring.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.AuthVO;
import com.team3.spring.vo.BoardVO;
import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.MemberVO;
import com.team3.spring.vo.TicketingVO;

public interface AdminMapper {
	public MemberVO loadInfo(String account);
	public int getMemberCnt();	// 회원 수
	public int getReserveCnt();	// 현재 날짜 이후의 예매 횟수
	public int getUnAnsweredCnt();	// 완료되지 않은 QnA 수
	public int getMonthRevenue();// 매 달 1일부터 말일까지의 매출액
	
	// 회원 관련
	public ArrayList<MemberVO> getMemberList();
	public MemberVO getMember(int id);
	public String getAuth(String account);
	public void authDelete(String account);
	public int authInsert(AuthVO vo);
	public int deleteUser(String account);
	
	// 공지사항 관련
	public ArrayList<BoardVO> getBoardList(@Param("page")int page);
	public int getTotalBoardCount();
	public BoardVO read(int p_id);
	public int write(BoardVO vo);
	public int boardDel(int p_id);
	public int boardModify(BoardVO vo);
	// QnA 관리 관련
	public ArrayList<BoardVO2> list(@Param("page")int page, @Param("p_status")String status);
	public ArrayList<BoardVO2> listByCategory(@Param("p_category") String p_category, int page, @Param("p_status")String status);
	public ArrayList<BoardVO2> listSearch(@Param("searchKey") String searchKey, @Param("word") String word, @Param("page") int page, @Param("p_status")String status);
	public ArrayList<BoardVO2> listSearchByCategory(@Param("p_category") String p_category, 
			@Param("searchKey") String searchKey, 
			@Param("word") String word, 
			@Param("page") int page,
			@Param("p_status")String status);
	public int getTotalCount(@Param("p_status")String status);
	public int getTotalCountByCategory(@Param("p_category") String p_category, @Param("p_status")String status);
	
	public int getSearchTotalCount(@Param("searchKey") String searchKey, 
			@Param("word") String word, @Param("p_status")String status);
	
	public int getSearchTotalCountByCategory(@Param("p_category") String p_category, 
			@Param("searchKey") String searchKey, 
			@Param("word") String word,
			@Param("p_status")String status);
	public int completQna(int p_id);
	public int delQna(int p_id);
	public void deleteFQnA(String account);
	public void modifyTQnA(String account);
	
	// 예매 관련
	public ArrayList<TicketingVO> getTicketList();
	public int delTicket(int id);
	
}
