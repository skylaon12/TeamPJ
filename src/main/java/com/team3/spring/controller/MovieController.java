package com.team3.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.spring.service.MovieService;
import com.team3.spring.vo.MovieDetailVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/movie/*") // 프로젝트 루트 경로 이하 /guest 상위폴더로 진입 시 여기로 진입하게 됨.
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class MovieController {
	
	@Autowired
	private MovieService movieService;
	
	@GetMapping("/detail")
	public void getList(Model m, @RequestParam("no") int id) {
		String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
		
		MovieDetailVO dmvo = movieService.getMovieDetail(id);
		
		// 포스터 이미지 url
		String poster_url =  IMAGE_URL + dmvo.poster_path;
		
		//장르
		String genre = "";
		for(int i = 0; i < dmvo.genres.size(); i++) {
			genre = genre + "/" + dmvo.genres.get(i).name;
		}
		
		m.addAttribute("title", dmvo.title);
		m.addAttribute("original_title", dmvo.original_title);
		m.addAttribute("overview", dmvo.overview);
		m.addAttribute("openDate", dmvo.release_date);
		m.addAttribute("runtime", dmvo.runtime);
		m.addAttribute("genre", genre);
		m.addAttribute("voteAverage", dmvo.vote_average);
		m.addAttribute("video", movieService.getMovieTrailer(id));
		m.addAttribute("poster", poster_url);
		m.addAttribute("actors", movieService.getMovieActor(id));
	}
	
	

}
