package com.team3.spring.controller;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.team3.spring.vo.MovieActorCast;
import com.team3.spring.vo.MovieActorVO;
import com.team3.spring.vo.MovieDetailVO;
import com.team3.spring.vo.MovieYoutubeVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/movie/*") // 프로젝트 루트 경로 이하 /guest 상위폴더로 진입 시 여기로 진입하게 됨.
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@Controller
public class MovieController {

	@GetMapping("/detail")
	public void getList(Model m, @RequestParam("no") int id) {
		String API_KEY = "dfdad57da9c250e542f415cb5b4b16a1";
		String API_URL = "https://api.themoviedb.org/3/movie/" + id;
		String DETAIL_API_URL = API_URL + "?language=ko-KR&region=KR&api_key=" + API_KEY;
		String ACTOR_API_URL = API_URL + "/credits?api_key=" + API_KEY;
		String VIDEO_API_URL = API_URL + "/videos?api_key=" + API_KEY;
		String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
		URI detail_uri = null;
		URI video_uri = null;
		URI actor_uri = null;
		RestTemplate resTemplate = new RestTemplate();
		
		try {
			detail_uri = new URI(DETAIL_API_URL);
			video_uri = new URI(VIDEO_API_URL);
			actor_uri = new URI(ACTOR_API_URL);
		}catch(URISyntaxException e) {
			e.printStackTrace();
		}
		
		MovieDetailVO dmvo = resTemplate.getForObject(detail_uri, MovieDetailVO.class);
		MovieYoutubeVO ymvo = resTemplate.getForObject(video_uri, MovieYoutubeVO.class);
		
		MovieActorVO amvo = resTemplate.getForObject(actor_uri, MovieActorVO.class);
		//이미지 url
		String poster_url =  IMAGE_URL + dmvo.poster_path;
		// actor 이미지 경로(최대 5명만 나오게 할거임)
		ArrayList<MovieActorCast> actors = new ArrayList<MovieActorCast>();
		for(int i=0; i < 5; i++) {
			amvo.cast.get(i).setProfile_path(IMAGE_URL + amvo.cast.get(i).getProfile_path());
			actors.add(amvo.cast.get(i));
		}
		//장르
		String genre = "";
		for(int i = 0; i < dmvo.genres.size(); i++) {
			genre = genre + "/" + dmvo.genres.get(i).name;
		}
		System.out.println(genre);	
		
		m.addAttribute("title", dmvo.title);
		m.addAttribute("original_title", dmvo.original_title);
		m.addAttribute("overview", dmvo.overview);
		m.addAttribute("openDate", dmvo.release_date);
		m.addAttribute("runtime", dmvo.runtime);
		m.addAttribute("genre", genre);
		m.addAttribute("voteAverage", dmvo.vote_average);
		m.addAttribute("video", ymvo.results.get(0).key);
		m.addAttribute("poster", poster_url);
		m.addAttribute("actors", actors);
	}
	
	

}
