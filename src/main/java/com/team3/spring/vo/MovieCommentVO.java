package com.team3.spring.vo;

import lombok.Data;

@Data
public class MovieCommentVO {
	private int r_id;
	private int m_id;
	private String r_text;
	private String u_id;
	private String created;
}
