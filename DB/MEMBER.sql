create database movie_db default character set UTF8;
show databases;
use movie_db;

# 사용자 테이블
create table member(
    id int,	# 회원 일련번호
    account varchar(50) primary key,		# 회원 id
    name varchar(10) not null,			# 회원명
    pwd text not null,			# 회원 비밀번호
    email1 varchar(50) not null,		# 회원 이메일1(cat)
    email2 varchar(50) not null,		# 회원 이메일2(gmail.com)
    phonenumber varchar(50) not null,	# 회원 핸드폰 번호
    age int not null					# 회원 나이
);

# 사용자 권한 테이블
CREATE TABLE mem_auth (
    no int not null auto_increment,
    account varchar(50) not null,
    auth varchar(50) not null,
    primary key (no),
    constraint fk_mem_auth foreign key (account) references member (account) ON DELETE CASCADE
);
# 사용자 탈퇴 시 그에 종속된 권한도 삭제하기 위해 외래키 설정하고 delete cascade 해놓음
# 테스트 하실 때 회원가입 하고
# DB쿼리로 직접 관리자 권한 줘야 관리자 페이지로 넘어갈 수 있습니다
# update mem_auth set auth = 'ROLE_ADMIN' where account = '내가 등록한 account';
