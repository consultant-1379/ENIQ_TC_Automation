*** Settings ***

Documentation     EQEV-106349 - Validate Scheduling Of Worker Analysis Files
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Validate Scheduling Of Worker Analysis Files
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC53    EQEV-106349
    open the worker analysis file
    enter the server details and connect to it
    verify that the worker analysis file is connected
	[Teardown]    Test teardown steps for pmalarm