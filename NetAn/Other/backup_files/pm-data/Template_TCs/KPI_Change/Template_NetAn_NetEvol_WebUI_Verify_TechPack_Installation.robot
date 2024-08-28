*** Settings ***

Documentation     Verify Techpack Installation
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${PMDataKeywordFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/NetAnAdminUI.robot

*** Variables ***

${pkg}    		  DC_E_SGSNMME_R30A_b89.tpi

*** Test Cases ***

Verify Techpack Installation
    Reset everything if changed and login to dcuser
    Get the TP name and version from TP file
    ${status}=    verify if the TechPack is installed in the server
    IF    ${status}==False
    	${isFilePresent}=    check if the TP file already exists and return status    ${pkg}
		Run Keyword If    ${isFilePresent}==False    download and place the downloaded tpi file in the server
		install the techpack
		verify if the TechPack is installed in the server
	END
	[Teardown]    close browser