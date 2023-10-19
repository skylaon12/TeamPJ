package com.team3.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

		m.addAttribute("title", vo.getTitle());
		m.addAttribute("runtime", vo.getRuntime());
		m.addAttribute("opendate", vo.getRelease_date());
		m.addAttribute("poster", vo.getPoster_path());
		

	}
	@RequestMapping("/popup")
	public void popup(@ModelAttribute TicketingVO vo) {
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
	public void ticketCheck(Model m, @RequestParam("id")int u_id) {
		m.addAttribute("ticket", ticketingService.getTicket(u_id));
	}
	
	@GetMapping("/bookCancel")
	public void cancel(Model m, @RequestParam("id")int t_id) {
		
		m.addAttribute("ticket", ticketingService.getTicket2(t_id));
	}
	
	@GetMapping("/cancelProc")
	public String cancelProc(RedirectAttributes rttr, @RequestParam("id")int t_id) {
		ticketingService.cancelProc(t_id);
		rttr.addFlashAttribute("msgType", "완료 메세지");
		rttr.addFlashAttribute("msg", "취소가 완료되었습니다.");
		return "redirect:/";
	}
		
	@GetMapping("/reservationInfo")
	public void reservationView(Model m,@RequestParam("id")int user_id) {
		m.addAttribute("tickets", ticketingService.getTicketHistory(user_id));
	}
	
	@GetMapping("/myTicketInfo")
	public void getTicketInfo(Model m, @RequestParam("id")int id) {
		m.addAttribute("ticket", ticketingService.getTicket2(id));
	}
}
