--name	         continent	area	population	gdp
--Afghanistan	 Asia   	652230	25500100	20343000000
--Albania	     Europe	    28748	2831741	    12960000000
--Algeria	     Africa	    2381741	37100000	188681000000
--Andorra	     Europe	    468	    78115	    3712000000
--Angola	     Africa	    1246700	20609294	100990000000

/*
Bigger than Russia
1.
List each country name where the population is larger than that of 'Russia'.
*/
select name from world
where population > (select population from world where name = 'Russia')

/*
Richer than UK
2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
Per Capita GDP
The per capita GDP is the gdp/population
*/
select name from world
where continent = 'Europe' and gdp/population > (select gdp/population from world where name = 'United Kingdom')

/*
Neighbours of Argentina and Australia
3.
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
*/
select name, continent from world
where continent in (select continent from world where name in ('Argentina', 'Australia'))
order by name

/*
Between Canada and Poland
4.
Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
*/
select name, population from world
where population > (select population from world where name = 'United Kingdom') and population < (select population from world where name = 'Germany')

/*
Percentages of Germany
5.
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
The format should be Name, Percentage for example:
name	 percentage
Albania	 3%
Andorra	 0%
Austria	 11%
...	...
Decimal places
You can use the function ROUND to remove the decimal places.
Percent symbol %
You can use the function CONCAT to add the percentage symbol.
*/
SELECT name, CONCAT(ROUND((population*100)/(SELECT population FROM world WHERE name='Germany'), 0), '%') from world where continent='Europe'

/*
Bigger than every country in Europe
6.
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
*/
select name from world
where gdp > ALL(select gdp from world
where continent = 'Europe')

/*
Largest in each continent
7.
Find the largest country (by area) in each continent, show the continent, the name and the area:
*/
select continent, name, area from world x
where area >= ALL(select area from world y where x.continent = y.continent and y.area > 0)

/*
First country of each continent (alphabetically)
8.
List each continent and the name of the country that comes first alphabetically.
*/
SELECT continent, name FROM world x WHERE name <= ALL(SELECT name FROM world y WHERE x.continent = y.continent);

/*
Difficult Questions That Utilize Techniques Not Covered In Prior Sections
9.
Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
*/
select name , continent, population 
from world x
where 25000000 >= ALL(select population from world y
                   where x.continent = y.continent and population > 0)

/*
Three time bigger
10.
Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
*/
select name, continent from world x
where population / 3 > ALL(select population from world y
                         where x.continent = y.continent and x.name <> y.name)
