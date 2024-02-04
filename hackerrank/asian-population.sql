-- https://www.hackerrank.com/challenges/asian-population/problem
/*
Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
*/

select sum(city.population)
from city
    inner join country on city.countrycode = country.code
where continent = 'asia';