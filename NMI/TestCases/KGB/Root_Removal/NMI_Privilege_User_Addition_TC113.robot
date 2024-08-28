*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if Privileged User Addition is started
    [Tags]                 Root_Dependency_Removal
	${RDR_Log}=            Get File                   Privilege_User_Addition.log
	Set Global Variable    ${RDR_Log}
    Should Contain         ${RDR_Log}                 Starting Privileged User Addition
	
Checking if Privileged User Creation Stage is entered
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Entering Privileged User Creation Stage
	
Checking if Privileged User Creation Stage is completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Completed Privileged User Creation Stage
	
Checking if Privileged User Addition is successfully completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Successfully completed Privileged User Addition
