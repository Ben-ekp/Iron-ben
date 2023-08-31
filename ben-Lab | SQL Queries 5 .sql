-- 1. Drop column picture from staff.--
USE SAKILA;
SELECT * FROM staff;
ALTER TABLE staff DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.--
SELECT first_name, last_name, address_id, email, store_id, active 
FROM sakila.customer
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

INSERT INTO sakila.staff (first_name, last_name, address_id, email, store_id, active, username) 
SELECT first_name, last_name, address_id, email, store_id, active, 'tammy'
FROM sakila.customer
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

-- 3.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
You can use current date for the rental_date column in the rental table. Hint: Check the columns 
in the table rental and see what information you would need to add there. You can query those 
pieces of information. For eg., you would notice that you need customer_id information as well.

SELECT * FROM sakila.film
WHERE title = "Academy Dinosaur";
SELECT * FROM sakila.inventory
WHERE film_id = 1;
SELECT * FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';
SELECT * FROM sakila.staff
WHERE store_id = 1;

INSERT INTO sakila.rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (current_date(),1,130,current_date()+6, 1);

-- 4.Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted.
SELECT * FROM sakila.customer
WHERE active = 0;
CREATE TABLE delete_users (
    customer_id int,
    email varchar(50),
    last_aupdate TIMESTAMP
);
INSERT INTO sakila.delete_users (customer_id, email, last_aupdate) 
SELECT customer_id, email, current_date() FROM sakila.customer
WHERE active = 0;
DELETE FROM sakila.customer 
WHERE active = 0;


