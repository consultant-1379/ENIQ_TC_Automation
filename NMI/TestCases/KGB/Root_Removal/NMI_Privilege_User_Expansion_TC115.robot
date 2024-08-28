*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if ENIQ Privileged User Support feature expansion is started
    [Tags]                 Root_Dependency_Removal
        ${RDR_Log}=            Get File                   Privilege_User_Expansion.log
        Set Global Variable    ${RDR_Log}
    Should Contain         ${RDR_Log}                 Starting ENIQ Privileged User Support feature expansion

Checking if node hardening is applied
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Checking Node Hardening Applied

Checking for node hardening to be verified
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Check completed for Server

Checking if ENIQ Privileged User Support feature expansion is completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Completed ENIQ Privileged User Support feature expansion
