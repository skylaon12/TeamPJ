package com.team3.spring.controller;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.spring.service.BoardService;
import com.team3.spring.vo.BoardVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/notice/*") // 프로젝트 루트 경로 이하 /guest 상위폴더로 진입 시 여기로 진입하게 됨.
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class BoardController {

	private BoardService service;

	@GetMapping("/list")
	public void getList(Model m) {
		log.info("컨트롤러에서 호출 ==========");
		String articleUrl = "article?p_id=";
		m.addAttribute("lists", service.list());
		m.addAttribute("articleUrl",articleUrl);
	}
	
	@PostMapping("/write")
	public String write(BoardVO gvo) {
		service.write(gvo);
		
		return "redirect:/notice/list";
	}
	
	@GetMapping("/write")
	public void write() {
		
	}
	
	@GetMapping({"/article", "/modify"})
	public void article(Model m, @RequestParam("p_id") Long p_id) {
		log.info("컨트롤러 글번호 읽기 =======>>>"+p_id);
		m.addAttribute("article", service.read(p_id));
	}
	
	@GetMapping("/del")
	public String del(@RequestParam("p_id") Long p_id) {
		log.info("컨트롤러 글번호 삭제 =======>>>"+p_id);
		service.del(p_id);
		return "redirect:/notice/list";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO gvo) {
		service.modify(gvo);
		return "redirect:/notice/list";
	}	

}
