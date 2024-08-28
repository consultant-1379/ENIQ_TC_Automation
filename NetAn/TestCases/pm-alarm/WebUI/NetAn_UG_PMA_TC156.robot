*** Settings ***

Documentation     Verify The Error Message When Wildcard Expression With Incorrect Syntax Is Entered
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Verify The Error Message When Wildcard Expression With Incorrect Syntax Is Entered
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC156
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
	Check the dynamic collection check-box
    Enter Wildcard Expression    IncorrectWildcard
	Click on preview button
	verify that Preview section is empty
	verify that an error message is visible for the invalid wildcard expression
	[Teardown]    Test teardown steps for pmalarm