*** Settings ***

Documentation     Verify The Delete Button Is Disabled With Failed Datasource
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

Verify The Delete Button Is Disabled With Failed Datasource
	[Tags]    PMA_CDB    NetAn_UG_PMA_TC110
    open pm alarm analysis
	Click on Administration button
    validate the page title    Administration
    navigate to section    ENIQ Connection Status
    Verify The delete Button should be disabled with failed datasource
	[Teardown]    Test teardown steps for pmalarm