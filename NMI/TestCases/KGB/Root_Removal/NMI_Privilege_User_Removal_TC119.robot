*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if Privileged User Privileges Removal is started
    [Tags]                 Root_Dependency_Removal
	${RDR_Log}=            Get File                   Privilege_User_Removal.log
	Set Global Variable    ${RDR_Log}
    Should Contain         ${RDR_Log}                 Starting User Privileges Removal
	
Checking if Privileges Removal Stage is entered
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Entering User Privileges Removal Stage
	
Checking if User Privileges Removal is successfully completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Successfully completed User Privileges Removal
