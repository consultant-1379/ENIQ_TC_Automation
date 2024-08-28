*** Settings ***

Documentation     Verify Connection Failure Message With no URL
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

Verify Connection Failure Message With no URL
	[Tags]    PMA_CDB        NetAn_UG_PMA_TC96
    open pm alarm analysis
    Click on Administration button
	Clear NetAn DB URL field
    Connect to ENIQ with incorrect Credentials    ${EMPTY}    netanserver    wrong_pass    NetAn_ODBC
    Navigate to section    Setup Data Source
    Verify after the NetAn Connection is not made "please provide Value for: NetAn SQL DB URL" message is visible
	Go to home page
	Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Edit_collection
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Core
    Select Node type for collection manager             CCDM    
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       CCDM01
    Click on Create button
	verify that the error "Could not perform action Create" is visible
	Click on Cancel button
    verify that the collection is not present    ${collection}
	[Teardown]    Test teardown steps for pmalarm