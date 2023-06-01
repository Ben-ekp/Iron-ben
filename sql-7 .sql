/* 1. In the table actor, which are the actors whose last names are not repeated? 
For example if you would sort the data in the table actor by last_name, you would 
see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
These three actors have the same last name. So we do not want to 
include this last name in our output. Last name "Astaire" is
 present only one time with actor "Angelina Astaire", 
 hence we would want this in our output list.*/
 
 -- My reply --
select * from sakila.actor;
select last_name
from sakila.actor
group by last_name
order by last_name ASC;

-- My reply using CHATGDP -- 
select last_name, count(*) as count 
from sakila.actor
group by last_name
HAVING COUNT(*) = 1;
-- I need to add COUNT and Having 


/* 2.Which last names appear more than once? We would use the same logic as in the 
previous question but this time we want to include the last names of the actors 
where the last name was present more than once.*/
select * from sakila.actor;
select last_name, count(*) as count 
from sakila.actor
group by last_name
HAVING COUNT(*) > 1;

/* 3. Using the rental table, find out how many rentals were processed by each employee.*/
select * from sakila.rental;
select rental_id, sum (rental_id) as "total sales"
from sakila.rental
group by rental_id;

/* 4. Using the film table, find out how many films were released each year.*/

Select release_year,COUNT(title) as "Films_Year" 
From sakila.film
Group by release_year
Order by Films_Year;

/*5. Using the film table, find out for each rating how many films were there.*/
select * from sakila.film;
--
Select rating,COUNT(rating) as "Films_Rating" 
From sakila.film
Group by rating
Order by Films_Rating;

/* 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places.*/
select * from sakila.film;
--
Select rating,round(avg(length),2) as "Mean_length" 
From sakila.film
Group by rating
Order by Mean_length;

/* 7. Which kind of movies (rating) have a mean duration of more than two hours?*/
select * from sakila.film;
--
SELECT rating, avg(rental_duration) "avg_rental"
FROM sakila.film
GROUP BY rating
ORDER BY avg_rental;