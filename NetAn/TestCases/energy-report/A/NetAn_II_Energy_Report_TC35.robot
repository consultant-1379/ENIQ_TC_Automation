*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${EnergyReportKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot


*** Test Cases ***

Verify That The ILs Do Not Have STATUS = 'ACTIVE' Condition
    [Tags]     Energy_Report_CDB
	${ilFilePath}=    set variable    ${EXEC_DIR}//ENIQ_TC_Automation//NetAn//Other//Files//EnergyReportIls.txt
	${status}=     Run    FIND "STATUS='ACTIVE'" ${ilFilePath}
	Log    ${status}  
    should not contain    $status}    STATUS='ACTIVE'