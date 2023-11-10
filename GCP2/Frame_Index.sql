/*Framing*/
use hrdb;

select first_name,salary, 
avg(salary) over( order by salary desc rows between unbounded 
preceding and unbounded following) avg_sal from tbl_employees;
 
 
select first_name,salary, job_id,
avg(salary) over(partition by job_id order by salary desc rows between 1 
preceding and 1 following) avg_sal from tbl_employees;



select first_name,salary, 
avg(salary) over( order by salary desc range between unbounded 
preceding and 0 following) avg_sal,
avg(salary) over( order by salary desc rows between unbounded 
preceding and 0 following) avg_sal_rows
 from tbl_employees;

/*Index*/

/*Indexes are used to improve the performance of the queries
Indexes will slow down the DMLS 

Where to create the indexes 
1) The columns which we are using in the where clause 
2) The columns which we are using in the join clause 
3) The columns which we are using in the order by clause 

If the table size is 1 Million
Suppose in a column is having 75% of the values as 'HR' and 25% of the 
values as 'other departments i.e. IT, FIN, MARK'
The column values should be more unique

When there are less number of records we will not create the index 
*/

create database index_learning;
use index_learning;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2)
);

create index idx_dept on employees(department_id);
desc employees;
select * from employees where department_id = 10;


