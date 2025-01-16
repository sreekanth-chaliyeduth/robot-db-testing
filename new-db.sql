CREATE DATABASE IF NOT EXISTS CombinedDB;
USE CombinedDB;

                CREATE TABLE IF NOT EXISTS CombinedData (
                    CustomerID INT,
                    CustomerName VARCHAR(100),
                    Age INT,
                    Gender ENUM('Male', 'Female'),
                    CompanyName VARCHAR(150),
                    ContactPerson VARCHAR(100),
                    PolicyNumber VARCHAR(20),
                    ClaimDate DATE,
                    ClaimAmount DECIMAL(10, 2)
                );
                INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (1, 'John Doe', 35, 'Male', 'TechCorp Inc.', 'Alice Davis', 'POL123', '2023-06-01', 1500.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (2, 'Jane Smith', 29, 'Female', 'GreenFields Ltd.', 'Robert Green', 'POL124', '2023-07-15', 3000.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (3, 'Alice Johnson', 50, 'Female', 'Innovate Solutions', 'Emily White', 'POL125', '2023-08-20', 5000.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (4, 'Bob Brown', 40, 'Male', 'UrbanTech Ltd.', 'Sophia Brown', 'POL126', '2023-09-05', 2500.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (5, 'Charlie Adams', 28, 'Male', 'EcoSystems Inc.', 'Daniel Green', 'POL127', '2023-10-10', 2000.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (6, 'Diana Lee', 45, 'Female', 'BrightTech LLC', 'Charlotte Lee', 'POL128', '2023-11-20', 4000.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (7, 'Ethan White', 60, 'Male', 'MacroSoft', 'James Bond', 'POL129', '2023-12-15', 1000.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (8, 'Fiona Green', 33, 'Female', 'NanoSystems Ltd.', 'William Black', 'POL130', '2024-01-05', 6000.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (9, 'George King', 39, 'Male', 'FutureCorp Inc.', 'Olivia Gray', 'POL131', '2024-02-10', 7000.00);
INSERT INTO CombinedData (CustomerID, CustomerName, Age, Gender, CompanyName, ContactPerson, PolicyNumber, ClaimDate, ClaimAmount) VALUES (10, 'Hannah Black', 25, 'Female', 'NovaTech Ltd.', 'Henry White', 'POL132', '2024-03-01', 3000.00);
