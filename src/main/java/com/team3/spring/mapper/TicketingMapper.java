package com.team3.spring.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.MovieDetailRegionVO;
import com.team3.spring.vo.MovieRegionVO;
import com.team3.spring.vo.MovieTheaterVO;
import com.team3.spring.vo.TicketingVO;

public interface TicketingMapper {

	public void bookTicket(TicketingVO vo);
	public ArrayList<String> getBookedSeat(TicketingVO vo);
	public TicketingVO getTicket(@Param("u_account")String u_account);
	public TicketingVO getTicket2(@Param("t_id")int t_id);
	public void cancelProc(@Param("t_id")int id);
	public void userInfoModify(@Param("u_name")String u_name, @Param("u_account")String u_account);
//	public void userDelete(@Param("user_id")int user_id);
	public ArrayList<TicketingVO> getTicketHistroy(@Param("u_account")String u_account);
	public ArrayList<MovieRegionVO> getRegion();
	public ArrayList<MovieDetailRegionVO> getDetailRegion(@Param("id")int id);
	public ArrayList<MovieTheaterVO> getTheater(@Param("id")int id);
}
