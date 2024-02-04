-- https://www.hackerrank.com/challenges/the-blunder/problem
/*
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table,
but did not realize her keyboard's  key was broken until after completing the calculation.
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed),
and the actual average salary.
Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries),
and round it up to the next integer.
*/

with no_zero as (
    select cast(salary as float) as salary, cast(replace(cast(salary as varchar), '0', '') as float) as no_zero_salary
    from employees
)

select cast(ceiling(avg(salary) - avg(no_zero_salary)) as int)
from no_zero;