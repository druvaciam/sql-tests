-- https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem
/*
Julia conducted a  days of learning SQL contest.
The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest),
and find the hacker_id and name of the hacker who made maximum number of submissions each day.
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id.
The query should print this information for each day of the contest, sorted by the date.
*/

-- MS SQL

with daynum as (
    select datediff(day, '2016-03-01', submission_date) + 1 as day,
           submission_date, hacker_id
    from (select submission_date, hacker_id from submissions group by submission_date, hacker_id) as subm
),

unique_hackers as (
    select submission_date, count(hacker_id) as uniq_count
    from daynum as dn
    where day = (select count(*) from daynum where day <= dn.day and hacker_id = dn.hacker_id)
    group by submission_date
),

sub_per_hacker as (
    select submission_date, hacker_id, count(submission_id) as subm_count,
        ROW_NUMBER() OVER(PARTITION BY submission_date ORDER BY count(submission_id) desc, hacker_id) AS idx
    from submissions
    group by hacker_id, submission_date
),

max_sub_hackers as (
    select submission_date, hackers.hacker_id, hackers.name
    from sub_per_hacker
        inner join hackers on sub_per_hacker.hacker_id = hackers.hacker_id
    where idx = 1
)

select unique_hackers.submission_date, uniq_count, hacker_id, name
from unique_hackers
    inner join max_sub_hackers on max_sub_hackers.submission_date = unique_hackers.submission_date
order by submission_date;