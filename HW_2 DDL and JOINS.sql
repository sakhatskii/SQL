-- Создать таблицу работников, 70 человек.

create table employees(
id serial primary key,
employee_name varchar (50) not null
);

insert into employees(employee_name)
values 
('alex_1'),('alex_2'),('alex_3'),('alex_4'),('alex_5'),('alex_6'),('alex_7'),('alex_8'),('alex_9'),('alex_10'),
('alex_11'),('alex_12'),('alex_13'),('alex_14'),('alex_15'),('alex_16'),('alex_17'),('alex_18'),('alex_19'),('alex_20'),
('alex_21'),('alex_22'),('alex_23'),('alex_24'),('alex_25'),('alex_26'),('alex_27'),('alex_28'),('alex_29'),('alex_30'),
('alex_31'),('alex_32'),('alex_33'),('alex_34'),('alex_35'),('alex_36'),('alex_37'),('alex_38'),('alex_39'),('alex_40'),
('alex_41'),('alex_42'),('alex_43'),('alex_44'),('alex_45'),('alex_46'),('alex_47'),('alex_48'),('alex_49'),('alex_50'),
('alex_51'),('alex_52'),('alex_53'),('alex_54'),('alex_55'),('alex_56'),('alex_57'),('alex_58'),('alex_59'),('alex_60'),
('alex_61'),('alex_62'),('alex_63'),('alex_64'),('alex_65'),('alex_66'),('alex_67'),('alex_68'),('alex_69'),('alex_70');

select * from employees;

--Создать таблицу зарплат, 16 строк.

create table salary_1(
id serial primary key,
monthly_salary int not null
);

insert into salary_1(monthly_salary)
values ('1000'),('1100'),('1200'),('1300'),('1400'),('1500'),('1600'),('1700'),('1800'),('1900'),('2000'),('2100'),
('2200'),('2300'),('2400'),('2500');

select * from salary_1;

-- Создать таблицу, присвоить зарплаты 30 сотрдудникам, присвоить зарплаты 10 несуществующим сотрудникам.

create table employee_salary(
id serial primary key,
employee_id int unique not null,
salary_id int not null
);

insert into employee_salary(employee_id, salary_id)
values (1,12),(2,1),(3,4),(4,2),(5,8),(6,8),(7,11),(8,3),(9,6),(10,15),
(11,2),(12,5),(13,9),(14,1),(15,8),(16,2),(17,2),(18,1),(19,12),(20,15),
(21,6),(22,9),(23,3),(24,9),(25,13),(26,12),(27,4),(28,1),(29,11),(30,10),
(81,11),(82,2),(83,3),(84,2),(85,1),(86,9),(87,7),(88,8),(89,12),(90,10);

select * from employee_salary;

-- Создать таблицу 20 должностей.

create table roles_1(
id serial primary key,
role_name varchar (30) unique not null
);

insert into roles_1(role_name)
values ('Junior Python developer'),
('Middle Python developer'),
('Senior Python developer'),
('Junior Java developer'),
('Middle Java developer'),
('Senior Java developer'),
('Junior JavaScript developer'),
('Middle JavaScript developer'),
('Senior JavaScript developer'),
('Junior Manual QA engineer'),
('Middle Manual QA engineer'),
('Senior Manual QA engineer'),
('Project Manager'),
('Designer'),
('HR'),
('CEO'),
('Sales manager'),
('Junior Automation QA engineer'),
('Middle Automation QA engineer'),
('Senior Automation QA engineer');

select * from roles_1;

-- Создать таблицу с сотрудниками и их должностями, 40 строк

create table roles_employee(
id serial primary key,
employee_id int not null,
role_id int not null,
foreign key (employee_id)
	references employees(id),
foreign key (role_id)
	references roles_1(id)
);

insert into roles_employee(employee_id,role_id)
values
(1,12),(2,2),(3,5),(4,10),(5,8),(6,5),(7,5),(8,14),(9,1),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15),(16,1),(17,2),(18,3),(19,4),(20,5),
(21,6),(22,7),(23,8),(24,9),(25,18),(26,1),(27,2),(28,3),(29,6),(30,12),
(31,3),(32,12),(33,1),(34,4),(35,9),(36,14),(37,13),(38,19),(39,5),(40,15);

select * from roles_employee;




select * from employees;
select * from salary_1;
select * from employee_salary;
select * from roles_1;
select * from roles_employee;



delete from employee_salary where id = 1;
drop table roles_employee;
drop table employee_salary;

--

select employee_name, monthly_salary  from employees
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id;

-- 1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.

select employee_name, monthly_salary from employees
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id;
 
select (select employee_name from employees where employee_salary.employee_id = employees.id),
(select monthly_salary from salary_1 where employee_salary.salary_id = salary_1.id)
from employee_salary;

select employee_name,(select salary_id from 
employee_salary where employee_salary.employee_id = employees.id) from employees;


-- 2. Вывести всех работников у которых ЗП меньше 2000.

select employee_name, monthly_salary from employees
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where monthly_salary < 2000;

-- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)

-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)

-- 5. Найти всех работников кому не начислена ЗП.

select employee_name, salary_id from employees
left join employee_salary on employees.id = employee_salary.employee_id
where salary_id is null;

-- 6. Вывести всех работников с названиями их должности.

select employee_name, role_name from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id;

-- 7. Вывести имена и должность только Java разработчиков.

select employee_name, role_name from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id 
where role_name like '% Java %';

-- 8. Вывести имена и должность только Python разработчиков.

select employee_name, role_name from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id 
where role_name like '% Python %';

-- 9. Вывести имена и должность всех QA инженеров.

select employee_name, role_name from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id 
where role_name like '% QA %';

-- 10. Вывести имена и должность ручных QA инженеров.

select employee_name, role_name from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id 
where role_name like '%Manual%';

-- 11. Вывести имена и должность автоматизаторов QA

select employee_name, role_name from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id 
where role_name like '%Auto%';

-- 12. Вывести имена и зарплаты Junior специалистов

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Jun%';
 

-- 13. Вывести имена и зарплаты Middle специалистов

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Mid%';

-- 14. Вывести имена и зарплаты Senior специалистов

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Sen%';

-- 15. Вывести зарплаты Java разработчиков

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Java%';


-- 16. Вывести зарплаты Python разработчиков

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Pyt%';

-- 17. Вывести имена и зарплаты Junior Python разработчиков

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Junior Pyt%';

-- 18. Вывести имена и зарплаты Middle JS разработчиков

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Middle Java%';

-- 19. Вывести имена и зарплаты Senior Java разработчиков

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Senior Java%';

-- 20. Вывести зарплаты Junior QA инженеров

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Jun%' and role_name like '%QA%';

-- 21. Вывести среднюю зарплату всех Junior специалистов

select avg(monthly_salary) from employees
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Jun%'

-- 22. Вывести сумму зарплат JS разработчиков

select sum(monthly_salary) from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%JavaS%';

-- 23. Вывести минимальную ЗП QA инженеров

select min(monthly_salary) from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%QA%';

-- 24. Вывести максимальную ЗП QA инженеров

select max(monthly_salary) from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%QA%';

-- 25. Вывести количество QA инженеров

select count(monthly_salary) from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%QA%';

-- 26. Вывести количество Middle специалистов.

select count(monthly_salary) from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%Mid%';

-- 27. Вывести количество разработчиков

select count(monthly_salary) from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where role_name like '%dev%';

-- 28. Вывести фонд (сумму) зарплаты разработчиков.

select sum(monthly_salary) from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id;

-- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
order by monthly_salary;

-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where monthly_salary between 1700 and 2300
order by monthly_salary;

-- 31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where monthly_salary < 2300
order by monthly_salary;

-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000

select employee_name, role_name, monthly_salary from employees 
join roles_employee on roles_employee.employee_id = employees.id
join roles_1 on roles_1.id = roles_employee.role_id
join employee_salary on employees.id = employee_salary.employee_id
join salary_1 on salary_1.id = employee_salary.salary_id
where monthly_salary in (1100, 1500, 2000)
order by monthly_salary;

