package com.team3.spring.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.mapper.BoardMapper;
import com.team3.spring.vo.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	// 리스트
	@Override
	public ArrayList<BoardVO> list() {
		log.info("서비스 진입");
		return mapper.list();
	}
	
	// 쓰기
	@Override
	public void write(BoardVO gvo) {
		mapper.write(gvo);
	}

	@Override
	public int test() {
		return mapper.test();
	}

}
