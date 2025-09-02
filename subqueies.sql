create DATABASE quries;
 create table employees(
    emp_id int,
    name varchar(50),
    dept_id int,
    salary decimal(10,2),
    hire_date date
 );

create table departments (
    dept_id int,
    dept_name varchar(50),
    location VARCHAR(50)
);

INSERT INTO employees (emp_id, name, dept_id, salary, hire_date) VALUES
(145, 'alice',   1, 6000, '2019-01-15'),
(102, 'Bob',     1, 55000, '2020-03-10'),
(111, 'Praveen',     1, 55000, '2020-03-10'),
(112, 'Kraven',     1, 55000, '2020-03-10'),
(103, 'Charlie', 1, 70000, '2018-07-23'),
(104, 'David',   2, 72000, '2021-09-01'),
(105, 'Eva',     3, 80000, '2017-11-05'),
(106, 'Frank',   3, 65000, '2020-05-20'),
(107, 'Grace',   3, 90000, '2021-12-11'),
(108, 'Hank',    4, 50000, '2020-06-15'),
(109, 'Ivy',     4, 58000, '2021-04-30'),
(110, 'Jack',    4, 62000, '2019-08-19');

INSERT INTO departments (dept_id, dept_name, location) VALUES
(1, 'HR', 'New York'),
(2, 'Finance', 'Chicago'),
(3, 'IT', 'New York'),
(4, 'Marketing', 'Los Angeles');

--scalar subquery using SELECT
select name ,salary ,(select avg(salary) from employees) as avg_salary 
from employees

-- scalar subquery using WHERE
select name,salary from employees
where salary> (select avg(salary) from employees)

--multi row subquery using IN 
select * from employees 
where dept_id in (select dept_id from departments where location= 'New York' );

-- multi row subqureyusing ALL
select * from employees 
where salary > ALL  (select salary from employees where dept_id =1 ); -- max

-- multi row subqureyusing ANY
select * from employees 
where salary > ANY  (select salary from employees where dept_id =1); -- min 

--correlated subquery
select e1.emp_id, e1.salary from employees as e1
where e1.salary> (select AVG(s.salary) from employees as s
                   where s.dept_id = e1.dept_id);

--inline view or derived table 
select dept_id, avg(salary) as avg_sal
from (select dept_id, salary from employees
where hire_date > '2020-01-01') as table1 -- temporary table
group by dept_id;

-- subquries in having
select dept_id, avg(salary) as avg_sal
from employees
group by dept_id 
having avg_sal > (select avg(salary) from employees); -- filters the group by result

--subquries in exists
select e.emp_id,e.name,e.dept_id from employees as e --only brings the given id 
where exists(select d.dept_id from departments d where e.dept_id= 3);

--subquries in not exists
select e.emp_id,e.name,e.dept_id from employees as e -- expect id 3 it brings all other id
where not exists(select d.dept_id from departments d where e.dept_id= 1);

 select * from employees 

 select * from departments

 select max(salary) from employees