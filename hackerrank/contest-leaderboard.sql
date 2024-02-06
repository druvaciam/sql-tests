-- https://www.hackerrank.com/challenges/contest-leaderboard/problem
/*
The total score of a hacker is the sum of their maximum scores for all of the challenges.
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score.
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id.
Exclude all hackers with a total score of  from your result.
*/

with hacker_challenge as (
    select hacker_id, challenge_id,  max(score) as max_score
    from submissions
    group by hacker_id, challenge_id
    ),
    
hacker_score as (
    select hacker_id, sum(max_score) as sum_score
    from hacker_challenge
    group by hacker_id
    )
    
select hacker_score.hacker_id,  hackers.name, hacker_score.sum_score
from hacker_score
    inner join hackers on hackers.hacker_id = hacker_score.hacker_id
where hacker_score.sum_score <> 0
order by sum_score desc, hacker_id;