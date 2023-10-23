package com.team3.spring.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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

import com.team3.spring.service.MemberService;
import com.team3.spring.service.MovieService;
import com.team3.spring.service.TicketingService;
import com.team3.spring.vo.MemberVO;
import com.team3.spring.vo.MovieDetailRegionVO;
import com.team3.spring.vo.MovieDetailVO;
import com.team3.spring.vo.MovieTheaterVO;
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
	private MemberService memberService;
	@PreAuthorize("isAuthenticated()")
	@RequestMapping("/screenList")
	public String screenList(Model m, RedirectAttributes rttr, Principal p, @RequestParam("no")int id) {
		if(p != null) {
			String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
			MemberVO mvo = memberService.read(p.getName());
			MovieDetailVO vo = movieService.getMovieDetail(id);
			vo.setPoster_path(IMAGE_URL + vo.getPoster_path());
			m.addAttribute("LOGIN_USER", mvo);
			m.addAttribute("title", vo.getTitle());
			m.addAttribute("runtime", vo.getRuntime());
			m.addAttribute("opendate", vo.getRelease_date());
			m.addAttribute("poster", vo.getPoster_path());
			m.addAttribute("regions", ticketingService.getRegion());
			return "ticketing/screenList";
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "redirect:/member/login"; // 권한이 없을 경우 접근 거부 페이지로 리다이렉트
		}
	}
	
	@GetMapping("/getDetailRegion")
	@ResponseBody
	public List<MovieDetailRegionVO> getDetailRegion(@RequestParam("region_id")int regionId){
		return ticketingService.getDetailRegion(regionId);
	}
	
	@GetMapping("/getTheater")
	@ResponseBody
	public List<MovieTheaterVO> getTheater(@RequestParam("detail_region_id")int detailRegionId){
		return ticketingService.getTheater(detailRegionId);
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
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/check")
	public String ticketCheck(Model m, RedirectAttributes rttr, Principal p) {
		if(p != null) {
			MemberVO vo = memberService.read(p.getName());
			m.addAttribute("ticket", ticketingService.getTicket(vo.getId()));
			return "ticketing/check";
		}else {
			return "redirect:/member/access-denied"; // 권한이 없을 경우 접근 거부 페이지로 리다이렉트 
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/bookCancel")
	public String cancel(Model m, RedirectAttributes rttr, Principal p, @RequestParam("id")int t_id) {
		if(p != null) {
			m.addAttribute("ticket", ticketingService.getTicket2(t_id));
			return "ticketing/bookCancel";
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "세션이 만료되었습니다. 다시 로그인 해 주십시오");
			return "redirect:/"; // 권한이 없을 경우 접근 거부 페이지로 리다이렉트 
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/cancelProc")
	public String cancelProc(RedirectAttributes rttr, Principal p ,@RequestParam("id")int t_id) {
		if(p != null) {
			ticketingService.cancelProc(t_id);
			rttr.addFlashAttribute("msgType", "완료 메세지");
			rttr.addFlashAttribute("msg", "취소가 완료되었습니다.");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "세션이 만료되었습니다. 다시 로그인 해 주십시오");
			return "redirect:/"; // 권한이 없을 경우 접근 거부 페이지로 리다이렉트 
		}
	}
		
	@GetMapping("/reservationInfo")
	public String reservationView(Model m, RedirectAttributes rttr, Principal p) {
		if(p != null) {
			MemberVO vo = memberService.read(p.getName());
			m.addAttribute("tickets", ticketingService.getTicketHistory(vo.getId()));
			return "ticketing/reservationInfo";
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "세션이 만료되었습니다. 다시 로그인 해 주십시오");
			return "redirect:/"; // 권한이 없을 경우 접근 거부 페이지로 리다이렉트
		}
//		m.addAttribute("tickets", ticketingService.getTicketHistory(user_id));
	}
	
	@GetMapping("/myTicketInfo")
	public void getTicketInfo(Model m, @RequestParam("id")int id) {
		m.addAttribute("ticket", ticketingService.getTicket2(id));
	}
	
}
