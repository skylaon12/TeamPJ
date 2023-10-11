package com.team3.spring.controller;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.spring.service.BoardService;
import com.team3.spring.vo.BoardConfig;
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
	public void getList(Model m, @RequestParam("page") int page) {
		log.info("컨트롤러에서 호출 ==========");
		
		// 시작 인덱스
		int index = service.getStartIndex(page);
		log.info("시작 =>"+index);
		
		// 전체 글 수
		int totalCount = service.getTotalCount();
		log.info("전체 글 수 =>"+totalCount);
		
		// 페이지 및 블럭 관련
		int totalPage = service.getTotalPage();
		log.info("전체 페이지 수 =>"+totalPage);
		
		int totalBlock = service.getTotalBlock(totalPage);
		log.info("전체 블럭 수 =>"+totalBlock);
		
		int currentBlock = (int)Math.ceil((double)page/BoardConfig.PAGE_PER_BLOCK);
		log.info("현재 블럭 =>"+currentBlock);
		
		int blockStartNo = (currentBlock - 1) * BoardConfig.PAGE_PER_BLOCK + 1;
		int blockEndNo = currentBlock * BoardConfig.PAGE_PER_BLOCK;
		log.info("현재 블럭 시작 번호 =>"+blockStartNo);
		log.info("현재 블럭 끝 번호 =>"+blockEndNo);
		
		// 이전 다음 버튼 계산 처리
		boolean hasPrev = true;
		boolean hasNext = true;
		int prevPage = 0;
		int nextPage = 0;
		
		if(currentBlock == 1){
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
		
		// 현재 페이지 번호 추가
	    m.addAttribute("currentPage", page);
	    log.info("현재 페이지 번호 =>"+page);
		
		// 페이지 리스트 뿌림
		m.addAttribute("totalCount",totalCount);
		m.addAttribute("totalPage",totalPage);
		m.addAttribute("totalBlock",totalBlock);
		m.addAttribute("currentBlock",currentBlock);
		m.addAttribute("blockStartNo",blockStartNo);
		m.addAttribute("blockEndNo",blockEndNo);
		m.addAttribute("hasPrev",hasPrev);
		m.addAttribute("hasNext",hasNext);
		m.addAttribute("prevPage",prevPage);
		m.addAttribute("nextPage",nextPage);
		m.addAttribute("lists", service.list(index));
		
		String articleUrl = "article?p_id=";
		m.addAttribute("articleUrl",articleUrl);
	}
	
	@PostMapping("/write")
	public String write(BoardVO gvo, @RequestParam("page") int page) {
		service.write(gvo);
		
		return "redirect:/notice/list?page="+page;
	}
	
	@GetMapping("/write")
	public void write(Model m, @RequestParam("page") int page) {
		log.info("글 작성 현재 페이지 번호는? =======>>>"+page);
		
		m.addAttribute("writeCurrentPage", page);
	}
	
	@GetMapping({"/article", "/modify"})
	public void article(Model m, @RequestParam("p_id") Long p_id, @RequestParam("page") int page) {
		log.info("컨트롤러 글번호 읽기 =======>>>"+p_id);
		
		BoardVO article = service.read(p_id);
		
		String con = article.getP_text().replace("\n", "<br>");
		
		m.addAttribute("article", article);
		m.addAttribute("articleContent", con);
		m.addAttribute("articleCurrentPage", page);
	}
	
	@GetMapping("/del")
	public String del(@RequestParam("p_id") Long p_id, @RequestParam("page") int page) {
		log.info("컨트롤러 글번호 삭제 =======>>>"+p_id);
		service.del(p_id);
		
		return "redirect:/notice/list?page="+page;
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO gvo, @RequestParam("page") int page) {
		service.modify(gvo);
		
		return "redirect:/notice/list?page="+page;
	}	

}
