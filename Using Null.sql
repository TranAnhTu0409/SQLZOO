--teacher
--id	  dept	name	    phone	mobile
--101	  1  	Shrivell    2753	07986 555 1234
--102	  1	    Throd	    2754	07122 555 1920
--103	  1	    Splint	    2293	
--104		    Spiregrain	3287	
--105	  2	    Cutflower	3212	07996 555 6574
--106		    Deadyawn	3345	
--...
--dept
--id	name
--1	Computing
--2	Design
--3	Engineering

--NULL, INNER JOIN, LEFT JOIN, RIGHT JOIN
--1.
--List the teachers who have NULL for their department.

--Why we cannot use =
--You might think that the phrase dept=NULL would work here but it doesn't - you can use the phrase dept IS NULL
select name
from teacher 
where dept is NULL

--2.
--Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
select teacher.name, dept.name
from teacher inner join dept
on teacher.dept = dept.id

--3.
--Use a different JOIN so that all teachers are listed.
select teacher.name, dept.name
from teacher left join dept
on teacher.dept = dept.id

--4.
--Use a different JOIN so that all departments are listed.
select teacher.name, dept.name
from teacher right join dept
on teacher.dept = dept.id

--COALESCE
--COALESCE takes any number of arguments and returns the first value that is not null.

--  COALESCE(x,y,z) = x if x is not NULL
--  COALESCE(x,y,z) = y if x is NULL and y is not NULL
--  COALESCE(x,y,z) = z if x and y are NULL but z is not NULL
--  COALESCE(x,y,z) = NULL if x and y and z are all NULL

--5.
--Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
select teacher.name, COALESCE(teacher.mobile, '07986 444 2266') 
from teacher left join dept
on teacher.dept = dept.id

--6.
--Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
select teacher.name, COALESCE(dept.name, 'None')
from teacher left join dept
on teacher.dept = dept.id

--7.
--Use COUNT to show the number of teachers and the number of mobile phones.
select count(teacher.name), count(teacher.mobile)
from teacher

--8.
--Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
select dept.name, count(teacher.name)
from teacher right join dept
on teacher.dept = dept.id
group by dept.name

--9.
--Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
select name,
CASE when dept = 1 or dept = 2 then 'Sci'
else 'Art'
end
from teacher

--10.
--Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
select name, 
CASE when dept in (1, 2) then 'Sci'
when dept = 3 then 'Art'
else 'None'
end
from teacher
