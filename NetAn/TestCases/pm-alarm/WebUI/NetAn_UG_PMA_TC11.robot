*** Settings ***
Documentation     Validate Specific Problem Field Size Limitation For More Than 100 Characters
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

Validate Specific Problem Field Size Limitation For More Than 100 Characters
	[Tags]      PMA_CDB     NetAn_UG_PMA_TC11
    open pm alarm analysis
    Click on Alarm rules manager button
    Click on Create button
    ${alarm_name}=      Prepare alarm name    Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    select system area      Radio
    Select Node type as       NR
    Click on fetch nodes button
    Select Nodes as    G2RBS01
    Select Measure type as     COUNTER
    Select measures    aclNdpAndMldPermits.DC_E_TCU_ACLIPV6_RAW
    Select Alarm severity as      Minor
    Select Aggregation as      1 Day
    Select Probable cause as       Threshold Crossed
    Enter specific problem     texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext      ${alarm_name}
    Enter alarm name     ${alarm_name}
    Click on Apply alarm template button
    Validate specific problem error message
           
    
*** Keywords ***

Validate specific problem error message
     Element Should Be Visible      xpath: //*[contains(text(),'Specific Problem cannot be more than 100 characters long')]