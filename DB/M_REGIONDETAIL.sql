create table m_regiondetail(
	id int primary key auto_increment,	# 상세 지역 번호
    name varchar(20),					# 지역 이름
    region_num int not null				# 상위 지역 번호(m_region.id의 foreign key)
);

alter table m_regiondetail add foreign key(region_num) references m_region(id);

insert into m_regiondetail(name, region_num) values('강남',1);
insert into m_regiondetail(name, region_num) values('강남대로(씨티)',1);
insert into m_regiondetail(name, region_num) values('강동',1);
insert into m_regiondetail(name, region_num) values('고양스타필드',2);
insert into m_regiondetail(name, region_num) values('광명AK플라자',2);
insert into m_regiondetail(name, region_num) values('김포한강신도시',2);
insert into m_regiondetail(name, region_num) values('검단',3);
insert into m_regiondetail(name, region_num) values('송도',3);
insert into m_regiondetail(name, region_num) values('영종',3);
insert into m_regiondetail(name, region_num) values('공주',4);
insert into m_regiondetail(name, region_num) values('논산',4);
insert into m_regiondetail(name, region_num) values('대전',4);
insert into m_regiondetail(name, region_num) values('경북도청',5);
insert into m_regiondetail(name, region_num) values('경산하양',5);
insert into m_regiondetail(name, region_num) values('구미강동',5);
insert into m_regiondetail(name, region_num) values('광주상무',6);
insert into m_regiondetail(name, region_num) values('광주하남',6);
insert into m_regiondetail(name, region_num) values('목포하당(포르모)',6);
insert into m_regiondetail(name, region_num) values('남춘천',7);
insert into m_regiondetail(name, region_num) values('속초',7);
insert into m_regiondetail(name, region_num) values('원주',7);

select * from m_regiondetail;