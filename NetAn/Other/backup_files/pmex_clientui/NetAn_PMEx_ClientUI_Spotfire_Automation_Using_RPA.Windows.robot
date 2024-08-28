*** Settings ***

Library    		  RPA.Windows
Library    		  RPA.Desktop
Library      	  rpaframework
Library           Selenium2Library
Library			  RPA.Desktop.Windows
Library			  OperatingSystem
Library			  SeleniumLibrary
Library			  Process
Library           String
Library			  BuiltInLibrary
Library			  AutoItLibrary
Library			  RPA.Desktop.Clipboard
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMExplorerWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library    		  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Scripts/IronPythonScripts/KeyboardActions.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Suite Setup       Suite setup steps
Suite Teardown	  Suite teardown steps

*** Test Cases ***

PMEx NetAn and ENIQ Connection
	${output}=    Open DXP, Run Script and Return Output    PM_Explorer_S11_10.dxp    DBConnection.py

*** Keywords ***

Open DXP, Run Script and Return Output
	[Arguments]    ${dxp_name}    ${scriptName}
	${loc}=		Replace String 		${file_loc}	   \\    \\\\
    ${script}=    Get iron_python script for PMA collection delete scenario     ${scripts}\\${scriptName}		${loc}
	run process    Powershell.exe    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\DXP_Files\\${dxp_name}
	close the certificate prompt
	run keyword and ignore error    close the Missing Information Link window
	open search prompt and search for    Document{SPACE}Properties
	go to document properties and run the script    ${script}
	${output}=    read an return the output	
	Log    ${output}
	[Return]    ${output}		