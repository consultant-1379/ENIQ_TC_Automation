*** Settings ***

Documentation     Verify The Selected Eniq Is Present Or Not In Connection Panel
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

Verify The Selected Eniq Is Present Or Not In Connection Panel
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC116
    open pm alarm analysis
	Connect to the DB    4140_ODBC
	Go to Home page	
    Click on Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Core
    Select Node type for collection manager             CCDM
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       CCDM01
    Click on Create button
    validate the page title    Node Collection Manager
    Click on Settings button
    validate the page title    Administration
    Click on minimise window button     0
    navigate to section    ENIQ Connection Status
    click on an ENIQ connection and check the Eniq Name and click on delete
    Verify the selected Eniq server is present in connection deletion panel    4140_ODBC
    [Teardown]    Test teardown steps for pmalarm