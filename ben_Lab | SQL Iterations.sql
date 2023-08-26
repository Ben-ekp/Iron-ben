USE Sakila;
/*Write a query to find what is the total business done by each store.*/

SELECT s.store_id, SUM(pa.amount) AS total_business
FROM store s
LEFT JOIN inventory i ON s.store_id = i.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment pa ON r.rental_id = pa.rental_id
GROUP BY s.store_id;

/* Convert the previous query into a stored procedure.*/

DELIMITER //

CREATE PROCEDURE Business_Store()
BEGIN
    SELECT s.store_id, SUM(pa.amount) AS total_business
    FROM store s
    LEFT JOIN inventory i ON s.store_id = i.store_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment pa ON r.rental_id = pa.rental_id
    GROUP BY s.store_id;
END //

DELIMITER ;

CALL Business_Store();

/*Convert the previous query into a stored procedure that takes the 
input for store_id and displays the total sales for that store*/

DELIMITER //

CREATE PROCEDURE Business_Store(IN input_store_id INT)
BEGIN
    SELECT s.store_id, SUM(pa.amount) AS total_business
    FROM store s
    LEFT JOIN inventory i ON s.store_id = i.store_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN payment pa ON r.rental_id = pa.rental_id
    WHERE s.store_id = input_store_id
    GROUP BY s.store_id;
END //

DELIMITER ;

CALL Business_Store(1);

/*Update the previous query. Declare a variable total_sales_value of float type,
 that will store the returned result (of the total sales amount for the store). 
 Call the stored procedure and print the results.*/
 
 DELIMITER //

CREATE PROCEDURE Business_Store(IN input_store_id INT)
BEGIN
  DECLARE total_sales_value FLOAT;
  
  SELECT SUM(pa.amount) INTO total_sales_value
  FROM store s
  LEFT JOIN inventory i ON s.store_id = i.store_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  LEFT JOIN payment pa ON r.rental_id = pa.rental_id
  WHERE s.store_id = input_store_id;
  
  SELECT total_sales_value AS 'Total Business';
END //

DELIMITER ;

-- Call the stored procedure and print the results
CALL Business_Store(1);
CALL Business_Store(2);

 
 
 /*In the previous query, add another variable flag. If the total sales value for the store is over 30.000, 
 then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an 
 input as the store_id and returns total sales value for that store and flag value.*/
 
DELIMITER //

CREATE PROCEDURE Business_Store(IN input_store_id INT)
BEGIN
  DECLARE total_sales_value FLOAT;
  DECLARE flag VARCHAR(20);
  
  -- Calculate total sales for the given store_id
  SELECT SUM(pa.amount) INTO total_sales_value
  FROM store s
  LEFT JOIN inventory i ON s.store_id = i.store_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  LEFT JOIN payment pa ON r.rental_id = pa.rental_id
  WHERE s.store_id = input_store_id;

  -- Determine the flag based on the total sales value
  IF total_sales_value > 30000 THEN
    SET flag = 'green_flag';
  ELSE
    SET flag = 'red_flag';
  END IF;
  
  -- Print or do something with the total_sales_value and flag
  SELECT total_sales_value AS 'Total Business', flag AS 'Flag Status';
END //

DELIMITER ;

-- Call the stored procedure and print the results
CALL Business_Store(1);
CALL Business_Store(2);


