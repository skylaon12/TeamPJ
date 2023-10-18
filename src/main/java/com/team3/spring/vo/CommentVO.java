package com.team3.spring.vo;

import lombok.Data;

@Data
public class CommentVO {			// 1:1 게시판 댓글 vo
	private int p_id;			// 게시판 댓글 일련번호
	private String p_writer;	// 게시판 댓글 작성자
	private String p_ori_id;	// 댓글 원글 번호
	private String p_comment;	// 댓글내용
	private String p_created; 	// 작성일자
}
