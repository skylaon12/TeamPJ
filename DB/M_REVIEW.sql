use movie_db;

create table m_review(
	u_id int not null,
	r_id int primary key auto_increment,	# 댓글 id
    m_id int not null,					# 영화 id
	r_text text not null,				# 댓글 내용
    u_name varchar(20) not null,		# 작성자 id
    created datetime default now()		# 작성일자
);
# 영화 메갈로돈2에 대한 댓글 test용 삽입
insert into m_review(m_id, r_text, u_id) values(615656, 'comment test', 'admin');
insert into m_review(m_id, r_text, u_id) values(615656, 'comment test2', 'admin');
# 들어갔는지 확인해보세요
select * from m_review;