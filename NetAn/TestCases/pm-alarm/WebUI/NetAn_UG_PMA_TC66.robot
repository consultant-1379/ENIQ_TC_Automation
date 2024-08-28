*** Settings ***

Documentation     Validate The Alarm Generation If Some Fields Are Missing
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

Validate The Alarm Generation If Some Fields Are Missing
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC66    MR-EQEV-110751
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name         Alarm
    Select the alarm type     Threshold
    Select ENIQ Data Source as     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
	Select System area and verify none value is not present      Radio
    Select Node type as       ERBS
    Click on fetch nodes button
    Select Nodes as    ERBS1
	Select All values in MO Class
    Select Measure type as     KPI
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Enter the specific problem
    Enter alarm name     ${alarm_name}
    click on Apply alarm template button
    verify that alarm generation failed