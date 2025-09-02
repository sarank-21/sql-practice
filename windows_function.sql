-- RANKING 
--1.ROW_NUMBER() --> is a window function that gives a unique sequential number to each row.
--Unlike RANK() and DENSE_RANK(), it does not care about ties — every row gets a distinct number.


select emp_id, name,salary,dept_id,
ROW_NUMBER() over(PARTITION BY dept_id) as row_no
from employees; 

--2.RANK() --> assigns a rank number to each row based on a given order.
--If two rows are tied (same value), they get the same rank.
--But the next rank is skipped (creates gaps).

select emp_id, name,salary,dept_id,
RANK() over(PARTITION BY dept_id ORDER BY salary desc) as row_no
from employees; 

--3.DENSE_RANK --> assigns a rank number to each row based on order.
--If there are ties (same value), they get the same rank.
--Unlike RANK(), it does not skip the next rank.
-- In short: No gaps in ranking.
select emp_id, name,salary,dept_id,
DENSE_RANK() over(PARTITION BY dept_id ORDER BY salary desc) as row_no
from employees;


--NTILE(n) --> is a window function that divides the result set into n groups (buckets).
--Each group gets a number: 1, 2, 3 … n.
--Useful for percentiles, quartiles, deciles, etc.
--it as splitting rows into equal (or nearly equal) parts.

select emp_id, name,salary,dept_id,
NTILE(3) over( ORDER BY salary desc) as row_no
from employees; 


SELECT emp_id, name, salary,
       PERCENT_RANK() OVER (ORDER BY salary) AS pct_rank
FROM employees;
select * from employees


select e.name ,e.dept_id, e.salary from employees as e
where salary > (select avg(salary) from employees as d
where d.dept_id = e.dept_id );
  select avg(salary) from employees
  where dept_id=1;