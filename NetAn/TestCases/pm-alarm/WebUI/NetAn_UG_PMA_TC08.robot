*** Settings ***
Documentation     Validate user is able to edit static collection and collection is updated based on the changes
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

Validate edit functionality in collection manager page
	[Tags]      PMA_CDB      NetAn_UG_PMA_TC08
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on the Node Collection manager button
    Click on Create collection button
    ${collection}=     Enter Collection name         Edit_collection
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR    
    Click on scroll down button     0      10
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Create button
    place the cursor on    CollectionName
    click on scroll up button    1    50
    select the created collection      ${collection}
    Click on Edit collection button
    Click on scroll down button     0      10
    Click on fetch nodes button in Node collection manager
    Select Nodes in collection manager       G2RBS01
    Click on Save button
    Click on collection        ${collection}
    Verify edited nodes displayed for collection       G2RBS01