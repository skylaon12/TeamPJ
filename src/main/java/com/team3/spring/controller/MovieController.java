package com.team3.spring.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team3.spring.service.MemberService;
import com.team3.spring.service.MovieService;
import com.team3.spring.vo.MemberVO;
import com.team3.spring.vo.MovieCommentVO;
import com.team3.spring.vo.MovieDetailVO;

import lombok.AllArgsConstructor;

@RequestMapping("/movie/*") // 프로젝트 루트 경로 이하 /guest 상위폴더로 진입 시 여기로 진입하게 됨.
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class MovieController {
	
	@Autowired
	private MovieService movieService;
	private MemberService memberService;
	
	@RequestMapping("/list")
	public void list() {
		
	}
	
	@GetMapping("/detail")
	public void getList(Model m, @RequestParam("no") int id, Principal p) {
		if(p != null) {
			MemberVO vo = memberService.read(p.getName());
			m.addAttribute("LOGIN_USER", vo);
		}
		String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
		
		MovieDetailVO dmvo = movieService.getMovieDetail(id);
		
		// 포스터 이미지 url
		dmvo.setPoster_path(IMAGE_URL + dmvo.getPoster_path());
		//String poster_url =  IMAGE_URL + dmvo.getPoster_path();
		
		//장르
		String genre = "";
		for(int i = 0; i < dmvo.getGenres().size(); i++) {
			genre = genre + "/" + dmvo.getGenres().get(i).name;
		}
		m.addAttribute("id", dmvo.getId());
		m.addAttribute("title", dmvo.getTitle());
		m.addAttribute("original_title", dmvo.getOriginal_title());
		m.addAttribute("overview", dmvo.getOverview());
		m.addAttribute("openDate", dmvo.getRelease_date());
		m.addAttribute("runtime", dmvo.getRuntime());
		m.addAttribute("genre", genre);
		m.addAttribute("voteAverage", dmvo.getVote_average());
		m.addAttribute("video", movieService.getMovieTrailer(id));
		//m.addAttribute("poster", poster_url);
		m.addAttribute("poster", dmvo.getPoster_path());
		m.addAttribute("actors", movieService.getMovieActor(id));
		m.addAttribute("comments", movieService.getMovieComment(id));
		
	}
	
	@RequestMapping(value = "/setComment", method = RequestMethod.POST)
	public String setComment(RedirectAttributes rttr,MovieCommentVO vo) {
		movieService.setComment(vo);
		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "관람평 등록이 완료되었습니다.");
		return "redirect:/movie/detail?no=" + vo.getM_id();
	}
	
	@RequestMapping("/search")
	public void searchMovie(Model m, @RequestParam("keyword")String word) {
		m.addAttribute("movies", movieService.getSearchMovie(word));
	}
	
	
	

}
