create table m_movie(
	id int primary key auto_increment,
    name varchar(50) not null,	# 영화 제목
    poster_url text,			# 영화 포스터 url
    trailer_url text,			# 영화 트레일러 url
    director varchar(20),		# 영화 감독명
    actress varchar(50),		# 출연 배우
    suitableage int not null	# 적합연령 m_viewingclass.id의 foreign key)
);

alter table m_movie add foreign key(suitableage) references m_viewingclass(id);

# api로 정보를 따와야 하나...? 알아 볼 필요가 있는듯
select * from m_movie;