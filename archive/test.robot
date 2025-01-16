*** Settings ***
Library    combine_databases.py

*** Test Cases ***
Combine Data From Databases
    [Documentation]   Test combining data from InsuranceDB1, InsuranceDB2, and InsuranceDB3.
    ${result}=    combine data
    Log     ${result}


