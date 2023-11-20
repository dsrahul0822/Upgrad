/*Stored Procedures - Set of SQL statements that can be stored in the database*/

create database spcur;
use spcur;

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

INSERT INTO department (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing');

INSERT INTO employee (employee_id, employee_name, salary, department_id) VALUES
(101, 'Alice Smith', 70000, 1),
(102, 'Bob Johnson', 80000, 2),
(103, 'Charlie Davis', 55000, 3),
(104, 'Diana Ross', 60000, 2);



select * from employee;

select * from department;

call UpdateSalary('Engineering',1000.00);


use hrdb;

select emp.employee_id, 
concat(emp.first_name, ' ', emp.last_name) Ename,
concat(emp.email, '@gmail.com') email,
emp.Hire_date, 
emp.job_id,
emp.salary,
emp.commission_pct,
emp.manager_id,
dept.department_name
 from tbl_stg_employees emp
inner join tbl_stg_departments dept
on emp.department_id = dept.department_id;





call Emp_Data_Cleaning();

select * from tbl_hop1_employees;

select * from tbl_hop2_employees;

select emp.employee_id,
emp.ename,
emp.email,
emp.year_exp,
emp.job_id, 
emp.salary,
emp.commission_pct,
emp.annual_salary,
emp.manager_id,
mgr.ename manager_name,
emp.department_name from tbl_hop2_employees emp 
left outer join tbl_hop2_employees mgr
on emp.manager_id = mgr.employee_id;


select * from tbl_stg_employees;





select employee_id, 
Ename, 
Email, 
datediff(current_date(),hire_date)/365 Year_Exp,
Salary,
ifnull(commission_pct,0) commission_pct,
(salary + (salary * ifnull(commission_pct,0)))*12 annual_salary,
manager_id,
department_name
 from tbl_hop1_employees;
 
select * from tbl_fnl_employees;
 
 drop table tbl_fnl_employees;
 drop table tbl_hop2_employees;
 drop table tbl_hop1_employees;
 
 
 select * from tbl_stg_employees;




CREATE DEFINER=`root`@`localhost` PROCEDURE `Emp_Data_Cleaning`()
BEGIN

/*Step 1*/
drop table if exists tbl_hop1_employees;
create table tbl_hop1_employees
(employee_id int,
EName varchar(50), 
Email varchar(50),
Hire_date date,
job_id varchar(50),
salary decimal(10,2),
commission_pct decimal(10,2),
manager_id int,
department_name varchar(50));

insert into tbl_hop1_employees 
select emp.employee_id, 
concat(emp.first_name, ' ', emp.last_name) Ename,
concat(emp.email, '@gmail.com') email,
emp.Hire_date, 
emp.job_id,
emp.salary,
emp.commission_pct,
emp.manager_id,
dept.department_name
from tbl_stg_employees emp
left outer join tbl_stg_departments dept
on emp.department_id = dept.department_id;


/*Step 2*/

drop table if exists tbl_hop2_employees;
create table tbl_hop2_employees
(employee_id int,
EName varchar(50), 
Email varchar(50),
Year_Exp decimal(10,2),
job_id varchar(50),
salary decimal(10,2),
commission_pct decimal(10,2),
annual_salary decimal(15,2),
manager_id int,
department_name varchar(50));

insert into tbl_hop2_employees 
select employee_id, 
Ename, 
Email, 
datediff(current_date(),hire_date)/365 Year_Exp,
job_id,
Salary,
ifnull(commission_pct,0) commission_pct,
(salary + (salary * ifnull(commission_pct,0)))*12 annual_salary,
manager_id,
department_name
 from tbl_hop1_employees;
 
 
drop table if exists tbl_fnl_employees;
create table tbl_fnl_employees
(employee_id int,
EName varchar(50), 
Email varchar(50),
Year_Exp decimal(10,2),
job_id varchar(50),
salary decimal(10,2),
commission_pct decimal(10,2),
annual_salary decimal(15,2),
manager_id int,
manager_name varchar(50),
department_name varchar(50));

insert into tbl_fnl_employees 
select emp.employee_id,
emp.ename,
emp.email,
emp.year_exp,
emp.job_id, 
emp.salary,
emp.commission_pct,
emp.annual_salary,
emp.manager_id,
mgr.ename manager_name,
emp.department_name from tbl_hop2_employees emp 
left outer join tbl_hop2_employees mgr
on emp.manager_id = mgr.employee_id;


END

/*Cursors*/

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Salary`()
BEGIN

declare done int default False;
declare emp_id int;
declare emp_salary decimal(10,2);
declare cur cursor for select id, salary from employees;
declare continue handler for not found set done=True;

open cur;

read_loop: LOOP
fetch cur into emp_id, emp_salary;
if done then
leave read_loop;
end if;

if emp_salary<50000 then 
update employees set salary = salary * 1.1 where id=emp_id;
end if;
end loop;
close cur;
END