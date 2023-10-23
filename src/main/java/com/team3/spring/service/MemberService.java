package com.team3.spring.service;

import com.team3.spring.vo.MemberVO;

public interface MemberService {
	public MemberVO login(String username);
	public MemberVO read(String account);
	public int signup(MemberVO memberVO, String auth);
	public int checkAccount(String account);
	public int checkEmail(String email1, String email2);
	public void userInfoModify(MemberVO membervo);
	public void userPwdModify(MemberVO membervo);
	public void userDelete(int id, String account);
}
