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

# 0918 테스트 데이터 삽입
insert into m_movie(name, poster_url, trailer_url, director, actress, suitableage)
values('잠', 'sleep.jpg', 'https://www.youtube.com/watch?v=aRxQDCXnfOc', '유재선', '정유미, 이선균, 김금순, 김국희, 이경진, 윤경호', 3);
insert into m_movie(name, poster_url, trailer_url, director, actress, suitableage)
values('베니스 유령 살인사건', '베니스유령살인사건.jpg', 'https://www.youtube.com/watch?v=Zg1KtJqbCz8', '케네스 브래너', '양자경, 카일 앨런, 카밀 코탄, 제이미 도넌, 티나 페이, 주드 힐, 켈리 라일리', 2);