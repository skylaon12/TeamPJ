package com.team3.spring.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.TicketingVO;

public interface TicketingMapper {

	public void bookTicket(TicketingVO vo);
	public ArrayList<String> getBookedSeat(TicketingVO vo);
	public TicketingVO getTicket(@Param("u_id")int u_id);
	public TicketingVO getTicket2(@Param("t_id")int t_id);
	public void cancelProc(@Param("t_id")int id);
}
