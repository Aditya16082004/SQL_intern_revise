# SQL_intern_revise

USE intern;

-- Create tables

-- Table: items
CREATE TABLE items (
    item_id INT(3) PRIMARY KEY,
    item_name VARCHAR(50) NOT NULL,
    item_price DECIMAL(10, 2) NOT NULL,
    quantity INT(5),
    city VARCHAR(30) CHECK(city IN ('New York', 'Los Angeles', 'Chicago')),
    added_date DATE,
    updated_at DATETIME
);

-- Table: clients
CREATE TABLE clients (
    client_id INT(3) PRIMARY KEY,
    client_name VARCHAR(30) NOT NULL,
    client_age INT(2) NOT NULL CHECK(client_age >= 18),
    address VARCHAR(50),
    client_email VARCHAR(100) UNIQUE
);

-- Table: purchases
CREATE TABLE purchases (
    purchase_id INT(3) PRIMARY KEY,
    client_id INT(3),
    item_id INT(3),
    total_amount DECIMAL(10, 2) NOT NULL,
    purchase_date DATETIME,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Table: transactions
CREATE TABLE transactions (
    transaction_id INT(3) PRIMARY KEY,
    purchase_id INT(3),
    trans_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(30) CHECK(payment_method IN ('paypal', 'bank_transfer', 'cash')),
    trans_status VARCHAR(30) CHECK(trans_status IN ('pending', 'declined', 'successful')),
    FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id)
);

-- Table: staff
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50),
    monthly_salary DECIMAL(10, 2)
);

-- Table: learners
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    learner_email VARCHAR(100) UNIQUE,
    learner_age INT CHECK (learner_age >= 18),
    course_id INT,
    final_grade CHAR(1) DEFAULT 'F'
);

-- Table: modules
CREATE TABLE modules (
    module_id INT PRIMARY KEY,
    module_title VARCHAR(100) NOT NULL
);

-- Alter learners table to add foreign key constraint
ALTER TABLE learners
ADD CONSTRAINT fk_module
FOREIGN KEY (course_id)
REFERENCES modules (module_id)
ON DELETE CASCADE;


-- Inserting values into items table
INSERT INTO items VALUES (101, 'Dell Laptop', 60000.00, 20, 'New York', '2023-02-01', NOW());
INSERT INTO items VALUES (102, 'Samsung Galaxy', 25000.00, 40, 'Los Angeles', '2023-03-01', NOW());
INSERT INTO items VALUES (103, 'Sony Headphones', 4000.00, 60, 'Chicago', '2023-04-01', NOW());
INSERT INTO items VALUES (104, 'HP Monitor', 15000.00, 10, 'New York', '2023-05-01', NOW());
INSERT INTO items VALUES (105, 'Wireless Mouse', 1500.00, 0, 'New York', '2023-06-01', NOW());
INSERT INTO items VALUES (106, 'iMac', 90000.00, 8, 'Los Angeles', '2023-07-01', NOW());
INSERT INTO items VALUES (107, 'Amazon Echo', 8000.00, 3, 'Chicago', '2023-08-01', NOW());

-- Inserting values into clients table
INSERT INTO clients VALUES (201, 'John', 35, 'New York', 'john@example.com');
INSERT INTO clients VALUES (202, 'Emily', 28, 'Los Angeles', 'emily@example.com');
INSERT INTO clients VALUES (203, 'Michael', 34, 'Chicago', 'michael@example.com');
INSERT INTO clients VALUES (204, 'Anna', 30, 'New York', 'anna@example.com');
INSERT INTO clients VALUES (205, 'David', 26, 'Los Angeles', 'david@example.com');

-- Inserting values into purchases table
INSERT INTO purchases VALUES (301, 202, 103, 3800.00, NOW());
INSERT INTO purchases VALUES (302, 204, 102, 24000.00, NOW());
INSERT INTO purchases VALUES (303, 205, 105, 1300.00, NOW());
INSERT INTO purchases VALUES (304, 201, 101, 58000.00, NOW());

-- Inserting values into transactions table
INSERT INTO transactions VALUES (401, 301, 3800.00, 'paypal', 'successful');
INSERT INTO transactions VALUES (402, 302, 24000.00, 'bank_transfer', 'successful');
INSERT INTO transactions VALUES (403, 303, 1300.00, 'cash', 'pending');

-- Inserting values into staff table
INSERT INTO staff VALUES (1, 'Peter Parker', 'Developer', 90000.00);
INSERT INTO staff VALUES (2, 'Bruce Wayne', 'Manager', 100000.00);
INSERT INTO staff VALUES (3, 'Clark Kent', 'Designer', 85000.00);

-- Inserting values into modules table
INSERT INTO modules VALUES (301, 'Data Science');
INSERT INTO modules VALUES (302, 'Marketing');
INSERT INTO modules VALUES (303, 'Mechanical Engineering');

-- Inserting values into learners table
INSERT INTO learners VALUES (401, 'Diana Prince', 'diana@example.com', 23, 301, 'A');
INSERT INTO learners VALUES (402, 'Barry Allen', 'barry@example.com', 25, 302, 'B');
INSERT INTO learners VALUES (403, 'Arthur Curry', 'arthur@example.com', 22, 303, 'C');

-- Update item details and set the updated_at to the current timestamp
UPDATE items SET item_price = 65000.00, updated_at = NOW() WHERE item_id = 101;

-- Delete items with quantity below a certain threshold
DELETE FROM items WHERE quantity < 10;
-- Queries to retrieve data based on various conditions

-- Retrieve items with a price greater than 100 and added after January 1, 2022
SELECT * FROM items WHERE item_price > 100 AND added_date > '2022-01-01';

-- Retrieve clients aged between 25 and 35
SELECT * FROM clients WHERE client_age BETWEEN 25 AND 35;

-- Retrieve purchases made by a specific client
SELECT * FROM purchases WHERE client_id = 202;

-- Retrieve transactions with status 'successful'
SELECT * FROM transactions WHERE trans_status = 'successful';

-- Retrieve learners enrolled in a specific module
SELECT * FROM learners WHERE course_id = 301;

-- Retrieve staff with a salary greater than 75000
SELECT * FROM staff WHERE monthly_salary > 75000;

-- Retrieve clients from a specific city
SELECT * FROM clients WHERE address = 'New York';

-- Retrieve purchases with total_amount greater than a specified value
SELECT * FROM purchases WHERE total_amount > 10000;

-- Retrieve transactions made using 'bank_transfer' method
SELECT * FROM transactions WHERE payment_method = 'bank_transfer';

-- Retrieve learners with a specific grade
SELECT * FROM learners WHERE final_grade = 'A';

-- Retrieve items located in 'Los Angeles'
SELECT * FROM items WHERE city = 'Los Angeles';

-- Retrieve purchases made on a specific date
SELECT * FROM purchases WHERE DATE(purchase_date) = '2023-02-01';

-- Retrieve clients with a specific email domain
SELECT * FROM clients WHERE client_email LIKE '%@example.com';

-- Retrieve transactions for a specific purchase
SELECT * FROM transactions WHERE purchase_id = 301;

-- Retrieve learners older than 20
SELECT * FROM learners WHERE learner_age > 20;

-- Retrieve items sorted by price
SELECT * FROM items ORDER BY item_price DESC;

-- Retrieve clients sorted by age
SELECT * FROM clients ORDER BY client_age ASC;

-- Retrieve purchases sorted by purchase_date
SELECT * FROM purchases ORDER BY purchase_date DESC;

-- Retrieve transactions sorted by trans_amount
SELECT * FROM transactions ORDER BY trans_amount DESC;

-- Retrieve staff sorted by salary
SELECT * FROM staff ORDER BY monthly_salary ASC;

-- Retrieve learners sorted by name
SELECT * FROM learners ORDER BY full_name ASC;

-- Retrieve items within a specific price range
SELECT * FROM items WHERE item_price BETWEEN 1000 AND 50000;

-- Retrieve clients whose names start with 'J'
SELECT * FROM clients WHERE client_name LIKE 'J%';

-- Retrieve purchases for a specific item
SELECT * FROM purchases WHERE item_id = 103;

-- Retrieve transactions with a specific status
SELECT * FROM transactions WHERE trans_status = 'pending';

-- Retrieve learners enrolled in a specific module and having a specific grade
SELECT * FROM learners WHERE course_id = 301 AND final_grade = 'A';

-- Retrieve items with quantity between 10 and 50
SELECT * FROM items WHERE quantity BETWEEN 10 AND 50;

-- Retrieve clients aged below 30
SELECT * FROM clients WHERE client_age < 30;

-- Retrieve purchases with total_amount less than a specified value
SELECT * FROM purchases WHERE total_amount < 5000;

-- Retrieve transactions made using 'paypal' method
SELECT * FROM transactions WHERE payment_method = 'paypal';

-- Retrieve learners with age between 18 and 22
SELECT * FROM learners WHERE learner_age BETWEEN 18 AND 22;

-- Retrieve items added after a specific date
SELECT * FROM items WHERE added_date > '2023-01-01';

-- Retrieve clients with a specific address
SELECT * FROM clients WHERE address = 'Los Angeles';

-- Retrieve purchases made by clients older than 25
SELECT * FROM purchases WHERE client_id IN (SELECT client_id FROM clients WHERE client_age > 25);




-- arithematic operators




-- Calculate the sum of all item prices to get the total revenue
SELECT SUM(item_price) AS total_revenue FROM items;

-- Select items where the price is divisible by 3
SELECT * FROM items WHERE item_price % 3 = 0;

-- Calculate the difference between each item's price and the average price
SELECT item_id, item_name, item_price, (item_price - (SELECT AVG(item_price) FROM items)) AS price_difference FROM items;




-- comparison operators



-- Select items with a price of 50000 or more
SELECT * 
FROM items 
WHERE item_price >= 50000;

-- Select clients whose age is not 30
SELECT * 
FROM clients 
WHERE client_age != 30;

-- Select purchases with a total amount of 10000 or less
SELECT * 
FROM purchases 
WHERE total_amount <= 10000;


-- Bitwise operators


-- The bitwise AND (&) operator performs a binary AND operation on each pair of corresponding bits in the operands.
-- For example, 5 & 3 in binary is 0101 & 0011 which results in 0001, which is the decimal value 1.
SELECT 5 & 3; -- Result: 1

-- The bitwise OR (|) operator performs a binary OR operation on each pair of corresponding bits in the operands.
-- For example, 5 | 3 in binary is 0101 | 0011 which results in 0111, which is the decimal value 7.
SELECT 5 | 3; -- Result: 7

-- The bitwise XOR (^) operator performs a binary XOR operation on each pair of corresponding bits in the operands.
-- For example, 5 ^ 3 in binary is 0101 ^ 0011 which results in 0110, which is the decimal value 6.
SELECT 5 ^ 3; -- Result: 6


-- logical operators


-- Select items located in 'Los Angeles' with a quantity greater than 10

SELECT * 
FROM items 
WHERE city = 'Los Angeles' 
AND quantity > 10;

-- Select clients who are from 'New York' or have made purchases totaling more than 20000

SELECT * 
FROM clients 
WHERE address = 'New York' 
OR client_id IN (
    -- Subquery to find clients with purchases totaling more than 20000
    SELECT client_id 
    FROM purchases 
    WHERE total_amount > 20000
);

 -- Select transactions with a payment method not equal to 'cash' and a status of 'successful'
SELECT * 
FROM transactions 
WHERE payment_method != 'cash' 
AND trans_status = 'successful';
