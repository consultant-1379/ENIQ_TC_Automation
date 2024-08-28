*** Settings ***
Documentation	  EQEV-103914 Verify That A DataSource Can't Be Deleted If It Is_Being Used In A Collection
Library           DatabaseLibrary
Library           OperatingSystem
Library           Selenium2Library 
Library           Collections
Library           String
Library           DateTime
Library 		  PostgreSQLDB
Library           CSVLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
      

*** Test Cases ***

Verify That A DataSource Can't Be Deleted If It Is Being Used In A Collection
    [Tags]		EQEV-103914      NetAn_UG_PMA_TC42		PMA_CDB
	open pm alarm analysis    
    Click on Node Collection manager button
    validate the page title    Node Collection Manager
    Click on Create collection button
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
	Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
    validate the page title    Node Collection Manager
    Click on Settings button
    validate the page title    Administration
    Runkeyword and ignore error      Click on minimise window button    0
    validate the page title    Administration
    Click on maximise window button    1
    click on the connected ENIQ and click on delete    NetAn_ODBC
    verify that the DataSource cant be deleted