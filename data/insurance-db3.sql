-- Create the database
CREATE DATABASE IF NOT EXISTS InsuranceDB3;

-- Use the database
USE InsuranceDB3;

-- Create Claims Processing Centers Table
CREATE TABLE IF NOT EXISTS ProcessingCenters (
    CenterID INT PRIMARY KEY AUTO_INCREMENT,
    CenterName VARCHAR(100) NOT NULL,
    Location VARCHAR(150) NOT NULL,
    ContactNumber VARCHAR(15),
    Email VARCHAR(100)
);

-- Create Claims Table
CREATE TABLE IF NOT EXISTS Claims (
    ClaimID INT PRIMARY KEY AUTO_INCREMENT,
    CenterID INT NOT NULL,
    PolicyNumber VARCHAR(20) NOT NULL,
    ClaimDate DATE NOT NULL,
    ClaimAmount DECIMAL(10, 2) NOT NULL,
    ClaimStatus ENUM('Pending', 'Approved', 'Rejected') NOT NULL,
    ProcessedBy VARCHAR(100),
    FOREIGN KEY (CenterID) REFERENCES ProcessingCenters(CenterID) ON DELETE CASCADE
);

-- Create Fraud Monitoring Table
CREATE TABLE IF NOT EXISTS FraudMonitoring (
    FraudID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyNumber VARCHAR(20) NOT NULL,
    InvestigationDate DATE NOT NULL,
    SuspicionLevel ENUM('Low', 'Moderate', 'High') NOT NULL,
    Comments TEXT
);

-- Populate ProcessingCenters Table
INSERT INTO ProcessingCenters (CenterName, Location, ContactNumber, Email) VALUES
('East Coast Processing', 'New York, NY', '555-1000', 'eastcoast@claims.com'),
('West Coast Processing', 'San Francisco, CA', '555-2000', 'westcoast@claims.com'),
('Central Processing', 'Chicago, IL', '555-3000', 'central@claims.com'),
('Southern Claims', 'Houston, TX', '555-4000', 'southern@claims.com'),
('Northern Claims', 'Boston, MA', '555-5000', 'northern@claims.com'),
('Pacific Claims Center', 'Seattle, WA', '555-6000', 'pacific@claims.com'),
('Midwest Claims Center', 'Denver, CO', '555-7000', 'midwest@claims.com'),
('Southwest Claims', 'Phoenix, AZ', '555-8000', 'southwest@claims.com'),
('Southeast Claims', 'Miami, FL', '555-9000', 'southeast@claims.com'),
('Mountain Claims', 'Salt Lake City, UT', '555-1111', 'mountain@claims.com');

-- Populate Claims Table
INSERT INTO Claims (CenterID, PolicyNumber, ClaimDate, ClaimAmount, ClaimStatus, ProcessedBy) VALUES
(1, 'POL123', '2023-06-01', 1500.00, 'Approved', 'John Agent'),
(2, 'POL124', '2023-07-15', 3000.00, 'Pending', 'Mary Processor'),
(3, 'POL125', '2023-08-20', 5000.00, 'Rejected', 'Susan Officer'),
(4, 'POL126', '2023-09-05', 2500.00, 'Approved', 'Michael Clark'),
(5, 'POL127', '2023-10-10', 2000.00, 'Pending', 'Anna Lewis'),
(6, 'POL128', '2023-11-20', 4000.00, 'Rejected', 'James Taylor'),
(7, 'POL129', '2023-12-15', 1000.00, 'Approved', 'Emma Brown'),
(8, 'POL130', '2024-01-05', 6000.00, 'Pending', 'William Hall'),
(9, 'POL131', '2024-02-10', 7000.00, 'Rejected', 'Sophia Davis'),
(10, 'POL132', '2024-03-01', 3000.00, 'Approved', 'Olivia Martinez');

-- Populate FraudMonitoring Table
INSERT INTO FraudMonitoring (PolicyNumber, InvestigationDate, SuspicionLevel, Comments) VALUES
('POL123', '2023-09-01', 'Low', 'No irregularities found.'),
('POL124', '2023-09-15', 'High', 'Policy holder flagged for multiple high-value claims.'),
('POL125', '2023-10-01', 'Moderate', 'Some inconsistencies in claim details.'),
('POL126', '2023-10-20', 'Low', 'Legitimate claim, no further action required.'),
('POL127', '2023-11-05', 'High', 'Evidence of forged documents submitted.'),
('POL128', '2023-11-15', 'Moderate', 'Unusual claim pattern detected.'),
('POL129', '2023-12-01', 'Low', 'Routine verification completed.'),
('POL130', '2023-12-10', 'High', 'Policyholder flagged for previous fraudulent claims.'),
('POL131', '2024-01-20', 'Moderate', 'Detailed review recommended.'),
('POL132', '2024-02-05', 'Low', 'No suspicious activity detected.');
