-- Select the database to use
USE InsuranceDB2;

-- Create Corporate Customers Table
CREATE TABLE IF NOT EXISTS CorporateCustomers (
    CorporateID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(150) NOT NULL,
    ContactPerson VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

-- Create Corporate Policies Table
CREATE TABLE IF NOT EXISTS CorporatePolicies (
    PolicyID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyNumber VARCHAR(20) NOT NULL UNIQUE,
    CorporateID INT NOT NULL,
    PolicyType ENUM('Group Health', 'Property', 'Business Liability', 'Travel') NOT NULL,
    CoverageAmount DECIMAL(12, 2) NOT NULL,
    PremiumAmount DECIMAL(10, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (CorporateID) REFERENCES CorporateCustomers(CorporateID) ON DELETE CASCADE
);

-- Create Corporate Claims Table
CREATE TABLE IF NOT EXISTS CorporateClaims (
    ClaimID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyID INT NOT NULL,
    ClaimDate DATE NOT NULL,
    ClaimAmount DECIMAL(10, 2) NOT NULL,
    ClaimStatus ENUM('Pending', 'Approved', 'Rejected') NOT NULL,
    FOREIGN KEY (PolicyID) REFERENCES CorporatePolicies(PolicyID) ON DELETE CASCADE
);

-- Populate CorporateCustomers Table
INSERT INTO CorporateCustomers (CompanyName, ContactPerson, PhoneNumber, Email, Address) VALUES
('TechCorp Inc.', 'Alice Davis', '555-9000', 'alice@techcorp.com', '100 Tech Park Avenue'),
('GreenFields Ltd.', 'Robert Green', '555-7000', 'robert@greenfields.com', '200 Green Road'),
('Innovate Solutions', 'Emily White', '555-8000', 'emily@innovatesolutions.com', '300 Innovate Street'),
('UrbanTech Ltd.', 'Sophia Brown', '555-1234', 'sophia@urbantech.com', '400 Urban Road'),
('EcoSystems Inc.', 'Daniel Green', '555-5678', 'daniel@ecosystems.com', '500 Eco Avenue'),
('BrightTech LLC', 'Charlotte Lee', '555-8765', 'charlotte@brighttech.com', '600 Bright Street'),
('MacroSoft', 'James Bond', '555-4321', 'james@macrosoft.com', '700 Macro Drive'),
('NanoSystems Ltd.', 'William Black', '555-6543', 'william@nanotech.com', '800 Nano Lane'),
('FutureCorp Inc.', 'Olivia Gray', '555-3210', 'olivia@futurecorp.com', '900 Future Blvd'),
('NovaTech Ltd.', 'Henry White', '555-9876', 'henry@novatech.com', '1000 Nova Drive');

-- Populate CorporatePolicies Table
INSERT INTO CorporatePolicies (PolicyNumber, CorporateID, PolicyType, CoverageAmount, PremiumAmount, StartDate, EndDate) VALUES
('CP123', 1, 'Group Health', 500000.00, 15000.00, '2023-01-01', '2023-12-31'),
('CP124', 2, 'Business Liability', 1000000.00, 20000.00, '2023-02-01', '2024-01-31'),
('CP125', 3, 'Property', 750000.00, 18000.00, '2023-03-01', '2024-02-28'),
('CP126', 4, 'Travel', 250000.00, 5000.00, '2023-04-01', '2024-03-31'),
('CP127', 5, 'Group Health', 600000.00, 16000.00, '2023-05-01', '2024-04-30'),
('CP128', 6, 'Property', 850000.00, 19000.00, '2023-06-01', '2024-05-31'),
('CP129', 7, 'Business Liability', 1200000.00, 25000.00, '2023-07-01', '2024-06-30'),
('CP130', 8, 'Travel', 300000.00, 6000.00, '2023-08-01', '2024-07-31'),
('CP131', 9, 'Group Health', 550000.00, 14000.00, '2023-09-01', '2024-08-31'),
('CP132', 10, 'Business Liability', 1100000.00, 23000.00, '2023-10-01', '2024-09-30');

-- Populate CorporateClaims Table
INSERT INTO CorporateClaims (PolicyID, ClaimDate, ClaimAmount, ClaimStatus) VALUES
(1, '2023-06-15', 20000.00, 'Approved'),
(2, '2023-07-10', 50000.00, 'Pending'),
(3, '2023-08-20', 100000.00, 'Rejected'),
(4, '2023-09-01', 15000.00, 'Approved'),
(5, '2023-10-15', 12000.00, 'Pending'),
(6, '2023-11-10', 25000.00, 'Rejected'),
(7, '2023-12-05', 30000.00, 'Approved'),
(8, '2024-01-20', 20000.00, 'Pending'),
(9, '2024-02-25', 18000.00, 'Rejected'),
(10, '2024-03-15', 50000.00, 'Approved');
