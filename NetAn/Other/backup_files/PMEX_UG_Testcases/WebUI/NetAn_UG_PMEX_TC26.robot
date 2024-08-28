*** Settings ***
Documentation     Validate That The Title Of NodeName Table Is The Selected SubNetwork
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

Validate That The Title Of NodeName Table Is The Selected SubNetwork
    [Tags]      PMEX_CDB         Collection_Manager      NetAn_UG_PMEX_TC26
	open pm explorer analysis
	Click on Collection Manager button
	validate the page title    Manage Collection
	verify that NodeName is added as a separate column
	${subNetwork}=    select a SubNetwork from the list
	verify that the title of NodeName table is the selected SubNetwork     ${subNetwork}
	Capture page screenshot
	
	

 