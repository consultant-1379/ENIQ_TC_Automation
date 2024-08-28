*** Settings ***
Force Tags  suite
Documentation     PMA Testcase
Documentation     DB connection
Test Setup       Open Connection And Log In     ${host}     ${username}    ${password}    ${PORT}
Test Teardown    Close All Connections
Suite setup      Set Screenshot Directory   ./Screenshots
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
Verify dataintegrity testcases with unique MOID
    [Tags]  moid
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/DataIntegrityWithMOID.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with MOID     ${object}[${key}]
    END
    

Verify dataintegrity testcases with unique VM Name
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/DataIntegrityWithVMName.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with VM Name     ${object}[${key}]
    END	
	
Verify dataintegrity testcases with unique Trans Mode
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/DataIntegrityWithTransMode.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with Trans Mode     ${object}[${key}]
    END	
	
Verify dataintegrity testcases with unique DCVECTOR_INDEX
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-alarm/DataIntegrityWithDCVectorIndex.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with DCVECTOR_INDEX     ${object}[${key}]
    END		
	

    
*** Keywords ***   
Verify Data Integrity with VM Name
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script for PMA DataIntegrity    ${scripts}\\pmAlarmDataIntegrity.py     ${data}    ${loc}		VM_NAME  
    Execute iron python script     ${test_script}     False 
    ${VM_NAME_VALUE}=    Read parameters from the text file    ${file_loc}\\moidvalue.txt
    ${DATEID_Value}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${MEASURE_Value}=    Read parameters from the text file    ${file_loc}\\measurevalue.txt.
    ${DB_Value}=     Query ENIQ database    ${data}[SQL]    ${DATEID_Value}    ${VM_NAME_VALUE}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMA Application


Verify Data Integrity with MOID
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script for PMA DataIntegrity    ${scripts}\\pmAlarmDataIntegrity.py     ${data}      ${loc}		MOID  
    Execute iron python script     ${test_script}     False 
    ${MOID}=    Read parameters from the text file    ${file_loc}\\moidvalue.txt
    ${DATETIME_ID}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${MEASURE_Value}=    Read parameters from the text file    ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database    ${data}[SQL]    ${DATETIME_ID}    ${MOID}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMA Application    

Verify Data Integrity with Trans Mode
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script for PMA DataIntegrity     ${scripts}\\pmAlarmDataIntegrity.py     ${data}     ${loc}	TRANS_MODE
    Execute iron python script     ${test_script}     False 
    ${TRANS_MODE_Value}=    Read parameters from the text file    ${file_loc}\\moidvalue.txt
    ${DATETIME_ID}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${MEASURE_Value}=    Read parameters from the text file    ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database    ${data}[SQL]    ${DATETIME_ID}    ${TRANS_MODE_Value}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMA Application 	
	
Verify Data Integrity with DCVECTOR_INDEX
    [Arguments]      ${data}
    Launch Tibco spotfire PMA Application
    ${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script for PMA DataIntegrity    ${scripts}\\pmAlarmDataIntegrity.py     ${data}     ${loc}	DCVECTOR_INDEX
    Execute iron python script     ${test_script}     False 
    ${TRANS_MODE_Value}=    Read parameters from the text file    ${file_loc}\\moidvalue.txt
    ${DATETIME_ID}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${MEASURE_Value}=    Read parameters from the text file    ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database    ${data}[SQL]    ${DATETIME_ID}    ${TRANS_MODE_Value}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMA Application 	
