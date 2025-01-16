# 🚀 **Using Robot Framework for Database Testing with MySQL & Docker**

This guide demonstrates how to use **Robot Framework** for **database testing** with MySQL, Python, and Docker. The project includes scripts for handling multiple databases, verifying data, and handling errors gracefully.

---

## 🗂️ **Project Overview**

### **Structure**
- **SQL Files (`data/`)**:
  - `insurance-db1.sql` → Populates `InsuranceDB1` with customer data.
  - `insurance-db2.sql` → Populates `InsuranceDB2` with corporate customer data.
  - `insurance-db3.sql` → Populates `InsuranceDB3` with claims data.

- **Python Scripts**:
  - `combine_databases_exceptions.py` → Combines data and raises exceptions for errors.
  - `combine_databases_return_strings.py` → Combines data and returns error messages instead of exceptions.

- **Robot Framework Files**:
  - `exception.robot` → Tests database operations using **exception-based** error handling.
  - `string.robot` → Tests database operations using **string-based** error handling.

- **Docker Compose Setup**:
  - `docker-compose.yml` → Manages three MySQL instances and phpMyAdmin.

---

## 🛠️ **Setting Up**

### **1️⃣ Clone the Repository**
```bash
git clone <repository-url>
cd <repository-directory>
```

### **2️⃣ Run Robot Framework Tests Before Starting Docker (Show Failures)**
Run the tests before starting Docker to simulate connection failures:
```bash
robot exception.robot string.robot
```

You should see errors like:
```plaintext
pymysql.err.OperationalError: (2003, "Can't connect to MySQL server on 'localhost'")
```
This confirms that the databases are not running yet.

### **3️⃣ Start Docker Containers**
Ensure Docker is installed and running. Then start the MySQL and phpMyAdmin services:
```bash
docker compose up -d
```

### **4️⃣ Verify Running Containers**
Run:
```bash
docker ps
```
Expected containers:
- `insurance_mysql1` (Database 1)
- `insurance_mysql2` (Database 2)
- `insurance_mysql3` (Database 3)
- `phpmyadmin1`, `phpmyadmin2`, `phpmyadmin3` (Web UI for each DB)

### **5️⃣ Run Robot Framework Tests Again (Show Passing)**
After starting Docker, run the tests again:
```bash
robot exception.robot string.robot
```
The tests should now pass as databases are running.

### **6️⃣ Open the Test Reports**
```bash
open report.html
```
This will provide a detailed log of passed and failed test cases.

---

## ⚙️ **Error Handling: Exceptions vs. Strings**

### **Comparison of `combine_databases_exceptions.py` vs. `combine_databases_return_strings.py`**

| **Aspect**           | **Exception-Based** (❌ Raises Errors) | **String-Based** (🔤 Returns Messages) |
|----------------------|--------------------------------|--------------------------------|
| **Error Handling**   | Stops execution immediately   | Allows execution to continue  |
| **Flow Control**     | Requires `try-except` in tests | Needs explicit condition checks |
| **Use Case**         | For fail-fast testing         | For debugging/logging scenarios |

---

## 🏗️ **How Tests Work**

### **✅ Exception-Based Test (`exception.robot`)**
```robot
*** Settings ***
Library    combine_databases_exceptions.py

*** Test Cases ***
Combine Data From Databases
    [Documentation]   Test combining data with exception-based handling.
    ${status}    ${message}=    Run Keyword And Ignore Error    Combine Data
    IF    '${status}' == 'PASS'
        Should Be Equal As Strings    ${message}    SQL file 'new-db.sql' generated successfully.
        Log    ${message}    INFO
    ELSE
        Log    ${message}    WARN
        Fail    ${message}
    END
```

### **✅ String-Based Test (`string.robot`)**
```robot
*** Settings ***
Library    combine_databases_return_strings.py

*** Test Cases ***
Combine Data From Databases
    [Documentation]   Test combining data from InsuranceDB1, InsuranceDB2, and InsuranceDB3.
    ${result}=    Combine Data
    ${expected_message}=    Set Variable    SQL file 'new-db.sql' generated successfully.
    Log    Actual result: ${result}    INFO
    Log    Expected message: ${expected_message}    INFO
    Should Be Equal As Strings    ${result}    ${expected_message}    The result does not match the expected success message.
```

---

## 🧹 **Cleaning Up**
To stop and remove Docker containers:
```bash
docker compose down -v
```

---

## **🚀 Why Use Robot Framework for DB Testing?**
- ✅ **Simplicity**: Easy integration with Python and SQL.
- ✅ **Flexibility**: Supports exception-based and string-based error handling.
- ✅ **Automation**: Automates database validation efficiently.
- ✅ **Reporting**: Generates detailed logs and reports for debugging.

---

## **📌 Summary of Commands**

### **1️⃣ Run Tests Before Starting Docker (Show Failure)**
```bash
robot exception.robot string.robot
```

### **2️⃣ Start Docker & Run Tests Again (Show Passing)**
```bash
docker compose up -d
robot exception.robot string.robot
open report.html
```

### **3️⃣ Run Python Scripts Individually**
```bash
python combine_databases_exceptions.py
python combine_databases_return_strings.py
```

### **4️⃣ Stop Docker Containers**
```bash
docker compose down -v
```
---

## **🛠️ Simple SQL Operations (`demo.robot`)**  
`demo.robot` includes basic SQL validation tests to check database integrity **without modifying data**.  

### **✅ Test Cases Covered:**  

1. **Verify Customers Table Exists in DB1**  
   - Connects to **InsuranceDB1** and checks that the `Customers` table is present.  
   - Logs the query and its result to help diagnose issues.

2. **Check CorporateCustomers Has Rows in DB2**  
   - Connects to **InsuranceDB2** and queries the `CorporateCustomers` table.  
   - Fails if the table is empty, ensuring at least one row exists.

3. **Ensure ProcessingCenters Table in DB3 is Not Empty**  
   - Connects to **InsuranceDB3** to confirm the `ProcessingCenters` table exists.  
   - Also verifies the table contains at least one row.


#### **🚀 Run the Tests:**  
```bash
robot demo.robot
```
These tests help confirm the database structure and data presence. 

---


## **📌 Quick Access Commands**
```bash
docker compose up -d
docker compose down -v
robot exception.robot string.robot demo.robot
```

---

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)

---