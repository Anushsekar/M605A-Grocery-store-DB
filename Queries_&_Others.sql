-- Query 1: Number of Products per Supplier
SELECT s. supplier_name, COUNT (p. product_id) AS num products
FROM Suppliers s
JOIN Products p ON s. supplier_id = p.supplier_id
GROUP BY s. supplier_name;

-- Query 2: supplier name and the products quantity
SELECT s.supplier_name,p.product_name,SUM(sd.quantity) AS total_quantity_delivered
FROM Suppliers s
JOIN Products p ON s.supplier_id = p.supplier_id
JOIN SupplierDeliveries sd ON p.product_id = sd.product_id
GROUP BY s.supplier_name,  p.product_name;

-- Query 3: Top 10 Products by Total Amount
SELECT p.product_name, SUM(oi.quantity * p.price) AS total_amount, s.supplier_name
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
JOIN Suppliers s ON p.supplier_id = s.supplier_id
GROUP BY p.product_name, s.supplier_name
ORDER BY total_amount DESC
LIMIT 10;

-- Query 4: Total Purchases per Customer
SELECT c.first_name, SUM(oi.quantity * p.price) AS total_purchases
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.first_name;

-- Query 5: Returned Items Details
SELECT ri.returned_item_id, c.first_name, p.product_name, p.description, r.refund_date, r.amount
FROM ReturnedItems ri
JOIN Orders o ON ri.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON ri.product_id = p.product_id
LEFT JOIN Refunds r ON ri.returned_item_id = r.returned_item_id;

-- Query 6: Deliveries after a Specific Date
SELECT d.delivery_date, d.tracking_number
FROM Delivery d
JOIN Orders o ON d.order_id = o.order_id
WHERE o.order_date > '2024-03-01';

-- view for the supplier product details
CREATE VIEW SupplierProductDetails AS
SELECT s.supplier_name,p.product_name,COALESCE(SUM(sd.quantity), 0) AS total_quantity_delivered
FROM Suppliers s
JOIN Products p ON s.supplier_id = p.supplier_id
LEFT JOIN SupplierDeliveries sd ON p.product_id = sd.product_id
GROUP BY s.supplier_name,p.product_name;

SELECT * FROM SupplierProductDetails;

DELIMITER //
CREATE TRIGGER UpdateTotalPriceAfterInsert
AFTER INSERT ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(quantity * price) INTO total
    FROM OrderItems
    WHERE order_id = NEW.order_id;

    UPDATE Orders
    SET total_price = total
    WHERE order_id = NEW.order_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER UpdateTotalPriceAfterUpdate
AFTER UPDATE ON OrderItems
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(quantity * price) INTO total
    FROM OrderItems
    WHERE order_id = NEW.order_id;

    UPDATE Orders
    SET total_price = total
    WHERE order_id = NEW.order_id;
END //
DELIMITER ;

-- Insert an order
INSERT INTO Orders (customer_id, order_date, total_price) VALUES (2, '2024-07-01', 30.00);

SELECT * FROM Orders WHERE customer_id = 2; 

-- Index:
CREATE INDEX idx_suppliers_name ON Suppliers(supplier_name);

SHOW INDEX FROM Suppliers;

