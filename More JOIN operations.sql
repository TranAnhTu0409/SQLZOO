--More JOIN operations

--MOVIE DATABASE
--This database features two entities (movies and actors) in a many-to-many relation. Each entity has its own table. A third table, casting , is used to link them. The relationship is many-to-many because each film features many actors and each actor has appeared in many films.

--movie
--Field name	Type     	Notes
--id	        INTEGER	    An arbitrary unique identifier
--title	    CHAR(70)	The name of the film - usually in the language of the first release.
--yr	        DECIMAL(4)	Year of first release.
--director	INT	        A reference to the actor table.
--budget	    INTEGER	    How much the movie cost to make (in a variety of currencies unfortunately).
--gross	    INTEGER	    How much the movie made at the box office.

--Example
--id	    title	                yr	    director	budget	    gross
--10003	"Crocodile" Dundee II	1988	38	        15800000	239606210
--10004	"Til There Was You"	    1997	49	        10000000	

--actor
--Field name	Type	    Notes
--id	        INTEGER	    An arbitrary unique identifier
--name	    CHAR(36)	The name of the actor (the term actor is used to refer to both male and female thesps.)

--Example
--id	name
--20	Paul Hogan
--50	Jeanne Tripplehorn

--casting
--Field name	                Type	    Notes
--movieid	                    INTEGER	    A reference to the movie table.
--actorid						INTEGER	    A reference to the actor table.
--ord							INTEGER	    The ordinal position of the actor in the cast list. 
--                                        The star of the movie will have ord value 1 the
--										co-star will have value 2, ...

--Example
--movieid	actorid	ord
--10003	20	4
--10004	50	1

--1962 movies
--1.
--List the films where the yr is 1962 [Show id, title]
select id, title
from movie
where yr = 1962

--When was Citizen Kane released?
--2.
--Give year of 'Citizen Kane'.
select yr
from movie 
where title = 'Citizen Kane'

--Star Trek movies
--3.
--List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
select id, title, yr
from movie
where title LIKE 'Star Trek%' order by yr asc

--id for actor Glenn Close
--4.
--What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close'

--id for Casablanca
--5.
--What is the id of the film 'Casablanca'
select id
from movie
where title = 'Casablanca'

--Cast list for Casablanca
--6.
--Obtain the cast list for 'Casablanca'.
--what is a cast list?
--The cast list is the names of the actors who were in the movie.
--Use movieid=11768, (or whatever value you got from the previous question)
select actor.name
from casting inner join movie
on casting.movieid = movie.id
inner join actor
on movie.id = actor.id
where casting.movieid = 11768	

--Alien cast list
--7.
--Obtain the cast list for the film 'Alien'
select actor.name
from casting inner join movie
on casting.movieid = movie.id
inner join actor
on casting.actorid = actor.id
where movie.title = 'Alien'

--Harrison Ford movies
--8.
--List the films in which 'Harrison Ford' has appeared
select movie.title
from movie inner join casting
on movie.id = casting.movieid
inner join actor
on casting.actorid = actor.id
where actor.name = 'Harrison Ford'

--Harrison Ford as a supporting actor
--9.
--List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
select movie.title
from movie inner join casting
on movie.id = casting.movieid
inner join actor
on casting.actorid = actor.id
where actor.name = 'Harrison Ford' and casting.ord != 1

--Lead actors in 1962 movies
--10.
--List the films together with the leading star for all 1962 films.
select movie.title, actor.name
from movie inner join casting
on movie.id = casting.movieid
inner join actor
on casting.actorid = actor.id
where movie.yr = 1962 and casting.ord = 1

--Busy years for Rock Hudson
--11.
--Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
select movie.yr, count(*)
from movie inner join casting
on movie.id = casting.movieid
inner join actor
on casting.movieid = actor.id
where actor.name = 'Rock Hudson' 
group by movie.yr
having count(movie.title) > 2

--Lead actor in Julie Andrews movies
--12.
--List the film title and the leading actor for all of the films 'Julie Andrews' played in.
--Did you get "Little Miss Marker twice"?
--Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).
--Title is not a unique field, create a table of IDs in your subquery

select movie.title, actor.name
from movie inner join casting
on movie.id = casting.movieid
inner join actor
on casting.actorid = actor.id
where movieid in (select movieid
from casting inner join actor
on casting.actorid = actor.id
where name = 'Julie Andrews') and ord = 1

