*** Settings ***

Documentation     Verify That The Delete Button Is Enabled
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

Verify That The Delete Button Is Enabled
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC111
    open pm alarm analysis    
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
    click on any ENIQ connection and click on delete    NetAn_ODBC
    Verify the Collection in delete box    ${collection}
    [Teardown]    Test teardown steps for pmalarm