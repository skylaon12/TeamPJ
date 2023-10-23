package com.team3.spring.vo;

import lombok.Data;

@Data
public class MovieCommentVO {
	private int r_id;	// 댓글 id
	private int m_id;	// 영화 id
	private String u_name;	// 작성자 이름
	private String u_account; // 작성자 id
	private String r_text;	// 댓글 내용
	private String created;	// 작성날짜
}
