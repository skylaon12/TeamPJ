use movie_db;

show tables;

select * from board;
select * from board_inquiry;
select * from board_inquiry_comment;

drop table board;
drop table board_inquiry;
drop table board_inquiry_comment;

create table board(								# 공지사항
	p_id int primary key auto_increment,		# 게시물 번호
    p_writer varchar(10) not null,				# 게시물 작성자
    p_title varchar(50) not null,				# 게시물 제목
    p_text text not null,						# 게시물 내용
    p_hitcount int default 0,					# 조회수
    p_created datetime not null default now()  # 작성일자
);

create table board_inquiry(						# 1대1 게시판
	p_id int primary key auto_increment,		# 게시물 번호
    p_category varchar(30) not null,			# 게시물 카테고리
    p_writer varchar(10) not null,				# 게시물 작성자
    p_title varchar(50) not null,				# 게시물 제목
    p_text text not null,						# 게시물 내용
    p_status varchar(2) default 'F',			# 관리자 답변 유무
    p_hitcount int default 0,					# 조회수
    p_created datetime not null default now() 	# 작성일자
);

create table board_inquiry_comment(				# 1대1 게시판 댓글 테이블
	p_id int primary key auto_increment,		# 댓글 번호
    p_writer varchar(10) not null,				# 댓글 작성자
    p_ori_id int not null,						# 게시글 원글 번호(댓글용)
    p_comment text not null,					# 댓글 내용
    p_created datetime not null default now() 	# 작성일자
);

# test 데이터삽입 ( 공지 사항 )
insert into board(p_writer, p_title, p_text) values ('user1', '테스트1입니다.', '테스트1이에요');
insert into board(p_writer, p_title, p_text) values ('user1', '테스트2입니다.', '테스트2이에요');

# test 데이터삽입 ( 1:1 문의 게시판 )
insert into board_inquiry(p_category, p_writer, p_title, p_text) values ('결제/환불', 'user1', '테스트1입니다.', '테스트1이에요');
insert into board_inquiry(p_category, p_writer, p_title, p_text) values ('결제/환불', 'user1', '테스트2입니다.', '테스트2이에요');
insert into board_inquiry(p_category, p_writer, p_title, p_text) values ('영화관', 'user1', '테스트3입니다.', '테스트3이에요');
insert into board_inquiry(p_category, p_writer, p_title, p_text) values ('영화관', 'user1', '테스트4입니다.', '테스트4이에요');

# test 댓글 데이터
insert into board_inquiry_comment(p_writer, p_ori_id, p_comment) values ('user1', '1', '댓글 입니다.');