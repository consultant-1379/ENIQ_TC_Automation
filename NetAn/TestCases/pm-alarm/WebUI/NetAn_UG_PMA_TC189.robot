*** Settings ***
Documentation     Verify Single Node listbox exception message should be enabled for multi selection
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

Verify Single Node listbox exception message should be enabled for multi selection
	[Tags]      PMA_CDB        NetAn_UG_PMA_TC189
    open pm alarm analysis
	Click on Alarm rules manager button
    Click on Create button
    ${alarm_name1}=      Prepare alarm name     Alarm_
    Select the alarm type     Threshold
    select the data source     NetAn_ODBC
    Select Single node or Collection or Subnetwork     Single Node
    Select System area as      Radio
    Select Node type as       ERBS
    Click on fetch nodes button in Alarm rules manager
    Verify Single Node listbox exception message should be enabled for multi selection
	[Teardown]    Test teardown steps for pmalarm
    
         
    
  
    

    
    


    


    
    