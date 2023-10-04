package com.team3.spring.service;

import com.team3.spring.vo.MemberVO;

public interface MemberService {
	public MemberVO login(String id, String pw);
}
