create table salary(
id serial primary key,
monthly_salary int not null
);

insert into salary(monthly_salary)
values (500), (700), (1000), (1200);

insert into salary (id, monthly_salary)
values (5,1500), (6,2000), (7,2300)

create table roles(
id serial primary key,
role_title varchar (50) unique not null
);

insert into roles(role_title)
values ('Junior_QA'),('Middle_QA'),('Senior_QA'),('Junior_JS_dev'),('Middle_JS_dev'),('Senior_JS_dev');

update salary 
set monthly_salary = 2100
where id = 6;

delete from salary 
where id=7;

alter table roles
add column parking int;

alter table roles 
rename column parking to taxi;

create table roles_salary (
id serial primary key,
id_role int not null,
id_salary int not null,
foreign key (id_role)
	references roles(id),
foreign key (id_salary)
	references salary(id)
);

insert into roles_salary(id_role,id_salary)
values (1,1),(2,2),(3,3),(4,6);


select * from salary;
select * from roles;
select * from roles_salary;

alter table salary
drop column monthly_salary;

drop table salary;