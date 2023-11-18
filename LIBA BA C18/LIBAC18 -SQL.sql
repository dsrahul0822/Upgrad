/*Constraints
Primary Key - It cannot be NULL, It cannot have duplicates
Foreign Key - It can be null, it can have duplicates
NOT NULL - When the value is mandatory
UNIQUE - Where the values cannot be duplicated i.e. emailids and all
CHECK - Where we can check for certain condition i.e. salary>0 
DEFAULT - It will take the default value is nothing is passed
*/

use hrdb;
create table department
(deptid int primary key,
deptname varchar(5));

desc department;

create table employees 
(empid int primary key, 
ename varchar(10) not null,
email varchar(10) unique,
salary int check(salary>0),
doj  date default (sysdate()),
deptid int,
foreign key (deptid) references department(deptid)
);

desc employees;

insert into employees values (3,'c','c',-1000,null,null);

insert into employees (empid,ename,email,salary,deptid) values 
(2,'b','b',2000,null);

insert into department values (10,'IT');
insert into employees (empid,ename,email,salary,deptid) values 
(3,'c','c',3000,10);

select * from department;
select * from employees;

delete from employees where empid=3;

delete from department;

SET SQL_SAFE_UPDATES = 0;


/*
DDL - Data Defination Language - Create/Drop/Alter/Truncate (It drops the table and create new one)
DML - Data Manipulation language - Insert, Delete, Update
DCL - Data Control Language - Revoke/Grant
Difference between Delete and Truncate - 
We can put where clause in the delete but not in truncate
Truncate is faster 
*/

CREATE TABLE Employee (
    EID INT PRIMARY KEY,
    ENAME VARCHAR(255),
    DEPTID INT,
    SALARY INT,
    FOREIGN KEY (DEPTID) REFERENCES Department(DEPTID)
);
CREATE TABLE Department (
    DEPTID INT PRIMARY KEY,
    DNAME VARCHAR(255)
);

INSERT INTO Department (DEPTID, DNAME) VALUES (10, 'HR');
INSERT INTO Department (DEPTID, DNAME) VALUES (20, 'IT');
INSERT INTO Department (DEPTID, DNAME) VALUES (30, 'Marketing');
INSERT INTO Department (DEPTID, DNAME) VALUES (40, 'Sales');


INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (1, 'A', 10.0, 1000);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (2, 'B', 20.0, 1500);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (3, 'C', 20.0, 1250);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (4, 'D', 20.0, 1300);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (5, 'E', 30.0, 1400);
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (6, 'F', NULL, 1500);  -- Note: DEPTID is NaN, replaced with NULL
INSERT INTO Employee (EID, ENAME, DEPTID, SALARY) VALUES (7, 'G', NULL, 1300);  -- Note: DEPTID is NaN, replaced with NULL




select * from employee;

select * from department;


select * from employee e 
inner join department d
on e.deptid = d.deptid;

select * from employee e 
left outer join department d
on e.deptid = d.deptid;

select * from employee e 
right outer join department d
on e.deptid = d.deptid;



select * from employee e 
left outer join department d
on e.deptid = d.deptid
union 
select * from employee e 
right outer join department d
on e.deptid = d.deptid;

select * from tbl_stg_employees;






select emp.employee_id, 
emp.first_name, 
mgr.employee_id, 
mgr.first_name 
from tbl_stg_employees emp 
left outer join tbl_stg_employees mgr
on emp.manager_id=mgr.employee_id;

/*Group By - Clause*/
select * from tbl_stg_employees;


select job_id, sum(salary)
from tbl_stg_employees
group by job_id;



select dept.department_name,emp.job_id, avg(emp.salary) from tbl_stg_employees emp 
inner join tbl_stg_departments dept
on emp.department_id = dept.department_id
group by dept.department_name, emp.job_id;

select sum(salary) from tbl_stg_employees;

select count(*) from tbl_stg_employees;




select dept.department_name, count(*) from tbl_stg_employees emp 
inner join tbl_stg_departments dept
on emp.department_id = dept.department_id
group by dept.department_name
having count(*)>5;


select job_id, count(*) from tbl_stg_employees
where job_id='IT_PROG'
group by job_id
having count(*)>1;