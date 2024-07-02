# M605A-Grocery-store-DB

# Database Project Repository

This repository contains the following files:

## ER Diagrams
 <img width="1109" alt="ER Diagram" src="https://github.com/Anushsekar/M605A-Grocery-store-DB/assets/67989000/7d2ab965-bc42-4984-8057-a99a5de20a0b">


## Database Files
- `Table_and_Sample_Datas.sql`: SQL script to create all tables &insert sample data into each table.

## Query Files
- `Queries_&_Others.sql`: SQL query to get the number of products per supplier and others such as triggers, index and views.
.

## Instructions
1. Run `Table_and_Sample_Datas.sql` to create the database schema.
2. Use the SQL queries in the `Queries_&_Others.sql` folder to retrieve relevant information.

For any additional information, refer to the individual `README.md` files in the respective folders.

Table Customers {
  customer_id INT [pk]
  first_name VARCHAR
  last_name VARCHAR
  email_address VARCHAR
  phone_number VARCHAR
  calling_code VARCHAR
  address_id INT [ref: > CustomerAddresses.address_id]
}

Table CustomerAddresses {
  address_id INT [pk]
  street_name VARCHAR
  street_no INT
  city VARCHAR
  state VARCHAR
  zip VARCHAR
  country VARCHAR
}

Table Suppliers {
  supplier_id INT [pk]
  supplier_name VARCHAR
  email_address VARCHAR
  phone_number VARCHAR
  address VARCHAR
}

Table SupplierDeliveries {
  delivery_id INT [pk]
  supplier_id INT [ref: > Suppliers.supplier_id]
  product_id INT [ref: > Products.product_id]
  delivery_date DATE
  tracking_number VARCHAR
  quantity INT
  price DECIMAL
}

Table Products {
  product_id INT [pk]
  product_name VARCHAR
  supplier_id INT [ref: > Suppliers.supplier_id]
  description TEXT
  price DECIMAL
}

Table Orders {
  order_id INT [pk]
  customer_id INT [ref: > Customers.customer_id]
  order_date DATE
  total_price DECIMAL
}

Table OrderItems {
  order_item_id INT [pk]
  order_id INT [ref: > Orders.order_id]
  product_id INT [ref: > Products.product_id]
  quantity INT
  price DECIMAL
}

Table ReturnedItems {
  returned_item_id INT [pk]
  order_id INT [ref: > Orders.order_id]
  product_id INT [ref: > Products.product_id]
}

Table Refunds {
  refund_id INT [pk]
  returned_item_id INT [ref: > ReturnedItems.returned_item_id]
  refund_date DATETIME
  amount DECIMAL
}

Table Delivery {
  delivery_id INT [pk]
  order_id INT [ref: > Orders.order_id]
  tracking_number VARCHAR
  delivery_date DATE
}

Table PaymentMethods {
  payment_method_id INT [pk]
  method_name VARCHAR
}

Table Payments {
  payment_id INT [pk]
  order_id INT [ref: > Orders.order_id]
  payment_method_id INT [ref: > PaymentMethods.payment_method_id]
  payment_date DATETIME
  amount DECIMAL
}
