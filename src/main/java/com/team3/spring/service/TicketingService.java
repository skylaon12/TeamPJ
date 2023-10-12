package com.team3.spring.service;

import java.util.ArrayList;

import com.team3.spring.vo.TicketingVO;

public interface TicketingService {
	
	public void bookTicket(TicketingVO vo);
	public ArrayList<String> getBookedSeat(TicketingVO vo);
	public TicketingVO getTicket(int id);
	public TicketingVO getTicket2(int t_id);
	public void cancelProc(int t_id);
}
