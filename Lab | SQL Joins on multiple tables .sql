-- 1. Write a query to display for each store its store ID, city, and country.
-- store (store_id),city (city), and country (country)

SELECT store.store_id, city.city, country.country
FROM store 
LEFT JOIN address
ON store.address_id = address.address_id
LEFT JOIN city
ON city.city_id = address.city_id
LEFT JOIN country
ON country.country_id = city.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
-- store.store_id, staffAFF, payment.amount 

SELECT store.store_id,SUM(payment.amount) as total_rev_per_store
FROM store 
LEFT JOIN staff
ON store.store_id = staff.store_id
LEFT JOIN payment
ON payment.staff_id = staff.staff_id
GROUP BY store_id;

-- 3. What is the average running time of films by category?
-- FILM film.lengh, film.title, film_id, FILM_CATEGORY, CATEGORY category.name   AVG(film.lengh) as film_average_running_time

-- BEN

SELECT category.name,AVG(film.length)
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name; -- will normally be in the SELECT 



-- 4. Which film categories are longest?

-- BEN 
SELECT film.title,category.name,SUM(film.length) as longest_film
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON category.category_id = film_category.category_id
GROUP BY film.length;

-- Chat GDP
SELECT category.name, AVG(film.length) as avg_length
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY avg_length DESC;

-- 5. Display the most frequently rented movies in descending order.
-- BEN
SELECT *
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id;


SELECT film.title, payment.amount
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id;

SELECT film.title, payment.amount
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY payment.amount


-- CHATGDP 

SELECT film.title, COUNT(*) AS rental_count
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC;







-- 6. List the top five genres in gross revenue in descending order.
-- category.name
-- 1 Join tables
SELECT *
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id;

-- 2 select colums
SELECT category.name,payment.amount, 
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id;


-- 2 adding rev in €
SELECT category.name,CONCAT('€', payment.amount) AS rev_euro_amount
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name;

-- 3 Grop by category.name

-- We you are doing a GROUP BY make sure tou add the aggregaded funtion to the group by 
-- Old version 
SELECT category.name, CONCAT('€', payment.amount) AS rev_euro_amount
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name;

-- New version

SELECT category.name, CONCAT('€', payment.amount) AS rev_euro_amount
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name, payment.amount;

-- 4 Addong descending order.
SELECT category.name, CONCAT('€', sum(payment.amount)) AS rev_euro_amount
FROM film_category
LEFT JOIN category ON category.category_ID = film_category.category_ID
LEFT JOIN film ON film_category.film_id = film.film_id 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY rev_euro_amount DESC;


https://chat.openai.com/share/7a445bbd-483c-4726-87a1-117528606c72

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
-- FILM, INVENTORY, STORE, RENTAL

-- film.title, inventory.inventory_id, store.sotre_id, rental.inventory_id

SELECT *
FROM film 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN store ON inventory.store_id = store.store_id
LEFT JOIN rental ON inventory.store_id = store.store_id
WHERE film.title = "Academy Dinosaur" and store.store_id = 1;



-- CHAT GDP
SELECT film.title, inventory.inventory_id
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN store ON inventory.store_id = store.store_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id;



SELECT film.title,inventory.inventory_id,store.store_id     -- 
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN store ON inventory.store_id = store.store_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id;



SELECT film.title, COUNT(film.title) AS Number_films    -- inventory.inventory_id,store.store_id     -- 
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN store ON inventory.store_id = store.store_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title;




