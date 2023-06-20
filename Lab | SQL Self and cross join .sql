-- 1. Get all pairs of actors that worked together.
-- 	

SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE T1.column_name = T2.column_name;

-- Find the customers that are from the same district:
select * from bank.account;

select * from bank.account a1
join bank.account a2
on a1.district_id = a2.district_id
order by a1.district_id, a1.account_id,a2.account_id;

SELECT *
FROM actor AC1
JOIN actor AC2
ON AC1.actor_id = AC2.actor_id;

WHERE AC1.actor = AC2.actor;


SELECT AC1.actor_id,AC1.first_name
FROM actor AC1, actor AC2
WHERE AC1.actor = AC2.actor;


SELECT FIRST_NAME, LAST_NAME,ADDRESS.ADDRESS 
FROM STAFF
LEFT JOIN ADDRESS
ON STAFF.address_id = ADDRESS.address_id;







-- 3. Get all possible pairs of actors and films.
SELECT DISTINCT fa1.actor_id, fa2.actor_id
FROM film_actor fa1
CROSS JOIN film_actor fa2
WHERE fa1.actor_id < fa2.actor_id
AND fa1.film_id = fa2.film_id;
