-- https://www.hackerrank.com/challenges/african-cities/problem
/*
Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
*/

select city.name
from city
    inner join country on city.countrycode = country.code
where continent = 'Africa';