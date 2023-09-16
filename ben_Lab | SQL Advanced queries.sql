USE sakila;
-- List each pair of actors that have worked together.--
SELECT DISTINCT a1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
                a2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY actor1_id, actor2_id;

-- For each film, list actor that has acted in more films.

SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN (
  SELECT f.film_id, COUNT(fa.actor_id) AS actor_count
  FROM film f
  JOIN film_actor fa ON f.film_id = fa.film_id
  GROUP BY f.film_id
) AS film_actor_count ON f.film_id = film_actor_count.film_id
WHERE film_actor_count.actor_count = (
  SELECT MAX(actor_count)
  FROM (
    SELECT f.film_id, COUNT(fa.actor_id) AS actor_count
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    GROUP BY f.film_id
  ) AS subquery
)
ORDER BY f.film_id;