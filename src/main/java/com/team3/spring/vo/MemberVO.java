package com.team3.spring.vo;

import java.util.List;

import lombok.Data;

@Data
public class MemberVO {			// 멤퍼 VO
	private int id;				// 일련번호 auto_increment
	private String account;		// 회원 id
	private String name;		// 회원 이름(실명)
	private String pwd;			// 회원 비밀번호`
	private String email1;		// 회원 이메일 아이디
	private String email2;		// 회원 이메일 도메인
	private String phonenumber;	// 회원 전화번호
	private int age;			// 회원 나이
	private List<AuthVO> authList; // 권한테이블
}
