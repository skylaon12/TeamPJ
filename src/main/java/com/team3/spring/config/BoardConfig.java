package com.team3.spring.config;

public class BoardConfig {
	/**
	 * 게시글 관련
	 */
	
	// 페이지 당 보여 줄 게시글 최대 수
	static public int AMOUNT_PER_PAGE = 10;
	
	// 페이지 링크 한 블럭에 보일 페이지 링크 갯수
	static public int PAGE_PER_BLOCK = 3;
	
	/**
	 * 댓글 관련
	 */
	
	// 페이지 당 보여 줄 댓글 최대 수
	static public int AMOUNT_PER_COMMENT_PAGE = 5;
	
	// 페이지 링크 한 블럭에 보일 페이지 링크 갯수 ( 댓글 )
	static public int PAGE_PER_BLOCK_COMMENT = 5;
	
	/**
	 * 관리자 관련
	 */

	// 페이지 당 보여 줄 게시글 최대 수
	static public int ADMIN_AMOUNT_PER_PAGE = 5;
}