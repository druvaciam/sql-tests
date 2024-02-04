-- https://www.hackerrank.com/challenges/challenges/problem
/*
Julia asked her students to create some coding challenges.
Write a query to print the hacker_id, name, and the total number of challenges created by each student.
Sort your results by the total number of challenges in descending order.
If more than one student created the same number of challenges, then sort the result by hacker_id.
If more than one student created the same number of challenges and the count is less than the maximum number
of challenges created, then exclude those students from the result.
*/

with count_cte as (
select hacker_id, count(challenge_id) as created_count
from challenges
group by hacker_id
),

allowed_count as (
select created_count
from count_cte
group by created_count
having count(hacker_id) = 1 or created_count = (select max(created_count) from count_cte)
)

select hackers.hacker_id, hackers.name, created_count
from count_cte
    inner join hackers on hackers.hacker_id = count_cte.hacker_id
where created_count in (select created_count from allowed_count)
order by created_count desc, hacker_id;