package com.team3.spring.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.spring.service.MemberService;
import com.team3.spring.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
@Controller
public class MemberController {
	
	private MemberService service;
	
	@GetMapping("/login")
	public void login(Model m) {
	}
	@PostMapping("/loginProc")
	public String login(HttpSession s, @RequestParam("id")String id, @RequestParam("pw")String pw) {
		MemberVO isLogin = service.login(id, pw);
		if(isLogin != null) {
			log.info("login success");
			s.setAttribute("LOGIN_USER", isLogin);
		}else {
			log.info("login failed!!");
		}
		return "redirect:/";
	}
	@RequestMapping("/logout")
	public String loginProc(HttpSession s) {
		s.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/checkLoginStatus")
	@ResponseBody
	public Map<String, Object> checkLoginStatus(HttpSession s){
		Map<String, Object> result = new HashMap<>();
		// 세션에서 로그인 상태 확인
		MemberVO isLogin = (MemberVO) s.getAttribute("LOGIN_USER");
		
		if(isLogin != null) {
			log.info("로그인상태임");
			result.put("loggedIn", true);
		}else {
			log.info("로그인상태아님");
			result.put("loggedIn", false);	
		}
		
		return result;
	}
	
}
