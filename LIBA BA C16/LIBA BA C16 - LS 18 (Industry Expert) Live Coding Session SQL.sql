create schema hr_management;
use hr_management;
create table tbl_employees (

employee_id int,
first_name varchar(25) not null,
last_name varchar(25) not null,
email varchar(25) unique,
phone_number varchar(15) unique, 
department_id  int ,
manager_id int,
commission decimal (3,2),
salary  decimal(10,2),
job_id varchar(10),
hire_date timestamp default current_timestamp
);


create table tbl_departments(
department_id int,
deparment_name varchar(50) not null,
manager_id int,
location_id int
); 

create table tbl_locations(
location_id int,
street_address varchar(50) not null,
postal_code int,
city varchar(25),
state_province varchar(25),
country_id char(2)
) ;


create table tbl_countries(
country_id char(2),
country_name varchar(20) not null,
region_id int 
) ;

create table tbl_regions(
region_id int,
region_name varchar(50) not null
);

drop table tbl_jobs;
create table tbl_jobs(
job_id varchar(10),
job_title varchar(50) not null,
min_salary decimal (10,2) check (min_salary>0),
max_salary decimal (10,2) check (max_salary>0)
);

create table tbl_job_history(
employess_id int,
start_date date,
end_date date,
job_id varchar(10),
department_id int
);

alter table tbl_employees add constraint pk_emp_id primary key
(employee_id) ;
alter table tbl_departments add constraint pk_dept_id primary key
(department_id) ; 
alter table tbl_locations add constraint pk_loc_id primary key
(location_id) ; 
alter table tbl_countries add constraint pk_coun_id primary key
(country_id) ; 
alter table tbl_regions add constraint pk_reg_id primary key
(region_id) ; 
alter table tbl_jobs add constraint pk_job_id primary key
(job_id) ; 
alter table tbl_job_history add constraint pk_jh_emp_id primary key
(employess_id) ; 


alter table tbl_employees add constraint fk_emp_emp foreign key 
(manager_id) references  tbl_employees(employee_id); 

alter table tbl_departments add constraint fk_dept_emp
foreign key (manager_id) references tbl_employees(employee_id);

alter table tbl_employees add constraint fk_emp_job
foreign key (job_id) references tbl_jobs(job_id); 
