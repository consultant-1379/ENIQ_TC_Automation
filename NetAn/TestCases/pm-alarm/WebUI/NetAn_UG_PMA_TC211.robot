*** Settings ***

Documentation     Validate Exception message displayed when multi selection In list Box for SubNetwork
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library 		  PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMalarmingKeywordsFile}

*** Test Cases ***

Validate Exception message displayed when multi selection In list Box for SubNetwork
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC211
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     SubNetwork
    Select System area for subnetwork as      Radio
    Select Node type for subnetwork as       NR
    Select multiple Subnetwork     G2RBS01,G2RBS02
	Verify error message for multi selection of subnetwork
	[Teardown]    Test teardown steps for pmalarm