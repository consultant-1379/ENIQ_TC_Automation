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
Library          SSHLibrary
Library          DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py
																								   
										

*** Variables ***


*** Test Cases ***
Verify dataintegrity testcases with unique MOID
    [Tags]  dataIntegrity
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithMOID.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with MOID     ${object}[${key}]
    END
    

Verify dataintegrity testcases with unique SN 
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithSN.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with SN     ${object}[${key}]
    END	
	
Verify dataintegrity testcases with unique NR Name
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithNrName.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with NR Name     ${object}[${key}]
    END	
	

    
*** Keywords ***   
Verify Data Integrity with MOID
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location    ${scripts}\\pmexCounterKPITwoParamVerification.py     ${data}     ${loc}		MOID
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue    ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}
    ${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
   	Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application


Verify Data Integrity with SN
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location    ${scripts}\\pmexCounterKPITwoParamVerification.py     ${data}     ${loc}		MOID
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue    ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}
    ${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
   	Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application  

Verify Data Integrity with NR Name
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location    ${scripts}\\pmexCounterKPITwoParamVerification.py     ${data}     ${loc}		MOID
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue    ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}
    ${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
   	Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application	
