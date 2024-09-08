CREATE DATABASE IF NOT EXISTS CreditCardFraudDetection;
USE CreditCardFraudDetection;


CREATE TABLE Customers (
customer_id INT PRIMARY KEY, -- Number of customer
name VARCHAR(100),           -- Name of customer
email VARCHAR(100),          -- Email of customer
phone_number VARCHAR(15),    -- Phone number of customer
address VARCHAR(255)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,  -- Each purchase has a number
    customer_id INT,                 -- Which customer bought it
    transaction_date DATE,           -- The day they bought it
    transaction_time TIME,           -- The time they bought it
    amount DECIMAL(10, 2),           -- How much money they spent
    location VARCHAR(100),           -- The city where they bought it
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

USE CreditCardFraudDetection;
-- Insert sample data into Customers table
INSERT INTO Customers (customer_id, name, email, phone_number, address) VALUES
(1, 'Erik Johansson', 'erik.johansson@example.com', '+46701234567', 'Drottninggatan 1, Stockholm'),
(2, 'Anna Svensson', 'anna.svensson@example.com', '+46709876543', 'Kungsgatan 10, Gothenburg'),
(3, 'Oskar Lind', 'oskar.lind@example.com', '+46705678901', 'Stora Södergatan 5, Malmö'),
(4, 'Elin Karlsson', 'elin.karlsson@example.com', '+46702349876', 'Järntorget 3, Uppsala'),
(5, 'Lars Nilsson', 'lars.nilsson@example.com', '+46708912345', 'Avenyn 20, Gothenburg');

-- Insert sample data into Transactions table
INSERT INTO Transactions (transaction_id, customer_id, transaction_date, transaction_time, amount, location) VALUES
(1, 1, '2024-08-27', '10:15:00', 450.50, 'Stockholm'),
(2, 1, '2024-08-27', '10:25:00', 15000.00, 'Stockholm'),
(3, 2, '2024-08-27', '11:00:00', 200.00, 'Gothenburg'),
(4, 3, '2024-08-28', '09:30:00', 320.00, 'Malmö'),
(5, 4, '2024-08-28', '14:00:00', 600.00, 'Uppsala'),
(6, 5, '2024-08-28', '16:30:00', 450.00, 'Gothenburg');


USE CreditCardFraudDetection;

SELECT 
    transaction_id AS TransactionID,
    customer_id AS CustomerID,
    amount AS Amount,
    transaction_date AS 'Transaction Date', 
    location AS Location
FROM 
    Transactions
WHERE 
    amount > 10000;  -- Show me transactions that cost more than 10,000 SEK
    
    USE CreditCardFraudDetection;

SELECT 
    t1.transaction_id AS 'FROM TransactionID', 
    t1.customer_id AS CustomerID, 
    t1.transaction_date AS Date, 
    t1.transaction_time AS 'From Time', 
    t1.location AS 'From Location', 
    t2.transaction_id AS 'To TransactionID', 
    t2.transaction_time AS 'To Time', 
    t2.location AS 'To Location'
FROM 
    Transactions t1
JOIN 
    Transactions t2 
ON 
    t1.customer_id = t2.customer_id
    AND t1.transaction_date = t2.transaction_date
    AND t1.transaction_id < t2.transaction_id
    AND t1.location <> t2.location
    AND TIMESTAMPDIFF(MINUTE, 
    CONCAT(t1.transaction_date, ' ', t1.transaction_time), 
    CONCAT(t2.transaction_date, ' ', t2.transaction_time)
    ) < 60;


