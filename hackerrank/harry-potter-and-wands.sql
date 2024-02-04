-- https://www.hackerrank.com/challenges/harry-potter-and-wands/problem
/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed
to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed,
and power of the wands that Ron's interested in, sorted in order of descending power.
If more than one wand has same power, sort the result in order of descending age.
*/

with nonevil as (
select id, age, coins_needed as coins, power
from wands
    inner join wands_property as props on props.code = wands.code
where is_evil = 0
),

with_rows as 
(
select id, age, coins, power,
    ROW_NUMBER() OVER(PARTITION BY age, power ORDER BY coins) AS idx -- TODO: find a better solution to avoid window func usage
from nonevil
)

select id, age, coins, power
from with_rows
where idx = 1
order by power desc, age desc;