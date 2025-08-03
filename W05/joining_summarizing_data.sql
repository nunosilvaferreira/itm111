-- Query 1: List all customers and their orders (Bike schema)
SELECT c.first_name, c.last_name, o.cust_order_id, o.order_date
FROM bike.customer AS c
JOIN bike.cust_order AS o
  ON c.customer_id = o.customer_id;

-- Query 2: Count how many orders each store processed
SELECT s.store_name, COUNT(o.cust_order_id) AS total_orders
FROM bike.store AS s
JOIN bike.cust_order AS o
  ON s.store_id = o.store_id
GROUP BY s.store_name;

-- Query 3: Total revenue by brand
SELECT b.brand_name, SUM(p.list_price * oi.quantity * (1 - oi.discount)) AS total_revenue
FROM bike.brand AS b
JOIN bike.product AS p
  ON b.brand_id = p.brand_id
JOIN bike.cust_order_item AS oi
  ON p.product_id = oi.product_id
GROUP BY b.brand_name;

-- Query 4: List artists and their artworks (V_Art schema)
SELECT a.fname, a.lname, aw.title, aw.artfile
FROM v_art.artist AS a
JOIN v_art.artwork AS aw
  ON a.artist_id = aw.artist_id;

-- Query 5: Find artworks by keyword
SELECT aw.title, k.keyword
FROM v_art.artwork AS aw
JOIN v_art.artwork_keyword AS akw
  ON aw.artwork_id = akw.artwork_id
JOIN v_art.keyword AS k
  ON akw.keyword_id = k.keyword_id;

-- Query 6: Count subscriptions per magazine (Magazine schema)
SELECT m.magazineName, COUNT(s.subscriptionKey) AS total_subscriptions
FROM magazine.magazine AS m
JOIN magazine.subscription AS s
  ON m.magazineKey = s.magazineKey
GROUP BY m.magazineName;

-- Query 7: Average subscription length by state
SELECT sub.subscriberState, AVG(s.subscriptionLength) AS avg_length
FROM magazine.subscriber AS sub
JOIN magazine.subscription AS s
  ON sub.subscriberKey = s.subscriberKey
GROUP BY sub.subscriberState;

-- Query 8: Employees and their departments (Employees schema)
SELECT e.first_name, e.last_name, d.dept_name
FROM employees.employees AS e
JOIN employees.dept_emp AS de
  ON e.emp_no = de.emp_no
JOIN employees.departments AS d
  ON de.dept_no = d.dept_no;

-- Query 9: Highest salary per department
SELECT d.dept_name, MAX(s.salary) AS highest_salary
FROM employees.departments AS d
JOIN employees.dept_emp AS de
  ON d.dept_no = de.dept_no
JOIN employees.salaries AS s
  ON de.emp_no = s.emp_no
GROUP BY d.dept_name;

-- Query 10: Average population by continent (World schema)
SELECT c.Continent, AVG(c.Population) AS avg_population
FROM world.country AS c
GROUP BY c.Continent;

-- Query 11: Most spoken languages per country
SELECT cl.Language, COUNT(*) AS num_countries
FROM world.countrylanguage AS cl
GROUP BY cl.Language
ORDER BY num_countries DESC;

-- Query 12: Top 5 largest countries by surface area
SELECT Name, SurfaceArea
FROM world.country
ORDER BY SurfaceArea DESC
LIMIT 5;

-- Query 13: Cities with more than 5 million people
SELECT Name, Population
FROM world.city
WHERE Population > 5000000
ORDER BY Population DESC;
