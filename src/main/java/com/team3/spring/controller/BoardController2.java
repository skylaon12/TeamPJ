package com.team3.spring.controller;

import java.security.Principal;
import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team3.spring.service.BoardService2;
import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;
import com.team3.spring.vo.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/inquiry/*") // 프로젝트 루트 경로 이하 /guest 상위폴더로 진입 시 여기로 진입하게 됨.
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class BoardController2 {

	private BoardService2 service;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model m, HttpServletRequest req) {
		return "inquiry/home";
	}
	
	@GetMapping("/list")
	public void getList(Model m, RedirectAttributes rttr, Principal p,
			@RequestParam(value = "p_category", required = false) String p_category,
			@RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "searchKey", required = false) String searchKey,
	        @RequestParam(value = "word", required = false) String word) {
		if(p != null) {
			MemberVO vo = service.getUserInfo(p.getName());
			m.addAttribute("LOGIN_USER", vo);
			 // "전체 카테고리"의 경우 p_category를 비워서 모든 글을 가져옴
		    if (p_category == null || p_category.isEmpty()) {
		    	p_category = "";
		    }

		    // 기본 검색 조건 설정
		    if (searchKey == null || searchKey.isEmpty()) {
		        searchKey = "p_title";
		    }

		    // 검색어가 없으면 빈 문자열로 초기화
		    if (word == null) {
		        word = "";
		    }
		    
		    // 시작 인덱스
		    int index = service.getStartIndex(page, false);
		    
		    // 검색 조건에 따라 적절한 서비스 메서드 호출
		    ArrayList<BoardVO2> lists = service.getLists(p_category, searchKey, word, index, vo.getAccount());

		    // 페이징 처리
		    service.updateModelWithPageInfo(m, page, p_category, searchKey, word);
		    
		    // 댓글 관련 코드
		    service.updateCommentInfo(lists);
		    
		    // 리스트 뷰로 전달
		    m.addAttribute("lists", lists);
		    
		    // 현재 페이지 번호 / 카테고리 뷰로 전달
		    m.addAttribute("currentPage", page);
		    m.addAttribute("currentCate", p_category);

		    String articleUrl = "article?p_id=";
		    m.addAttribute("articleUrl", articleUrl);
		    
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "로그인이 필요한 서비스입니다.");
		}
	    
	}
	
	@PostMapping("/write")
	public String write(RedirectAttributes rttr, BoardVO2 gvo, @RequestParam("page") int page) {
		int result = service.write(gvo);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "문의가 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "오류가 발생하였습니다.");
		}
		
		return "redirect:/inquiry/list?page="+page;
	}
	
	@GetMapping("/write")
	public void write(Model m,RedirectAttributes rttr, Principal p, @RequestParam("page") int page) {
			MemberVO vo = service.getUserInfo(p.getName());
			m.addAttribute("LOGIN_USER", vo);
			m.addAttribute("writeCurrentPage", page);
	}
	
	@GetMapping({"/article", "/modify"})
	public void article(Model m, Principal p, 
			@RequestParam("p_id") Long p_id, 
			@RequestParam(value = "page", defaultValue = "1") int page, 
			@RequestParam(value = "coPage", defaultValue = "1", required = false) int coPage) {
		log.info("컨트롤러 글번호 읽기 =======>>>"+p_id);
		
		
		MemberVO vo = service.getUserInfo(p.getName());
		m.addAttribute("LOGIN_USER", vo);
			
			
		String cp = request.getContextPath();
		
		// 조회수 중복 복사 방지 ( 쿠키 )
		// 해당 글을 조회한 적이 있는지 쿠키를 통해 확인
	    String cookieName = "article_viewed_inquiry_" + p_id;
	    Cookie[] cookies = request.getCookies();
	    boolean viewed = false;
	    
	    // 클라이언트로부터 받은 쿠키들을 확인하여 해당 글을 조회한 기록이 있는지 확인
	    if (cookies != null) {
	    	for (Cookie cookie : cookies) {
	    		if (cookie.getName().equals(cookieName)) {
	    			viewed = true;
	    			
	    			break;
	    		}
	    	}
	    }
	    
	    // 해당 글을 처음 조회하는 경우 (쿠키를 찾을 수 없는 경우), 조회수를 증가시키고 쿠키를 설정
	    if (!viewed) {
	    	// 해당 글 조회수 증가
	        service.updateHitCount(p_id);

	        // 해당 글 조회한 것을 표시하는 쿠키 하나 생성
	        Cookie cookie = new Cookie(cookieName, "viewed");
	        cookie.setMaxAge(60);  // 쿠키 60초 지속 ( 임시 )
	        cookie.setPath("/");  // 어플리케이션 전역에서 접근 허용 코드
	        response.addCookie(cookie);
	    }
		
	    // 게시글 관련 처리
		BoardVO2 article = service.read(p_id);
		
		// 이전 글의 ID와 다음 글의 ID 가져오기
		Long previousArticleId = service.getPreviousArticleId(p_id);
		Long nextArticleId = service.getNextArticleId(p_id);
		
		// 이전 글의 제목 가져오기
		BoardVO2 previousArticle = null;
		String previousArticleTitle = null;
		String previousArticleCategory = null; // 카테고리 변수 추가
		if (previousArticleId != null) {
		    previousArticle = service.read(previousArticleId);
		    previousArticleTitle = previousArticle.getP_title();
		    previousArticleCategory = previousArticle.getP_category(); // 이전 글의 카테고리 가져오기
		}

		// 다음 글의 제목 가져오기
		BoardVO2 nextArticle = null;
		String nextArticleTitle = null;
		String nextArticleCategory = null; // 카테고리 변수 추가
		if (nextArticleId != null) {
		    nextArticle = service.read(nextArticleId);
		    nextArticleTitle = nextArticle.getP_title();
		    nextArticleCategory = nextArticle.getP_category(); // 다음 글의 카테고리 가져오기
		}
		
		String previousArticleUrl = (previousArticleId != null) ? cp + "/inquiry/article?p_id=" + previousArticleId + "&page=" + page : null;
	    String nextArticleUrl = (nextArticleId != null) ? cp + "/inquiry/article?p_id=" + nextArticleId + "&page=" + page : null;
		
	    // 글 엔터 처리
		String con = article.getP_text().replace("\n", "<br>");
		
		// 게시글 처리 뷰로 전달
		m.addAttribute("article", article);
		m.addAttribute("articleContent", con);
		
		m.addAttribute("articleCurrentPage", page);
		
		m.addAttribute("previousArticleUrl", previousArticleUrl);
	    m.addAttribute("nextArticleUrl", nextArticleUrl);
	    
	    m.addAttribute("previousArticleTitle", previousArticleTitle); // 이전 글의 제목 추가
	    m.addAttribute("nextArticleTitle", nextArticleTitle); // 다음 글의 제목 추가
	    
	    m.addAttribute("previousArticleCategory", previousArticleCategory); // 이전 글의 카테고리 추가
	    m.addAttribute("nextArticleCategory", nextArticleCategory); // 다음 글의 카테고리 추가
		
	    /**
	     * 댓 글 관 련 코 드
	     */
	    
		// 댓글 시작 인덱스
		int index = service.getStartIndex(coPage, true);
		
		ArrayList<CommentVO> comment = service.getCommentData(p_id, index);
		
		// 댓글이 있을 때만
		if ( comment != null ) {
			
			// 댓글 엔터 처리
			for (CommentVO commentVO : comment) {
			    String modifiedComment = commentVO.getP_comment().replace("\n", "<br>");
			    commentVO.setP_comment(modifiedComment);
			}
			
			// 댓글 페이징 처리
			service.calculateCommentPagingInfo(m, coPage, p_id);

		    // 댓글 리스트 뷰로 전달
		    m.addAttribute("commentLists", comment);
		    
		    // 댓글 현재 페이지 뷰로 전달
		    m.addAttribute("commentCurrentPage", coPage);
	    }
	}
	
	@PostMapping("/modify")
	public String modify(RedirectAttributes rttr ,BoardVO2 gvo, @RequestParam("page") int page) {
		int result = service.modify(gvo); 
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "문의가 수정되었습니다.");
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "수정에 실패하였습니다.");
		}
		return "redirect:/inquiry/list?page="+page;
	}
	
	@PostMapping("/writeComment")
	public String writeComment(RedirectAttributes rttr, CommentVO gvo, @RequestParam("p_id") Long p_id, @RequestParam("page") int page) {
		int result = service.writeComment(gvo); 
		
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "댓글이 작성되었습니다.");
		}else {
			rttr.addFlashAttribute("msgType", "오류 메세지");
			rttr.addFlashAttribute("msg", "수정에 실패하였습니다.");
		}
		return "redirect:/inquiry/article?p_id=" + p_id + "&page=" + page;
	}
	
	@GetMapping("/endAnswer")
	public String endAnswer(@RequestParam("p_id") Long p_id, @RequestParam("page") int page) {
		log.info("컨트롤러 글 마감 =======>>>"+p_id);
		service.endAnswer(p_id);
		
		return "redirect:/inquiry/article?p_id=" + p_id + "&page=" + page;
	}
}
