*** Settings ***

Documentation     Validate The Cross Button In The Connection Deletion Window In Administration Page
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

Validate The Cross Button In The Connection Deletion Window In Administration Page
	[Tags]    PMA_CDB        NetAn_UG_PMA_TC93
    open pm alarm analysis
    Click on Administration button
    validate the page title    Administration
    navigate to section    ENIQ Connection Status
    select an ENIQ and click on remove
	Verify the delete box enabled
	close the connection deletion window by clicking on the cross
	verify that the delete window is closed
    [Teardown]    Test teardown steps for pmalarm