USE ECommerce_Analytics;

CREATE VIEW vw_Total_Revenue AS
SELECT
    ROUND(SUM(payment_value),2) AS Total_Revenue
FROM Order_Payments;

CREATE VIEW vw_Monthly_Sales AS
SELECT
    YEAR(o.order_purchase_timestamp) AS Year,
    MONTH(o.order_purchase_timestamp) AS Month,
    ROUND(SUM(op.payment_value),2) AS Revenue
FROM Orders o
JOIN Order_Payments op
ON o.order_id = op.order_id
GROUP BY YEAR(o.order_purchase_timestamp),
         MONTH(o.order_purchase_timestamp);

CREATE VIEW vw_Revenue_By_State AS
SELECT
    c.customer_state,
    ROUND(SUM(op.payment_value),2) AS Revenue
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Payments op
ON o.order_id = op.order_id
GROUP BY c.customer_state;

CREATE VIEW vw_Revenue_By_Category AS
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price),2) AS Revenue
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name;

CREATE VIEW vw_Top_Products AS
SELECT
    p.product_category_name,
    COUNT(*) AS Total_Sold
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name;

CREATE VIEW vw_Top_Customers AS
SELECT
    o.customer_id,
    ROUND(SUM(op.payment_value),2) AS Total_Spent
FROM Orders o
JOIN Order_Payments op
ON o.order_id = op.order_id
GROUP BY o.customer_id;

CREATE VIEW vw_Top_Sellers AS
SELECT
    seller_id,
    ROUND(SUM(price),2) AS Revenue
FROM Order_Items
GROUP BY seller_id;

CREATE VIEW vw_Order_Status AS
SELECT
    order_status,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY order_status;

CREATE VIEW vw_Payment_Type AS
SELECT
    payment_type,
    COUNT(*) AS Total_Payments,
    ROUND(SUM(payment_value),2) AS Revenue
FROM Order_Payments
GROUP BY payment_type;

CREATE VIEW vw_Average_Order_Value AS
SELECT
    ROUND(AVG(payment_value),2) AS Average_Order_Value
FROM Order_Payments;

CREATE VIEW vw_Customer_Reviews AS
SELECT
    review_score,
    COUNT(*) AS Total_Reviews
FROM Order_Reviews
GROUP BY review_score;

CREATE VIEW vw_Average_Freight AS
SELECT
    ROUND(AVG(freight_value),2) AS Average_Freight
FROM Order_Items;

CREATE VIEW vw_Customer_Locations AS
SELECT
    customer_state,
    COUNT(*) AS Customers
FROM Customers
GROUP BY customer_state;

CREATE VIEW vw_Seller_Locations AS
SELECT
    seller_state,
    COUNT(*) AS Sellers
FROM Sellers
GROUP BY seller_state;

CREATE VIEW vw_Product_Performance AS
SELECT
    p.product_category_name,
    COUNT(oi.order_id) AS Orders,
    ROUND(SUM(oi.price),2) AS Revenue,
    ROUND(AVG(oi.price),2) AS Average_Price
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name;

SELECT * FROM vw_Total_Revenue;

SELECT * FROM vw_Monthly_Sales;

SELECT * FROM vw_Revenue_By_State;

SELECT * FROM vw_Revenue_By_Category;

SELECT * FROM vw_Top_Products;

SELECT * FROM vw_Top_Customers;

SELECT * FROM vw_Top_Sellers;

SELECT * FROM vw_Order_Status;

SELECT * FROM vw_Payment_Type;

SELECT * FROM vw_Average_Order_Value;

SELECT * FROM vw_Customer_Reviews;

SELECT * FROM vw_Average_Freight;

SELECT * FROM vw_Customer_Locations;

SELECT * FROM vw_Seller_Locations;

SELECT * FROM vw_Product_Performance;