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




select name,salary,commission,yearly_salary, department_name,
rank() over(partition by department_name order by yearly_salary desc) rnk from (
select concat(emp.first_name,' ',emp.last_name) name, 
emp.salary,
ifnull(emp.commission_pct,0) commission, 
(salary + (salary*ifnull(emp.commission_pct,0)))*12 yearly_salary,
dept.department_name
from tbl_employees emp
inner join tbl_departments dept
on emp.department_id = dept.department_id) tbl;







