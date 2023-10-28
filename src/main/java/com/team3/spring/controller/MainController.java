package com.team3.spring.controller;


import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model m, HttpServletRequest req) {
		return "main";
	}
	
	@GetMapping("/access-denied")
	public void showAccessDenied() {

	}
	
	@GetMapping("/sessionExpire")
	public String sessionExprie(RedirectAttributes rttr) {
		
		rttr.addFlashAttribute("msgType", "만료 메세지");
		rttr.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
		return "/member/login";
	}
}
