-- Create the database
CREATE DATABASE IF NOT EXISTS InsuranceDB1;

-- Use the database
USE InsuranceDB1;

-- Create Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

-- Create Policies Table
CREATE TABLE IF NOT EXISTS Policies (
    PolicyID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyNumber VARCHAR(20) NOT NULL UNIQUE,
    CustomerID INT NOT NULL,
    PolicyType ENUM('Health', 'Vehicle', 'Home', 'Life') NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    PremiumAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Create Claims Table
CREATE TABLE IF NOT EXISTS Claims (
    ClaimID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyID INT NOT NULL,
    ClaimDate DATE NOT NULL,
    ClaimAmount DECIMAL(10, 2) NOT NULL,
    ClaimStatus ENUM('Pending', 'Approved', 'Rejected') NOT NULL,
    FOREIGN KEY (PolicyID) REFERENCES Policies(PolicyID) ON DELETE CASCADE
);

-- Create Payments Table
CREATE TABLE IF NOT EXISTS Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    AmountPaid DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('Credit Card', 'Debit Card', 'Bank Transfer', 'Cash') NOT NULL,
    FOREIGN KEY (PolicyID) REFERENCES Policies(PolicyID) ON DELETE CASCADE
);

-- Populate Customers Table
INSERT INTO Customers (FullName, Age, Gender, Address, PhoneNumber, Email) VALUES
('John Doe', 35, 'Male', '123 Elm Street', '555-1234', 'johndoe@example.com'),
('Jane Smith', 29, 'Female', '456 Maple Avenue', '555-5678', 'janesmith@example.com'),
('Alice Johnson', 50, 'Female', '789 Pine Road', '555-8765', 'alicej@example.com'),
('Bob Brown', 40, 'Male', '321 Oak Street', '555-4321', 'bobbrown@example.com'),
('Charlie Adams', 28, 'Male', '555 Cedar Lane', '555-1111', 'charliea@example.com'),
('Diana Lee', 45, 'Female', '678 Birch Road', '555-2222', 'dianal@example.com'),
('Ethan White', 60, 'Male', '912 Spruce Street', '555-3333', 'ethanw@example.com'),
('Fiona Green', 33, 'Female', '344 Cypress Avenue', '555-4444', 'fionag@example.com'),
('George King', 39, 'Male', '100 Willow Way', '555-5555', 'georgek@example.com'),
('Hannah Black', 25, 'Female', '222 Aspen Drive', '555-6666', 'hannahb@example.com');

-- Populate Policies Table
INSERT INTO Policies (PolicyNumber, CustomerID, PolicyType, StartDate, EndDate, PremiumAmount) VALUES
('POL123', 1, 'Health', '2023-01-01', '2023-12-31', 1200.00),
('POL124', 2, 'Vehicle', '2023-02-01', '2024-01-31', 800.00),
('POL125', 3, 'Home', '2023-03-01', '2024-02-28', 1500.00),
('POL126', 4, 'Life', '2023-04-01', '2028-03-31', 2000.00),
('POL127', 5, 'Health', '2023-05-01', '2023-12-31', 1100.00),
('POL128', 6, 'Vehicle', '2023-06-01', '2024-05-31', 900.00),
('POL129', 7, 'Home', '2023-07-01', '2024-06-30', 1600.00),
('POL130', 8, 'Life', '2023-08-01', '2028-07-31', 2200.00),
('POL131', 9, 'Health', '2023-09-01', '2023-12-31', 1250.00),
('POL132', 10, 'Vehicle', '2023-10-01', '2024-09-30', 850.00);

-- Populate Claims Table
INSERT INTO Claims (PolicyID, ClaimDate, ClaimAmount, ClaimStatus) VALUES
(1, '2023-06-01', 500.00, 'Approved'),
(1, '2023-07-01', 300.00, 'Pending'),
(2, '2023-08-01', 800.00, 'Rejected'),
(3, '2023-09-01', 700.00, 'Approved'),
(4, '2023-09-10', 400.00, 'Pending'),
(5, '2023-09-15', 600.00, 'Rejected'),
(6, '2023-10-01', 750.00, 'Approved'),
(7, '2023-10-10', 850.00, 'Pending'),
(8, '2023-10-15', 950.00, 'Rejected'),
(9, '2023-11-01', 1000.00, 'Approved');

-- Populate Payments Table
INSERT INTO Payments (PolicyID, PaymentDate, AmountPaid, PaymentMethod) VALUES
(1, '2023-01-10', 600.00, 'Credit Card'),
(2, '2023-02-10', 800.00, 'Debit Card'),
(3, '2023-03-10', 1500.00, 'Cash'),
(4, '2023-04-10', 2000.00, 'Credit Card'),
(5, '2023-05-10', 1100.00, 'Bank Transfer'),
(6, '2023-06-10', 900.00, 'Debit Card'),
(7, '2023-07-10', 1600.00, 'Cash'),
(8, '2023-08-10', 2200.00, 'Credit Card'),
(9, '2023-09-10', 1250.00, 'Bank Transfer'),
(10, '2023-10-10', 850.00, 'Debit Card');
