


select concat(emp.first_name,' ',emp.last_name) ename,
salary, ifnull(commission_pct,0) commission,
jobs.job_title, dept.department_name, loc.state_province,
cnt.country_name, reg.region_name
from tbl_stg_employees_1 emp
inner join tbl_stg_departments_1 dept
on emp.department_id = dept.department_id
inner join tbl_stg_locations_1 loc 
on dept.location_id = loc.location_id
inner join tbl_stg_countries_1 cnt
on loc.country_id = cnt.country_id
inner join tbl_stg_regions_1 reg
on cnt.region_id = reg.region_id 
inner join tbl_stg_jobs_1 jobs
on emp.job_id = jobs.job_id
where dept.department_name = 'IT'
and reg.region_name='Americas';



select concat(emp.first_name,' ',emp.last_name) ename,
salary, 
ifnull(commission_pct,0) commission,
jobs.job_title, 
dept.department_name, 
loc.state_province,
cnt.country_name, 
reg.region_name
from tbl_stg_employees_1 emp 
inner join (select department_id, department_name, location_id 
from tbl_stg_departments_1 where department_name='IT') dept
on emp.department_id=dept.department_id
inner join tbl_stg_locations_1 loc 
on dept.location_id = loc.location_id
inner join tbl_stg_countries_1 cnt 
on loc.country_id = cnt.country_id
inner join (select region_id,region_name 
from tbl_stg_regions_1 where region_name='Americas') reg
on cnt.region_id=reg.region_id
inner join tbl_stg_jobs_1 jobs 
on emp.job_id = jobs.job_id;



create index idx_dname on tbl_stg_departments_1(department_name);
create index idx_emp_deptid on tbl_stg_employees_1(department_id);
create index idx_dept_deptid on tbl_stg_departments_1(department_id);
create index idx_dept_locid on tbl_stg_departments_1(location_id);
create index idx_loc_locid on tbl_stg_locations_1(location_id);
create index idx_loc_cntid on tbl_stg_locations_1(country_id);
create index idx_cnt_cntid on tbl_stg_countries_1(country_id);
create index idx_cnt_regid on tbl_stg_countries_1(region_id);
create index idx_reg_regid on tbl_stg_regions_1(region_id);
create index idx_emp_jobid on tbl_stg_employees_1(job_id);
create index idx_job_jobid on tbl_stg_jobs_1(job_id);



/*Query Optimization - Main purpose is to improve the speed or time
of the output of the queries*/
/*All employees who are from IT and Executive, Americas*/

/*Name, Salary, Job_title, Department_name, State_name, 
commission it should be 0 if null, Country, Region*/ 
use hrdb;


select concat(emp.first_name,' ',emp.last_name) ename,
salary, ifnull(commission_pct,0) commission,
jobs.job_title, dept.department_name, loc.state_province,
cnt.country_name, reg.region_name
from tbl_stg_employees emp
inner join tbl_stg_departments dept
on emp.department_id = dept.department_id
inner join tbl_stg_locations loc 
on dept.location_id = loc.location_id
inner join tbl_stg_countries cnt
on loc.country_id = cnt.country_id
inner join tbl_stg_regions reg
on cnt.region_id = reg.region_id 
inner join tbl_stg_jobs jobs
on emp.job_id = jobs.job_id
where dept.department_name = 'IT'
and reg.region_name='Americas';



select concat(emp.first_name,' ',emp.last_name) ename,
salary, 
ifnull(commission_pct,0) commission,
jobs.job_title, 
dept.department_name, 
loc.state_province,
cnt.country_name, 
reg.region_name
from tbl_stg_employees emp 
inner join (select department_id, department_name, location_id 
from tbl_stg_departments where department_name='IT') dept
on emp.department_id=dept.department_id
inner join tbl_stg_locations loc 
on dept.location_id = loc.location_id
inner join tbl_stg_countries cnt 
on loc.country_id = cnt.country_id
inner join (select region_id,region_name 
from tbl_stg_regions where region_name='Americas') reg
on cnt.region_id=reg.region_id
inner join tbl_stg_jobs jobs 
on emp.job_id = jobs.job_id;



select count(*) from tbl_stg_employees;
/*107*/

select count(*) from tbl_stg_employees;
/*107*/

select count(*) from tbl_stg_departments;
/*27*/

select count(*) from tbl_stg_locations;
/*23*/

select count(*) from tbl_stg_countries;
/*25*/

select count(*) from tbl_stg_regions;
/*4*/

select count(*) from tbl_stg_jobs;
/*19*/


create index idx_dname on tbl_stg_departments(department_name);
create index idx_rname on tbl_stg_regions(region_name);

desc  tbl_stg_employees;
select * from tbl_stg_employees;

create table tbl_stg_employees 


/*Common Table Expressions (CTEs)*/

select * from tbl_stg_employees_1 emp
inner join tbl_stg_departments_1 dept
on emp.department_id = dept.department_id
where dept.DEPARTMENT_name='IT';



with dept as (select department_id, department_name from 
tbl_stg_departments_1 where department_name ='IT')
select employee_id, first_name, last_name, department_name 
from tbl_stg_employees_1 emp 
inner join dept
on emp.DEPARTMENT_ID = dept.department_id;
/*Get all the department names sum salary > the avg salary of all the depts*/


with dept_sal as (
select department_name, sum(salary) dept_total from tbl_stg_employees_1 emp
inner join tbl_stg_departments_1 dept 
on emp.department_id = dept.DEPARTMENT_ID
group by department_name),
avg_salary as (select sum(dept_total)/count(*) as dept_avg from dept_sal )
select * from dept_sal where dept_total> (select dept_avg from avg_salary);













