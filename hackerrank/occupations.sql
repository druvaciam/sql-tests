-- https://www.hackerrank.com/challenges/occupations/problem
/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically
and displayed underneath its corresponding Occupation.
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.
*/
-- MySQL

SET @idx1 = 0, @idx2 = 0, @idx3 = 0, @idx4 = 0;

with doctors as (
    select (@idx1:=@idx1 + 1) AS idx, name
    from occupations
    where occupation = 'Doctor'
    order by name),
    
professors as (
    select (@idx2:=@idx2 + 1) AS idx, name
    from occupations
    where occupation = 'Professor'
    order by name),
    
singers as (
    select (@idx3:=@idx3 + 1) AS idx, name
    from occupations
    where occupation = 'Singer'
    order by name),
    
actors as (
    select (@idx4:=@idx4 + 1) AS idx, name
    from occupations
    where occupation = 'Actor'
    order by name)

select doctors.name, professors.name, singers.name, actors.name
from doctors
     right join professors using (idx) -- TODO: use full join
     left join singers  using (idx)
     left join actors  using (idx);