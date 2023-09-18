create database movie_db default character set UTF8;
show databases;
use movie_db;

create table member(
	id int primary key auto_increment,	# 회원 일련번호
    account varchar(50) not null,		# 회원 id
    name varchar(10) not null,			# 회원명
    pwd varchar(50) not null,			# 회원 비밀번호
    email1 varchar(50) not null,		# 회원 이메일1(cat)
    email2 varchar(50) not null,		# 회원 이메일2(gmail.com)
    phonenumber varchar(50) not null,	# 회원 핸드폰 번호
    age int not null					# 회원 나이
);
insert into member(account, name, pwd, email1, email2, phonenumber, age) values('user1', '유저1', 'user1', 'user1', 'gmail.com', '010-1234-5678', 26);
