# 지역, 상세지역, 상영관에 대한 테이블 쿼리
use movie_db;
# 영화 지역 대분류
create table m_region( 
	id int auto_increment primary key,
	region varchar(20) not null
);
# 영화 지역 소분류
create table m_detail_region(
	id int auto_increment primary key,
    region_id int not null,
    detail_region varchar(20) not null
);
# 상영관
create table m_theater(
	id int auto_increment primary key,
	detail_region_id int not null,
    theater varchar(20) not null
);
# 지역이 사라지면 그에 종속되는 데이터를 외래키로 지정해서 종속적 삭제를 등록해놓음
alter table m_detail_region add foreign key(region_id) references m_region(id) on delete cascade;
alter table m_theater add foreign key(detail_region_id) references m_detail_region(id) on delete cascade;

# 데이터 삽입
insert into m_region(region) values('서울');
insert into m_region(region) values('경기');
insert into m_region(region) values('인천');
insert into m_region(region) values('대전/충청/세종');
insert into m_region(region) values('부산/대구/경상');
insert into m_region(region) values('광주/전라');
insert into m_region(region) values('강원');

insert into m_detail_region(region_id, detail_region) values(1,'강남');
insert into m_detail_region(region_id, detail_region) values(1,'강남대로(씨티)');
insert into m_detail_region(region_id, detail_region) values(1,'강동');
insert into m_detail_region(region_id, detail_region) values(2,'고양스타필드');
insert into m_detail_region(region_id, detail_region) values(2,'광명AK플라자');
insert into m_detail_region(region_id, detail_region) values(2,'김포한강신도시');
insert into m_detail_region(region_id, detail_region) values(3,'검단');
insert into m_detail_region(region_id, detail_region) values(3,'송도');
insert into m_detail_region(region_id, detail_region) values(3,'영종');
insert into m_detail_region(region_id, detail_region) values(4,'공주');
insert into m_detail_region(region_id, detail_region) values(4,'논산');
insert into m_detail_region(region_id, detail_region) values(4,'대전');
insert into m_detail_region(region_id, detail_region) values(5,'경북도청');
insert into m_detail_region(region_id, detail_region) values(5,'경산하양');
insert into m_detail_region(region_id, detail_region) values(5,'구미강동');
insert into m_detail_region(region_id, detail_region) values(6,'광주상무');
insert into m_detail_region(region_id, detail_region) values(6,'광주하남');
insert into m_detail_region(region_id, detail_region) values(6,'목포하당(포르모)');
insert into m_detail_region(region_id, detail_region) values(7,'속초');
insert into m_detail_region(region_id, detail_region) values(7,'원주');


insert into m_theater(detail_region_id, theater) values(1,'1관');
insert into m_theater(detail_region_id, theater) values(1,'2관');
insert into m_theater(detail_region_id, theater) values(1,'3관');
insert into m_theater(detail_region_id, theater) values(1,'4관');
insert into m_theater(detail_region_id, theater) values(1,'5관');
insert into m_theater(detail_region_id, theater) values(2,'1관');
insert into m_theater(detail_region_id, theater) values(2,'2관');
insert into m_theater(detail_region_id, theater) values(2,'3관');
insert into m_theater(detail_region_id, theater) values(2,'4관');
insert into m_theater(detail_region_id, theater) values(3,'1관');
insert into m_theater(detail_region_id, theater) values(3,'2관');
insert into m_theater(detail_region_id, theater) values(3,'3관');
insert into m_theater(detail_region_id, theater) values(3,'4관');
insert into m_theater(detail_region_id, theater) values(3,'5관');
insert into m_theater(detail_region_id, theater) values(3,'MX관');
insert into m_theater(detail_region_id, theater) values(4,'1관');
insert into m_theater(detail_region_id, theater) values(4,'2관');
insert into m_theater(detail_region_id, theater) values(4,'3관');
insert into m_theater(detail_region_id, theater) values(4,'4DX관');
insert into m_theater(detail_region_id, theater) values(5,'1관');
insert into m_theater(detail_region_id, theater) values(5,'2관');
insert into m_theater(detail_region_id, theater) values(5,'3관');
insert into m_theater(detail_region_id, theater) values(5,'4관');
insert into m_theater(detail_region_id, theater) values(6,'1관');
insert into m_theater(detail_region_id, theater) values(6,'2관');
insert into m_theater(detail_region_id, theater) values(6,'3관');
insert into m_theater(detail_region_id, theater) values(6,'4관');
insert into m_theater(detail_region_id, theater) values(6,'MX관');
insert into m_theater(detail_region_id, theater) values(7,'1관');
insert into m_theater(detail_region_id, theater) values(7,'2관');
insert into m_theater(detail_region_id, theater) values(7,'3관');
insert into m_theater(detail_region_id, theater) values(7,'4관');
insert into m_theater(detail_region_id, theater) values(7,'4DX관');
insert into m_theater(detail_region_id, theater) values(8,'1관');
insert into m_theater(detail_region_id, theater) values(8,'2관');
insert into m_theater(detail_region_id, theater) values(8,'3관');
insert into m_theater(detail_region_id, theater) values(8,'4관');
insert into m_theater(detail_region_id, theater) values(8,'5관');
insert into m_theater(detail_region_id, theater) values(9,'1관');
insert into m_theater(detail_region_id, theater) values(9,'2관');
insert into m_theater(detail_region_id, theater) values(9,'3관');
insert into m_theater(detail_region_id, theater) values(9,'4관');
insert into m_theater(detail_region_id, theater) values(9,'MX관');
insert into m_theater(detail_region_id, theater) values(10,'1관');
insert into m_theater(detail_region_id, theater) values(10,'2관');
insert into m_theater(detail_region_id, theater) values(10,'3관');
insert into m_theater(detail_region_id, theater) values(10,'4관');
insert into m_theater(detail_region_id, theater) values(11,'1관');
insert into m_theater(detail_region_id, theater) values(11,'2관');
insert into m_theater(detail_region_id, theater) values(11,'3관');
insert into m_theater(detail_region_id, theater) values(11,'4관');
insert into m_theater(detail_region_id, theater) values(11,'5관');
insert into m_theater(detail_region_id, theater) values(12,'1관');
insert into m_theater(detail_region_id, theater) values(12,'2관');
insert into m_theater(detail_region_id, theater) values(12,'3관');
insert into m_theater(detail_region_id, theater) values(12,'4관');
insert into m_theater(detail_region_id, theater) values(12,'4DX관');
insert into m_theater(detail_region_id, theater) values(13,'1관');
insert into m_theater(detail_region_id, theater) values(13,'2관');
insert into m_theater(detail_region_id, theater) values(13,'3관');
insert into m_theater(detail_region_id, theater) values(13,'4관');
insert into m_theater(detail_region_id, theater) values(13,'5관');
insert into m_theater(detail_region_id, theater) values(14,'1관');
insert into m_theater(detail_region_id, theater) values(14,'2관');
insert into m_theater(detail_region_id, theater) values(14,'3관');
insert into m_theater(detail_region_id, theater) values(14,'4관');
insert into m_theater(detail_region_id, theater) values(14,'MX관');
insert into m_theater(detail_region_id, theater) values(15,'1관');
insert into m_theater(detail_region_id, theater) values(15,'2관');
insert into m_theater(detail_region_id, theater) values(15,'3관');
insert into m_theater(detail_region_id, theater) values(15,'4관');
insert into m_theater(detail_region_id, theater) values(15,'5관');
insert into m_theater(detail_region_id, theater) values(16,'1관');
insert into m_theater(detail_region_id, theater) values(16,'2관');
insert into m_theater(detail_region_id, theater) values(16,'3관');
insert into m_theater(detail_region_id, theater) values(16,'4관');
insert into m_theater(detail_region_id, theater) values(16,'4DX관');
insert into m_theater(detail_region_id, theater) values(17,'1관');
insert into m_theater(detail_region_id, theater) values(17,'2관');
insert into m_theater(detail_region_id, theater) values(17,'3관');
insert into m_theater(detail_region_id, theater) values(17,'4관');
insert into m_theater(detail_region_id, theater) values(17,'5관');
insert into m_theater(detail_region_id, theater) values(18,'1관');
insert into m_theater(detail_region_id, theater) values(18,'2관');
insert into m_theater(detail_region_id, theater) values(18,'3관');
insert into m_theater(detail_region_id, theater) values(18,'4관');
insert into m_theater(detail_region_id, theater) values(19,'1관');
insert into m_theater(detail_region_id, theater) values(19,'2관');
insert into m_theater(detail_region_id, theater) values(19,'3관');
insert into m_theater(detail_region_id, theater) values(19,'4관');
insert into m_theater(detail_region_id, theater) values(19,'MX관');
insert into m_theater(detail_region_id, theater) values(20,'1관');
insert into m_theater(detail_region_id, theater) values(20,'2관');
insert into m_theater(detail_region_id, theater) values(20,'3관');
insert into m_theater(detail_region_id, theater) values(20,'4관');
