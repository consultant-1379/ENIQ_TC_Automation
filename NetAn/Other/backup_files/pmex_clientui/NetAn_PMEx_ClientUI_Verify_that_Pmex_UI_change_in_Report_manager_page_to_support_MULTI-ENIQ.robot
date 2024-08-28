*** Settings ***
Documentation     Testing Core Nodetypes
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/WebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
Suite setup       Set Screenshot Directory    ./Screenshots



*** Variables ***
${base_url}=       https://localhost/
${pmex_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Explorer/PM-Explorer/Analyses/PM%20Explorer&waid=Tza-om0C4Emhp9dxoJ0wu-091024061e335T&wavid=0
${browser_name}=   chrome

*** Test Cases ***
	
Verify that Pmex:UI change in Report manager page to support MULTI-ENIQ
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/pmexMultiEniqInputs.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        IF     '${count}'=='0'
                Run keyword       Run the test case with values from json file       ${object}[${key}]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}   Run the test case with values from json file        ${object}[${key}]
		END
    END    
    Capture page screenshot
	[Teardown]     Close the Tibco spotfire PMEX Application
	