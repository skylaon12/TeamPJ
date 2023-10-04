package com.team3.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.spring.service.MovieService;
import com.team3.spring.vo.MovieDetailVO;

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
}
