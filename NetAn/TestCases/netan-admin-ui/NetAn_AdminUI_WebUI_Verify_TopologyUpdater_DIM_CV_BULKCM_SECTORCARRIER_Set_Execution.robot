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

Verify TopologyUpdater_DIM_CV_BULKCM_SECTORCARRIER set execution
	open the adminui page
	click on button    ETLC Set History
	verify the page title    ETLC Set History
	select the package    CV_INFORMATION_STORE
	select the type    Topology
	enter the name filter    TopologyUpdater_DIM_CV_BULKCM_SECTORCARRIER
	click on the button    Search
	verify that the execution status is FINISHED
	Capture page screenshot
	[Teardown]    Test teardown