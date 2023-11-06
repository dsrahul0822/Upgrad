/*Rank

Dense_rank

row_number*/

create database rank_today;
use rank_today;
CREATE TABLE scores (
    id INT PRIMARY KEY,
    player_name VARCHAR(255),
    score INT
);


INSERT INTO scores (id, player_name, score) VALUES
    (1, 'Alice', 100),
    (2, 'Bob', 80),
    (3, 'Charlie', 90),
    (4, 'David', 100);


select * from scores;

select player_name, score, rank() over (order by score desc) as rnk,
dense_rank() over (order by score desc) as drnk,
row_number() over(order by score desc) as rnnum
from scores;


select * from scores;

use hrdb;


select * from tbl_employees;

select commission_pct, ifnull(commission_pct,0) from tbl_employees;

select name,salary,commission,yearly_salary, department_name,
rank() over(order by yearly_salary desc) rnk from (
select concat(emp.first_name,' ',emp.last_name) name, 
emp.salary,
ifnull(emp.commission_pct,0) commission, 
(salary + (salary*ifnull(emp.commission_pct,0)))*12 yearly_salary,
dept.department_name
from tbl_employees emp
inner join tbl_departments dept
on emp.department_id = dept.department_id) tbl;




drop table scores;
CREATE TABLE scores (
    id INT ,
    player_name VARCHAR(255),
    score INT
);


INSERT INTO scores (id, player_name, score) VALUES
    (1, 'Alice', 100),
    (2, 'Bob', 80),
    (3, 'Charlie', 90),
    (1, 'Alice', 100),
    (3, 'Charlie', 90),
    (2, 'Bob', 80),
    (2, 'Bob', 80),
    (4, 'Rushank', 70);



select * from scores;

insert into score_new 
select id,player_name,score from (
select id,player_name, score,
rank() over (order by score desc) as rnk,
row_number() over(order by score desc) as rnnum
from scores) tbl
where rnk=rnnum;

create table score_new select * from scores where 1=2;

select * from score_new;

use hrdb;


select * from tbl_employees;

select first_name,last_name,job_id,salary, 
rank() over(partition by job_id order by salary desc) rnk,
dense_rank() over(partition by job_id order by salary desc) drnk,
row_number() over(partition by job_id order by salary desc) rnum
from tbl_employees;



create view rank_emp_exe as 
select name,salary,commission,yearly_salary, department_name,
rank() over(partition by department_name order by yearly_salary desc) rnk from (
select concat(emp.first_name,' ',emp.last_name) name, 
emp.salary,
ifnull(emp.commission_pct,0) commission, 
(salary + (salary*ifnull(emp.commission_pct,0)))*12 yearly_salary,
dept.department_name
from tbl_employees emp
inner join tbl_departments dept
on emp.department_id = dept.department_id) tbl
where department_name ='Executive';


select * from rank_emp_exe;

/*CTE - To improve the query performance*/

-- Create the Employees table
CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  EmployeeName VARCHAR(50),
  DepartmentID INT
);

-- Create the EmployeeSalaries table
CREATE TABLE EmployeeSalaries (
  EmployeeID INT PRIMARY KEY,
  Salary DECIMAL(10, 2)
);

-- Insert sample data into Employees
INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID)
VALUES
  (1, 'John Doe', 1),
  (2, 'Jane Smith', 2),
  (3, 'Bob Johnson', 1),
  (4, 'Alice Brown', 2),
  (5, 'Eva Davis', 1);

-- Insert sample data into EmployeeSalaries
INSERT INTO EmployeeSalaries (EmployeeID, Salary)
VALUES
  (1, 60000.00),
  (2, 65000.00),
  (3, 58000.00),
  (4, 70000.00),
  (5, 62000.00);










select * from employees;


select * from employeesalaries;

with deptavgsalary as (
select 
e.departmentid, 
avg(es.salary) as avgsal
from employees e
inner join employeesalaries es 
on e.employeeid=es.employeeid
group by e.departmentid
having avg(es.salary)>60000
)

select 
d.departmentid,
da.avgsal,
count(*) as empcount
from deptavgsalary da
inner join employees d on da.departmentid = d.departmentid
group by d.departmentid, da.avgsal
order by da.avgsal desc;






