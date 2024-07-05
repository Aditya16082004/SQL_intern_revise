-- TCL (Transaction control language) Commands
/*
TCL commands are used to manage transactions, maintain ACID properties, and control the flow of data modifications.
TCL commands ensure the consistency and durability of data in a database.
For example, if an operation fails during a transaction, the transaction is rolled back.
When a transaction is committed, its changes are permanent, even if the system fails or restarts.
TCL commands also ensure that all operations within a transaction are executed as a single unit.
*/

-- commit
/*
Commit: Saves a transaction to the database
*/
commit;
-- rollback
/*
Rollback: Undoes a transaction or change that hasn't been saved to the database
*/
rollback;

-- savepoint
/*
Savepoint: Temporarily saves a transaction for later rollback 
*/
savepoint a;
-- here it will store that as a
-- after we can call that by rollback to a
rollback to a;

-- any operation performed on table using dml
-- insert,delete,update every command is transaction 

/*
In mysql it is having auto commit so is doesnot make anysense transaction commands in mysql
for this we have to use command start transaction
*/

-- Triggers 

-- Trigger is a statement that a system executes automatically when there is any modification to the database
-- Triggers are used to specify certain integrity constraints and referential constraints that cannot be specified using the constraint mechanism of SQL

-- Trigers are 6 types 
/*
1)after insert -- activated after data is inserted into the table.
2)after update -- activated after data in the table is modified. 
3)after delete -- activated after data is deleted/removed from the table. 
4)before insert -- activated before data is inserted into the table. 
5)before update -- activated before data in the table is modified.
6)before delete --  activated before data is deleted/removed from the table. 
*/
-- Delimiters are necessary when creating stored procedures or triggers
-- Delimiters are used in MySQL to avoid conflicts with semicolons within SQL statements

													Uses of tirggers
Enforcing Data Integrity and Business Rules:

Data Validation: Triggers can validate data before it's inserted or updated, ensuring it adheres to specific rules. 
For example, a trigger can prevent negative product stock values or enforce a minimum age requirement for customer entries.

Maintaining Referential Integrity: Triggers can automatically maintain relationships between tables. 
When a record is deleted from a parent table (e.g., customers), a trigger can cascade the deletion to related child records (e.g., orders) or prevent deletion if dependent records exist.

Enforcing Business Logic: Triggers can implement complex business rules that might not be easily achievable with standard SQL statements. 
For instance, a trigger could automatically calculate discounts based on order amount or apply loyalty point adjustments upon successful purchases.

security:Triggers can enforce data access restrictions or security checks on specific events within the database.

Performance Impact: Triggers can introduce overhead to data manipulation operations. Analyze their impact on performance and optimize them if necessary.

Trigger Order: When using multiple triggers, their execution order can be important. Define the order in which triggers fire to ensure desired results.

*/

											-- advance triggers 
-- Advanced triggers can be used to implement row-level security restrictions. For example, a trigger can filter data displayed to a user based on their role:
/*
DELIMITER //
CREATE TRIGGER filter_products_by_role
BEFORE SELECT ON products
FOR EACH ROW
BEGIN
  DECLARE user_role VARCHAR(50);

  -- Get user role from session variable or another source
  SET user_role = 'user';  -- Replace with logic to get actual role

  IF user_role = 'admin' THEN
    SET FOUND = 1;  -- Allow admin to see all products
  ELSEIF user_role = 'user' AND NEW.location = 'Mumbai' THEN
    SET FOUND = 1;  -- Allow users to see only Mumbai products
  ELSE
    SET FOUND = 0;  -- Block other roles from seeing data
  END IF;
END //
DELIMITER ;
*/

														-- create or replace veiws 
#Create a new view: If the view doesn't already exist, it defines a new virtual table based on a specified query.
#Replace an existing view: If a view with the same name already exists, it replaces its definition with the new query provided in the statement.


-- Use the appropriate database
USE internsql;

-- Create tables
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS customer (
    cid INT AUTO_INCREMENT PRIMARY KEY,
    cname VARCHAR(100),
    age INT,
    addr VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS products (
    pid INT AUTO_INCREMENT PRIMARY KEY,
    pname VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT,
    location VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100),
    amount DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS orders (
    oid INT AUTO_INCREMENT PRIMARY KEY,
    cid INT,
    pid INT,
    amt DECIMAL(10, 2),
    FOREIGN KEY (cid) REFERENCES customer(cid),
    FOREIGN KEY (pid) REFERENCES products(pid)
);

CREATE TABLE IF NOT EXISTS payment (
    pay_id INT AUTO_INCREMENT PRIMARY KEY,
    oid INT,
    amount DECIMAL(10, 2),
    mode VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (oid) REFERENCES orders(oid)
);

CREATE TABLE IF NOT EXISTS product_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    pid INT,
    pname VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT,
    location VARCHAR(100),
    inserted_at DATETIME,
    updated_at DATETIME,
    deleted_at DATETIME
);

-- Insert sample data
INSERT INTO employees (first_name, last_name, department_id, job_title, salary)
VALUES 
    ('John', 'Doe', 1, 'Manager', 75000.00),
    ('Jane', 'Smith', 1, 'Team Lead', 65000.00),
    ('Michael', 'Johnson', 2, 'Developer', 60000.00),
    ('Emily', 'Williams', 2, 'Developer', 60000.00),
    ('Robert', 'Brown', 1, 'Analyst', 55000.00),
    ('Jessica', 'Miller', 3, 'Designer', 50000.00),
    ('William', 'Davis', 3, 'Designer', 50000.00),
    ('Mary', 'Wilson', 1, 'Manager', 80000.00);

INSERT INTO customer (cname, age, addr)
VALUES 
    ('John Smith', 35, '123 Main St, Anytown, USA'),
    ('Jane Doe', 28, '456 Oak Ave, Anycity, USA'),
    ('Michael Johnson', 40, '789 Elm Blvd, Anystate, USA'),
    ('Emily Williams', 32, '567 Pine Dr, Anothercity, USA');

INSERT INTO products (pname, price, stock, location)
VALUES 
    ('Product A', 100.00, 50, 'New York'),
    ('Product B', 150.00, 100, 'Los Angeles'),
    ('Product C', 200.00, 75, 'Chicago'),
    ('Product D', 75.00, 30, 'Houston');

INSERT INTO sales (category, amount)
VALUES 
    ('Electronics', 5000.00),
    ('Clothing', 3000.00),
    ('Books', 2000.00),
    ('Electronics', 7000.00),
    ('Clothing', 4000.00);

INSERT INTO orders (cid, pid, amt)
VALUES 
    (1, 1, 100.00),
    (2, 2, 150.00),
    (3, 3, 200.00),
    (4, 1, 75.00),
    (1, 2, 125.00),
    (3, 4, 50.00),
    (2, 3, 180.00);

INSERT INTO payment (oid, amount, mode, status)
VALUES 
    (1, 100.00, 'credit', 'completed'),
    (2, 150.00, 'credit', 'completed'),
    (3, 200.00, 'credit', 'completed'),
    (4, 75.00, 'credit', 'completed'),
    (5, 125.00, 'credit', 'completed'),
    (6, 50.00, 'credit', 'completed'),
    (7, 180.00, 'credit', 'completed');

-- Create views
CREATE OR REPLACE VIEW CustomerOrders AS
SELECT c.cid, c.cname, o.oid, o.amt, p.pname
FROM customer c
JOIN orders o ON c.cid = o.cid
JOIN products p ON o.pid = p.pid;

CREATE OR REPLACE VIEW payment_order_customer_details AS
SELECT p.pay_id, p.oid, o.cid, c.cname, c.age, c.addr, p.amount, p.mode, p.status
FROM payment p
JOIN orders o ON p.oid = o.oid
JOIN customer c ON o.cid = c.cid;

-- Triggers
DELIMITER //

-- After Insert Trigger for Logging Product Insertions
CREATE TRIGGER products_after_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO product_log (pid, pname, price, stock, location, inserted_at)
  VALUES (NEW.pid, NEW.pname, NEW.price, NEW.stock, NEW.location, NOW());
END //

-- After Insert Trigger to Update Stock Levels After Each New Order
CREATE TRIGGER orders_after_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE products
  SET stock = stock - NEW.amt
  WHERE pid = NEW.pid;
END //

-- After Update Trigger to Log Changes Made to Product Information
CREATE TRIGGER products_after_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
  IF OLD.pid <> NEW.pid OR OLD.pname <> NEW.pname OR OLD.price <> NEW.price OR OLD.stock <> NEW.stock OR OLD.location <> NEW.location THEN
    INSERT INTO product_log (pid, pname, price, stock, location, updated_at)
    VALUES (OLD.pid, OLD.pname, OLD.price, OLD.stock, OLD.location, NOW());
  END IF;
END //

-- After Delete Trigger to Prevent Deletion of Product with Existing Orders
CREATE TRIGGER products_after_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
  DECLARE has_orders INT DEFAULT 0;

  SELECT COUNT(*) INTO has_orders
  FROM orders
  WHERE pid = OLD.pid;

  IF has_orders > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product with existing orders. Update or delete orders first.';
  END IF;
END //

-- Before Insert Trigger for Automatic Payment Status on Payment Insert
CREATE TRIGGER set_default_payment_status
BEFORE INSERT ON payment
FOR EACH ROW
BEGIN
  IF NEW.status IS NULL THEN
    SET NEW.status = 'Pending';
  END IF;
END //

-- TCL Commands Example
START TRANSACTION;
INSERT INTO products (pid, pname, price, stock, location) VALUES (8, 'iPhone 12', 79900, 10, 'Delhi');
INSERT INTO customer (cid, cname, age, addr) VALUES (106, 'John Doe', 35, '123 Main Street');
INSERT INTO orders (oid, cid, pid, amt) VALUES (1005, 106, 8, 79900);
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES (1, 1005, 79900, 'credit', 'completed');
SAVEPOINT A;
ROLLBACK TO A;
COMMIT;

DELIMITER ;
