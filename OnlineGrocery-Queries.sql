-- QUERIES --

-- QUESTION 1: 
-- Identify customers who have not completed a purchase/delivery survey in the last
-- 8 months. Display the customer name and email. Use a nested select to answer this question.
SELECT Name, Email
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT p.CustomerID
    FROM Purchases p
    WHERE p.PurchaseID IN (
        SELECT PurchaseID
        FROM Deliveries
        WHERE DeliveryDate >= DATE_SUB(CURDATE(), INTERVAL 8 MONTH)
        UNION
        SELECT PurchaseID
        FROM Order_Surveys
        WHERE SurveyDate >= DATE_SUB(CURDATE(), INTERVAL 8 MONTH)
    )
)
LIMIT 0, 1000;

-- QUESTION 2:
-- Identify the most popular product purchased in the last month. Display four
-- columns: warehouse, product name, product type and number of orders. Display
-- one distinct row for each warehouse, product and product type. Display the product with the most orders first.
SELECT 
    wp.WarehouseID,
    p.Name AS ProductName,
    p.Type AS ProductType,
    (
        SELECT COUNT(DISTINCT PurchaseID)
        FROM Purchases
        WHERE ProductID = p.ProductID
        AND PurchaseDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    ) AS NumberOfOrders
FROM 
    Warehouse_Products wp,
    Products p
WHERE 
    wp.ProductID = p.ProductID
GROUP BY 
    wp.WarehouseID, p.Name, p.Type, p.ProductID
ORDER BY 
    NumberOfOrders DESC
LIMIT 1;



-- QUESTION 3:
-- Identify customers with the most purchases of fruit in the last year by customer location. Display five rows in your output – one row for each borough. Display
-- three columns: borough, number of orders, total dollar amount of order. The borough with the most orders is displayed first. You may need multiple SQL to
-- answer this question. 
SELECT 
    c.BillingAddress AS Borough,
    COUNT(DISTINCT p.PurchaseID) AS NumberOfOrders,
    SUM(p.Price) AS TotalDollarAmount
FROM 
    Customers c, Purchases p, Products pr
WHERE 
    c.CustomerID = p.CustomerID
    AND p.ProductID = pr.ProductID
    AND pr.Type = 'Fruit'
    AND p.PurchaseDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY 
    c.BillingAddress
ORDER BY 
    NumberOfOrders DESC
LIMIT 5;

-- QUESTION 4:
-- Identify customers with no comments in the product survey. Display the customer name.
SELECT Name AS CustomerName
FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Product_Ratings
);

-- QUESTION 5:
-- Search the open-ended narrative text/comments in the product and delivery comments to identify personally identifiable information (PII). This includes any
-- data that could potentially be used to identify a person. For instance, examples of PII include email address, date of birth, Social Security number, bank account
-- number, home address, and full name. Display the customer who created the comment, date of comment and the comment. Order the output by customer name
SELECT 
    c.Name AS CustomerName,
    pr.RatingDate AS DateOfComment,
    pr.RatingComment AS Comment
FROM 
    Customers c, Product_Ratings pr
WHERE 
    c.CustomerID = pr.CustomerID
    AND pr.RatingComment REGEXP '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}'
ORDER BY 
    c.Name;
    
-- Question 7:
-- Using purchases made in the last 2 months, identify customers with children. Display the customer name and email. Order the output by
-- customer name. Replace children with other demographic characteristics. For instance, dog owners, seniors, vegetarians, Tesla car owners, etc.

-- SET SQLSAFEUPDATES off so you can Mark some products as 'Vegetarian' then turn it back on
SET SQL_SAFE_UPDATES = 0;
UPDATE Products SET Attributes = 'Vegetarian' WHERE Name IN ('Spelt Noodles', 'Organic Avocado');
SET SQL_SAFE_UPDATES = 1;
-- Now Call the Query
SELECT DISTINCT c.Name AS CustomerName, c.Email
FROM Customers c, Purchases p, Products pr
WHERE 
    c.CustomerID = p.CustomerID
    AND p.ProductID = pr.ProductID
    AND pr.Attributes = 'Vegetarian'
    AND p.PurchaseDate > DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
ORDER BY 
    c.Name;

-- Question 8
-- Identify staff with the most deliveries in the last 3 months. Display two columns: staff and number of deliveries. Display one row for each
-- distinct staff. Display the staff with the most deliveries first.
SELECT 
    s.Name AS StaffName,
    (
        SELECT COUNT(*) 
        FROM Deliveries 
        WHERE StaffID = s.StaffID 
        AND DeliveryDate > DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    ) AS NumberOfDeliveries
FROM 
    Staff s
ORDER BY 
    NumberOfDeliveries DESC;

-- Question 11:
-- The product Raisin Bran is no longer being offered by the grocery store and being available for 3 years. Identify the SQL to implement. 
-- Add a 'Status' column to the 'Products' table with a default value of 'Active'
ALTER TABLE Products ADD COLUMN Status VARCHAR(255) DEFAULT 'Active';

SET SQL_SAFE_UPDATES = 0;
-- Set the Status of 'Blueberry Yogurt' to be 'Discontinued'
UPDATE Products
SET Status = 'Discontinued'
WHERE Name = 'Blueberry Yogurt';
-- Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;

-- Question 12:
-- Use the SQL DESCRIBE operation to display the structure for all tables.
DESCRIBE Customers;
DESCRIBE Staff;
DESCRIBE Departments;
DESCRIBE Staff_Departments;
DESCRIBE Warehouses;
DESCRIBE Products;
DESCRIBE Warehouse_Products;
DESCRIBE Purchases;
DESCRIBE Deliveries;
DESCRIBE Product_Ratings;
DESCRIBE Order_Surveys;

-- Question 13:
-- Display the SQL Version I am using
SELECT VERSION();