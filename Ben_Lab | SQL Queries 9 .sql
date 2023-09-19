USE SAKILA;
-- Create a table rentals_may to store the data from rental table with information for the month of May.
CREATE TABLE rentals_may (
	rental_id INT UNIQUE NOT NULL,
	rental_date VARCHAR(255),
	inventory_id INT,
	customer_id INT,
	return_date VARCHAR(255),
	staff_id INT,
	last_update VARCHAR(255),
	PRIMARY KEY (rental_id) -- Corrected placement of PRIMARY KEY constraint
);
-- 2. Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
INSERT INTO rentals_may (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update
FROM rental
WHERE SUBSTRING(rental_date, 6, 2) = '05';
-- 3. Create a table rentals_june to store the data from rental table with information for the month of June.
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
WHERE MONTH(rental_date) = 6  -- Filter for the month of June
GROUP BY customer_id
ORDER BY rental_count DESC;  -- Optional: Order the results by rental count in descending order

-- 4. Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
INSERT INTO rentals_june (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
SELECT rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update
FROM rental
WHERE MONTH(rental_date) = 6;

-- 5. Check the number of rentals for each customer for May.
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
WHERE MONTH(rental_date) = 5  -- Filter for the month of May
GROUP BY customer_id
ORDER BY rental_count DESC;  -- Optional: Order the results by rental count in descending order

-- 6. Check the number of rentals for each customer for June.

SELECT customer_id, COUNT(*) AS rental_count
FROM rental
WHERE MONTH(rental_date) = 6 
GROUP BY customer_id
ORDER BY rental_count DESC; 


