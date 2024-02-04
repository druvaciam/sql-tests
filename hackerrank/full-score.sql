-- https://www.hackerrank.com/challenges/full-score/problem
/*
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
*/

with submission_cte as (
select submissions.hacker_id
from submissions
    inner join challenges on challenges.challenge_id = submissions.challenge_id
    inner join difficulty on difficulty.difficulty_level = challenges.difficulty_level
where submissions.score = difficulty.score -- full scores filter
),

winners_cte as (
select hacker_id, count(*) as win_count
from submission_cte
group by hacker_id
having count(*) > 1
)
 
select win.hacker_id, hackers.name
from winners_cte as win
    inner join hackers on hackers.hacker_id = win.hacker_id
order by win_count desc, hacker_id;