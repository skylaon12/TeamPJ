package com.team3.spring.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.mapper.TicketingMapper;
import com.team3.spring.vo.MovieDetailRegionVO;
import com.team3.spring.vo.MovieRegionVO;
import com.team3.spring.vo.MovieTheaterVO;
import com.team3.spring.vo.TicketingVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class TicketingServiceImpl implements TicketingService{
	
	@Setter(onMethod_ = @Autowired)
	private TicketingMapper mapper;
	
	@Override
	public void bookTicket(TicketingVO vo) {
		mapper.bookTicket(vo);
	}

	@Override
	public ArrayList<String> getBookedSeat(TicketingVO vo) {
		
		ArrayList<String> seats = mapper.getBookedSeat(vo);
		ArrayList<String> bookedSeats = new ArrayList<String>();
		System.out.println("배열 크기 : " + seats.size());
		if(seats != null) {
			for(int i = 0; i < seats.size(); i++) {
				for(int j = 0; j < seats.get(i).length(); j+=2) {
					bookedSeats.add(seats.get(i).substring(j,j+2)); 
				}
			}
		}
		if(bookedSeats != null) {
			for(int i = 0; i < bookedSeats.size(); i++) {
				log.info(bookedSeats.get(i));
			}
		}
		
		return bookedSeats;
	}

	@Override
	public TicketingVO getTicket(String u_account) {
		return mapper.getTicket(u_account);
	}

	@Override
	public TicketingVO getTicket2(int t_id) {
		return mapper.getTicket2(t_id);
	}

	@Override
	public void cancelProc(int t_id) {
		mapper.cancelProc(t_id);
	}

	@Override
	public ArrayList<TicketingVO> getTicketHistory(String u_account) {
		
		return mapper.getTicketHistroy(u_account);
	}
	
	@Override
	public List<MovieRegionVO> getRegion() {
		return mapper.getRegion();
	}

	@Override
	public List<MovieDetailRegionVO> getDetailRegion(int id) {
		return mapper.getDetailRegion(id);
	}

	@Override
	public List<MovieTheaterVO> getTheater(int id) {
		return mapper.getTheater(id);
	}

	


}
