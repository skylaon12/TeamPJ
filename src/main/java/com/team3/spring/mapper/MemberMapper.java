package com.team3.spring.mapper;

import org.apache.ibatis.annotations.Param;

import com.team3.spring.vo.MemberVO;

public interface MemberMapper {
	public MemberVO login(@Param("id")String id, @Param("pw")String pw);
	public void signup(MemberVO memberVO);
	public int checkAccount(String account);
	public void userInfoModify(MemberVO membervo);
	public void userPwdModify(MemberVO membervo);
}
