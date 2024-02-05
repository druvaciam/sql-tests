-- https://www.hackerrank.com/challenges/draw-the-triangle-1/problem
/*
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* * * * *
* * * *
* * * 
* * 
*
Write a query to print the pattern P(20).
*/

with nums as (
    select 20 num union all
    select 19 num union all
    select 18 num union all
    select 17 num union all
    select 16 num union all
    select 15 num union all
    select 14 num union all
    select 13 num union all
    select 12 num union all
    select 11 num union all
    select 10 num union all
    select 9 num union all
    select 8 num union all
    select 7 num union all
    select 6 num union all
    select 5 num union all
    select 4 num union all
    select 3 num union all
    select 2 num union all
    select 1 num
)

select REPLICATE('* ', num)
from nums;