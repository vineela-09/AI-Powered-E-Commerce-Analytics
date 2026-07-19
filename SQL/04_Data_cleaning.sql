USE ECommerce_Analytics;

-- Check for NULL values

SELECT COUNT(*) AS Missing_Customers
FROM Customers
WHERE customer_id IS NULL;

SELECT COUNT(*) AS Missing_Orders
FROM Orders
WHERE order_id IS NULL;

SELECT COUNT(*) AS Missing_Products
FROM Products
WHERE product_id IS NULL;

SELECT COUNT(*) AS Missing_Sellers
FROM Sellers
WHERE seller_id IS NULL;

-- Remove duplicate records (if any)

DELETE c1
FROM Customers c1
JOIN Customers c2
ON c1.customer_id = c2.customer_id
AND c1.customer_unique_id > c2.customer_unique_id;

DELETE s1
FROM Sellers s1
JOIN Sellers s2
ON s1.seller_id = s2.seller_id
AND s1.seller_city > s2.seller_city;

-- Trim unwanted spaces

UPDATE Customers
SET customer_city = TRIM(customer_city);

UPDATE Sellers
SET seller_city = TRIM(seller_city);

UPDATE Products
SET product_category_name = TRIM(product_category_name);

-- Standardize text to uppercase

UPDATE Customers
SET customer_state = UPPER(customer_state);

UPDATE Sellers
SET seller_state = UPPER(seller_state);

UPDATE Geolocation
SET geolocation_state = UPPER(geolocation_state);

-- Replace NULL category names

UPDATE Products
SET product_category_name = 'Unknown'
WHERE product_category_name IS NULL;

-- Replace NULL review titles

UPDATE Order_Reviews
SET review_comment_title = 'No Title'
WHERE review_comment_title IS NULL;

-- Replace NULL review messages

UPDATE Order_Reviews
SET review_comment_message = 'No Comments'
WHERE review_comment_message IS NULL;

-- Replace NULL payment type

UPDATE Order_Payments
SET payment_type = 'Not Specified'
WHERE payment_type IS NULL;

-- Replace NULL order status

UPDATE Orders
SET order_status = 'Processing'
WHERE order_status IS NULL;

-- Remove negative values

UPDATE Order_Items
SET price = ABS(price)
WHERE price < 0;

UPDATE Order_Items
SET freight_value = ABS(freight_value)
WHERE freight_value < 0;

UPDATE Order_Payments
SET payment_value = ABS(payment_value)
WHERE payment_value < 0;

-- Verify cleaned data

SELECT COUNT(*) AS Total_Customers
FROM Customers;

SELECT COUNT(*) AS Total_Orders
FROM Orders;

SELECT COUNT(*) AS Total_Products
FROM Products;

SELECT COUNT(*) AS Total_Order_Items
FROM Order_Items;

SELECT COUNT(*) AS Total_Payments
FROM Order_Payments;

SELECT COUNT(*) AS Total_Reviews
FROM Order_Reviews;

SELECT COUNT(*) AS Total_Sellers
FROM Sellers;

-- Preview cleaned data

SELECT *
FROM Customers
LIMIT 10;

SELECT *
FROM Orders
LIMIT 10;

SELECT *
FROM Products
LIMIT 10;

SELECT *
FROM Order_Items
LIMIT 10;