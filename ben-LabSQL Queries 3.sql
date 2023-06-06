-- How many distinct (different) actors' last names are there?
select * from sakila.actor
select last_name from sakila.actor

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)

 select count(language_id) AS "Fimls_Orginal" from sakila.language;
 
-- How many movies were released with "PG-13" rating?
SELECT COUNT(rating) AS customers_in_UK -- Rating = Columna AS Es como 	quieres que se llame ese resultado
FROM sakila.film -- Sakila.film es la base de datos 
WHERE rating = 'PG-13'; -- WHERE rating = 'PG-13' eso quiere decir que dentro de la columna rating busca 'PG-13'
-- 
-- Get 10 the longest movies from 2006.
SELECT MAX(length),release_year
FROM sakila.film
WHERE release_year = 2006
LIMIT 10;
-- CHAT GDP HELP Why I need to add the order by?
SELECT length, release_year
FROM sakila.film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10;

--
-- How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF('2006-02-14','2005-05-25') AS days_difference

-- Show rental info with additional columns month and weekday. Get 20.
SELECT MONTHNAME(rental_date) AS month, DAYNAME(rental_date) AS day_of_week
FROM sakila.rental
LIMIT 20;
