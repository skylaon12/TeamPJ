package com.team3.spring.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team3.spring.service.MailSendService;
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
	private MailSendService mailService;
	@GetMapping("/login")
	public void login(Model m) {
	}
	@PostMapping("/loginProc")
	public String login(RedirectAttributes rttr, HttpSession s, @RequestParam("id")String id, @RequestParam("pw")String pw) {
		MemberVO isLogin = service.login(id, pw);
		if(isLogin != null) {
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "환영합니다 " + isLogin.getName() + "님");
			s.setAttribute("LOGIN_USER", isLogin);
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 다릅니다.");
		}
		return "redirect:/";
	}
	@RequestMapping("/logout")
	public String loginProc(RedirectAttributes rttr, HttpSession s) {
		s.invalidate();
		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "정상적으로 로그아웃 되었습니다.");
		return "redirect:/";
	}
	
	@RequestMapping("/checkLoginStatus")
	public String checkLoginStatus(RedirectAttributes rttr,HttpSession s, @RequestParam("id")String id){
		// 세션에서 로그인 상태 확인
		MemberVO isLogin = (MemberVO) s.getAttribute("LOGIN_USER");
		
		if(isLogin != null) {
			return "redirect:/ticketing/screenList?no="+id;
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다. 로그인 후 이용해주세요.");
			return "redirect:login";
		}
	}
	// 회원가입 페이지 이동
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signupGET() {
	}
	
	// 회원가입
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signupPOST(RedirectAttributes rttr ,@ModelAttribute MemberVO vo) throws Exception{
		log.info("입력된 아이디 : "+ vo.getAccount());
		log.info("이름 : " + vo.getName());
		log.info("비밀번호 : " + vo.getPwd());
		log.info("이메일 : " + vo.getEmail1() + "@" + vo.getEmail2());
		log.info("폰 : " + vo.getPhonenumber());
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
				return "redirect:signup"; 
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
				return "redirect:signup";
			}
	}
	// 가람님 아이디 중복검사 개선함..
	@RequestMapping("/checkAccount")
	public @ResponseBody int memRegisterCheck(@RequestParam("account") String account) {
		int count = service.checkAccount(account); // memberVO에 있는 값의 유무를 보고 result 1 or 0
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value="/emailAuth", method = RequestMethod.POST)
	public String emailAuth(RedirectAttributes rttr, String email) {
		
		// 이메일 중복검사 해야함
		// @ 기준으로 host, domain부분 나눠줌
		int idx = email.indexOf("@");
		String host = email.substring(0,idx);
		String domain = email.substring(idx+1);
		int result = service.checkEmail(host, domain);
		if(result > 0) {
			return "false";
		}else {
			return mailService.joinEmail(email);
		}
		
		
	}
	
	@GetMapping("/info")
	public void userInfoView(Model m, HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("LOGIN_USER");
		if(vo == null) {
			m.addAttribute("msgType", "실패 메세지");
			m.addAttribute("msg", "로그인 후 이용해주십시오.");
		}
	}
	// 유저 정보수전 전에 비밀번호 확인하는 화면
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
	public String userInfoModify(RedirectAttributes rttr, HttpSession s, MemberVO membervo) {
		service.userInfoModify(membervo);
		// 수정했으니 다시 member객체 받아서 세션 다시 설정해야함
		MemberVO isLogin = service.login(membervo.getAccount(), membervo.getPwd());
		if(isLogin != null) {
			s.setAttribute("LOGIN_USER", isLogin);
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "사용자 정보 수정이 완료되었습니다.");
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "사용자 정보 수정에 실패하였습니다.");
		}
		return "redirect:/";
	}
	
	// 비밀번호 변경 시에는 다시 로그인 하도록
	@RequestMapping(value="/setPwdProc", method = RequestMethod.POST)
	public String userPwdModify(RedirectAttributes rttr, HttpSession s, MemberVO membervo) {
		service.userPwdModify(membervo);
		s.invalidate();
		rttr.addFlashAttribute("msgType", "가입 메세지");
		rttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 재로그인 해주시기 바랍니다.");
		return "redirect:login";
	}
	
	// 회원 탈퇴 화면
	@GetMapping("/userWithdraw")
	public void userWithdrawView() {
	}
	
	@RequestMapping(value="/userDelete", method = RequestMethod.POST)
	public String userDelete(RedirectAttributes rttr,HttpSession s, @RequestParam("id")int id) {
		service.userDelete(id);
		s.invalidate();
		rttr.addFlashAttribute("msgType", "탈퇴 메세지");
		rttr.addFlashAttribute("msg", "회원 탈퇴가 완료되었습니다. 솔시네마를 이용해주셔서 감사합니다.");
		return "redirect:/";
	}
}
