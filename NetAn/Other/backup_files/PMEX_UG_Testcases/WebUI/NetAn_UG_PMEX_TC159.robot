*** Settings ***

Documentation     Validate DELETE Button in Collection manager page
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

Validate DELETE Button in Collection manager page
    [Tags]       PMEX_KGB    Collection_Manager
    open pm explorer analysis
    Click on Collection Manager button
    Click on Create Collection button
    ${collectionName}=    Enter the Collection name
    Select DataSource as      NetAn_ODBC
    Select System area    Radio
    click on the scroll down button    6    7
    Select Node type    NR
    select System Area and verify Node Type is empty
    Click on scroll down button    6    20
    validate that the Add and Remove buttons are disabled
    Click on Fetch Nodes
    validate that the Add and Remove buttons are enabled
    Select Nodes    G2RBS01
    Click on Add >>
    Click on Save button
    Verify that the Collection is created    ${collectionName}
    verify that if collections are not selected edit and delete buttons are disabled
    Select created Collection    ${collectionName}
    click on button    Delete Collection
    confirm collection deletion
    Verify that the Collection is deleted    ${collectionName}
