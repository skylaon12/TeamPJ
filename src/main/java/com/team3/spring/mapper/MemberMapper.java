package com.team3.spring.mapper;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.MemberVO;

public interface MemberMapper {
	public MemberVO login(String username);
	public MemberVO read(String account);
	public int signup(MemberVO memberVO);
	public int checkAccount(String account);
	public int checkEmail(@Param("email1")String email1, @Param("email2")String email2);
	public void userInfoModify(MemberVO membervo);
	public void userPwdModify(MemberVO membervo);
	public void userDelete(@Param("account")String account);
	public int signupAuth(@Param("account")String account, @Param("auth")String auth);
//	public void userAuthDelete(@Param("account")String account);
}
