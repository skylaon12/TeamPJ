package com.team3.spring.vo;

import lombok.Data;

@Data
public class BoardVO {			// 공지 게시판 vo
	private int p_id;			// 게시판 일련번호
	private String p_writer;	// 게시판 작성자
	private String p_title;		// 제목
	private String p_text;		// 내용
	private String p_hitcount;	// 조회수
	private String p_created; 	// 작성일자
}
