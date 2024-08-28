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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/PMAlarmWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library    		  ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/KeyboardActions.py
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Suite Setup       Suite setup steps
Suite Teardown	  Suite teardown steps

*** Variable ***

#${script}=    print "Hello"

*** Test Cases ***

TEST CASE NAME
	${output}=    Open DXP, Run Script and Return Output    PM_Alarming_S11_2.dxp    DBConnection.py

*** Keywords ***

Open DXP, Run Script and Return Output
	[Arguments]    ${dxp_name}    ${scriptName}
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
    ${script}=    Get iron_python script for PMA collection delete scenario     ${scripts}\\${scriptName}		${loc}
	run process    Powershell.exe    ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\DXP_Files\\${dxp_name}
	close the certificate prompt
	run keyword and ignore error    close the Missing Information Link window
	open search prompt and search for    Document{SPACE}Properties
	go to document properties and run the script    ${script}
	${output}=    read an return the output	
	Log    ${output}
	[Return]    ${output}
	
Suite teardown steps
    Close Spotfire Application
    sleep    2
    
Suite setup steps
    Selenium2Library.Set Screenshot Directory   ./Screenshots   
    
close the certificate prompt
    sleep    10
	press keyboard button    '{TAB}'
	sleep    5
	press keyboard button    '{ENTER}'
	
open search prompt and search for
	[Arguments]    ${text}
	sleep    5    
    open search prompt
	enter text    ${text}
	sleep    4
	press keyboard button    '{ENTER}'
	sleep    5
	
go to document properties and run the script
	[Arguments]    ${script}	
	control window    Document Properties
	sleep    5
	RPA.Windows.Click   name:Properties
	control window    Document Properties
	sleep    4
	RPA.Windows.Click  id:scriptButton
	sleep    4
	control window    Script – Act on Property Change
	sleep    4
	RPA.Windows.Click  id:useScriptRadioButton
	sleep    5
	RPA.Windows.Click  id:newButton
	sleep    4
	control window    New Script
	RPA.Windows.Click  id:wrapInTransactionCheckbox
	sleep    4
	RPA.Windows.Click  id:nameTextBox
	click button multiple times    {TAB}    3
	paste the text    ${script}
    RPA.Desktop.Clear Clipboard
	sleep    4
	RPA.Windows.Click  id:runButton
	sleep    10
	
read an return the output
	sleep    10
	RPA.Windows.Click  id:outputTextBox
	sleep    4
	copy and paste output
	${spotfireOutput}=    OperatingSystem.get file    ${EXEC_DIR}\\SpotfireOutput.txt
	Log    ${spotfireOutput}
	[Return]    ${spotfireOutput}
	