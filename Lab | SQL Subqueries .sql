-- How many copies of the film Hunchback Impossible exist in the inventory system?
-- FILM, tiltel.film, Where tiltel.film = "Hunchback Impossible", INVENTORY 

Select * -- Join tables
FROM FILM 
LEFT JOIN INVENTORY
ON FILM.film_id = INVENTORY.film_id;
 
Select FILM.title,INVENTORY.inventory_id  -- Show columns
FROM FILM 
LEFT JOIN INVENTORY
ON FILM.film_id = INVENTORY.film_id;

SELECT FILM.title, INVENTORY.inventory_id -- filter "Hunchback Impossible"
FROM FILM 
LEFT JOIN INVENTORY
ON FILM.film_id = INVENTORY.film_id
WHERE FILM.title = "Hunchback Impossible";

-- Error -- I just need to remove "INVENTORY.inventory_id" because is not in the grup by and not in the agregation (SUM,MAX,COUNT). 

SELECT FILM.title, INVENTORY.inventory_id, count(FILM.title) AS Count_inventory -- count films inventory and grop by
FROM FILM 
LEFT JOIN INVENTORY
ON FILM.film_id = INVENTORY.film_id
WHERE FILM.title = "Hunchback Impossible"
Group by FILM.title;

-- 
SELECT FILM.title,count(FILM.title) AS Count_inventory -- count films inventory and grop by
FROM FILM 
LEFT JOIN INVENTORY
ON FILM.film_id = INVENTORY.film_id
WHERE FILM.title = "Hunchback Impossible"
Group by FILM.title;


-- chat gdp 
SELECT FILM.title, COUNT(INVENTORY.inventory_id) AS inventory_count
FROM FILM 
LEFT JOIN INVENTORY
ON FILM.film_id = INVENTORY.film_id
GROUP BY FILM.title;

-- Chap gdp + Ben (I have doubts)
SELECT FILM.title, COUNT(INVENTORY.inventory_id) AS inventory_count
FROM FILM 
LEFT JOIN INVENTORY
ON FILM.film_id = INVENTORY.film_id
WHERE FILM.title = "Hunchback Impossible"
GROUP BY FILM.title;

-- List all films whose length is longer than the average of all the films.
-- FILM, film.lenght, avg off all films

SELECT *  -- Show film table
FROM FILM;  

SELECT title,length -- Show colums 
FROM FILM;  

SELECT title,length, avg(length) AS avg_length -- Show colums 
FROM FILM  
GROUP BY length;


SELECT avg(length) AS avg_length -- Show colums 
FROM FILM;

SELECT * 
FROM FILM
WHERE length > (SELECT avg(length) AS avg_length  -- YOu have to put the query if before.
FROM FILM);

SELECT title,length
FROM FILM
WHERE length > (SELECT avg(length) AS avg_length  -- YOu have to put the query if before.
FROM FILM);

-- Use subqueries to display all actors who appear in the film Alone Trip.
-- FILM,ACTOR, actor.first_name, where film.title = "Alone Trip"
-- ON FILM.FILM_ID = 

SELECT *
FROM FILM

SELECT *
FROM FILM
LEFT JOIN FILM_ACTOR ON FILM.film_id = FILM_ACTOR.film_id

SELECT *
FROM FILM
LEFT JOIN FILM_ACTOR ON FILM.film_id = FILM_ACTOR.film_id
LEFT JOIN actor ON FILM_ACTOR.actor_id = actor.actor_id;

SELECT actor.first_name, film.title
FROM FILM
LEFT JOIN FILM_ACTOR ON FILM.film_id = FILM_ACTOR.film_id
LEFT JOIN actor ON FILM_ACTOR.actor_id = actor.actor_id;

SELECT actor.first_name, film.title
FROM FILM
LEFT JOIN FILM_ACTOR ON FILM.film_id = FILM_ACTOR.film_id
LEFT JOIN actor ON FILM_ACTOR.actor_id = actor.actor_id
WHERE film.title = "Alone Trip"


SELECT last_name, first_name
FROM actor
WHERE actor_id IN (
  SELECT actor_id
  FROM film_actor
  WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'
  )
);


-- 1
SELECT film_id
    FROM film
    WHERE title = 'Alone Trip';
-- 2
SELECT actor_id
  FROM film_actor
  WHERE film_id = 17;
  
  -- 3
  SELECT actor_id
  FROM film_actor
  WHERE film_id = (SELECT film_id
    FROM film
    WHERE title = 'Alone Trip');
    
-- 4 error
SELECT *
FROM actor
WHERE actor_id = (SELECT actor_id
  FROM film_actor
  WHERE film_id = (SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'));
    
-- 5 error  -- If is has more than one row you don't put = you put IN 

SELECT *
FROM actor
WHERE actor_id IN (SELECT actor_id
  FROM film_actor
  WHERE film_id = (SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'));

-- 
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
  FROM film_actor
  WHERE film_id = (SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'));
    


-- Use subqueries to display all actors who appear in the film Alone Trip.
  
SELECT *
FROM film;

SELECT *
FROM film
WHERE title = "Alone Trip";

SELECT film_id
FROM film
WHERE title = "Alone Trip";    

SELECT *
FROM film_actor;

SELECT *
FROM film_actor
WHERE FILM_id = 17;

SELECT *
FROM film_actor
WHERE FILM_id = (SELECT film_id
FROM film
WHERE title = "Alone Trip"); 


SELECT actor_id
FROM film_actor
WHERE FILM_id = (SELECT film_id
FROM film
WHERE title = "Alone Trip"); 

SELECT *
FROM actor;

SELECT *
FROM actor
WHERE actor_id IN (SELECT actor_id
FROM film_actor
WHERE FILM_id = (SELECT film_id
FROM film
WHERE title = "Alone Trip")); 


SELECT actor_id,first_name,last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
FROM film_actor
WHERE FILM_id = (SELECT film_id
FROM film
WHERE title = "Alone Trip"));

-- Sales have been lagging among young families,
-- and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
-- FILM
SELECT title
FROM film
WHERE rating = 'G' OR rating = 'PG';

-- Get name and email from customers from Canada using subqueries. 
-- Do the same with joins. Note that to create a join, you will have 
-- to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

-- CUSTOMER, customer.fist_name, customer.name: customer,

-- LEFT JOIN

SELECT * 
FROM CUSTOMER
LEFT JOIN ADDRESS ON CUSTOMER.ADDRESS_ID = ADDRESS.ADDRESS_ID
LEFT JOIN CITY ON CITY.CITY_ID = ADDRESS.CITY_ID
LEFT JOIN COUNTRY ON COUNTRY.COUNTRY_ID = CITY.COUNTRY_ID;

SELECT CUSTOMER.first_name,CUSTOMER.email,country.country
FROM CUSTOMER
LEFT JOIN ADDRESS ON CUSTOMER.ADDRESS_ID = ADDRESS.ADDRESS_ID
LEFT JOIN CITY ON CITY.CITY_ID = ADDRESS.CITY_ID
LEFT JOIN COUNTRY ON COUNTRY.COUNTRY_ID = CITY.COUNTRY_ID;

SELECT CUSTOMER.first_name,CUSTOMER.email,country.country
FROM CUSTOMER
LEFT JOIN ADDRESS ON CUSTOMER.ADDRESS_ID = ADDRESS.ADDRESS_ID
LEFT JOIN CITY ON CITY.CITY_ID = ADDRESS.CITY_ID
LEFT JOIN COUNTRY ON COUNTRY.COUNTRY_ID = CITY.COUNTRY_ID
WHERE country = "Canada";

-- Subqueries

-- Get name and email from customers from Canada using subqueries. 
-- Do the same with joins. Note that to create a join, you will have 
-- to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT cust.first_name, cust.email, "Canada" as country FROM customer as cust WHERE cust.address_id in (
	SELECT addr.address_id FROM address as addr WHERE addr.city_id in (
		SELECT c.city_id FROM city as c WHERE c.country_id in (
			SELECT country_id FROM country WHERE country = "Canada"
		)
	)
);

-- Which are the films starred by the most prolific actor? Most prolific actor is defined as the actor that has 
-- acted in the most number of films. First you will have to find the most prolific actor and then use
-- that actor_id to find the different films that he/she starred.

SELECT *
FROM film as f
JOIN (
	SELECT fa.*
    FROM film_actor as fa
    JOIN (
		SELECT inner_fa.actor_id FROM film_actor as inner_fa
        GROUP BY inner_fa.actor_id
        ORDER BY COUNT(inner_fa.actor_id) DESC
        LIMIT 1
	) subq_fa ON subq_fa.actor_id = fa.actor_id
) subq ON f.film_id = subq.film_id
JOIN actor act ON act.actor_id = subq.actor_id;



SELECT *
FROM film_actor
WHERE actor_id in (SELECT max(actor_id) FROM film_actor GROUP BY actor_id);

SELECT actor_id FROM film_actor GROUP BY actor_id ORDER BY COUNT(actor_id) desc LIMIT 1;

-- BRUNO AND BEN

WITH prolific_actor as (
	SELECT actor_id,COUNT(actor_id) AS count_actor_id
	FROM film_actor fa 
	GROUP BY actor_id
	ORDER BY count_actor_id DESC 
	LIMIT 1)
SELECT f.*
FROM film_actor fa
JOIN prolific_actor ON prolific_actor.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id; 


-- Films rented by most profitable customer. You can use the customer table and payment 
-- table to find the most profitable customer ie the customer that has made the largest sum of payments

-- Films rented by most profitable customer. You can use the customer table and payment 
-- table to find the most profitable customer ie the customer that has made the largest sum of payments

-- Find the customer that has made the most amount of payments


SELECT * 
FROM customer c;

SELECT * 
FROM payment p ;

SELECT payment_id, customer_id, amount
FROM payment p ;

SELECT customer_id, amount
FROM payment p ;

SELECT customer_id, COUNT(amount) as count_amount_of_payments
From payment p 
GROUP BY customer_id
Order BY count_amount_of_payments DESC
LIMIT 1;

SELECT * 
FROM customer c;

SELECT *
FROM film f ;

SELECT *
FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN customer c ON r.customer_id = c.customer_id;

SELECT f.film_id,c.customer_id 
FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN customer c ON r.customer_id = c.customer_id;

SELECT f.film_id,c.customer_id 
FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN customer c ON r.customer_id = c.customer_id
WHERE c.customer_id IN ((SELECT customer_id, COUNT(amount) as count_amount_of_paymentsFrom payment p GROUP BY customer_idOrder BY count_amount_of_payments DESC LIMIT 1));


SELECT f.film_id,c.customer_id 
FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN customer c ON r.customer_id = c.customer_id
WHERE c.customer_id IN (
  SELECT customer_id, COUNT(amount) as count_amount_of_payments 
  FROM payment p 
  GROUP BY customer_id 
  ORDER BY count_amount_of_payments DESC 
  LIMIT 1
);



