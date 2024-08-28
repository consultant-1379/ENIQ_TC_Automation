*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if ENIQ Privileged User Support feature is enabled
    [Tags]                 Root_Dependency_Removal
	${RDR_Log}=            Get File                   Enable_Privilege_User.log
	Set Global Variable    ${RDR_Log}
    Should Contain         ${RDR_Log}                 Enabling ENIQ Privileged User Support feature
	
Checking if node hardening is applied
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Checking Node Hardening Applied
	
Checking if Privileged Group Creation Stage is entered
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Entering Privileged Group Creation Stage
	
Checking if Privileged Group Creation Stage is successfuly completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Successfully completed Privileged group creation stage
	
Checking if Privileged User Creation Stage is entered
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Entering Privileged User Creation Stage
	
Checking if Privileged User Creation Stage is successfuly completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Completed Privileged User Creation Stage
	
Checking if ENIQ Privileged User Support feature is successfuly enabled
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Successfully enabled ENIQ Privileged User Support feature
