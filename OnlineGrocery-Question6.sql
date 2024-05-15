					-- [SECURITY MEASUREMENTS] [Creating Roles --
-- DROP the user if this user already exists
DROP USER IF EXISTS 'customer_user'@'localhost';
-- Create the Customer User account @LocalHost and set a password
CREATE USER 'customer_user'@'localhost' IDENTIFIED BY 'password';
-- Grant SELECT permission on the Purchases table to the customer user
GRANT SELECT ON OnlineGrocery.Purchases TO 'customer_user'@'localhost';

