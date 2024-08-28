*** Settings ***

Documentation     Validate EDIT Button in Collection manager page
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}

Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Validate EDIT Button in Collection manager page
    [Tags]      PMEX_KGB      Collection_Manager
    open pm explorer analysis
    Click on Collection Manager button
    Click on Create Collection button
    validate the page title    Create Collection
    ${collectName}=    Enter the Collection name
    Select DataSource as    NetAn_ODBC
    Select System area    Radio
    click on the scroll down button    6    7
    Select Node type    NR
    Click on scroll down button    6    20
    Click on Fetch Nodes
    Select Nodes    G2RBS01
    Click on Add >>
    verify that the node is present in Selected Nodes list    G2RBS01
    Click on Save button
    Verify that the Collection is created    ${collectName}
    Select created Collection    ${collectName}
    select a created collection and verify that nodes are displayed
    Click on the EDIT button
    Add all nodes to the collection in Edit
    Navigate to the section    Save
    Click on the save button on edit page
	Select created Collection    ${collectName}
	verify that the edit and delete buttons are enabled
