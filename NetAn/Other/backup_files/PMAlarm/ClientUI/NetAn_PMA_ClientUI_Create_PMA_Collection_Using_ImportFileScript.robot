*** Settings ***
Force Tags  suite
Documentation     PMA Testcase

Suite setup      Set Screenshot Directory   ./Screenshots
Library           DatabaseLibrary
Library           AutoItLibrary
Library           SikuliLibrary
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library          SSHLibrary
Library          DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
																								   
										

*** Variables ***


*** Test Cases ***

Create PMA Collection Using ImportFileScript
    [Tags]  dataIntegrity
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/ImportFileCollectionInput.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Create PMA Collection Using ImportFile     ${object}[${key}]
    END
    
*** Keywords ***   

Create PMA Collection Using ImportFile
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
	 # ${loc}=		Replace String 		${file_loc}	 \\		\\\\
    Click on Node Collection Manager
    ${test_script_DB}=    Get iron_python script for import file    ${scripts}\\PMADBConnection.py     ${data}
    Execute iron python script for DB Connection     ${test_script_DB}    False
    Sleep	5s
    Click on Node Collection Manager
    Sleep    5s
    ${test_script}=    Get iron_python script for import file    ${scripts}\\PMAImportFile.py     ${data}
    Execute iron python script for import file     ${test_script}    False
    Click on Create Button
    # Choose File    //input[@type="file"]    C:\\NetAn_repo\\ENIQ_TC_Automation\\NetAn\\Other\\Files\\collection_test_eniq_test_Public.txt	
    # Sleep    5s
    [Teardown]    Test teardown steps
	
Test teardown steps
    Capture screen
    Close Tibco spotfire PMA Application