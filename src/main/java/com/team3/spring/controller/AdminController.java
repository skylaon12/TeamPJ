package com.team3.spring.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team3.spring.config.BoardConfig;
import com.team3.spring.service.AdminService;
import com.team3.spring.vo.AuthVO;
import com.team3.spring.vo.BoardVO;
import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/admin/*")
@AllArgsConstructor
@Controller
@Log4j
public class AdminController {

	private AdminService service;

	@GetMapping("/main")
	public void main(Model m, Principal p) {
		MemberVO vo = service.loadInfo(p.getName());
		int currentPage = 1;
		// 전체 페이지 수 계산
		int totalPage = service.getTotalPage();
		int index = service.getStartBoardIndex(currentPage);
		
		m.addAttribute("admin", vo);
		m.addAttribute("m_cnt", service.getMemberCnt());
		m.addAttribute("resv_cnt", service.getReserveCnt());
		m.addAttribute("q_cnt", service.getUnAnsweredCnt());
		m.addAttribute("revenue", service.getMonthRevenue());
		m.addAttribute("board", service.getBoardList(index));
		m.addAttribute("currentPage", currentPage);
		m.addAttribute("totalPage", totalPage);

	}

	@GetMapping("/memberList")
	public void getMemberList(Model m, Principal p) {
		MemberVO vo = service.loadInfo(p.getName());
		m.addAttribute("admin", vo);
		m.addAttribute("members", service.getMemberList());
	}

	@GetMapping("/userInfo")
	public void userModify(Model m, @RequestParam("id") int id, Principal p) {
		MemberVO admin = service.loadInfo(p.getName());
		m.addAttribute("admin", admin);
		MemberVO vo = service.getMember(id);
		m.addAttribute("member", vo);
		m.addAttribute("auth", service.getAuth(vo.getAccount()));
	}

	@PostMapping("/userModifyProc")
	public String userModifyProc(RedirectAttributes rttr, MemberVO membervo) {
		int authResult = 0;
		service.authDelete(membervo.getAccount());
		List<AuthVO> list = membervo.getAuthList();
		for (AuthVO authVO : list) {
			if (authVO.getAuth() != null) {
				AuthVO saveVO = new AuthVO();
				saveVO.setAccount(membervo.getAccount());
				saveVO.setAuth(authVO.getAuth());
				authResult = service.authInsert(saveVO);
			}
		}
		if (authResult == 1) {
			rttr.addFlashAttribute("msgType", "Success");
			rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
			log.info("수정완료");
			return "redirect:memberList";
		} else {
			rttr.addFlashAttribute("msgType", "Fail");
			rttr.addFlashAttribute("msg", "수정에 실패하였습니다.");
			log.info("수정실패");
			return "redirect:memberList";
		}
	}
	
	@GetMapping("/userDeleteProc")
	public String userDeleteProc(RedirectAttributes rttr, @RequestParam("id")int id, @RequestParam("account")String account) {
		
		int result = service.deleteUser(id, account);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "Success");
			rttr.addFlashAttribute("msg", "삭제가 완료되었습니다.");
			return "redirect:memberList";
		}else {
			rttr.addFlashAttribute("msgType", "Fail");
			rttr.addFlashAttribute("msg", "오류가 발생했습니다.");
			return "redirect:memberList";
		}
	}

	@GetMapping("/QnAList")
	public void getBoardList(Model m, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchKey", required = false) String searchKey,
			@RequestParam(value = "word", required = false) String word, Principal p) {
		MemberVO vo = service.loadInfo(p.getName());
		m.addAttribute("admin", vo);
		// 기본 검색 조건 설정
		if (searchKey == null || searchKey.isEmpty()) {
			searchKey = "p_title";
		}

		// 검색어가 없으면 빈 문자열로 초기화
		if (word == null) {
			word = "";
		}

		// 시작 인덱스
		int index = service.getStartIndex(page);
		log.info("시작 =>" + index);

		// 검색 결과에 따른 총 글 수 가져오기
		int totalCount = word.isEmpty() ? service.getTotalCount() : service.getSearchTotalCount(searchKey, word);
		log.info("전체 글 수 =>" + totalCount);

		// 전체 페이지 수 계산
		int totalPage = service.getTotalPage(searchKey, word);
		log.info("전체 페이지 수 =>" + totalPage);

		// 전체 블럭 수 계산
		int totalBlock = service.getTotalBlock(totalPage);
		log.info("전체 블럭 수 =>" + totalBlock);

		// 현재 블럭 계산
		int currentBlock = (int) Math.ceil((double) page / BoardConfig.PAGE_PER_BLOCK);
		log.info("현재 블럭 =>" + currentBlock);

		// 현재 블럭의 시작과 끝 페이지 번호 계산
		int blockStartNo = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK + 1;
		int blockEndNo = Math.min(currentBlock * BoardConfig.PAGE_PER_BLOCK, totalPage);
		log.info("현재 블럭 시작 번호 =>" + blockStartNo);
		log.info("현재 블럭 끝 번호 =>" + blockEndNo);

		// 이전 다음 버튼 계산 처리
		boolean hasPrev = true;
		boolean hasNext = true;
		int prevPage = 0;
		int nextPage = 0;

		if (currentBlock == 1) {
			hasPrev = false;
		} else {
			hasPrev = true;
			prevPage = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK;
		}

		if (currentBlock < totalBlock) {
			hasNext = true;
			nextPage = currentBlock * BoardConfig.PAGE_PER_BLOCK + 1;
		} else {
			hasNext = false;
		}

		// 검색 조건에 따라 적절한 서비스 메서드 호출
		ArrayList<BoardVO2> lists;
		if (word.isEmpty()) {
			// 검색어가 없는 경우 전체 리스트 가져오기
			lists = service.list(index);
		} else {
			// 검색어가 있는 경우 검색 조건에 맞게 리스트 가져오기
			lists = service.listSearch(searchKey, word, index);
		}

		// 현재 페이지 번호 추가
		m.addAttribute("currentPage", page);

		// 페이지 리스트 및 페이징 관련 정보 뷰로 전달
		m.addAttribute("totalCount", totalCount);
		m.addAttribute("totalPage", totalPage);
		m.addAttribute("totalBlock", totalBlock);
		m.addAttribute("currentBlock", currentBlock);
		m.addAttribute("blockStartNo", blockStartNo);
		m.addAttribute("blockEndNo", blockEndNo);
		m.addAttribute("hasPrev", hasPrev);
		m.addAttribute("hasNext", hasNext);
		m.addAttribute("prevPage", prevPage);
		m.addAttribute("nextPage", nextPage);
		m.addAttribute("lists", lists);

		m.addAttribute("searchKey", searchKey);
		m.addAttribute("word", word);

		String articleUrl = "/solcinema/inquiry/article?p_id=";
		String pageUrl = "QnAList";
		m.addAttribute("articleUrl", articleUrl);
		m.addAttribute("pageUrl", pageUrl);

	}


//	공지사항 관련
	@GetMapping("/getBoardData")
	public String getBoardData(@RequestParam(name = "page", defaultValue = "1") int page, Model m, Principal p) {
		MemberVO vo = service.loadInfo(p.getName());
		m.addAttribute("admin", vo);
		int index = service.getStartBoardIndex(page);
		log.info("찾을 인덱스 : " + index);
		m.addAttribute("board", service.getBoardList(index));

		return "admin/board_fragment"; // fragment 뷰 페이지를 반환
	}

	@GetMapping("/write")
	public void write(Model m, Principal p) {
		MemberVO vo = service.loadInfo(p.getName());
		m.addAttribute("admin", vo);
	}
	
	@RequestMapping(value="/writeProc", method = RequestMethod.POST)
	public String writeProc(RedirectAttributes rttr ,BoardVO vo) {
		int result = service.write(vo);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "Success");
			rttr.addFlashAttribute("msg", "등록이 완료되었습니다.");
			return "redirect:/admin/main";
		}else {
			rttr.addFlashAttribute("msgType", "Fail");
			rttr.addFlashAttribute("msg", "오류가 발생했습니다.");
			return "redirect:/admin/main";
		}
	}

	@GetMapping({ "/read", "/modify" })
	public void read(Model m, @RequestParam("id") int id, Principal p) {
		MemberVO vo = service.loadInfo(p.getName());
		m.addAttribute("admin", vo);
		m.addAttribute("board", service.read(id));
	}
	
	@GetMapping("/boardDel")
	public String boardDelProc(RedirectAttributes rttr, @RequestParam("id")int id) {
		int result = service.boardDel(id);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "Success");
			rttr.addFlashAttribute("msg", "삭제가 완료되었습니다.");
			return "redirect:/admin/main";
		}else {
			rttr.addFlashAttribute("msgType", "Fail");
			rttr.addFlashAttribute("msg", "오류가 발생했습니다.");
			return "redirect:/admin/main";
		}
	}
	
	@RequestMapping(value="/boardModifyProc", method = RequestMethod.POST)
	public String boardModifyProc(RedirectAttributes rttr, BoardVO vo) {
		log.info("제목 : " + vo.getP_title());
		log.info("내용 : " + vo.getP_text());
		int result = service.boardModify(vo);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "Success");
			rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
			return "redirect:/admin/read?id=" + vo.getP_id();
		}else {
			rttr.addFlashAttribute("msgType", "Fail");
			rttr.addFlashAttribute("msg", "오류가 발생했습니다. 관리자에게 문의하세요");
			return "redirect:/admin/read?id=" + vo.getP_id();
		}
	}
	
//	예매 관련
	@GetMapping("/ticketList")
	public void getTicketList(Model m, Principal p) {
		MemberVO vo = service.loadInfo(p.getName());
		m.addAttribute("admin", vo);
		m.addAttribute("tickets", service.getTicketList()); 
	}
	
	@GetMapping("/cancelTicket")
	public String cancelTicketProc(RedirectAttributes rttr, @RequestParam("id")int id) {
		int result = service.delTicket(id);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "Success");
			rttr.addFlashAttribute("msg", "예매 취소가 완료되었습니다.");
			return "redirect:/admin/ticketList";
		}else {
			rttr.addFlashAttribute("msgType", "Fail");
			rttr.addFlashAttribute("msg", "오류가 발생했습니다.");
			return "redirect:/admin/ticketList";
		}
		
	}
	
	@GetMapping("/access-denied")
	public void showAccessDenied() {
	}

}
