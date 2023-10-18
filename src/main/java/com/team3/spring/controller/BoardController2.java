package com.team3.spring.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.spring.service.BoardService2;
import com.team3.spring.vo.BoardConfig;
import com.team3.spring.vo.BoardVO2;
import com.team3.spring.vo.CommentVO;

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
	
	@GetMapping("/list")
	public void getList(Model m,
			@RequestParam(value = "page", defaultValue = "1") int page,
	        @RequestParam(value = "searchKey", required = false) String searchKey,
	        @RequestParam(value = "word", required = false) String word) {
	    log.info("컨트롤러에서 호출 ==========");

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
	    
	    if(currentBlock < totalBlock ){
	    	hasNext = true;
	    	nextPage = currentBlock * BoardConfig.PAGE_PER_BLOCK + 1;
	    } else {
	    	hasNext = false;
	    }

	    // 검색 조건에 따라 적절한 서비스 메서드 호출
	    List<BoardVO2> lists;
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

	    String articleUrl = "article?p_id=";
	    m.addAttribute("articleUrl", articleUrl);
	}
	
	@PostMapping("/write")
	public String write(BoardVO2 gvo, @RequestParam("page") int page) {
		service.write(gvo);
		
		return "redirect:/inquiry/list?page="+page;
	}
	
	@GetMapping("/write")
	public void write(Model m, @RequestParam("page") int page) {
		log.info("글 작성 현재 페이지 번호는? =======>>>"+page);
		
		m.addAttribute("writeCurrentPage", page);
	}
	
	@GetMapping({"/article", "/modify"})
	public void article(Model m, @RequestParam("p_id") Long p_id,
			@RequestParam("page") int page,
			@RequestParam(value = "coPage", defaultValue = "1", required = false) int coPage) {
		log.info("컨트롤러 글번호 읽기 =======>>>"+p_id);
		
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
		
		BoardVO2 article = service.read(p_id);
		
		// 이전 글의 ID와 다음 글의 ID 가져오기
		Long previousArticleId = service.getPreviousArticleId(p_id);
		Long nextArticleId = service.getNextArticleId(p_id);
		
		// 이전 글의 제목 가져오기
		BoardVO2 previousArticle = null;
		String previousArticleTitle = null;
		if (previousArticleId != null) {
		    previousArticle = service.read(previousArticleId);
		    previousArticleTitle = previousArticle.getP_title();
		}

		// 다음 글의 제목 가져오기
		BoardVO2 nextArticle = null;
		String nextArticleTitle = null;
		if (nextArticleId != null) {
		    nextArticle = service.read(nextArticleId);
		    nextArticleTitle = nextArticle.getP_title();
		}
		
		String previousArticleUrl = (previousArticleId != null) ? cp + "/inquiry/article?p_id=" + previousArticleId + "&page=" + page : null;
	    String nextArticleUrl = (nextArticleId != null) ? cp + "/inquiry/article?p_id=" + nextArticleId + "&page=" + page : null;
		
		String con = article.getP_text().replace("\n", "<br>");
		
		m.addAttribute("article", article);
		m.addAttribute("articleContent", con);
		
		m.addAttribute("articleCurrentPage", page);
		
		m.addAttribute("previousArticleUrl", previousArticleUrl);
	    m.addAttribute("nextArticleUrl", nextArticleUrl);
	    
	    m.addAttribute("previousArticleTitle", previousArticleTitle); // 이전 글의 제목 추가
	    m.addAttribute("nextArticleTitle", nextArticleTitle); // 다음 글의 제목 추가
		
	    
	    /**
	     * 댓 글 관 련 코 드
	     */
	    
		// 댓글 페이징 처리
		int index = service.getStartIndex(coPage);
		int totalCount = service.getCommentTotalCount(p_id);
		int totalPage = service.getTotalCommentPage(p_id);
		int totalBlock = service.getTotalCommentBlock(totalPage);
		int currentBlock = (int) Math.ceil((double) coPage / BoardConfig.PAGE_PER_BLOCK);
		int blockStartNo = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK + 1;
	    int blockEndNo = Math.min(currentBlock * BoardConfig.PAGE_PER_BLOCK, totalPage);
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
	    
	    if(currentBlock < totalBlock ){
	    	hasNext = true;
	    	nextPage = currentBlock * BoardConfig.PAGE_PER_BLOCK + 1;
	    } else {
	    	hasNext = false;
	    }
		
		List<CommentVO> comment = service.getCommentData(p_id, index);
		
		if ( comment != null ) {
			for (CommentVO commentVO : comment) {
			    String modifiedComment = commentVO.getP_comment().replace("\n", "<br>");
			    commentVO.setP_comment(modifiedComment);
			}

		    // 댓글 리스트 및 댓글 페이징 관련 정보 뷰로 전달
		    m.addAttribute("commentTotalCount", totalCount);
		    m.addAttribute("commentTotalPage", totalPage);
		    m.addAttribute("commentTotalBlock", totalBlock);
		    m.addAttribute("commentCurrentBlock", currentBlock);
		    m.addAttribute("commentBlockStartNo", blockStartNo);
		    m.addAttribute("commentBlockEndNo", blockEndNo);
		    m.addAttribute("commentHasPrev", hasPrev);
		    m.addAttribute("commentHasNext", hasNext);
		    m.addAttribute("commentPrevPage", prevPage);
		    m.addAttribute("commentNextPage", nextPage);
		    m.addAttribute("commentLists", comment);
	    }
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO2 gvo, @RequestParam("page") int page) {
		service.modify(gvo);
		
		return "redirect:/inquiry/list?page="+page;
	}
	
	@PostMapping("/writeComment")
	public String writeComment(CommentVO gvo, @RequestParam("p_id") Long p_id, @RequestParam("page") int page) {
		service.writeComment(gvo);
		
		return "redirect:/inquiry/article?p_id=" + p_id + "&page=" + page;
	}

}
