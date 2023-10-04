package com.team3.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.spring.mapper.MemberMapper;
import com.team3.spring.vo.MemberVO;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public MemberVO login(String id, String pw) {
		return mapper.login(id, pw);
	}

}
