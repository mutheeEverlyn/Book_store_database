
-- Creating database
CREATE DATABASE  bookstore_db;
USE bookstore_db;




-- shipping_method table
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100),
    cost DECIMAL(10, 2)
);

-- order_status table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- cust_order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(status_id)
);

-- order_line table
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- order_history table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


-- Create Admin User with Full access
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminspass123!';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'admin'@'localhost';

-- Create Read-Only User: Can only view data
CREATE USER 'user'@'localhost' IDENTIFIED BY 'ReadOnlyusers123!';
GRANT SELECT ON bookstore_db.* TO 'user'@'localhost';

-- Create Data Entry User who Can insert and update, but not delete
CREATE USER 'entrystaff'@'localhost' IDENTIFIED BY 'EntryPassword123!';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.* TO 'entrystaff'@'localhost';

-- Create Shipping Staff who Can view and update shipping/order tables
CREATE USER 'shippingstaff'@'localhost' IDENTIFIED BY 'ShipstaffPass123!';
GRANT SELECT, UPDATE ON bookstore_db.cust_order TO 'shippingstaff'@'localhost';
GRANT SELECT, UPDATE ON bookstore_db.order_status TO 'shippingstaff'@'localhost';
GRANT SELECT, INSERT ON bookstore_db.order_history TO 'shippingstaff'@'localhost';




