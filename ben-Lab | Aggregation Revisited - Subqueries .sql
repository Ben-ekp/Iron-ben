USE SAKILA
-- Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT c.first_name,c.last_name,c.email
FROM customer c
LEFT JOIN rental r ON c.customer_ID = r.customer_ID
-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.email,
    c.customer_id,
    AVG(p.amount) AS average_payment
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, full_name, c.email;
-- Select the name and email address of all the customers who have rented the "Action" movies.
-- Write the query using multiple join statements
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';
-- Write the query using sub queries with multiple WHERE clause and IN condition
SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (
    SELECT DISTINCT r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Action'
);

-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
SELECT
    payment_id,
    amount,
    CASE
        WHEN amount BETWEEN 0 AND 2 THEN 'low'
        WHEN amount BETWEEN 2 AND 4 THEN 'medium'
        WHEN amount > 4 THEN 'high'
    END AS payment_label
FROM payment;
