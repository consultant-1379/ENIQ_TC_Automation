*** Settings ***

Documentation     Verify The Functionality For Consumer User
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

Verify the functionality for Consumer user 
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC146
    open pm alarm analysis with another username    Consumer	Ericsson01
	verify that the button is not present    Administration
	Click on Node Collection manager button
	verify that the button is not present    Create Collection
	verify that the button is not present    Edit Collection
	verify that the button is not present    Delete Collection
	Click on Alarm rules manager button
	verify that the button is not present    Create
	verify that the button is not present    Edit
	verify that the button is not present    Activate
	verify that the button is not present    Deactivate
	verify that the button is not present    Delete
	verify that the button is not present    Import
	verify that the button is not present    Export
	[Teardown]    Test teardown steps for pmalarm
    
    