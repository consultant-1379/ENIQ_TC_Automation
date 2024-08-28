*** Settings ***

Documentation     EQEV-124466-Validate SubNetwork List is empty before sync with eniq
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
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot

*** Test Cases ***

Validate SubNetwork List is empty before sync with eniq
	[Tags]    PMA_KGB    NetAn_UG_PMA_TC150    EQEV-124466
	open pm alarm analysis
	verify that the SubNetwork List is empty
	change the mode to       Editing
	Connect to DB and sync with eniq
	Navigate to Home page
	Save the analysis file
	verify that the SubNetwork List is not empty