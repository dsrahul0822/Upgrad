/*Windows Function in MySQL
rank()
dense_rank()
row_number() 
Partitioning 
framing 

lag()
lead()
*/

select * from tbl_stg_employees;

select first_name, salary, 
rank() over(order by salary desc) rnk,
dense_rank() over(order by salary desc) drnk,
row_number() over(order by salary desc) rnum
from tbl_Stg_employees;

/*lead() 
lag()*/

select first_name, salary, prev_sal, ((salary-prev_sal)/prev_sal)*100 percent_change
from ( 
select first_name,salary,
lag(salary,3) over(order by salary desc) as prev_sal
from tbl_stg_employees) tbl;


/*UDFs*/


CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);


SET GLOBAL log_bin_trust_function_creators = 1;



CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);


select sum(salary) from employee emp
inner join department dept
on emp.DepartmentID=dept.DepartmentID
where dept.DepartmentName='Engineering';

INSERT INTO Department (DepartmentID, DepartmentName) VALUES (1, 'Human Resources');
INSERT INTO Department (DepartmentID, DepartmentName) VALUES (2, 'Engineering');

INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (1, 'John Doe', 50000, 1);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (2, 'Jane Smith', 55000, 2);



select getDepartmentName(1);


select * from employee;

select * from department;



/*Function to get the department name based on the department id*/

/*Function to get the total salary in the department*/
/*deptname in, decimal(10,2)*/


select totalsalarydept('Engineering');



/*Total_Yearly_salary - (salary + (salary*commission)) * 12  */


desc tbl_stg_departments;

select totalyearlysalary(100,'Steven');

select * from tbl_stg_employees;


select first_name, salbydept('Executive') from tbl_stg_employees;


select first_name, (salary+(salary*ifnull(commission_pct,0)))*12 as yearly_salary


,totalyearlysalary(100,'Steven') from tbl_stg_employees;


CREATE WINDOW sales_window AS (PARTITION BY department ORDER BY sales DESC);











drop table employee;


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary DECIMAL(10, 2),
    DepartmentID INT
);

INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (1, 'John Doe', 70000, 1);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (2, 'Jane Smith', 90000, 1);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (3, 'Alice Johnson', 50000, 1);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (4, 'Mike Brown', 80000, 2);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (5, 'Emma Wilson', 60000, 2);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (6, 'A', 80000, 3);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (7, 'B', 60000, 3);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (8, 'C', 60000, 3);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (9, 'D', 60000, 3);

INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (10, 'E', 60000, 4);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (11, 'F', 60000, 4);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (12, 'G', 60000, 4);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (13, 'H', 60000, 4);
select * from Employee;
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (14, 'I', 60000, 5);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (15, 'J', 90000, 5);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (16, 'K', 120000,5);
INSERT INTO Employee (EmployeeID, Name, Salary, DepartmentID) VALUES (17, 'L', 180000,5);

select name, departmentid, salary,
percent_rank() over (partition by departmentid order by salary) salperrank
from employee;




