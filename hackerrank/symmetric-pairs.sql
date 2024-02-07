-- https://www.hackerrank.com/challenges/symmetric-pairs/problem
/*
You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X.
List the rows such that X1 <= Y1.
*/

select x, y
from functions as func
where (x < y and 1 = (select count(*) from functions as sub where func.x = sub.y and func.y = sub.x))
    or (x = y and 2 = (select count(*) from functions as sub where func.x = sub.y and func.y = sub.x))
group by x, y
order by x;