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