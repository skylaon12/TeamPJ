package com.team3.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.mapper.MemberMapper;
import com.team3.spring.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public MemberVO login(String id, String pw) {
		return mapper.login(id, pw);
	}

	@Override
	public void signup(MemberVO memberVO) {
		mapper.signup(memberVO);
		
	}

	@Override
	public boolean checkAccount(String account) {
		log.info(mapper.checkAccount(account));
		int count = mapper.checkAccount(account);
		log.info("서비스 중보개수 : " + count);
		boolean value = false;
		if(count == 0) value = true;
		return value;
	}

}
