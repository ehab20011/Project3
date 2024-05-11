					-- [SECURITY MEASUREMENTS] --
-- Question 9:

-- Staff are restricted from accessing customer credit card number and expiration dates. 
-- Create SQL to implement. Demonstrate your implementation will prevent staff from viewing customer credit card data.
DROP VIEW IF EXISTS StaffCustomerView;
CREATE VIEW StaffCustomerView AS
SELECT CustomerID, Name, BillingAddress, Account, Phone
FROM Customers;

-- This should fail or return an error that the user does not have the necessary permissions
SELECT CreditCardNumber FROM Customers;
