*** Settings ***
Documentation     Validate if create button is displayed in Report Manager Page
Library           Selenium2Library
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMEXKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PostgresDBConnection.robot
								   
									  

*** Test Cases ***

Validate if create button is displayed in Report Manager Page
    [Tags]      PMEX_CDB     Report_Manager    NetAn_UG_PMEX_TC54
	open pm explorer analysis
	Click on Report manager button
	validate the page title    Report Manager
	verify that the button is visible    Create
	Capture page screenshot
							
	
				
	
				 
											

					
						   
 
			 
						   
				 
 