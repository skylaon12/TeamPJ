package com.team3.spring.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	// 회원가입 페이지 이동
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signupGET() {
		log.info("회원가입 페이지 진입");
	
	}
	
	// 회원가입
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signupPOST(MemberVO memberVO) throws Exception{
		log.info("signup 진입");
		
		// 회원가입 서비스 실행
		service.signup(memberVO);
		
		log.info("회원가입 성공");
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/checkAccount", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> checkAccount(@RequestBody MemberVO membervo) {
		boolean success = false;
		String message = "이미 사용중인 아이디입니다.";
		log.info("컨트롤러 account : " + membervo.getAccount());
		success = service.checkAccount(membervo.getAccount());
		message = success?"사용가능한 아이디입니다.":message;
		log.info("success : " + success);
		
		Map<String,Object> response = new HashMap<>();
		
		response.put("success", success);
		response.put("message", message);
		
		return ResponseEntity.ok(response);
	}
	
	@GetMapping("/info")
	public void userInfoView() {
	}
	
	@GetMapping("/checkUserPw")
	public void checkPwView() {
	}
	
	@GetMapping("/userModify")
	public void userInfoModifyView() {
		
	}
	
	@GetMapping("/pwdModify")
	public void getPwdInfo() {
		
	}
	
	// 유저 정보를 변경하면 게시판이랑 영화 댓글 예매내역의 테이블에도 접근해서 변경시켜야 하지 않을까?
	@RequestMapping(value="/userModifyProc", method = RequestMethod.POST)
	public String userInfoModify(HttpSession s, MemberVO membervo) {
		service.userInfoModify(membervo);
		// 수정했으니 다시 member객체 받아서 세션 다시 설정해야함
		MemberVO isLogin = service.login(membervo.getAccount(), membervo.getPwd());
		if(isLogin != null) {
			log.info("login success");
			s.setAttribute("LOGIN_USER", isLogin);
		}else {
			log.info("login failed!!");
		}
		return "redirect:/";
	}
	
	// 비밀번호 변경 시에는 다시 로그인 하도록
	@RequestMapping(value="/setPwdProc", method = RequestMethod.POST)
	public String userPwdModify(HttpSession s, MemberVO membervo) {
		service.userPwdModify(membervo);
		s.invalidate();
		return "redirect:login";
	}
	
}
