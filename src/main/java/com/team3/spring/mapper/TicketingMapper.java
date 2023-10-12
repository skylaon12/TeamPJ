package com.team3.spring.mapper;

import java.util.ArrayList;

import com.team3.spring.vo.TicketingVO;

public interface TicketingMapper {

	public void bookTicket(TicketingVO vo);
	public ArrayList<String> getBookedSeat(TicketingVO vo);
}
