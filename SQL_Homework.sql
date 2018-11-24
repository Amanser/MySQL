use sakila;

-- 1a

SELECT first_name, last_name FROM actor;

-- 1b

SELECT upper(concat(first_name, " ", last_name)) AS `Actor Name`
FROM actor;

-- 2a

SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

-- 2b

SELECT first_name, last_name FROM actor
WHERE last_name like '%GEN%';


-- 2c

SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;


-- 2d

SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');


-- 3a

ALTER TABLE actor
ADD column description blob;

-- 3b

ALTER TABLE actor
DROP COLUMN description;

-- 4a

SELECT count(last_name),last_name FROM actor
group by last_name;

-- 4b

SELECT COUNT(last_name) AS LastNameCount, last_name
FROM actor
GROUP BY last_name
HAVING LastNameCount >= 2;


-- 4c

-- Find the actor id of the mislabeled record
SELECT first_name, last_name, actor_id FROM actor
WHERE first_name = 'GROUCHO';

-- Update the incorrect record
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

-- 5a

SHOW CREATE TABLE address;

-- 6a

SELECT
staff.first_name,
staff.last_name,
address.address
FROM staff
Join address ON staff.address_id = address.address_id;

-- 6b

SELECT
staff.first_name,
staff.last_name,
sum(payment.amount)
FROM staff
Join payment ON staff.staff_id = payment.staff_id
GROUP BY first_name;

-- 6c

SELECT
film.title,
count(film_actor.actor_id) as `Number of Actors`
FROM film
Join film_actor ON film.film_id = film_actor.film_id
GROUP BY title;

-- 6d

SELECT
title,
SUM(inventory.store_id) as `Number of Copies`
FROM film
JOIN inventory ON film.film_id = inventory.film_id
where title = "Hunchback Impossible"
GROUP BY title;


-- 6e

SELECT
first_name,
last_name,
SUM(payment.amount) as `Total Payments`
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY last_name
ORDER BY last_name;


-- 7a

SELECT title
FROM film
WHERE language_id = (
	SELECT language_id
	FROM `language` 
	WHERE `name` = 'English')
AND
`title` like 'K%' or `title` like 'Q%';


-- 7b
Select first_name,last_name
from actor
where actor_id in (

	SELECT actor_id
	FROM film_actor
	WHERE film_id = (
		
        SELECT film_id
		FROM `film` 
		WHERE `title` = 'Alone Trip'));


-- 7c


SELECT first_name, last_name, email, country.country
FROM customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
where country =  'Canada';

-- 7d

SELECT film.title, category.name as 'Category'
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
WHERE category.name = 'Family';


-- 7e

SELECT film.title, count(rental.inventory_id)
from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.title
order by `count(rental.inventory_id)` desc;


-- 7f


SELECT store.store_id, sum(payment.amount) as 'Revenue'
from store
join inventory on store.store_id = inventory.store_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by store_id;

-- 7g

SELECT store.store_id, city.city, country.country
from store
join address on store.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;


-- 7h

SELECT category.name as 'Category', sum(payment.amount) as 'Gross Revenue'
from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by `Category`
order by `Gross Revenue` desc LIMIT 5;


-- 8a


CREATE VIEW TopFiveGenres AS
SELECT category.name as 'Category', sum(payment.amount) as 'Gross Revenue'
from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by `Category`
order by `Gross Revenue` desc LIMIT 5;


-- 8b

SELECT * FROM TopFiveGenres;


-- 8c

DROP VIEW TopFiveGenres;





























