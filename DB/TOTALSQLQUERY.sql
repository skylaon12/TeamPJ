show databases;
use movie_db;
show tables;
# show tables하셨을 때 
# board, m_movietotal, m_review, member 테이블을 제외한 나머지 테이블은 drop해주시면 되겠습니다!!
# m_movietotal이 이미 존재하는 경우 삭제하시고 아래 쿼리문 실행해주시면 됩니다.
create table m_movietotal(
	id int primary key auto_increment,
    user_id int not null,				# 유저 id
    user_name varchar(20) not null,		# 유저 이름
    ticket_cnt int not null,			# 티켓 수
    cost int,							# 결제 금액
	m_title varchar(50) not null,		# 영화이름
    m_poster text,						# 영화 포스터 url
    m_runtime int not null,				# 영화 런타임
    region_detail varchar(20) not null,	# 영화관 지역(솔시네마 AK프라자, 솔시네마 강남대로..)
    theater_num varchar(20) not null,	# 영화관 번호(1관 2관..)
	seat_num varchar(20) not null,		# 좌석 번호
    reserv_date varchar(20) not null,	# 영화 상영날짜
    str_hour varchar(10) not null,				# 영화 시작 시각
    str_min varchar(10) not null,				# 영화 시작 분
    end_hour varchar(10) not null,				# 영화 종료 시각
    end_min varchar(10) not null				# 영화 종료 분
);
create table m_review(
	r_id int primary key auto_increment,	# 댓글 id
    m_id int not null,					# 영화 id
	r_text text not null,				# 댓글 내용
    u_id varchar(20) not null,		# 작성자 id
    created datetime default now()		# 작성일자
);