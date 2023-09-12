create table m_playkind(
	id int primary key auto_increment,
    name varchar(20)
);

insert into m_playkind (name) values ('2D');
insert into m_playkind (name) values ('3D');
insert into m_playkind (name) values ('2D(자막)');
insert into m_playkind (name) values ('3D(자막)');

select * from m_playkind;