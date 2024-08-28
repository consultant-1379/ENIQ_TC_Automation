*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if Verify Reconfigure Retention Period procedure started successfully.
    [Tags]                         Reconfigure Retention Period 
    ${db_expansion}=         Get File                   DB_Expansion.log
    Set Global Variable            ${db_expansion}
    Should Contain                 ${db_expansion}      repdb is running OK

Starting to change the partition plan for feature
    [Tags]             Reconfigure Retention Period
    Should Contain     ${db_expansion}      Starting to change the partition plan for feature

Checking if Verify Reconfigure Retention Period procedure completed successfully.
    [Tags]             Reconfigure Retention Period
    Should Contain     ${db_expansion}      Partition plan changes have been completed successfully
