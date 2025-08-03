USE v_art;

-- Query 1: Insert Johannes Vermeer
INSERT INTO artist (fname, lname, dob, dod, country, local)
VALUES ('Johannes', 'Vermeer', 1632, 1674, 'Netherlands', 'n');

-- Query 2: List all artists sorted by last name
SELECT fname, lname, dob, dod, country, local
FROM artist
ORDER BY lname ASC;

-- Query 3: Update Vermeer's death year to 1675
UPDATE artist
SET dod = 1675
WHERE fname = 'Johannes' AND lname = 'Vermeer';

-- Query 4: Delete Johannes Vermeer
DELETE FROM artist
WHERE fname = 'Johannes' AND lname = 'Vermeer';


USE bike;

-- Query 5: Houston customers for race event
SELECT first_name, last_name, phone
FROM customer
WHERE city = 'Houston' AND state = 'TX';

-- Query 6: High-end bikes with $500 discount
SELECT product_name, list_price, (list_price - 500) AS 'Discount Price'
FROM product
WHERE list_price >= 5000
ORDER BY list_price DESC;

-- Query 7: Staff from other stores (not store_id 1)
SELECT first_name, last_name, email
FROM staff
WHERE store_id != 1;

-- Query 8: Bikes with 'spider' in the name
SELECT product_name, model_year, list_price
FROM product
WHERE product_name LIKE '%spider%';

-- Query 9: Bikes priced $500-$550 sorted by price
SELECT product_name, list_price
FROM product
WHERE list_price BETWEEN 500 AND 550
ORDER BY list_price ASC;

-- Query 10: Customers with phone and city containing 'ach' or 'och'
SELECT first_name, last_name, phone, street, city, state, zip_code
FROM customer
WHERE (phone IS NOT NULL) 
AND (city LIKE '%ach%' OR city LIKE '%och%' OR last_name = 'William')
LIMIT 5;

-- Query 11: Product names without year
SELECT SUBSTRING_INDEX(product_name, ' - ', 1) AS 'Product Name without Year'
FROM product
ORDER BY product_id
LIMIT 14;

-- Query 12: 2019 bikes with 3 payment installments
SELECT product_name, CONCAT('$', FORMAT(list_price/3, 2)) AS 'One of 3 payments'
FROM product
WHERE model_year = 2019;


USE magazine;

-- Query 13: Magazine prices with 3% discount
SELECT 
    magazineName AS 'magazineName',
    ROUND(magazinePrice * 0.97, 2) AS '3% off'
FROM magazine;

-- Query 14: Years since subscription started (rounded)
SELECT 
    s.subscriberKey AS 'subscriberKey',
    ROUND(DATEDIFF('2020-12-20', sub.subscriptionStartDate)/365) AS 'Years since subscription'
FROM subscription sub
JOIN subscriber s ON sub.subscriberKey = s.subscriberKey;

-- Query 15: Subscription end date formatted
SELECT 
    sub.subscriptionStartDate AS 'subscriptionStartDate',
    sub.subscriptionLength AS 'subscriptionLength',
    DATE_FORMAT(DATE_ADD(sub.subscriptionStartDate, INTERVAL sub.subscriptionLength MONTH), '%M %e, %Y') AS 'Subscription end'
FROM subscription sub;