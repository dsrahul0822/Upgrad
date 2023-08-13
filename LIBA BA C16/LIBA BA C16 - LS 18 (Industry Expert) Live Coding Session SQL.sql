/*https://www.ukessays.com/essays/computer-science/logical-database-design-hr-management-6214.php*/

/*Creating the employee table - 
The name of the object cannot be more than 30 characters*/
use hrdb;
drop table tbl_employees;
create table tbl_employees (
employee_id int,
first_name varchar(25) not null,
last_name varchar(25) not null,
email varchar(25) unique, 
phone_number varchar(15) unique , check(length(phone_number)>=10),
hire_date timestamp default current_timestamp(),
job_id varchar(10),
Salary decimal(10,2) check(salary>0),
commission_pct decimal(3,2),
manager_id int,
department_id int
);

create table tbl_departments(
department_id int, 
department_name varchar(50) not null,
manager_id int,
location_id int
);

create table tbl_locations(
location_id int, 
street_address varchar(50) not null,
postal_code int, 
city varchar(25),
State_province varchar(25),
country_id char(2)
);


create table tbl_countries(
country_id char(2),
country_name varchar(20) not null,
region_id int
);

create table tbl_regions(
region_id int,
region_name varchar(50) not null
);

/*We cannot have same column names twice in the same table*/
drop table tbl_jobs;
create table tbl_jobs
(job_id varchar(10),
job_title varchar(50) not null,
min_salary decimal(10,2) check (min_salary>0),
max_salary decimal(10,2) check (max_salary>0)
);


create table tbl_job_history(
employee_id int, 
start_date date, 
end_date date, 
job_id varchar(10),
department_id int
);


/*DDL - Data definition language 

Create alter drop*/

drop table tbl_job_history;


/*Creating all the Primary Keys*/
alter table tbl_employees add constraint pk_emp_id primary key(employee_id);
alter table tbl_departments add constraint pk_dept_id primary key(department_id);
alter table tbl_locations add constraint pk_loc_id primary key(location_id);
alter table tbl_countries add constraint pk_con_id primary key(country_id);
alter table tbl_regions add constraint pk_reg_id primary key(region_id);
alter table tbl_jobs add constraint pk_job_id primary key(job_id);
alter table tbl_job_history add constraint pk_jh_emp_id primary key(employee_id);

select * from tbl_employees;
/*Creating all the foreign keys*/
alter table tbl_employees 
add constraint fk_emp_emp foreign key (manager_id) references tbl_employees(employee_id);
alter table tbl_departments
add constraint fk_dept_emp foreign key (manager_id) references tbl_employees(employee_id);
alter table tbl_employees
add constraint fk_emp_dept foreign key (department_id) 
references tbl_departments(department_id);

alter table tbl_employees
add constraint fk_emp_job foreign key (job_id) 
references tbl_jobs(job_id);


alter table tbl_job_history add constraint fk_jh_jobs foreign key (employee_id) 
references tbl_employees (employee_id);

alter table tbl_departments add constraint fk_dept_loc foreign key (location_id) references tbl_locations(location_id);

alter table tbl_locations add constraint fk_loc_country foreign key (country_id) references tbl_countries(country_id);

alter table tbl_countries add constraint fk_count_reg foreign key(region_id) references tbl_regions(region_id);

/*In the PK and FK the datatypes should be same
We cannot create the FK without creating the PK*/


