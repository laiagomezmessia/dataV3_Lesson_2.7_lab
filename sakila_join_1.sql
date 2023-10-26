-- Lab | SQL Join (Part I)
USE sakila;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT COUNT(f.category_id) as num_films, c.name
FROM category c
JOIN film_category f
ON c.category_id = f.category_id
GROUP BY c.name
ORDER BY num_films;

-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) AS total_amount, p.payment_date
FROM payment p
JOIN staff s
ON p.staff_id = s.staff_id
WHERE YEAR(p.payment_date) = 2005 AND MONTH(p.payment_date) = 8
GROUP BY s.staff_id, s.first_name, s.last_name, p.payment_date;
 
-- 3. Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)
SELECT count(r.customer_id), c.first_name, c.last_name
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY r.customer_id
ORDER BY count(r.customer_id) DESC
LIMIT 1 ;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a
ON s.address_id = a.address_id;

-- 6. List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(a.actor_id) as count_actor
FROM film f
LEFT JOIN film_actor a
ON f.film_id = a.film_id
GROUP BY f.title;
-- ORDER BY num_actors DESC;


-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.last_name, c.customer_id, SUM(amount)
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY c.last_name, c.customer_id
ORDER BY c.last_name;

-- 8. List the titles of films per category.
SELECT f.title, fc.category_id, c.name
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
GROUP BY fc.category_id, f.title;
