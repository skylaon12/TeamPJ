package com.team3.spring.vo;

import lombok.Data;

@Data
public class AuthVO {
	private int no;		// 일련번호
	private String account; // 아이디
	private String auth;	// 권한명
}
