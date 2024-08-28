*** Settings ***
Documentation     Verify Report Manager Page Navigation button
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile} 
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
 
 
*** Test Cases ***
Verify Report Manager Page Navigation button
    [Tags]    Collection Manager    PMEX_CDB
    open pm explorer analysis
    Click on Report Manager button
    validate the page title    Report Manager
    go to Home page
    validate the page title    Home
    Click on Collection Manager button
    validate the page title    Manage Collection
    Click on Report Manager button
    validate the page title    Report Manager
    Capture page screenshot