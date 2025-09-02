
# Window Functions Mastery

-- Window (analytic) functions let you compute values across sets of rows without collapsing them like GROUP BY.

-- set of rows -- window

# 1. Ranking:
ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE(n)

# 2. Aggregate:
SUM(), AVG(), MIN(), MAX(), COUNT()

# 3.Value:
LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()

# 4.Distribution:
CUME_DIST(), PERCENT_RANK()

-- 1.RANKING 
--1.ROW_NUMBER() --> is a window function that gives a unique sequential number to each row.
--Unlike RANK() and DENSE_RANK(), it does not care about ties — every row gets a distinct number.


select emp_id, name,salary,dept_id,
ROW_NUMBER() over(PARTITION BY dept_id order by salary desc) as row_no
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

--2. Aggregate Functions as Window
-- SUM()
-- Running total of salaries (ordered by hire date).

SELECT emp_id, name, hire_date, salary,
       SUM(salary) OVER (ORDER BY hire_date) AS running_total
FROM employees;

-- Avg()
 -- Average salary per department.

 SELECT emp_id, name, dept_id, salary,
       AVG(salary) OVER (PARTITION BY dept_id) AS dept_avg
FROM employees;


--  MIN() / MAX()
-- Lowest and highest salary in each department.
 
SELECT emp_id, name, dept_id, salary,
       MIN(salary) OVER (PARTITION BY dept_id) AS min_salary,
       MAX(salary) OVER (PARTITION BY dept_id) AS max_salary
FROM employees;

-- COUNT()

-- Number of employees in each department.

SELECT emp_id, name, dept_id,
       COUNT(*) OVER (PARTITION BY dept_id) AS dept_size
FROM employees;
 -- 3. VALUE FUNCTION 
-- LEAD()

--  Look at the next row’s value.

SELECT emp_id, name, salary,
       LEAD(salary,1) OVER (ORDER BY hire_date) AS next_salary
FROM employees;

-- hows the salary of the employee hired after the current one.

--  LAG()

-- Look at the previous row’s value.

SELECT emp_id, name, salary,
       LAG(salary,1) OVER (ORDER BY hire_date) AS prev_salary
FROM employees;

-- FIRST_VALUE()

-- Get the first value in a partition.

SELECT emp_id, name, dept_id, salary,
       FIRST_VALUE(salary) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS top_salary
FROM employees;

-- For each department → returns highest salary.


-- LAST_VALUE()


-- Get the last value in a partition (be careful with frame definition in MySQL).


SELECT emp_id, name, dept_id, salary,
       LAST_VALUE(salary) OVER (PARTITION BY dept_id ORDER BY salary DESC
                                ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_salary
FROM employees;


# Default : RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

       -- the “window” only looks up to the current row

       -- LAST_VALUE() without a proper frame often just returns the current row value, not the actual last one.

-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING

--    This expands the frame to include all rows in the partition (from first to last row)

# 4. 4. Distribution Functions

-- CUME_DIST()

-- Cumulative distribution: proportion of rows with salary ≤ current.

SELECT emp_id, name, salary, dept_id,
       CUME_DIST() OVER ( ORDER BY salary) AS cum_dist
FROM employees;


-- values go from 0 → 1 (closer to 1 = higher in distribution)


-- PERCENT_RANK()

-- Relative rank between 0 and 1.

SELECT emp_id, name, salary,
       PERCENT_RANK() OVER (ORDER BY salary) AS pct_rank
FROM employees;




-- PERCENT_RANK=  rank-1 / total rows in partition - 1


#Key points :

-- Values range from 0.0 to 1.0.

-- The first row (smallest rank) always has 0.0.

-- The last row (largest rank) always has 1.0.

-- If rows are tied, they get the same rank, so they’ll also get the same percent rank.

-- Exmaple : Rows has rank 1  and total rows is 4

-- (1-1)/(4-1) = 0.00   0 /3 = 0
