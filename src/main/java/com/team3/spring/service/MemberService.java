package com.team3.spring.service;

import com.team3.spring.vo.MemberVO;

public interface MemberService {
	public MemberVO login(String id, String pw);
	public void signup(MemberVO memberVO);
	public boolean checkAccount(String account);
	public void userInfoModify(MemberVO membervo);
	public void userPwdModify(MemberVO membervo);
}
