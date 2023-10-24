package com.team3.spring.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
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

	@Autowired
	PasswordEncoder pwEncoder;

	private MemberService service;
	private MailSendService mailService;

	@GetMapping("/login")
	public String login(Model m, RedirectAttributes rttr, Principal p) {
		if(p != null) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "이미 로그인 되어있는 상태입니다.");
			return "redirect:/";
		}else {
			return "member/login";
		}
	}

	@GetMapping("/logout")
	public String logout(RedirectAttributes rttr, HttpServletRequest req, HttpServletResponse res, @RequestParam("id")String s) throws Exception{
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth != null) {
			new SecurityContextLogoutHandler().logout(req, res, auth);
			if(s.equals("setNewPwd")) {
				rttr.addFlashAttribute("msgType", "가입 메세지");
				rttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다. 재로그인 해주시기 바랍니다.");
			}else if(s.equals("deleteUser")) {
				rttr.addFlashAttribute("msgType", "탈퇴 메세지");
				rttr.addFlashAttribute("msg", "회원 탈퇴가 완료되었습니다. 솔시네마를 이용해주셔서 감사합니다.");
			}else if(s.equals("navLogout")) {
				rttr.addFlashAttribute("msgType", "확인 메세지");
				rttr.addFlashAttribute("msg", "로그아웃이 완료되었습니다.");
			}
		}
		return "redirect:/";
	}
	
	@GetMapping("/navLogout")
	public String navLogout() {
		return "redirect:logout?id=navLogout";
	}
	
	@PostMapping("/checkUserPwProc")
	public String matchPw(RedirectAttributes rttr, @RequestParam("password") String pwd,
		@RequestParam("s_pwd") String s_pwd) {
		log.info("입력받은 pw : " + pwd);
		log.info("세션에 저장된 pw : " + s_pwd);
		if (pwd == null || pwd.equals("")) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호를 작성해주세요.");
		}

		if (pwEncoder.matches(pwd, s_pwd)) {
			return "redirect:userModify";
		} else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 다릅니다.");
		}
		return "redirect:checkUserPw";
	}

//	@RequestMapping("/checkLoginStatus")
//	public String checkLoginStatus(RedirectAttributes rttr, HttpSession s, @RequestParam("id") String id, Principal p) {
//
////		SecurityContext context = SecurityContextHolder.getContext();
////        Authentication authentication = context.getAuthentication();
////        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
//
//       if( p != null ) {
//           return "redirect:/ticketing/screenList?no=" + id; 
//       } else {
//          rttr.addFlashAttribute("msgType", "실패 메세지");
//            rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다. 로그인 후 이용해주세요."); 
//            return
//            "redirect:login";
//       }
//	}

	// 회원가입 페이지 이동
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signupGET() {
	}

	// 회원가입
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signupPOST(RedirectAttributes rttr, @ModelAttribute MemberVO vo) throws Exception {

		if (vo.getAccount() == null || vo.getAccount().equals("") || // 유효성 체크 (객체가 안만들어졌거나 공백일시)
				vo.getPwd() == null || vo.getPwd().equals("") || vo.getName() == null || vo.getName().equals("")
				|| vo.getAge() <= 0 || vo.getEmail1() == null || vo.getEmail1().equals("") || vo.getEmail2() == null
				|| vo.getEmail2().equals("")) {
			// 오류 메세지 => 객체바인딩(Model, HttpServletRequest, HttpSession)
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 정확히 입력하세요.");
			return "redirect:signup";
		}
		// 회원을 테이블에 저장하기
		String auth = "ROLE_USER";

		String encyptPw = pwEncoder.encode(vo.getPwd());
		vo.setPwd(encyptPw);

		int result = service.signup(vo, auth);
		if (result == 2) { // 회원가입 성공 || 가입 메세지 출력
			rttr.addFlashAttribute("msgType", "가입 메세지");
			rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
			return "redirect:/";
		} else { // 회원가입 실패 || 실패 메세지 출력
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
	@RequestMapping(value = "/emailAuth", method = RequestMethod.POST)
	public String emailAuth(RedirectAttributes rttr, String email) {

		// 이메일 중복검사 해야함
		// @ 기준으로 host, domain부분 나눠줌
		int idx = email.indexOf("@");
		String host = email.substring(0, idx);
		String domain = email.substring(idx + 1);
		int result = service.checkEmail(host, domain);
		if (result > 0) {
			return "false";
		} else {
			return mailService.joinEmail(email);
		}

	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/info")
	public String userInfoView(Model m, Principal p, RedirectAttributes rttr) {
	    if (p != null) {
	        MemberVO vo = service.read(p.getName());
	        m.addAttribute("LOGIN_USER", vo);
	        return "member/info"; // 사용자 정보 페이지로 이동
	    } else {
	    	rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "redirect:login"; // 권한이 없을 경우 접근 거부 페이지로 리다이렉트
	    }
	}

	// 유저 정보수전 전에 비밀번호 확인하는 화면
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/checkUserPw")
	public String checkPwView(Model m, RedirectAttributes rttr, Principal p) {
		if(p != null) {
			MemberVO vo = service.read(p.getName());
	        m.addAttribute("LOGIN_USER", vo);
	        return "member/checkUserPw";
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "세션이 만료되었습니다. 다시 로그인 해 주십시오");
			return "redirect:login"; // 권한이 없을 경우 접근 거부 페이지로 리다이렉트
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/userModify")
	public String userInfoModifyView(Model m, Principal p) {
		if(p != null) {
			MemberVO vo = service.read(p.getName());
	        m.addAttribute("LOGIN_USER", vo);
	        return "member/userModify";
		}else {
			return "redirect:access-denied";
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/pwdModify")
	public String getPwdInfo(Model m, Principal p) {
		if(p != null) {
			MemberVO vo = service.read(p.getName());
	        m.addAttribute("LOGIN_USER", vo);
	        return "member/pwdModify";
		}else {
			return "redirect:access-denied";
		}

	}
	
	// 유저 정보를 변경하면 게시판이랑 영화 댓글 예매내역의 테이블에도 접근해서 변경시켜야 하지 않을까?
	@RequestMapping(value = "/userModifyProc", method = RequestMethod.POST)
	public String userInfoModify(RedirectAttributes rttr, HttpSession s, MemberVO membervo) {
		service.userInfoModify(membervo);
		// 수정했으니 다시 member객체 받아서 세션 다시 설정해야함
		MemberVO isLogin = service.login(membervo.getAccount());
		if (isLogin != null) {
			s.setAttribute("LOGIN_USER", isLogin);
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "사용자 정보 수정이 완료되었습니다.");
		} else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "사용자 정보 수정에 실패하였습니다.");
		}
		return "redirect:/";
	}

	// 비밀번호 변경 시에는 다시 로그인 하도록
	@RequestMapping(value = "/setPwdProc")
	public String userPwdModify(RedirectAttributes rttr, MemberVO vo,
			@RequestParam("pwd_input") String ori_pwd, @RequestParam("pwd_ori") String sessionPwd) {
		log.info("사용자가 입력한 현재 비밀번호 : " + ori_pwd);
		log.info("사용자가 입력한 바꿀 비밀번호 : " + vo.getPwd());
		log.info("세션에서 넘긴 사용자 입력 pw : " + sessionPwd);

		if (pwEncoder.matches(ori_pwd, sessionPwd)) {
			String encyptPw = pwEncoder.encode(vo.getPwd());
			vo.setPwd(encyptPw);
			service.userPwdModify(vo);
//			s.invalidate();
			//로그아웃처리
			return "redirect:logout?id=setNewPwd";
		} else {
			rttr.addFlashAttribute("msgType", "가입 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 올바르지 않습니다.");
			return "redirect:pwdModify";
		}

	}
	
	
	// 회원 탈퇴 화면
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/userWithdraw")
	public String userWithdrawView(Model m, Principal p) {
		if(p != null) {
			MemberVO vo = service.read(p.getName());
			m.addAttribute("LOGIN_USER", vo);
			return "member/userWithdraw";
		}else {
			return "redirect:access-denied";
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/checkPwd2")
	public ResponseEntity<Map<String, Object>> checkPwd(@RequestParam(required = false, value="pwd")String pwd, Principal p) {
		Map<String, Object> result = new HashMap<String, Object>();
		if(p != null) {
			MemberVO mvo = service.read(p.getName());
			if (pwEncoder.matches(pwd, mvo.getPwd())) {
				result.put("result", true);
			} else {
				result.put("result", false);
			}
		}
		
		
		return ResponseEntity.ok(result);

	}
	
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public String userDelete(RedirectAttributes rttr, HttpSession s,@RequestParam("id")int id, @RequestParam("account") String account) {
		log.info("회원탈퇴 로직 실행");
		service.userDelete(id, account);
		return "redirect:logout?id=deleteUser";
	}

	@GetMapping("/access-denied")
	public void showAccessDenied() {

	}
}
