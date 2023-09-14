USE SAKILA;
-- List the number of films per category.
SELECT c.name AS Category, COUNT(fc.film_id) AS NumberOfFilms
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY COUNT(fc.film_id) DESC
-- Display the first and the last names, as well as the address, of each staff member.--
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a ON s.address_id = a.address_id;
-- Display the total amount rung up by each staff member in August 2005. --

-- List all films and the number of actors who are listed for each film. --
SELECT f.film_id, f.title, COUNT(fa.actor_id) AS NumberOfActors
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title
ORDER BY NumberOfActors DESC;

-- Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.-- 

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS TotalAmountPaid
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.last_name ASC, c.first_name ASC;



