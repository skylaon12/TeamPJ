package com.peisia.spring.mi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.peisia.spring.mi.mapper.GuestMapper;
import com.peisia.spring.mi.vo.GuestVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class GuestServiceImpl implements GuestService{

	@Setter(onMethod_ = @Autowired)
	private GuestMapper mapper;	
	
	@Override
	public List<GuestVO> getList(int currentPage) {
		log.info("비지니스 계층===========");
		int limitIndex = (currentPage-1) * 5;
		return mapper.getList(limitIndex);
	}

	@Override
	public GuestVO read(long bno) {
		return mapper.read(bno);
	}

	@Override
	public void del(long bno) {
		mapper.del(bno);
	}

	@Override
	public void write(GuestVO gvo) {
		mapper.write(gvo);
	}

	@Override
	public void modify(GuestVO gvo) {
		mapper.modify(gvo);
	}
	
}


