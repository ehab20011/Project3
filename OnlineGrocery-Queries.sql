-- QUERIES --

-- QUESTION 1: 
-- Identify customers who haven't completed a survey in the last 8 months
SELECT c.Name AS CustomerName
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 FROM Order_Surveys s
    WHERE s.CustomerID = c.CustomerID
    AND s.SurveyDate > DATE_SUB(CURDATE(), INTERVAL 8 MONTH)
);

-- QUESTION 2:
-- Identify the most popular product purchased in the last 3 months
SELECT w.Location AS Warehouse, p.Name AS ProductName, p.Type AS ProductType, COUNT(*) AS NumberOfOrders
FROM Purchases pu
JOIN Products p ON pu.ProductID = p.ProductID
JOIN Warehouse_Products wp ON p.ProductID = wp.ProductID
JOIN Warehouses w ON wp.WarehouseID = w.WarehouseID
WHERE pu.PurchaseDate > DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY w.Location, p.Name, p.Type
ORDER BY COUNT(*) DESC;

-- QUESTION 3:
-- Identify customers with the most purchases of fruit in the last year by customer location
SELECT 
    SUBSTRING_INDEX(Customers.BillingAddress, ',', -1) AS Borough,
    COUNT(Purchases.PurchaseID) AS NumberOfOrders,
    SUM(Purchases.Price) AS TotalDollarAmountOfOrder
FROM Customers
JOIN Purchases ON Customers.CustomerID = Purchases.CustomerID
JOIN Products ON Purchases.ProductID = Products.ProductID
WHERE Products.Type = 'Fruit'
AND Purchases.PurchaseDate > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY Borough
ORDER BY NumberOfOrders DESC
LIMIT 5;

-- QUESTION 4:
-- Identify customers with no comments in the product survey. Display the customer name.
SELECT DISTINCT c.Name AS CustomerName
FROM Customers c
LEFT JOIN Product_Ratings pr ON c.CustomerID = pr.CustomerID
WHERE pr.RatingComment IS NULL OR TRIM(pr.RatingComment) = '' OR pr.RatingComment = 'No comment';

-- QUESTION 5:
-- Search the open-ended narrative text/comments in the product and delivery comments to identify personally identifiable information (PII). This includes any
-- data that could potentially be used to identify a person. For instance, examples of PII include email address, date of birth, Social Security number, bank account
-- number, home address, and full name. Display the customer who created the comment, date of comment and the comment. Order the output by customer name
SELECT 
    c.Name AS CustomerName,
    pr.RatingDate AS DateOfComment,
    pr.RatingComment AS Comment
FROM 
    Customers c
JOIN 
    Product_Ratings pr ON c.CustomerID = pr.CustomerID
WHERE 
    pr.RatingComment REGEXP '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}'
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
SELECT DISTINCT c.Name AS CustomerName
FROM Customers c
JOIN Purchases p ON c.CustomerID = p.CustomerID
JOIN Products pr ON p.ProductID = pr.ProductID
WHERE pr.Attributes = 'Vegetarian'
AND p.PurchaseDate > DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
ORDER BY c.Name;

-- Question 8
-- Identify staff with the most deliveries in the last 3 months. Display two columns: staff and number of deliveries. Display one row for each
-- distinct staff. Display the staff with the most deliveries first.
SELECT 
    s.Name AS StaffName,
    COUNT(d.DeliveryID) AS NumberOfDeliveries
FROM 
    Staff s
JOIN 
    Deliveries d ON s.StaffID = d.StaffID
WHERE 
    d.DeliveryDate > DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY 
    s.StaffID, s.Name
ORDER BY 
    NumberOfDeliveries DESC;

-- Question 11:
-- The product Raisin Bran is no longer being offered by the grocery store and being available for 3 years. Identify the SQL to implement. 
-- To Implement this we can give the product a STATUS attribute and set the Status to be Discontinued
ALTER TABLE Products ADD COLUMN Status VARCHAR(255) DEFAULT 'Active';
-- Now we can set the Status of Raisin Bran to be Discontinued
UPDATE Products
SET Status = 'Discontinued'
WHERE Name = 'Raisin Bran';

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