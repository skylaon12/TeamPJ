package com.team3.spring.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.team3.spring.vo.Item;
import com.team3.spring.vo.MovieVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MovieServiceImpl implements MovieService {

    private String API_KEY = "dfdad57da9c250e542f415cb5b4b16a1";
	private String API_URL = "https://api.themoviedb.org/3/movie/popular?language=ko-KR&api_key="+API_KEY;
	
	@Override
	public List<Item> getTop4Movies() {
		log.info("apikey : " + API_KEY);
		log.info("api_url : " + API_URL);
		URI uri = null;
		RestTemplate restTemplate = new RestTemplate();
		try {
			uri = new URI(API_URL);
		}catch(URISyntaxException e) {
			e.printStackTrace();
		}
		
		MovieVO mvo = restTemplate.getForObject(uri, MovieVO.class);
		System.out.println("id : " + mvo.results.get(0).title);
		
		List<Item> movie = new ArrayList<Item>();
		// 상위 4개만 가져오기
		for(int i = 0; i < 4; i++) {
			movie.add(mvo.results.get(i));
		}
			// 비즈니스 로직 구현
		return movie;
	}

}
