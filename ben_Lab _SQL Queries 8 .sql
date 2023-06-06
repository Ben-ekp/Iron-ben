-- 1 Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT * FROM sakila.film
SELECT title, length, RANK() OVER (ORDER BY length DESC) as "Rank" 
FROM sakila.film;
/*2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
 In your output, only select the columns title, length, rating and rank.*/
-- 
/*3. How many films are there for each of the categories in the category table? 
Hint: Use appropriate join between the tables "category" and "film_category".*/

select * from sakila.film a
join sakila.film  on a.account_id = l.account_id -- inner join -- using (account_id)
where l.duration = 12
order by l.payments;


/*4. Which actor has appeared in the most films? Hint: You can create a join 
between the tables "actor" and "film actor" and count the number of times an actor appears. */
select * from sakila.film  -- Films (title)
select * from sakila.actor  -- Actor (first_name) 
select * from sakila.film_actor  -- Actor id (first_name) 
--
SELECT first_name AS Name,last_name AS `Last name`, count(Table_1.actor_id) AS MOST_FILMS 
FROM actor AS Table_1 -- Table 1 
JOIN film_actor AS Table_2 ON Table_1.actor_id = Table_2.actor_id
GROUP BY Table_1.actor_id
ORDER BY MOST_FILMS  DESC
LIMIT 1;

/* NOTES for me

-- This sin alies
SELECT *
FROM sakila.actor  -- Table 1 
JOIN sakila.film_actor ON  sakila.actor.actor_id = sakila.film_actor.actor_id; 

-- Use this for alies
SELECT *
FROM sakila.actor AS Table_1 -- Table 1 
JOIN sakila.film_actor AS Table_2 ON Table_1.actor_id = Table_2.actor_id;


--
SELECT first_name,last_name, count(Table_1.actor_id) 
FROM sakila.actor AS Table_1 -- Table 1 
JOIN sakila.film_actor AS Table_2 ON Table_1.actor_id = Table_2.actor_id
GROUP BY Table_1.actor_id
ORDER BY count(Table_1.actor_id) DESC
LIMIT 1;

-- Alias 
 
SELECT first_name AS Name,last_name AS `Last name`, count(Table_1.actor_id) AS MOST_FILMS 
FROM sakila.actor AS Table_1 -- Table 1 
JOIN sakila.film_actor AS Table_2 ON Table_1.actor_id = Table_2.actor_id
GROUP BY Table_1.actor_id
ORDER BY MOST_FILMS  DESC
LIMIT 1;





SELECT first_name AS Name,last_name AS `Last name`, count(Table_1.actor_id) AS MOST_FILMS 
FROM actor AS Table_1 -- Table 1 
JOIN film_actor AS Table_2 ON Table_1.actor_id = Table_2.actor_id
GROUP BY Table_1.actor_id
ORDER BY MOST_FILMS  DESC
LIMIT 1;


/*5.Which is the most active customer (the customer that has rented the most number of films)? 
Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer. */
select * from sakila.customer  -- customers (title)
select * from sakila.rental  -- rental (first_name) 
-- They have in commun customer ID 

SELECT first_name, rental_id, count(rental_id)
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY rental_id
ORDER BY rental_id DESC
LIMIT 1;











