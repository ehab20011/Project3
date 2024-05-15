USE OnlineGrocery;

-- TABLE CREATIONS FOR THE DATABASE --
-- Drop tables if they exist
DROP TABLE IF EXISTS Order_Surveys, Product_Ratings, Deliveries, Purchases, Warehouse_Products, Products, Warehouses, Staff_Departments, Departments, Staff, Customers, CreditCards;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    BillingAddress VARCHAR(255),
    Account VARCHAR(255),
    Password VARCHAR(255),
    CreditCardNumber VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20)
);
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    Email VARCHAR(255)
);
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);
CREATE TABLE Staff_Departments (
    StaffID INT,
    DepartmentID INT,
    JobTitle VARCHAR(255),
    Salary DECIMAL(10, 2),
    DateStarted DATE,
    DateEnded DATE,
    PRIMARY KEY (StaffID, DepartmentID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
CREATE TABLE Warehouses (
    WarehouseID INT AUTO_INCREMENT PRIMARY KEY,
    Location VARCHAR(255),
    Type VARCHAR(50)
);
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Type VARCHAR(50),
	Attributes VARCHAR(255),
    Calories INT,
    Sodium INT,
    Quantity INT,
    ExpirationDate DATE
);
CREATE TABLE Warehouse_Products (
    ProductID INT,
    WarehouseID INT,
    PRIMARY KEY (ProductID, WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);
CREATE TABLE Purchases (
    PurchaseID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    PurchaseDate date,
    Price DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    DeliveryAddress VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Deliveries (
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    PurchaseID INT,
    StaffID INT,
    DeliveryAddress VARCHAR(255),
    DeliveryDate DATE,
    FOREIGN KEY (PurchaseID) REFERENCES Purchases(PurchaseID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE TABLE Product_Ratings (
    RatingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    RatingMethod VARCHAR(50),
    RatingDate DATE,
    RatingComment TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Order_Surveys (
    SurveyID INT AUTO_INCREMENT PRIMARY KEY,
    PurchaseID INT,
    CustomerID INT,
    SurveyDate DATE,
    SurveyMethod VARCHAR(50),
    SurveyComment TEXT,
    FOREIGN KEY (PurchaseID) REFERENCES Purchases(PurchaseID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE CreditCards (
    CreditCardID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CreditCardNumber VARCHAR(255),
    ExpirationDate DATE,
    CVV VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- INSERT COMMANDS --
-- Customers 
INSERT IGNORE INTO Customers (Name, BillingAddress, Account, Password, Phone, Email)
VALUES
('Ehab Abdalla', '789 Jasmine Blvd, New York, NY', 'aria_noor', 'safe&sound123', '555-7890', 'ehab@email.com'),
('Tariq Jamal', '354 Cedar Ave, Brooklyn, NY', 'tariq_jamal', 'secure*789', '555-6543', 'tariq@email.com'),
('Fatma Muhammed', '912 Willow Lane, Queens, NY', 'luna_rodriguez', 'moonlight456', '555-2021', 'fatma@email.com'),
('Helen Wang', '218 Bamboo Grove, Manhattan, NY', 'kai_hu', 'password1234', '555-8989', 'helen@email.com'),
('Leo Messi', '100 Liberty St, New York, NY', 'john_d', 'john1234', '555-1010', 'leo@email.com');


-- Staff
INSERT IGNORE INTO Staff (Name, Address, Email)
VALUES
('Mila Kunis', '450 Maple Street, Bronx, NY', 'mila.k@example.com'),
('Nadia Chaudhry', '672 Oak Road, Staten Island, NY', 'nadia.c@example.com'),
('Leon Bates', '880 Palm Way, Harlem, NY', 'leon.b@example.com'),
('Raj Patel', '331 Pine Street, Flushing, NY', 'raj.p@example.com');

-- Products 
INSERT IGNORE INTO Products (Name, Type, Calories, Sodium, Quantity, ExpirationDate)
VALUES
('Almond Butter', 'Condiment', 200, 50, 100, '2024-10-15'),
('Spelt Noodles', 'Pasta', 250, 5, 150, '2024-06-30'),
('Blueberry Yogurt', 'Dairy', 180, 65, 200, '2024-09-01'),
('Organic Avocado', 'Produce', 160, 10, 300, '2024-07-22'),
('Banana', 'Fruit', 110, 1, 200, '2024-12-31'),
('Apple', 'Fruit', 95, 2, 300, '2024-11-30'),
('Orange', 'Fruit', 62, 0, 180, '2024-12-15');

-- Purchases
INSERT IGNORE INTO Purchases (CustomerID, ProductID, Price, PaymentMethod, DeliveryAddress, PurchaseDate)
VALUES
(1, 1, 10.99, 'Credit Card', '789 Jasmine Blvd, New York, NY', DATE_SUB(CURDATE(), INTERVAL 10 DAY)),
(1, 1, 10.99, 'Credit Card', '789 Jasmine Blvd, New York, NY', DATE_SUB(CURDATE(), INTERVAL 20 DAY)),
(1, 1, 10.99, 'Credit Card', '789 Jasmine Blvd, New York, NY', DATE_SUB(CURDATE(), INTERVAL 30 DAY)),
(2, 2, 2.50, 'Debit Card', '354 Cedar Ave, Brooklyn, NY', DATE_SUB(CURDATE(), INTERVAL 15 DAY)),
(2, 2, 2.50, 'Debit Card', '354 Cedar Ave, Brooklyn, NY', DATE_SUB(CURDATE(), INTERVAL 25 DAY)),
(3, 3, 3.75, 'Credit Card', '912 Willow Lane, Queens, NY', DATE_SUB(CURDATE(), INTERVAL 35 DAY)),
(4, 4, 1.95, 'Cash', '218 Bamboo Grove, Manhattan, NY', DATE_SUB(CURDATE(), INTERVAL 5 DAY)),
(4, 4, 1.95, 'Cash', '218 Bamboo Grove, Manhattan, NY', DATE_SUB(CURDATE(), INTERVAL 100 DAY)),
(1, 5, 0.99, 'Credit Card', '789 Jasmine Blvd, New York, NY', DATE_SUB(CURDATE(), INTERVAL 10 DAY)),
(2, 6, 1.29, 'Debit Card', '354 Cedar Ave, Brooklyn, NY', DATE_SUB(CURDATE(), INTERVAL 20 DAY)),
(3, 7, 0.89, 'Credit Card', '912 Willow Lane, Queens, NY', DATE_SUB(CURDATE(), INTERVAL 30 DAY)),
(4, 5, 0.99, 'Cash', '218 Bamboo Grove, Manhattan, NY', DATE_SUB(CURDATE(), INTERVAL 40 DAY)),
(1, 6, 1.29, 'Credit Card', '789 Jasmine Blvd, New York, NY', DATE_SUB(CURDATE(), INTERVAL 50 DAY)),
(2, 7, 0.89, 'Debit Card', '354 Cedar Ave, Brooklyn, NY', DATE_SUB(CURDATE(), INTERVAL 60 DAY));

-- Warehouses
INSERT IGNORE INTO Warehouses (Location, Type)
VALUES
('1234 Market St, New York, NY', 'Refrigerated'),
('5678 Trade St, Brooklyn, NY', 'Dry Goods'),
('9101 Exchange Blvd, Queens, NY', 'Kitchen'),
('2345 Stock St, Bronx, NY', 'Refrigerated');

-- Warehouse_Products
INSERT IGNORE INTO Warehouse_Products (ProductID, WarehouseID)
VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(3, 1),
(4, 4),
(5, 1),  
(6, 2),  
(7, 3);

-- Inserting Comments into Product Ratings
INSERT IGNORE INTO Product_Ratings (CustomerID, ProductID, RatingMethod, RatingDate, RatingComment)
VALUES
(1, 5, 'Stars', CURDATE(), 'Loved it! For more info, email me at ehab@email.com'),
(2, 6, 'Stars', CURDATE() - INTERVAL 5 DAY, 'Not bad, reach out at tariq@gmail.com'),
(3, 7, 'Number', CURDATE() - INTERVAL 10 DAY, 'Could be better... contact: fatma123@gmail.com'),
(4, 4, 'Letter', CURDATE() - INTERVAL 15 DAY, 'Excellent product! My email is helen@gmail.com for inquiries.'),
(1, 1, 'Number', CURDATE() - INTERVAL 20 DAY, 'Pretty decent, email me for collaboration ehab.work@gmail.com');

-- Insert Deliveries
INSERT IGNORE INTO Deliveries (PurchaseID, StaffID, DeliveryAddress, DeliveryDate)
VALUES
(1, 1, '789 Jasmine Blvd, New York, NY', CURDATE()),
(2, 2, '354 Cedar Ave, Brooklyn, NY', DATE_SUB(CURDATE(), INTERVAL 20 DAY)),
(3, 3, '912 Willow Lane, Queens, NY', DATE_SUB(CURDATE(), INTERVAL 40 DAY)),
(4, 4, '218 Bamboo Grove, Manhattan, NY', DATE_SUB(CURDATE(), INTERVAL 10 DAY)),
(5, 1, '789 Jasmine Blvd, New York, NY', DATE_SUB(CURDATE(), INTERVAL 15 DAY)),
(6, 2, '354 Cedar Ave, Brooklyn, NY', DATE_SUB(CURDATE(), INTERVAL 5 DAY));

-- INSERT CreditCards
INSERT IGNORE INTO CreditCards (CustomerID, CreditCardNumber, ExpirationDate, CVV)
VALUES
(1, '4111 1111 1111 1111', '2025-01-01', '123'),
(2, '5500 0000 0000 0004', '2025-02-01', '234'),
(3, '3400 0000 0000 009', '2025-03-01', '345'),
(4, '3000 0000 0000 04', '2025-04-01', '456'),
(5, '6011 0000 0000 0004', '2025-05-01', '567');



