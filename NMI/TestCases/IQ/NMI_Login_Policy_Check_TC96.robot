*** Settings ***
Library           OperatingSystem

*** Variables ***

*** Test Cases ***
Checking if current password is asked for DBA user
    [Tags]             Login Policy Check
    ${Content}=        Get File                   Login_Policy_Check.log
    Set Global Variable     ${Content} 
    Should Contain     ${Content}                 Enter the current password for DBA user

Checking if maximum number of connections is asked
    [Tags]             Login Policy Check
    Should Contain     ${Content}                 Enter the maximum number of connections to allow

Checking if maximum number of failed attempts is asked before the user account is locked
    [Tags]             Login Policy Check
    Should Contain     ${Content}                 Enter the maximum number of failed attempts to log into the database before the user account is locked
