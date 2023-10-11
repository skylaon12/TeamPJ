package com.team3.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.spring.service.MovieService;
import com.team3.spring.service.TicketingService;
import com.team3.spring.vo.MovieDetailVO;
import com.team3.spring.vo.TicketingVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/ticketing/*") // 프로젝트 루트 경로 이하 /guest 상위폴더로 진입 시 여기로 진입하게 됨.
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class TicketingController {
	@Autowired
	private MovieService movieService;
	private	TicketingService ticketingService;
	
	@RequestMapping("/screenList")
	public void screenList(Model m, @RequestParam("no")int id) {
		String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";

		MovieDetailVO vo = movieService.getMovieDetail(id);
		vo.setPoster_path(IMAGE_URL + vo.getPoster_path());
		//String poster_url =  IMAGE_URL + vo.poster_path;

		m.addAttribute("title", vo.getTitle());
		m.addAttribute("runtime", vo.getRuntime());
		m.addAttribute("opendate", vo.getRelease_date());
		m.addAttribute("poster", vo.getPoster_path());
		

	}
	@RequestMapping("/popup")
	public void popup(@ModelAttribute TicketingVO vo) {
//		log.info("유저 id : " + vo.getUser_id());
//		log.info(vo.getUser_name());
//		log.info("티켓 수 : " + vo.getTicket_cnt());
//		log.info("가격 : " + vo.getCost());
//		log.info("영화제목 : " + vo.getM_title());
//		log.info(vo.getM_poster());
//		log.info(vo.getM_runtime());
//		log.info(vo.getRegion_detail());
//		log.info(vo.getTheater_num());
//		log.info(vo.getSeat_num());
//		log.info(vo.getReserv_date());
//		log.info(vo.getStr_hour());
//		log.info(vo.getStr_min());
//		log.info(vo.getEnd_hour());
//		log.info(vo.getEnd_min());
		ticketingService.bookTicket(vo);
	}
	
	@PostMapping("/getBookedSeat")
	@ResponseBody
	public List<String> getBookedSeat(@RequestBody TicketingVO vo){
		List<String> bookedSeats = ticketingService.getBookedSeat(vo);
		log.info(bookedSeats);
		return bookedSeats;
	}
	
	@GetMapping("/check")
	public void ticketCheck() {
	}
	
}
