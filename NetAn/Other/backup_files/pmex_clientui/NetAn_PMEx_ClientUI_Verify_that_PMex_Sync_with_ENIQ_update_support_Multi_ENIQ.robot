*** Settings ***
Documentation     Testing Core Nodetypes
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/WebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Suite setup       Set Screenshot Directory    ./Screenshots



*** Variables ***
${base_url}=       https://localhost/
${pmex_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Explorer/PM-Explorer/Analyses/PM%20Explorer&waid=Tza-om0C4Emhp9dxoJ0wu-091024061e335T&wavid=0
${browser_name}=   chrome

*** Test Cases ***
	
Verify that PMex: Sync with ENIQ update support Multi ENIQ
    Launch the Tibco spotfire PMEX Application
    ${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniq.py
	Execute the iron python script     ${test_script}     False
	Open the table    Modified Topology Data    12
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/PMExMultiEniqSQL.json     multiEniqTableUpdate
	${DB_Value}=    Query ENIQ database for multi eniq    ${sql_query}
	${test_script}=    Get the iron_python script by passing project location for multi eniq    ${scripts}\\pmexMultiEniq.py
	Execute the iron python script     ${test_script}     False
	Open the table    Modified Topology Data    12
	Verify that the deactivated table is not present in the Modified Topology Data Table
	Capture page screenshot
	[Teardown] Close the Tibco spotfire PMEX Application  