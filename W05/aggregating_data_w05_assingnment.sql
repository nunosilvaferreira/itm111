-- =============================================
-- v_art Database Queries
-- =============================================
USE v_art;

-- Question 1: List all artworks from the 'Impressionism' period
SELECT artfile
FROM artwork
WHERE period = 'Impressionism';

-- Question 2: Find all artworks with 'flower' in their keywords
SELECT a.artfile
FROM artwork a
JOIN artwork_keyword ak ON a.artwork_id = ak.artwork_id
JOIN keyword k ON ak.keyword_id = k.keyword_id
WHERE k.keyword LIKE '%flower%';

-- Question 3: List all artists and their related artworks
SELECT ar.fname AS "First Name", ar.lname AS "Last Name", aw.title AS "Artwork Title"
FROM artist ar
LEFT JOIN artwork aw ON ar.artist_id = aw.artist_id
ORDER BY ar.lname, aw.title;

-- =============================================
-- Magazine Database Queries
-- =============================================
USE magazine;

-- Question 4: List all subscriptions with magazine and subscriber info
SELECT m.magazineName, s.subscriberLastName, s.subscriberFirstName
FROM subscription sub
JOIN magazine m ON sub.magazineKey = m.magazineKey
JOIN subscriber s ON sub.subscriberKey = s.subscriberKey
ORDER BY m.magazineName;

-- Question 5: List magazines Samantha Sanders subscribes to
SELECT m.magazineName
FROM subscription sub
JOIN magazine m ON sub.magazineKey = m.magazineKey
JOIN subscriber s ON sub.subscriberKey = s.subscriberKey
WHERE s.subscriberFirstName = 'Samantha' 
  AND s.subscriberLastName = 'Sanders'
ORDER BY m.magazineName;

-- =============================================
-- Employee Database Queries
-- =============================================
USE employees;

-- Question 6: First 5 Customer Service employees by last name
SELECT e.first_name, e.last_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
  AND de.to_date > CURDATE()
ORDER BY e.last_name
LIMIT 5;

-- Question 7: Current salary and department of Berni Genin
SELECT e.first_name, e.last_name, d.dept_name, s.salary, s.from_date
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = 'Berni' 
  AND e.last_name = 'Genin'
  AND de.to_date > CURDATE()
  AND s.to_date > CURDATE()
ORDER BY s.from_date DESC
LIMIT 1;

-- Question 11: Total number of employees
SELECT COUNT(*) AS "Number of Employees"
FROM employees;

-- Question 12: Average salary by department (< $60,000)
SELECT 
    d.dept_name, 
    FORMAT(AVG(s.salary), 2) AS average_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
WHERE de.to_date > CURDATE() 
  AND s.to_date > CURDATE()
GROUP BY d.dept_name
HAVING AVG(s.salary) < 60000
ORDER BY AVG(s.salary);

-- Question 13: Female employees per department
SELECT 
    d.dept_name, 
    COUNT(e.emp_no) AS "Number of Females"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE e.gender = 'F'
  AND de.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY d.dept_name;

-- =============================================
-- Bike Database Queries
-- =============================================
USE bike;

-- Question 8: Average stock quantity
SELECT ROUND(AVG(quantity)) AS "Stock Average"
FROM stock;

-- Question 9: Products needing reorder (quantity = 0)
SELECT DISTINCT p.product_name
FROM product p
JOIN stock s ON p.product_id = s.product_id
WHERE s.quantity = 0
ORDER BY p.product_name;

-- Question 10: Inventory by category at Baldwin Bikes
SELECT c.category_name, SUM(s.quantity) AS "InStock"
FROM category c
JOIN product p ON c.category_id = p.category_id
JOIN stock s ON p.product_id = s.product_id
WHERE s.store_id = 2
GROUP BY c.category_name
ORDER BY InStock;
