*** Settings ***
Documentation     Validate that Delete Button is Disabled If Report is Not Selected
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot


*** Test Cases ***

Validate that Delete Button is Disabled If Report is Not Selected
    [Tags]    Report_Manager     PMEX_CDB      NetAn_UG_PMEX_TC64
	open pm explorer analysis
	Click on Report manager button
	${IsElementInteractable}=    Run Keyword And Return Status    click on button    Delete
    verify that the element is not interactable    ${IsElementInteractable}    
	Capture page screenshot
	
    

 