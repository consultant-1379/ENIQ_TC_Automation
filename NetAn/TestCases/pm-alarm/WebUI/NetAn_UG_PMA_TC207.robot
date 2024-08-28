*** Settings ***

Documentation     Verify That A Message Is Displayed If Alarm Rule Is Not Selected And Assign Nodes/Collections Button Is Clicked
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

Verify That A Message Is Displayed If Alarm Rule Is Not Selected And Assign Nodes/Collections Button Is Clicked
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC207
    open pm alarm analysis
    Click on Alarm rules manager button
	Click on Import button
	select NetAn_ODBC as DataSource in Alarm Rules Import Manager
	Select single node in Alarm Rules Import Manager
	Click on scroll down button    10     5
	Click on fetch nodes button
	select node in Alarm Rules Import Manager
	Click on Assign Nodes/Collection button
	verify that a notification is displayed if alarm rule is not selected and Assign button is clicked
    [Teardown]    Test teardown steps for pmalarm