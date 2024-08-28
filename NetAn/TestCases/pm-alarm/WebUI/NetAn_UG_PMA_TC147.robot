*** Settings ***

Documentation     Verify Restore/Permanent Delete Button Functionality When NetAn Database Is Failed
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

Verify Restore/Permanent Delete Button Functionality When NetAn Database Is Failed
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC147
    open pm alarm analysis
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Select Access Type
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
	Validate that the collection is present in GUI    ${collection}
	select the created collection and click on delete    ${collection}
	confirm collection deletion by clicking on Delete button
	verify that the deleted collection is not present in the GUI    ${collection}
	Click on Settings button
	disconnect the ENIQ db and go to home page
	Click on Node Collection manager button
	click on the Deleted Items button
	select a collection and click on restore    ${collection}
	verify that the exception is visible
	select a collection and click on permanently delete    ${collection}
	verify that the exception is visible
	[Teardown]    Test teardown steps for pmalarm