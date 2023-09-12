create table m_movietotal(
	id int primary key auto_increment,
    movie_num int not null,		# 영화 번호(m_movie.id의 foreign key)
    pk_num int not null,		# 상영 종류(m_playkind.id의 foreign key)
    theater_num int not null,	# 상영관 번호(m_theater.id의 foreign key)
    remainseat int,				# 잔여 좌석 수
    str_date datetime not null,	# 영화 상영 날짜
    str_hour int not null,		# 영화 시작 시각
    str_min	int not null,		# 영화 시작 분
    end_hour int not null, 		# 영화 종료 시각
	end_min int not null		# 영화 종료 분
);

alter table m_movietotal add foreign key(movie_num) references m_movie(id);
alter table m_movietotal add foreign key(pk_num) references m_playkind(id);
alter table m_movietotal add foreign key(theater_num) references m_theater(id);

select * from m_movietotal;
