/*
name	    continent	area	population	gdp
Afghanistan	Asia	652230	    25500100	20343000000
Albania	    Europe	28748	    2831741	    12960000000
Algeria	    Africa	2381741	    37100000	188681000000
Andorra	    Europe	468	        78115   	3712000000
Angola	    Africa	1246700	    20609294	100990000000
...
*/

/*
Introduction
1.
Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries.
*/
select name, continent, population from world

/*
Large Countries
2.
How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
*/
select name from world 
where population >= 200000000

/*
Per capita GDP
3.
Give the name and the per capita GDP for those countries with a population of at least 200 million.
*/
select name, gdp/population  from world
where population >= 200000000

/*
South America In millions
4.
Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
*/
select name, population from world
where continent = 'South America'

/*
France, Germany, Italy
5.
Show the name and population for France, Germany, Italy
*/
select name, population 
from world
where name in ('France', 'Germany', 'Italy')

/*
United
6.
Show the countries which have a name that includes the word 'United'
*/
select name from world
where name LIKE '%United%'

/*
Two ways to be big
7.
Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
Show the countries that are big by area or big by population. Show name, population and area.
*/
select name,population, area from world
where area > 3000000 or population > 250000000

/*One or the other (but not both)
8.
Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded.
*/

select name, population, area from world
where (area > 3000000 AND population <= 250000000) OR (area <= 3000000 AND population > 250000000)	

/*
Rounding
9.
Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.

For South America show population in millions and GDP in billions both to 2 decimal places.
*/
select name, round(population/1000000, 2) as population, round(gdp/1000000000, 2) as gdp from world
where continent = 'South America'

/*
Trillion dollar economies
10.
Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

Show per-capita GDP for the trillion dollar countries to the nearest $1000.
*/
select name, round(gdp/population, -3)
from world
where gdp >= 1000000000000

/*
Name and capital have the same length
11.
Greece has capital Athens.
Each of the strings 'Greece', and 'Athens' has 6 characters.
Show the name and capital where the name and the capital have the same number of characters.
You can use the LENGTH function to find the number of characters in a string
For Microsoft SQL Server the function LENGTH is LEN
*/
select name, capital
from world
where LEN(name) = LEN(capital)

/*
Matching name and capital
12.
The capital of Sweden is Stockholm. Both words start with the letter 'S'.
Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
You can use the function LEFT to isolate the first character.
LEFT(s,n) allows you to extract n characters from the start of the string s.
 LEFT('Hello world', 4) -> 'Hell'   
 SELECT name,
       LEFT(name, 3)
  FROM bbc
You can use <> as the NOT EQUALS operator.
*/
select name, capital from world
where left(name, 1) = left(capital, 1) and name <> capital

/*
All the vowels
13.
Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.
Find the country that has all the vowels and no spaces in its name.
You can use the phrase name NOT LIKE '%a%' to exclude characters from your results.
The query shown misses countries like Bahamas and Belarus because they contain at least one 'a'
*/
select name from world
where name like '%a%'
and name like '%e%'
and name like '%i%'
and name like '%o%'
and name like '%u%'
and name NOT LIKE '% %'