package com.team3.spring.vo;

import lombok.Data;

@Data
public class BoardVO2 {			// 1:1 게시판 vo
	private int p_id;			// 게시판 일련번호
	private String p_writer;	// 게시판 작성자
	private String p_title;		// 제목
	private String p_text;		// 내용
	private String p_status;	// 답글 작성 여부 T/F
	private String p_hitcount;	// 조회수
	private String p_created; 	// 작성일자
}
