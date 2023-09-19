package com.team3.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.spring.service.BoardService;
import com.team3.spring.service.MovieListService;
import com.team3.spring.vo.MovieVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/movie/*") // 프로젝트 루트 경로 이하 /guest 상위폴더로 진입 시 여기로 진입하게 됨.
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class MovieController {

	private MovieListService service;
	
	@GetMapping("/movieDetail")
	public void getList(Model m, @RequestParam("no") int id) {
		log.info("영화 상세정보");
		m.addAttribute("movie", service.getMovie(id));
		
	}
	
	

}
