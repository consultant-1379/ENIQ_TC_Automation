*** Settings ***

Documentation     Verify The Error Message If Preview Button Is Clicked While Wildcard Expression Is Empty
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

Verify The Error Message If Preview Button Is Clicked While Wildcard Expression Is Empty
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC168
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Check the dynamic collection check-box
    Enter Wildcard Expression    NodeName like '%G2RBS%'
	Click on preview button
    Click on Create button
	Validate that the collection is present in GUI    ${collection}
	select the created collection    ${collection}
	Click on Edit collection button
	Enter Wildcard Expression    ${EMPTY}
	Click on preview button
	verify that Preview section is empty
	verify that an error message is visible for the empty wildcard expression
	Enter Wildcard Expression    NodeName like '%G2RBS%'
	Click on preview button
	verify that nodes are visible in Preview section
	verify that error message for the empty wildcard expression is not visible
	[Teardown]    Test teardown steps for pmalarm