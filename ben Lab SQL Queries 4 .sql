select * from sakila.film;

-- Get film ratings.
select rating from sakila.film;
select distinct rating from sakila.film;

-- Get release years.
select release_year from sakila.film;
select distinct release_year from sakila.film;

-- Get all films with ARMAGEDDON in the title.
select * from sakila.film
where title like '%ARMAGEDDON%';

-- Get all films which title ends with APOLLO.

select * from sakila.film
where title like '%APOLLO';

-- Get all films with word DATE in the title.
select * from sakila.film
where title like '%DATE%';

-- Get 10 films with the longest title.
SELECT LENGTH(title) FROM sakila.film
ORDER BY LENGTH(title) DESC
LIMIT 10; 

-- Get 10 the longest films.
SELECT LENGTH FROM sakila.film
ORDER BY LENGTH DESC
LIMIT 10; 
-- How many films include Behind the Scenes content?
select * from sakila.film;
select special_features from sakila.film
where special_features like '%Behind the Scenes%';
-- List films ordered by release year and title in alphabetical order.
Select * From sakila.film;
Select title,release_year 
From sakila.film
ORDER BY title;


