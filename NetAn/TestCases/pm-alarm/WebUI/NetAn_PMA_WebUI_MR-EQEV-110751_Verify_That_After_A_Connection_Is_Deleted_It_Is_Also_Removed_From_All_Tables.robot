*** Settings ***
Documentation     Testing Core Nodetypes
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

Verify That If A Connection Is Deleted It Is Also Removed From All Tables
    [Tags]      PMA_KGB     NetAn_UG_PMA_TC84
    open pm alarm analysis
    click on scroll down button    0    20
    Connect to the DB     4140_ODBC
    navigate to section    ENIQ Connection Status
    select a connected datasource    4140_ODBC
    Click on minimise window button    0
    place the cursor on    ENIQ Connection Status
    navigate to section    To delete connected ENIQ, mark a single ENIQ from above table.
    click on button    Delete
    click on the delete confirmation button
    Click on minimise window button    0
    sleep    10
    place the cursor on    ENIQ Connection Status
    navigate to the section    Node Collection Manager    
    Click on Alarm rules manager button
    click on button    Create
    verify that the delete eniq is not visible    4140_ODBC
       
    
 
    

    
    

    
    


    
    