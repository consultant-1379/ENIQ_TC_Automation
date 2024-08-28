*** Settings ***
Force Tags  suite
Documentation      Create PMEx Collection Using ImportFileScript
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           CustomFunctions
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
																								   
										

*** Variables ***


*** Test Cases ***

Create PMEx Collection Using ImportFileScript
    [Tags]  dataIntegrity       pmexClientUI
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/ImportFileCollectionInput.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
	${count}=       set variable     0
    FOR   ${key}   IN  @{object.keys()}
	    IF     '${count}'=='0'
                Run keyword       Create PMEx Collection Using ImportFile     ${object}[${key}]
                ${count}=       set variable     1
        ELSE				
                Add Test Case    ${key}   Create PMEx Collection Using ImportFile     ${object}[${key}]
		END
    END
	
*** Keywords ***   

Create PMEx Collection Using ImportFile
    [Arguments]      ${data}
    Launch the Tibco spotfire PMEx Application
	 # ${loc}=		Replace String 		${file_loc}	 \\		\\\\
    Click on Collection Manager
    ${test_script_DB}=    Get iron_python script for import file    ${scripts}\\DBConnection.py     ${data}
    Execute iron python script for DB Connection     ${test_script_DB}    False
    ${test_script}=    Get iron_python script for import file    ${scripts}\\ImportFileScript.py     ${data}
    Execute iron python script for import file     ${test_script}    False
    Click on Save Button
    #Choose File    //input[@type="file"]    C:\\NetAn_repo\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\collection_test_eniq_test_Public.txt	
    #Sleep    5s
