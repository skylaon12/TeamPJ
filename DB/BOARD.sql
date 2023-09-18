use movie_db;
create table board(	# 1대1 게시판, 공지사항)
	p_id int primary key auto_increment,# 게시물 번호
    p_writer varchar(10) not null,		# 게시물 작성자
    p_title varchar(50) not null,		# 게시물 제목
    p_text text not null,				# 게시물 내용
    p_status varchar(2) default 'F',	# 관리자 답변 유무
    p_ori_id int,						# 게시글 원글 번호(댓글용)
    p_comment text,						# 댓글 내용
    p_hitcount int default 0			# 조회수
);

# 작성일자 컬럼 추가
alter table board add p_created datetime not null default now();
# test 데이터삽입
insert into board(p_writer, p_title, p_text) values ('user1', '테스트1입니다.', '테스트1이에요');
insert into board(p_writer, p_title, p_text) values ('user1', '테스트2입니다.', '테스트2이에요');