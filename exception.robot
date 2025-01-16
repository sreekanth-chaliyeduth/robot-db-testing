*** Settings ***
Library    combine_databases_exceptions.py

*** Variables ***
${SQL_FILE_NAME}    new-db.sql

*** Test Cases ***
Combine Data From Databases
    [Documentation]   Test combining data with exception-based handling.
    ${status}    ${message}=    Run Keyword And Ignore Error    Combine Data
    IF    '${status}' == 'PASS'
        Should Be Equal As Strings    ${message}    SQL file '${SQL_FILE_NAME}' generated successfully.
        Log    ${message}    INFO
    ELSE
        Log    ${message}    WARN
        Fail    ${message}
    END
