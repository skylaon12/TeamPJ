create table m_theater(	# 상영관
	id int primary key auto_increment,
    name varchar(20),		# 상영관 이름
    region_detail_num int,	# 상세지역 번호 m_regiondetail.id의 foreign key
    total_seat int			# 좌석 수
);

alter table m_theater add foreign key(region_detail_num) references m_regiondetail(id);

Insert into m_theater(name, region_detail_num, total_seat) values ('1관',1,232);
Insert into m_theater(name, region_detail_num, total_seat) values ('2관',1,103);
Insert into m_theater(name, region_detail_num, total_seat) values ('6관',1,103);
Insert into m_theater(name, region_detail_num, total_seat) values ('1관',2,230);
Insert into m_theater(name, region_detail_num, total_seat) values ('2관',2,240);
Insert into m_theater(name, region_detail_num, total_seat) values ('3관',2,126);
Insert into m_theater(name, region_detail_num, total_seat) values ('4관',2,123);
Insert into m_theater(name, region_detail_num, total_seat) values ('2관',3,249);
Insert into m_theater(name, region_detail_num, total_seat) values ('3관',3,249);
Insert into m_theater(name, region_detail_num, total_seat) values ('4관',3,249);
Insert into m_theater(name, region_detail_num, total_seat) values ('1관',4,178);
Insert into m_theater(name, region_detail_num, total_seat) values ('2관',4,118);
Insert into m_theater(name, region_detail_num, total_seat) values ('3관',4,136);
Insert into m_theater(name, region_detail_num, total_seat) values ('컴포트 1관',5,164);
Insert into m_theater(name, region_detail_num, total_seat) values ('컴포트 2관',5,115);
Insert into m_theater(name, region_detail_num, total_seat) values ('컴포트 3관',5,115);
Insert into m_theater(name, region_detail_num, total_seat) values ('3관',1,232);
Insert into m_theater(name, region_detail_num, total_seat) values ('7관',3,74);
Insert into m_theater(name, region_detail_num, total_seat) values ('MX관',4,218);
Insert into m_theater(name, region_detail_num, total_seat) values ('8관',4,25);
Insert into m_theater(name, region_detail_num, total_seat) values ('컴포트 5관',5,127);
Insert into m_theater(name, region_detail_num, total_seat) values ('컴포트 4관',5,103);
Insert into m_theater(name, region_detail_num, total_seat) values ('컴포트 6관',5,171);
Insert into m_theater(name, region_detail_num, total_seat) values ('1관',6,137);
Insert into m_theater(name, region_detail_num, total_seat) values ('2관',6,150);
Insert into m_theater(name, region_detail_num, total_seat) values ('4관',6,150);
Insert into m_theater(name, region_detail_num, total_seat) values ('5관',4,168);
Insert into m_theater(name, region_detail_num, total_seat) values ('4관',1,103);
Insert into m_theater(name, region_detail_num, total_seat) values ('7관',4,152);
Insert into m_theater(name, region_detail_num, total_seat) values ('9관',4,29);
Insert into m_theater(name, region_detail_num, total_seat) values ('4관',7,208);
Insert into m_theater(name, region_detail_num, total_seat) values ('3관',7,151);
Insert into m_theater(name, region_detail_num, total_seat) values ('컴포트 2관',8,116);
Insert into m_theater(name, region_detail_num, total_seat) values ('5관',8,165);
Insert into m_theater(name, region_detail_num, total_seat) values ('3관',8,147);
Insert into m_theater(name, region_detail_num, total_seat) values ('1관',8,200);
Insert into m_theater(name, region_detail_num, total_seat) values ('8관',8,175);

select * from m_theater;