-- sakila Database
-- INNER JOINS

--  What country is the city based in?
SELECT city, country
FROM city
JOIN country 
	ON
	city.country_id =country.country_id;
	

--  What language is spoken in each film?
SELECT  film.title, `language`.name
FROM film
JOIN `language`
	ON film.language_id = `language`.language_id;


-- List all film titles and their category (genre)
SELECT film.title, category.name
FROM film 
JOIN film_category 
	ON film.film_id = film_category.film_id 
Join category
	ON film_category.category_id = category.category_id;


-- Create an email list of Canadian customers
SELECT customer.first_name, customer.last_name, customer.email, country.country
FROM country 
JOIN city 
	ON country.country_id = city.country_id 
JOIN address
	ON city.city_id = address.city_id 
JOIN customer 
	ON address.address_id =customer.customer_id 
WHERE country.country = 'Canada';


--  How much rental revenue has each customer generated? 
--      In other words, what is the SUM rental payment amount for each customer 
--      ordered by the SUM amount from high to low?
SELECT  customer.first_name, customer.last_name, payment.amount AS Customer_Revenue
FROM payment 
JOIN customer
	ON payment.customer_id = customer.customer_id 
GROUP BY payment.customer_id 
ORDER BY Customer_Revenue DESC;


-- How many cities are associated to each country? Filter the results to countries with at least 10 cities.

SELECT country.country, COUNT(DISTINCT(city)) as City_Count 
FROM country
JOIN city 
	ON country.country_id = city.country_id
GROUP BY country.country_id
HAVING City_Count > 10
ORDER BY City_Count DESC;



-- LEFT JOINS

-- Which films do not have an actor?

SELECT film.title, film_actor.film_id
FROM film
LEFT JOIN film_actor
	ON film.film_id =film_actor.film_id 
WHERE film_actor.film_id IS NULL;


-- Which comedies are not in inventory?
-- Meaning it is not carried at all
    
SELECT title, inventory.film_id, category.name
FROM film
LEFT JOIN inventory
	ON film.film_id =inventory.film_id
JOIN film_category 
	ON film.film_id =film_category.film_id 
JOIN category
	ON film_category.category_id =category.category_id 
WHERE inventory_id IS NULL
AND category.name ='Comedy';



-- 18 - Generate a list of never been rented films

SELECT title, inventory.inventory_id, rental.inventory_id 
FROM film
JOIN inventory
	ON film.film_id =inventory.film_id 
LEFT JOIN rental
	ON inventory.inventory_id = rental.inventory_id 
WHERE rental.inventory_id IS NULL;
