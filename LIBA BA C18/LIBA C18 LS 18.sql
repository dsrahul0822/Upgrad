/*Constraints
Data Model - ERD
Where Clause 
Joins
Group by*/


create database upgrad_liba_c18;
use upgrad_liba_c18;
/*Create/Drop/Alter - DDLs - Data Definition Language*/
/*Insert/Delete/Update - DML - Data Manipulation Language*/
drop table persons;
create table persons 
(id int, 
last_name varchar(10),
first_name varchar(10),
age int, 
primary key(id));


drop table orders;
drop table persons;
create table persons 
(id int, 
last_name varchar(10),
first_name varchar(10),
age int);

alter table persons
add primary key (id);


desc persons;

alter table persons 
drop primary key;



create table orders
(orderid int, 
ordernumber int,
personid int,
primary key (orderid),
foreign key (personid) references persons(id)
);

desc orders;


insert into orders values (1, 100, 200);

insert into persons values (200,'T','R',38);

select * from orders;
select * from persons;

delete from persons where id = 200;

delete from orders where personid=200;


drop table persons;
create table persons 
(id int, 
last_name varchar(10) not null,
first_name varchar(10),
age int);

desc persons;
insert into persons values (200,'T','R',38);

select * from persons;

drop table persons;

create table persons 
(id int, 
last_name varchar(10) not null,
first_name varchar(10),
email varchar(10),
age int,
check(age>=18));

desc persons;

insert into persons (id,last_name,first_name,email,age) values (200,'T','R','rt',18);

select * from persons;

use dvd_rental;

select * from actor where first_name = 'PENELOPE' and last_name='MONROE';

select co.country, ci.city, cs.first_name, cs.last_name,
f.title
from 
country co 
inner join city ci
on co.country_id = ci.country_id
inner join address ad
on ad.city_id = ci.city_id
inner join customer cs 
on cs.address_id = ad.address_id
inner join store s 
on cs.address_id=s.address_id
inner join inventory inv
on inv.store_id = s.store_id
inner join film f 
on f.film_id = inv.film_id;


select * from film;


select co.country, ci.city,cs.first_name, cs.last_name, f.title
from 
country co 
left outer join city ci
on co.country_id = ci.country_id
left outer join address ad
on ad.city_id = ci.city_id
left outer join customer cs 
on cs.address_id = ad.address_id
left outer join store s 
on cs.address_id=s.address_id
left outer join inventory inv
on inv.store_id = s.store_id
left outer join film f 
on f.film_id = inv.film_id;



select * from store;
select * from inventory;

select * from film;



select * from customer where address_id in (1,2);

use hrdb;
select * from tbl_employees;

select * from tbl_departments;


select dept.department_name,emp.job_id, avg(emp.salary) from tbl_employees emp 
inner join tbl_departments dept 
on emp.department_id = dept.department_id
group by dept.department_name,emp.job_id;


select dept.department_name, count(*) from tbl_employees emp 
inner join tbl_departments dept 
on emp.department_id = dept.department_id
group by dept.department_name
order by count(*) ;


select emp.job_id, count(*) from tbl_employees emp 
inner join tbl_departments dept 
on emp.department_id = dept.department_id
group by emp.job_id
order by count(*) desc;
