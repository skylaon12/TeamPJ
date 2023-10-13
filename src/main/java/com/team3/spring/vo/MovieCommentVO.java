package com.team3.spring.vo;

import lombok.Data;

@Data
public class MovieCommentVO {
	private int m_id;
	private int u_id;
	private String r_text;
	private String u_name;
	private String created;
}
