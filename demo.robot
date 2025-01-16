*** Settings ***
Library    DatabaseLibrary

*** Variables ***
${DB1_NAME}    InsuranceDB1
${DB1_HOST}    localhost
${DB1_PORT}    3306

${DB2_NAME}    InsuranceDB2
${DB2_HOST}    localhost
${DB2_PORT}    3307

${DB3_NAME}    InsuranceDB3
${DB3_HOST}    localhost
${DB3_PORT}    3308

${DB_USER}     root
${DB_PASSWORD}  root

*** Test Cases ***
Verify Customers Table Exists in DB1
    [Documentation]  Checks that the Customers table is present in InsuranceDB1.
    ${int_port_db1}=    Convert To Integer    ${DB1_PORT}
    Connect To Database    pymysql    ${DB1_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB1_HOST}    ${int_port_db1}

    ${query}=    Set Variable    SHOW TABLES LIKE 'Customers';
    Log    Running query on DB1: ${query}    # Log the query
    ${result}=   Query    ${query}
    Log    Query result: ${result}    # Log the raw query result

    Should Not Be Empty    ${result}    The Customers table does not exist in DB1.
    Disconnect From Database


Check CorporateCustomers Has Rows in DB2
    [Documentation]  Checks that CorporateCustomers table in InsuranceDB2 has at least 1 row.
    ${int_port_db2}=    Convert To Integer    ${DB2_PORT}
    Connect To Database    pymysql    ${DB2_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB2_HOST}    ${int_port_db2}

    ${count_query}=    Set Variable    SELECT COUNT(*) FROM CorporateCustomers;
    Log    Running query on DB2: ${count_query}
    ${count_result}=   Query    ${count_query}
    Log    Query result: ${count_result}

    Should Not Be Equal As Integers    ${count_result}[0][0]    0    CorporateCustomers table is empty in DB2.
    Disconnect From Database


Ensure ProcessingCenters Table in DB3 is Not Empty
    [Documentation]  Verifies that the ProcessingCenters table exists and is not empty in InsuranceDB3.
    ${int_port_db3}=    Convert To Integer    ${DB3_PORT}
    Connect To Database    pymysql    ${DB3_NAME}    ${DB_USER}    ${DB_PASSWORD}    ${DB3_HOST}    ${int_port_db3}

    ${exist_query}=    Set Variable    SHOW TABLES LIKE 'ProcessingCenters';
    Log    Running query on DB3: ${exist_query}
    ${exist_result}=   Query           ${exist_query}
    Log    Query result: ${exist_result}
    Should Not Be Empty    ${exist_result}    The ProcessingCenters table does not exist in DB3.

    ${row_query}=      Set Variable    SELECT COUNT(*) FROM ProcessingCenters;
    Log    Running query on DB3: ${row_query}
    ${row_result}=     Query           ${row_query}
    Log    Query result: ${row_result}
    Should Not Be Equal As Integers    ${row_result}[0][0]    0    No rows found in ProcessingCenters table in DB3.
    Disconnect From Database
