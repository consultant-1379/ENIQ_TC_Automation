*** Settings ***

Documentation     Verify That The Cancel Button Is Working Properly In Alarm Deletion Dialog Box
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

Verify That The Cancel Button Is Working Properly In Alarm Deletion Dialog Box
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC200
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name     Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     SubNetwork
    Select System area for subnetwork as      Radio
    Select Node type for subnetwork as       NR
    Select Subnetwork as     G2RBS01
    Select Measure type as     COUNTER
    Select measures    aclNdpAndMldPermits.DC_E_TCU_ACLIPV6_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     text      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on scroll down button    5    12
    Click on Apply alarm template button
    Verify alarm title      ${alarm_name}
    Click on Save button 
    Verify alarm displayed in UI       ${alarm_name}
    Select Alarm       ${alarm_name}
	click on delete button to delete the selected alarm    	${alarm_name}
	close the delete alarm dialog box by clicking on the Cancel button
	[Teardown]    Test teardown steps for pmalarm