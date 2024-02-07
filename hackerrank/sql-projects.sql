-- https://www.hackerrank.com/challenges/sql-projects/problem
/*
You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date.
It is guaranteed that the difference between the End_Date and the Start_Date
is equal to 1 day for each row in the table.

If the End_Date of the tasks are consecutive, then they are part of the same project.
Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days
it took to complete the project in ascending order.
If there is more than one project that have the same number of completion days,
then order by the start date of the project.
*/

-- notes:
-- mysql: DATE_ADD(end_date, INTERVAL -1 DAY)
-- mssql: DATEADD(day, -1, end_date)

SET @rowindex1 := -1, @rowindex2 := 0;

with indexed as (
    select @rowindex1:=@rowindex1 + 1 as rowindex1,
           @rowindex2:=@rowindex2 + 1 as rowindex2,
           start_date, end_date      
    from projects
    order by start_date
),

duplicated as (
    select t1.start_date as sd, t2.end_date as ed
    from indexed as t1
        left outer join indexed as t2 on t1.rowindex1 = t2.rowindex2

    union -- full join

    select t1.start_date as sd, t2.end_date as ed
    from indexed as t1
        right outer join indexed as t2 on t1.rowindex1 = t2.rowindex2
),

filtered as (
    select sd, ed
    from duplicated
    where sd <> ed or sd is null or ed is null
),

start_d as (select @rowindex2:=@rowindex2 + 1  as idx, sd from filtered), 
end_d as (select @rowindex1:=@rowindex1 + 1 as idx, ed from filtered)

select sd, ed
from start_d inner join end_d on start_d.idx = end_d.idx
order by ed-sd, sd;