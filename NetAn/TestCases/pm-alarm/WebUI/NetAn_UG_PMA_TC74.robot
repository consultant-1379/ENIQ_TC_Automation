*** Settings ***

Documentation     EQEV-110751 - Validate That The Last Successful Sync With Eniq Value Remains Same After Connection Is Refreshed
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

Validate That The Last Successful Sync With Eniq Value Remains Same After Connection Is Refreshed
    [Tags]    PMA_CDB    NetAn_UG_PMA_TC74    EQEV-110751
	open pm alarm analysis
    Click on Administration button
	Navigate to the section    ENIQ Connection Status
    ${time}=    read the Last Successful Sync With Eniq value
    Navigate to the section    Setup Data Source
    Connect to DB    localhost       netanserver      Ericsson01     4140_ODBC
    Navigate to the section    ENIQ Connection Status
    ${time1}=    read the Last Successful Sync With Eniq value
	should be equal    ${time}    ${time1}
	go to Home page
	change the mode to       Editing
	Save the analysis file
	Close browser
	open pm alarm analysis
	Click on Administration button
	Navigate to the section    ENIQ Connection Status
    ${time2}=    read the Last Successful Sync With Eniq value
	should be equal    ${time1}    ${time2}
	[Teardown]    Test teardown steps for pmalarm