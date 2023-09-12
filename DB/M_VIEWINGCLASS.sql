create table m_viewingclass( # 적합연령
	id int primary key auto_increment,
    tagname varchar(20), 	
    hangle varchar(20)
);


insert into m_viewingclass (TAGNAME,HANGLE) values ('age-all','전체 관람가');
insert into m_viewingclass (TAGNAME,HANGLE) values ('age-12','12세이상 관람가');
insert into m_viewingclass (TAGNAME,HANGLE) values ('age-15','15세이상 관람가');
insert into m_viewingclass (TAGNAME,HANGLE) values ('age-19','19세이상 관람가');
insert into m_viewingclass (TAGNAME,HANGLE) values ('age-no','미정');
