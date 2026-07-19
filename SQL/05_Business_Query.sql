USE ECommerce_Analytics;

-- 1. Total Orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- 2. Total Customers
SELECT COUNT(DISTINCT customer_id) AS Total_Customers
FROM Customers;

-- 3. Total Sellers
SELECT COUNT(*) AS Total_Sellers
FROM Sellers;

-- 4. Total Products
SELECT COUNT(*) AS Total_Products
FROM Products;

-- 5. Total Revenue
SELECT ROUND(SUM(payment_value),2) AS Total_Revenue
FROM Order_Payments;

-- 6. Average Order Value
SELECT ROUND(AVG(payment_value),2) AS Average_Order_Value
FROM Order_Payments;

-- 7. Orders by Status
SELECT
    order_status,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY order_status
ORDER BY Total_Orders DESC;

-- 8. Revenue by Payment Type
SELECT
    payment_type,
    ROUND(SUM(payment_value),2) AS Revenue
FROM Order_Payments
GROUP BY payment_type
ORDER BY Revenue DESC;

-- 9. Top 10 Selling Products
SELECT
    p.product_category_name,
    COUNT(oi.product_id) AS Total_Sold
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Total_Sold DESC
LIMIT 10;

-- 10. Top 10 Highest Revenue Products
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price),2) AS Revenue
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Revenue DESC
LIMIT 10;

-- 11. Revenue by State
SELECT
    c.customer_state,
    ROUND(SUM(op.payment_value),2) AS Revenue
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Payments op
ON o.order_id = op.order_id
GROUP BY customer_state
ORDER BY Revenue DESC;

-- 12. Top 10 Cities by Orders
SELECT
    customer_city,
    COUNT(order_id) AS Total_Orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY customer_city
ORDER BY Total_Orders DESC
LIMIT 10;

-- 13. Monthly Revenue Trend
SELECT
    YEAR(o.order_purchase_timestamp) AS Year,
    MONTH(o.order_purchase_timestamp) AS Month,
    ROUND(SUM(op.payment_value),2) AS Revenue
FROM Orders o
JOIN Order_Payments op
ON o.order_id = op.order_id
GROUP BY Year, Month
ORDER BY Year, Month;

-- 14. Monthly Orders
SELECT
    YEAR(order_purchase_timestamp) AS Year,
    MONTH(order_purchase_timestamp) AS Month,
    COUNT(*) AS Orders
FROM Orders
GROUP BY Year, Month
ORDER BY Year, Month;

-- 15. Average Freight Cost
SELECT
    ROUND(AVG(freight_value),2) AS Average_Freight
FROM Order_Items;

-- 16. Top 10 Sellers by Revenue
SELECT
    seller_id,
    ROUND(SUM(price),2) AS Revenue
FROM Order_Items
GROUP BY seller_id
ORDER BY Revenue DESC
LIMIT 10;

-- 17. Top 10 Customers by Spending
SELECT
    customer_id,
    ROUND(SUM(payment_value),2) AS Total_Spent
FROM Orders o
JOIN Order_Payments op
ON o.order_id = op.order_id
GROUP BY customer_id
ORDER BY Total_Spent DESC
LIMIT 10;

-- 18. Average Review Score
SELECT
    ROUND(AVG(review_score),2) AS Average_Rating
FROM Order_Reviews;

-- 19. Review Score Distribution
SELECT
    review_score,
    COUNT(*) AS Total_Reviews
FROM Order_Reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- 20. Top Product Categories
SELECT
    product_category_name,
    COUNT(*) AS Products
FROM Products
GROUP BY product_category_name
ORDER BY Products DESC
LIMIT 10;

-- 21. Customers by State
SELECT
    customer_state,
    COUNT(*) AS Customers
FROM Customers
GROUP BY customer_state
ORDER BY Customers DESC;

-- 22. Sellers by State
SELECT
    seller_state,
    COUNT(*) AS Sellers
FROM Sellers
GROUP BY seller_state
ORDER BY Sellers DESC;

-- 23. Average Payment Installments
SELECT
    ROUND(AVG(payment_installments),2) AS Avg_Installments
FROM Order_Payments;

-- 24. Highest Freight Charges
SELECT
    order_id,
    freight_value
FROM Order_Items
ORDER BY freight_value DESC
LIMIT 10;

-- 25. Most Expensive Products Sold
SELECT
    product_id,
    price
FROM Order_Items
ORDER BY price DESC
LIMIT 10;

-- 26. Revenue by Product Category
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price),2) AS Revenue
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Revenue DESC;

-- 27. Delivered Orders
SELECT COUNT(*) AS Delivered_Orders
FROM Orders
WHERE order_status='delivered';

-- 28. Cancelled Orders
SELECT COUNT(*) AS Cancelled_Orders
FROM Orders
WHERE order_status='canceled';

-- 29. Average Product Price
SELECT
    ROUND(AVG(price),2) AS Average_Product_Price
FROM Order_Items;

-- 30. Top 10 Revenue Generating Orders
SELECT
    order_id,
    ROUND(payment_value,2) AS Revenue
FROM Order_Payments
ORDER BY Revenue DESC
LIMIT 10;