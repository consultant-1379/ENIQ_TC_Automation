*** Settings ***
Documentation     EQEV-103913-Verify while editing a collection correct page is opening and EQEV-126953 - Verify That A Collection Can Be Edited If Its created by another user
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
      

*** Test Cases ***

Validate While Editing A Collection The FIelds Are Filled With Proper Values
	[Tags]      PMA_CDB      EQEV-126953       EQEV-103913      NetAn_UG_PMA_TC36
    open pm alarm analysis
    Click on Node Collection manager button
    validate the page title    Node Collection Manager
    Click on Create collection button
	Click on scroll down button    0    20
	Verify Add >> button is disabled
	Verify Import nodes from File button is disabled
	Verify Fetch nodes button is disabled
	Click on scroll up button    0    20
	Verify Node panel is empty for All nodes
	Verify Node panel is empty for selected nodes
    ${collection}=     Enter Collection name         Collection_
    Select ENIQ Data Source in collection manager        NetAn_ODBC
    Select System area for collection manager        Radio
    Select Node type for collection manager             NR
    Click on fetch nodes button in Node collection manager
	Verify Node panel is empty for selected nodes
	Verify Node panel is not empty for All nodes
    Select Nodes in collection manager       G2RBS01
    Click on Create button
    validate the page title    Node Collection Manager
    Close Browser
    open pm alarm analysis with another username
    Click on Node Collection manager button
    Click on collection        ${collection}
    Click on Edit collection button
    validate the page title    Node Collection Manager
	Verify Node panel is empty for All nodes
	Verify Node panel is not empty for selected nodes
    validate that the ENIQ Datasource is    NetAn_ODBC
    validate that the System Area is    Radio
    validate that the Node Type is    NR
    verify that the dropdown is disabled
	Verify Select Eniq data source, system area and node type is disabled in edit collection
	Verify Remove >> button is enabled
	Click on fetch nodes button in Node collection manager
	Select Nodes in collection manager       G2RBS01
    Click on Save button
	validate the page title    Node Collection Manager
	Capture page screenshot
