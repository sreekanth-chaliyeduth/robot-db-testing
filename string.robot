*** Settings ***
Library    combine_databases_return_strings.py

*** Variables ***
${SQL_FILE_NAME}    new-db.sql

*** Test Cases ***
Combine Data From Databases
    [Documentation]   Test combining data from InsuranceDB1, InsuranceDB2, and InsuranceDB3.
    ${result}=    Combine Data
    ${expected_message}=    Set Variable    SQL file '${SQL_FILE_NAME}' generated successfully.
    Log    Actual result: ${result}    INFO
    Log    Expected message: ${expected_message}    INFO
    Should Be Equal As Strings    ${result}    ${expected_message}    The result does not match the expected success message.
