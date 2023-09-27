package com.team3.spring.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.team3.spring.service.MovieService;
import com.team3.spring.vo.Item;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/rest/*")
@AllArgsConstructor // 필드 값을 매개변수로 하는 생성자를 스프링이 알아서 만들어 줌. 그리고 그런 형태의 생성자를 추가하면 스프링이 알아서 객체관리
					// 해줌(@Auto.. 처럼)
@RestController
public class RestMovieController {
	
	@Autowired
	private MovieService movieService;
	 
	@GetMapping("/top4")
	public ResponseEntity<List<Item>> getTop4Movies() {
		List<Item> top4Movies = movieService.getTop4Movies();
        return ResponseEntity.ok(top4Movies);
	}
	
}
