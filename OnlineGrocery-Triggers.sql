					-- [SECURITY MEASUREMENTS] --
-- TRIGGERS and TEST --
-- Create a TRIGGER that prevents updates to any past orders in the Purchases table
-- IF any attempt happens to update a purchase record it will result in an error and print 'cannot modify past orders'
-- Delimiter changes to accommodate the trigger creation
DELIMITER $$

DROP TRIGGER IF EXISTS PreventOrderUpdate;
CREATE TRIGGER PreventOrderUpdate
BEFORE UPDATE ON Purchases
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot modify past orders.';
END$$

-- Reset the delimiter back to semicolon
DELIMITER ;

-- Question 9
-- Attempting to update a purchase entry
UPDATE Purchases SET Price = 100 WHERE PurchaseID = 1;

-- Question 10
-- Attempting to delete a purchase entry
DELETE FROM Purchases WHERE PurchaseID = 1;
