show databases;
use movie_db;
show tables;
# 
create table m_movietotal(
	id int primary key auto_increment,
    u_account varchar(20) not null,		# 유저 id
    u_name varchar(20) not null,		# 유저 이름
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
    end_min varchar(10) not null,				# 영화 종료 분
    CONSTRAINT fk_m_movietotal FOREIGN KEY (u_account) REFERENCES member (account) ON DELETE CASCADE
);

# 댓글 테이블
CREATE TABLE m_review (
    r_id INT PRIMARY KEY AUTO_INCREMENT,  # 댓글 id
    m_id INT NOT NULL,                   # 영화 id
    r_text TEXT NOT NULL,               # 댓글 내용
    u_account VARCHAR(20),         # 작성자 id
    u_name VARCHAR(20) NOT NULL,                 # 작성자 일련번호
    created DATETIME DEFAULT NOW(),   # 작성일자
    CONSTRAINT fk_m_review FOREIGN KEY (u_account) REFERENCES member (account) ON DELETE CASCADE
);

