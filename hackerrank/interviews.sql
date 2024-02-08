-- https://www.hackerrank.com/challenges/interviews/problem
/*
Samantha interviews many candidates from different colleges using coding challenges and contests.
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions,
total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id.
Exclude the contest from the result if all four sums are .
Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.
*/

with sub_stats_sum as (
    select contests.contest_id,
           sum(sstats.total_submissions) as ts, sum(sstats.total_accepted_submissions) as tas
    from contests
        inner join colleges on contests.contest_id = colleges.contest_id
        inner join challenges on colleges.college_id = challenges.college_id
        inner join submission_stats as sstats on challenges.challenge_id = sstats.challenge_id
    group by contests.contest_id
),

view_stats_sum as (
    select contests.contest_id,
           sum(vstats.total_views) as tv, sum(vstats.total_unique_views) as tuv
    from contests
        inner join colleges on contests.contest_id = colleges.contest_id
        inner join challenges on colleges.college_id = challenges.college_id
        inner join view_stats as vstats on challenges.challenge_id = vstats.challenge_id
    group by contests.contest_id
)

select contests.contest_id, hacker_id, name, ts, tas, tv, tuv
from contests
    inner join sub_stats_sum on contests.contest_id = sub_stats_sum.contest_id
    inner join view_stats_sum on contests.contest_id = view_stats_sum.contest_id
where ts + tas + tv + tuv <> 0
order by contests.contest_id;