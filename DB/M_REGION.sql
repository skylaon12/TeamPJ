create table m_region(
	id  int primary key auto_increment, # 지역 번호
    name varchar(20)					# 지역 이름
);

insert into m_region values (1, '서울');
insert into m_region values (2, '경기');
insert into m_region values (3, '인천');
insert into m_region values (4, '대전/충청/세종');
insert into m_region values (5, '부산/대구/경상');
insert into m_region values (6, '광주/전라');
insert into m_region values (7, '강원');