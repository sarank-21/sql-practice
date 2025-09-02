-- VIEW -- > it is temparery table where it will not store data permenently .
--creation update drop 

CREATE VIEW active_customers AS
SELECT name, salary
FROM employees
WHERE dept_id = 2;

alter VIEW active_customers AS
SELECT name, salary, dept_id
FROM employees
WHERE dept_id = 1;

update active_customers  --> once we update a new value in value it affect the main table 
set salary = 5000
where name="alice"

drop view active_customers

SELECT * FROM active_customers;


create table summary_salary(name int , salary int);

insert into active_customers select name , salary ,dept_id from employees




-- unnormalized table 

Messy Design : Unnormalized Table


CREATE TABLE employee_data (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    dept_location VARCHAR(50),
    salary_month1 DECIMAL(10,2),
    salary_month2 DECIMAL(10,2),
    salary_month3 DECIMAL(10,2)
);

INSERT INTO employee_data VALUES
(1, 'Alice', 'HR', 'New York', 5000, 5100, 5200),
(2, 'Bob', 'IT', 'London', 6000, 6100, NULL),
(3, 'Charlie', 'IT', 'London', 6200, 6300, 6400);

SELECT * from employee_data


--normalization using rules 1NF,2NF,3NF..
-- Employee info

-- 1NF
drop table employee_info

CREATE TABLE employee_info(
    emp_id INT,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    dept_location VARCHAR(50),
    salary_month VARCHAR(50),
    salary_amount DECIMAL(10,2)
);
     
INSERT INTO employee_info VALUES
(1, 'Alice', 'HR', 'New York', 'Jan', 5000),
(1, 'Alice', 'HR', 'New York', 'Feb', 5100),
(1, 'Alice', 'HR', 'New York', 'Mar', 5200),

(2, 'Bob', 'IT', 'London', 'Jan', 6000),
(2, 'Bob', 'IT', 'London', 'Feb', 6100),

(3, 'Charlie', 'IT', 'London', 'Jan', 6200),
(3, 'Charlie', 'IT', 'London', 'Feb', 6300),
(3, 'Charlie', 'IT', 'London', 'Mar', 6400);

SELECT * from employee_info



CREATE TABLE employee_infoedit(
    emp_id INT PRIMARY key ,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    dept_location VARCHAR(50)
);

INSERT INTO employee_infoedit VALUES
(1, 'Alice', 'HR', 'New York'),
(2, 'Bob', 'IT', 'London'),
(3, 'Charlie', 'IT', 'London');

SELECT*from employee_infoedit

CREATE TABLE employees_salary(
    emp_id INT ,
    salary_month VARCHAR(50),
    salary_amount DECIMAL(10,2),
    PRIMARY KEY (emp_id,salary_amount),
    Foreign Key (emp_id) REFERENCES employee_infoedit (emp_id)
);


INSERT INTO employees_salary VALUES
(1, 'Jan', 5000),
(1, 'Feb', 5100),
(1, 'Mar', 5200),

(2, 'Jan', 6000),
(2, 'Feb', 6100),

(3, 'Jan', 6200),
(3, 'Feb', 6300),
(3, 'Mar', 6400);

select * from employees_salary

 drop table employee_dept

CREATE TABLE employee_dept(
    dept_id int PRIMARY KEY,
    dept_name VARCHAR(50),
    dept_location VARCHAR(50)
);

INSERT INTO employee_dept VALUES
(10, 'HR', 'New York'),
(20, 'IT', 'London');

SELECT * FROM employee_dept


-- employee_infoedit now link to employee_dept
CREATE TABLE employees_nf (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES employee_dept(dept_id)
);

INSERT INTO employees_nf VALUES
(1, 'Alice', 10),
(2, 'Bob', 20),
(3, 'Charlie', 20);


select * from employees_nf--> nf3

SELECT * FROM employee_dept--> nf2

select * from employees_salary --> nf1

