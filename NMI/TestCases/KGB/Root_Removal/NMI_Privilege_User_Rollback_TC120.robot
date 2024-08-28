*** Settings ***
Library           OperatingSystem

*** Test Cases ***
Checking if Rollback ENIQ Privileged User Support is started
    [Tags]                 Root_Dependency_Removal
	${RDR_Log}=            Get File                   Privilege_User_Rollback.log
	Set Global Variable    ${RDR_Log}
    Should Contain         ${RDR_Log}                 Starting Rollback ENIQ Privileged User Support
	
Checking if Rollback Privileged Users Stage is entered
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Entering Rollback Privileged Users Stage
	
Checking if Rollback Privileged Users stage is successfully completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Successfully completed Rollback Privileged Users stage
	
Checking if Rollback Admin Group Stage is entered
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Entering Rollback Admin Group Stage
	
Checking if Rollback Admin group stage is successfully completed
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Successfully completed Rollback Admin group stage
	
Checking if Rollback ENIQ Privileged User Support is successfully completed 
    [Tags]             Root_Dependency_Removal
    Should Contain     ${RDR_Log}                     Successfully completed Rollback ENIQ Privileged User Support
