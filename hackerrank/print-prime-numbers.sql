-- https://www.hackerrank.com/challenges/print-prime-numbers/problem
/*
Write a query to print all prime numbers less than or equal to 1000.
Print your result on a single line, and use the ampersand () character as your separator (instead of a space).
For example, the output for all prime numbers  would be:
2&3&5&7
*/

with ones as (
    select 0 num union all
    select 1 num union all
    select 2 num union all
    select 3 num union all
    select 4 num union all
    select 5 num union all
    select 6 num union all
    select 7 num union all
    select 8 num union all
    select 9 num
),

nums as (
    select ones.num + 10 * tens.num + 100 * hundreds.num + 1 as num
    from ones as hundreds
    cross join ones as ones
    cross join ones as tens
),

pre_primes as (
    select n.num,
        (select count(nc.num)
         from nums as nc
         where (nc.num < n.num) and (n.num % nc.num = 0)
        ) as divisors_count
    from nums as n
),

primes as (
    select num
    from pre_primes
    where divisors_count = 1
)
 
select STRING_AGG(num, '&') -- within group (order by num)
from primes;