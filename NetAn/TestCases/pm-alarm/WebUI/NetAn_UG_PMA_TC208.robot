*** Settings ***

Documentation     Verify That 3 Columns Alarm Rule, Status and Message Are Generated When Assign Nodes/Collections Button Is Clicked
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

Verify That 3 Columns Alarm Rule, Status and Message Are Generated When Assign Nodes/Collections Button Is Clicked
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC208
    open pm alarm analysis
    Click on Alarm rules manager button
	Click on Import button
	Select an Alarm rule file
	select NetAn_ODBC as DataSource in Alarm Rules Import Manager
	Select single node in Alarm Rules Import Manager
	Click on scroll down button    10     5
	Click on fetch nodes button
	select node in Alarm Rules Import Manager
	Click on Assign Nodes/Collection button
	verify that Alarm Rule, Status and Message columns are generated in Import Result section
    [Teardown]    Test teardown steps for pmalarm