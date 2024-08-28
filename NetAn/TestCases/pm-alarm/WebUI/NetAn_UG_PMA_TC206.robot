*** Settings ***

Documentation     Verify That The Export Button Works For Multiple Alarms
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

Verify That The Export Button Works For Multiple Alarms
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC206
    open pm alarm analysis
    Click on Alarm rules manager button
    select multiple alarms
	Click on Export button
	verify that the rules were exported
	[Teardown]    Test teardown steps for pmalarm