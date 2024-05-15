					-- [SECURITY MEASUREMENTS] --
USE OnlineGrocery;
-- Question 9:
-- Staff are restricted from accessing customer credit card number and expiration dates. 
-- Create SQL to implement. Demonstrate your implementation will prevent staff from viewing customer credit card data.

-- Drop the staff user if it exists
DROP USER IF EXISTS 'Staff_Member'@'localhost';

-- Create the staff user
CREATE USER 'Staff_Member'@'localhost' IDENTIFIED BY 'baseballisthebest';

-- Grant SELECT permission on the Purchases table to the staff user
GRANT SELECT ON OnlineGrocery.Purchases TO 'Staff_Member'@'localhost';

-- Allow them to see the CreditCardID and CustomerID
GRANT SELECT (CreditCardID, CustomerID) ON OnlineGrocery.CreditCards TO 'Staff_Member'@'localhost';

-- Grant SELECT permission on the non-sensitive columns of the Customers table
GRANT SELECT (CustomerID, Name, BillingAddress, Account, Phone, Email) ON OnlineGrocery.Customers TO 'Staff_Member'@'localhost';

-- Question 10
-- Ensure no DELETE permission on the Purchases table
REVOKE DELETE ON OnlineGrocery.Purchases FROM 'Staff_Member'@'localhost';






