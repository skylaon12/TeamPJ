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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String signupPOST(RedirectAttributes rttr ,MemberVO vo) throws Exception{
		log.info("아이디 : " + vo.getAccount());
		log.info("비밀번호 : " + vo.getPwd());
		log.info("이름 : " + vo.getName());
		log.info("이메일 : " +  vo.getEmail1() + "@" + vo.getEmail2());
		log.info("나이 : " + vo.getAge());
		if(vo.getAccount()==null || vo.getAccount().equals("") || // 유효성 체크 (객체가 안만들어졌거나 공백일시)
				vo.getPwd()==null || vo.getPwd().equals("") ||
				vo.getName()==null || vo.getName().equals("") || vo.getAge()<=0 ||
				vo.getEmail1()==null || vo.getEmail1().equals("") ||
				vo.getEmail2()==null || vo.getEmail2().equals(""))
			{
				// 오류 메세지 => 객체바인딩(Model, HttpServletRequest, HttpSession)
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "모든 내용을 정확히 입력하세요.");	
				return "redirect:sign"; 
			}
			// 회원을 테이블에 저장하기
			int result = service.signup(vo);
			if(result==1) {		// 회원가입 성공 || 가입 메세지 출력
				rttr.addFlashAttribute("msgType", "가입 메세지");
				rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
				return "redirect:/";
			}else { // 회원가입 실패 || 실패 메세지 출력
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
				return "redirect:sign";
			}
	}
	// 가람님 아이디 중복검사 개선함..
	@RequestMapping("/checkAccount")
	public @ResponseBody int memRegisterCheck(@RequestParam("account") String account) {
		int count = service.checkAccount(account); // memberVO에 있는 값의 유무를 보고 result 1 or 0
		return count;
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
	
	// 회원 탈퇴 화면
	@GetMapping("/userWithdraw")
	public void userWithdrawView() {
	}
	
	@RequestMapping(value="/userDelete", method = RequestMethod.POST)
	public String userDelete(HttpSession s, @RequestParam("id")int id) {
		service.userDelete(id);
		s.invalidate();
		log.info("유저삭제완료");
		return "redirect:/";
	}
	
}
