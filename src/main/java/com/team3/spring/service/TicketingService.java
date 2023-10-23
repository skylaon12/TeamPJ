package com.team3.spring.service;

import java.util.ArrayList;
import java.util.List;

import com.team3.spring.vo.MovieDetailRegionVO;
import com.team3.spring.vo.MovieRegionVO;
import com.team3.spring.vo.MovieTheaterVO;
import com.team3.spring.vo.TicketingVO;

public interface TicketingService {
	
	public void bookTicket(TicketingVO vo);
	public ArrayList<String> getBookedSeat(TicketingVO vo);
	public TicketingVO getTicket(String u_account);
	public TicketingVO getTicket2(int t_id);
	public void cancelProc(int t_id);
	public ArrayList<TicketingVO> getTicketHistory(String u_account);
	// 영화 지역정보 가져오기
	public List<MovieRegionVO> getRegion();
	// 영화 상세지역정보 가져오기
	public List<MovieDetailRegionVO> getDetailRegion(int id);
	// 영화 상영관정보 가져오기
	public List<MovieTheaterVO> getTheater(int id);
}
