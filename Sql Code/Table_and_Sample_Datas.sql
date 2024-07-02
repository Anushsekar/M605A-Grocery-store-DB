CREATE TABLE Customers (
  customer_id INT AUTO_INCREMENT,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  email_address VARCHAR(100),
  phone_number VARCHAR(20),
  calling_code VARCHAR(5),
  address_id INT,
  PRIMARY KEY (customer_id)
);

CREATE TABLE CustomerAddresses (
  address_id INT AUTO_INCREMENT,
  street_name VARCHAR(255),
  street_no INT(5),
  city VARCHAR(255),
  state VARCHAR(255),
  zip VARCHAR(10),
  country VARCHAR(255),
  PRIMARY KEY (address_id)
);

ALTER TABLE Customers
ADD CONSTRAINT fk_customers_addresses FOREIGN KEY (address_id) REFERENCES CustomerAddresses(address_id);

CREATE TABLE Suppliers (
  supplier_id INT AUTO_INCREMENT,
  supplier_name VARCHAR(200),
  email_address VARCHAR(100),
  phone_number VARCHAR(20),
  address VARCHAR(255),
  PRIMARY KEY (supplier_id)
);

CREATE TABLE SupplierDeliveries (
  delivery_id INT AUTO_INCREMENT,
  supplier_id INT,
  product_id INT,
  delivery_date DATE,
  tracking_number VARCHAR(20),
  quantity INT,
  price DECIMAL(10, 2),
  PRIMARY KEY (delivery_id)
);

CREATE TABLE Products (
  product_id INT AUTO_INCREMENT,
  product_name VARCHAR(255),
  supplier_id INT,
  description TEXT,
  price DECIMAL(10, 2),
  PRIMARY KEY (product_id)
);

ALTER TABLE Products
ADD CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id);

ALTER TABLE SupplierDeliveries
ADD CONSTRAINT fk_supplierdeliveries_suppliers FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
ADD CONSTRAINT fk_supplierdeliveries_products FOREIGN KEY (product_id) REFERENCES Products(product_id);

CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT,
  customer_id INT,
  order_date DATE,
  total_price DECIMAL(10, 2),
  PRIMARY KEY (order_id)
);

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id);

CREATE TABLE OrderItems (
  order_item_id INT AUTO_INCREMENT,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10, 2),
  PRIMARY KEY (order_item_id)
);

ALTER TABLE OrderItems
ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
ADD CONSTRAINT fk_orderitems_products FOREIGN KEY (product_id) REFERENCES Products(product_id);

CREATE TABLE ReturnedItems (
  returned_item_id INT AUTO_INCREMENT,
  order_id INT,
  product_id INT,
  PRIMARY KEY (returned_item_id)
);

ALTER TABLE ReturnedItems
ADD CONSTRAINT fk_returneditems_orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
ADD CONSTRAINT fk_returneditems_products FOREIGN KEY (product_id) REFERENCES Products(product_id);

CREATE TABLE Refunds (
  refund_id INT AUTO_INCREMENT,
  returned_item_id INT,
  refund_date DATETIME,
  amount DECIMAL(10, 2),
  PRIMARY KEY (refund_id)
);

ALTER TABLE Refunds
ADD CONSTRAINT fk_refunds_returneditems FOREIGN KEY (returned_item_id) REFERENCES ReturnedItems(returned_item_id);

CREATE TABLE Delivery (
  delivery_id INT AUTO_INCREMENT,
  order_id INT,
  tracking_number VARCHAR(20),
  delivery_date DATE,
  PRIMARY KEY (delivery_id)
);

ALTER TABLE Delivery
ADD CONSTRAINT fk_deliveries_orders FOREIGN KEY (order_id) REFERENCES Orders(order_id);

CREATE TABLE PaymentMethods (
  payment_method_id INT AUTO_INCREMENT,
  method_name VARCHAR(50),
  PRIMARY KEY (payment_method_id)
);

CREATE TABLE Payments (
  payment_id INT AUTO_INCREMENT,
  order_id INT,
  payment_method_id INT,
  payment_date DATETIME,
  amount DECIMAL(10, 2),
  PRIMARY KEY (payment_id)
);

ALTER TABLE Payments
ADD CONSTRAINT fk_payments_orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
ADD CONSTRAINT fk_payments_paymentmethods FOREIGN KEY (payment_method_id) REFERENCES PaymentMethods(payment_method_id);

-- Suppliers
INSERT INTO Suppliers (supplier_name,email_address,phone_number,address)
VALUES
  ('Sunrise Farms Inc.',         'terry.royal@brakus.net',         '+1-918-208-0208',  '37504 Ayana Road Apt. 015 Lake Korytown, VA 64644-6850'),
  ('Provenance Provisions LLC',  'donnie98@grant.com',             '1-458-481-8734',   '58914 Joel Heights Spinkaberg, AL 04155'),
  ('Harvest Home Gourmet',       'hebert@walter.com',              '930-480-8749',     '3319 Nikolaus Parks Elisaville, MA 42365'),
  ('FreshFusion Foods Ltd.',     'garth05@dach.com',               '+19595214532',     '5500 Berge Green East Candice, IN 80777-7708'),
  ('TasteQuest Ingredients Co.', 'janick.boyer@paucek.info',       '+1-947-254-8010',  '516 Josue Mission Suite 724 Caylaside, WA 79046'),
  ('SunnySide Grocery Supply',   'marquis.schneider@daugherty.biz','520-642-6945',     '34858 Schamberger Plain Suite 924 Aliviachester, TN 04240-2289'),
  ('Greenspace Produce Partners','rdavis@bernier.com',             '1-678-635-2366',   '7901 Yundt Parkways Apt. 866 Sonnyburgh, HI 79201-1367'),
  ('MeatMaster Foods Inc.',      'hhowell@weissnat.info',          '(929) 919-7298',   '6945 Wyman Route Apt. 766 Maggiobury, ND 70025-7303'),
  ('FlavorFusion Food Products', 'euna.wehner@conn.biz',           '+1 (320) 681-0054','85062 Estevan Key Creminshire, AR 51104-0101'),
  ('Nourish Natural Foods Co.',  'emmitt28@hyatt.com',             '(351) 704-2527',   '821 Ellsworth Rapid Suite 372 Alvisport, UT 92789-7010');

 -- SupplierDeliveries
INSERT INTO SupplierDeliveries (supplier_id, product_id, delivery_date, tracking_number, quantity, price)
VALUES
    (1, 1, '2024-01-05', 'TRK123456', 100, 1999.00),    -- Sunrise Farms Inc. delivering Organic Apple
    (2, 2, '2024-01-10', 'TRK123457', 50, 1499.50),     -- Provenance Provisions LLC delivering Whole Grain Bread
    (3, 3, '2024-01-15', 'TRK123458', 75, 2999.25),     -- Harvest Home Gourmet delivering Free-Range Chicken
    (4, 4, '2024-01-20', 'TRK123459', 200, 9998.00),    -- FreshFusion Foods Ltd. delivering Almond Milk
    (5, 5, '2024-01-25', 'TRK123460', 150, 8998.50),    -- TasteQuest Ingredients Co. delivering Gluten-Free Pasta
    (6, 6, '2024-01-30', 'TRK123461', 100, 6999.00),    -- SunnySide Grocery Supply delivering Extra Virgin Olive Oil
    (7, 7, '2024-02-05', 'TRK123462', 80, 6399.20),     -- Greenspace Produce Partners delivering Greek Yogurt
    (8, 8, '2024-02-10', 'TRK123463', 90, 8099.10),     -- MeatMaster Foods Inc. delivering Organic Quinoa
    (9, 9, '2024-02-15', 'TRK123464', 120, 11998.80),   -- FlavorFusion Food Products delivering Wild-Caught Salmon
    (10, 10, '2024-02-20', 'TRK123465', 110, 12098.90); -- Nourish Natural Foods Co. delivering Dark Chocolate

-- customer_addresses
INSERT INTO customeraddresses (street_name,street_no, city, state, zip, country)
VALUES 
    ('Luebecker Str',       19, 'Reckendorf',      'Freistaat Bayern',       '96182', 'Germany'),
    ('Brandenburgische str',72, 'Berlin Neukolln', 'Berlin',                 '12053', 'Germany'),
    ('Hermannstrasse',      13, 'Florsheim',       'Rheinland-Pfalz',        '67592', 'Germany'),
    ('Schonwalder Allee',   21, 'Rendsburg',       'Schleswig-Holstein',     '24757', 'Germany'),
    ('Genslerstabe',        04, 'Berlin Tempelhof','Berlin',                 '12107', 'Germany'),
    ('Leipziger Str',       31, 'Bevern',          'Niedersachsen',          '37639', 'Germany'),
    ('Rhinstrasse',         87, 'Freiberg',        'Baden-Württemberg',      '71691', 'Germany'),
    ('Hedemannstasse',      01, 'Munchen',         'Freistaat Bayern',       '80731', 'Germany'),
    ('Kantstraße',          70, 'Großräschen',     'Brandenburg',            '01981', 'Germany'),
    ('Reeperbahn',          13, 'Geneva',          'Mecklenburg-Vorpommern', '18303', 'Germany');

-- Customers
INSERT INTO Customers (first_name, last_name, email_address, phone_number,calling_code, address_id)
VALUES 
    ('Mayra',   'Kling',   'mayra10@yahoo.com',       '09531 19 81 28','(+49)',  1),
    ('Marvin',  'Smith',   'marvin.rocky@yahoo.org',  '030 86 76 99',  '(+49)',  2),
    ('Paxton',  'Brown',   'paxton.howell@gmail.com', '06747 22 63 72','(+49)',  3),
    ('Bob',     'Heller',  'bobheller@icloud.com',    '06243 38 08 43','(+49)',  4),
    ('Charlie', 'Davis',   'charliedavis@gmail.com',  '09201 21 17 67','(+49)',  5),
    ('Isabella','Crona',   'isabella@icloud.com',     '04331 60 59 92','(+49)',  6),
    ('Heineken','Hofmann', 'heinekenmann@icloud.com', '05231 29 02 77','(+49)',  7),
    ('Frank',   'Hartmann','frankhartmann@gmail.com', '039454 74 80',  '(+49)',  8),
    ('George',  'Hall',    'georgehall@outlook.com',  '06754 84 72 79','(+49)',  9),
    ('Helen',   'Martin',  'helenmartin@hotmail.com', '09352 92 14 21','(+49)', 10);
 
-- Products
INSERT INTO Products (product_name, supplier_id, description, price)
VALUES 
    ('Organic Apple',          1, 'Fresh organic apple, sourced from sustainable farms.',        19.99),
    ('Whole Grain Bread',      2, 'Healthy whole grain bread with no artificial preservatives.', 29.99),
    ('Free-Range Chicken',     3, 'Free-range chicken, raised without antibiotics.',             39.99),
    ('Almond Milk',            4, 'Vegan almond milk, rich in vitamins and minerals.',           49.99),
    ('Gluten-Free Pasta',      5, 'Delicious gluten-free pasta made from rice flour.',           59.99),
    ('Extra Virgin Olive Oil', 6, 'High-quality extra virgin olive oil from Italy.',             69.99),
    ('Greek Yogurt',           7, 'Creamy Greek yogurt, packed with probiotics.',                79.99),
    ('Organic Quinoa',         8, 'Organic quinoa, a versatile and nutritious superfood.',       89.99),
    ('Wild-Caught Salmon',     9, 'Wild-caught salmon, rich in omega-3 fatty acids.',            99.99),
    ('Dark Chocolate',        10, 'Premium dark chocolate with 70% cocoa content.',             109.99);

-- Orders
INSERT INTO Orders (customer_id, order_date, total_price)
VALUES 
    ( 1, '2024-01-01',  100.00),
    ( 2, '2024-02-01',  200.00),
    ( 3, '2024-03-01',  300.00),
    ( 4, '2024-04-01',  400.00),
    ( 5, '2024-05-01',  500.00),
    ( 6, '2024-06-01',  600.00),
    ( 7, '2023-07-01',  700.00),
    ( 8, '2023-08-01',  800.00),
    ( 9, '2023-09-01',  900.00),
    (10, '2023-10-01', 1000.00);

-- OrderItems
INSERT INTO OrderItems (order_id, product_id, quantity, price)
VALUES 
    (11,  1, 1,  19.99),
    (12,  2, 2,  29.99),
    (13,  3, 1,  39.99),
    (14,  4, 2,  49.99),
    (15,  5, 1,  59.99),
    (16,  6, 2,  69.99),
    (17,  7, 1,  79.99),
    (18,  8, 2,  89.99),
    (19,  9, 1,  99.99),
    (20, 10, 2, 109.99);

-- ReturnedItems
INSERT INTO ReturnedItems (order_id, product_id)
VALUES 
    (11,  1),
    (12,  3),
    (13,  4),
    (14,  5),
    (15,  6),
    (16,  7),
    (17,  8),
    (18,  9),
    (19, 10);

-- Refunds
INSERT INTO Refunds (returned_item_id, refund_date, amount)
VALUES 
    (1, '2024-01-15', 19.99),
    (2, '2024-02-20', 39.99),
    (3, '2024-03-25', 49.99),
    (4, '2024-04-30', 59.99),
    (5, '2024-05-20', 69.99),
    (6, '2024-06-15', 79.99),
    (7, '2023-07-25', 89.99),
    (8, '2023-08-10', 99.99),
    (9, '2023-09-20', 109.99);
   
-- Delivery   
INSERT INTO Delivery (order_id, tracking_number, delivery_date)
VALUES
  (11, 'USPS12345',  '2024-02-15'),
  (12, 'UPS78901',   '2024-03-22'),
  (13, 'FEDEX34567', '2024-04-05'),
  (14, 'USPS90123',  '2024-05-10'),
  (15, 'UPS11111',   '2024-06-15'),
  (16, 'FEDEX22222', '2023-07-20'),
  (17, 'USPS33333',  '2023-08-25'),
  (18, 'UPS44444',   '2023-09-30'),
  (19, 'FEDEX55555', '2023-10-05'),
  (20, 'USPS66666',  '2023-11-15');
 
-- PaymentMethods
INSERT INTO PaymentMethods (method_name)
VALUES 
    ('Cash'),
    ('Credit Card'),
    ('Debit Card'),
    ('PayPal'),
    ('Bank Transfer');

-- Payments
INSERT INTO Payments (order_id, payment_method_id, payment_date, amount)
VALUES 
    (11, 1, '2024-01-05', 100.00),
    (12, 2, '2024-02-10', 200.00),
    (13, 3, '2024-03-15', 300.00),
    (14, 4, '2024-04-20', 400.00),
    (15, 5, '2024-05-25', 500.00),
    (16, 2, '2023-06-10', 600.00),
    (17, 3, '2023-07-15', 700.00),
    (18, 4, '2023-08-20', 800.00),
    (19, 5, '2023-09-25', 900.00);
