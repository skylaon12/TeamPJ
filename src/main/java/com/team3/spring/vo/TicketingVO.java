package com.team3.spring.vo;

import lombok.Data;

@Data
public class TicketingVO {
	private int id;				// 예매 id
	private int user_id;		// 유저 id
	private String user_name;	// 유저 이름
	private int ticket_cnt;		// 티켓 수
	private int cost;			// 결제 금액
	private String m_title;		// 영화 제목	
	private String m_poster;	// 영화 포스터 url
	private int m_runtime;		// 런타임
	private String region_detail;// 영화관 상세지역
	private String theater_num;	// 상영관 번호
	private String seat_num;	// 좌석 번호
	private String reserv_date;	// 영화 상영 날짜
	private String str_hour;		// 시작 시각
	private String str_min;		// 시작 분
	private String end_hour;		// 종료 시각
	private String end_min;		// 종료 분
}
