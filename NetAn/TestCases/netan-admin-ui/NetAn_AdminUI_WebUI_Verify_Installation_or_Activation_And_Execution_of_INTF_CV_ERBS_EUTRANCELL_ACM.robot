*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/NetAnAdminUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verify Installation/Activation And Execution of INTF_CV_ERBS_EUTRANCELL_ACM
	open the adminui page
	click on button    ETLC Set History
	verify the page title    ETLC Set History
	select the package    INTF_CV_ERBS_EUTRANCELL_ACM-eniq_oss_1
	select the type    Adapter
	click on the button    Search
	verify that the execution status is FINISHED
	Capture page screenshot
	[Teardown]    Test teardown