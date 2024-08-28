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
Verify dataintegrity testcases with SN and NRCellDU
    [Tags]  dataIntegrity
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithSN_NrCellDU.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with SN and NRCellDU     ${object}[${key}]
    END
    

Verify dataintegrity testcases with MOID and SN 
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithMOID_SN.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with MOID and SN     ${object}[${key}]
    END	
	
Verify dataintegrity testcases with MOID and DCVECTOR_INDEX
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithMOID_DcVector.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with MOID and DCVECTOR_INDEX     ${object}[${key}]
    END	
	
Verify dataintegrity testcases with MOID and DscAdjacentRealm
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithMOID_DscAdjacent.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with MOID and DscAdjacentRealm     ${object}[${key}]
    END		

Verify dataintegrity testcases with MOID and ERBS
    ${json}=    OperatingSystem.get file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/pm-explorer/DataIntegrityWithMOID_ERBS.json
    &{object}=    Evaluate     json.loads('''${json}''')     json
    FOR   ${key}   IN  @{object.keys()}
        Add Test Case    ${key}   Verify Data Integrity with MOID and ERBS     ${object}[${key}]
    END	
    
*** Keywords ***   
Verify Data Integrity with SN and NRCellDU
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for three param    ${scripts}\\pmexCounterKPIThreeParamVerification.py     ${data}     ${loc}		SN		NRCellDU  
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
	${NODE_NAME_VALUE}=    Read parameters from the text file     ${file_loc}\\NRCellDUvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue for three param  ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}		${NODE_NAME_VALUE}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application 


Verify Data Integrity with MOID and SN
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for three param    ${scripts}\\pmexCounterKPIThreeParamVerification.py     ${data}     ${loc}		MOID		SN  
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
	${NODE_NAME_VALUE}=    Read parameters from the text file     ${file_loc}\\NRCellDUvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue for three param  ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}		${NODE_NAME_VALUE}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application  

Verify Data Integrity with MOID and DCVECTOR_INDEX
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for three param    ${scripts}\\pmexCounterKPIThreeParamVerification.py     ${data}     ${loc}		MOID		DCVECTOR_INDEX  
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
	${NODE_NAME_VALUE}=    Read parameters from the text file     ${file_loc}\\NRCellDUvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue for three param  ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}		${NODE_NAME_VALUE}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application

Verify Data Integrity with MOID and DscAdjacentRealm
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for three param    ${scripts}\\pmexCounterKPIThreeParamVerification.py     ${data}      ${loc}		MOID		DscAdjacentRealm  
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
	${NODE_NAME_VALUE}=    Read parameters from the text file     ${file_loc}\\NRCellDUvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue for three param  ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}		${NODE_NAME_VALUE}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application	

Verify Data Integrity with MOID and ERBS
    [Arguments]      ${data}
    Launch Tibco spotfire PMEX Application
	${loc}=		Replace String 		${file_loc}	 \\		\\\\
	${test_script}=    Get iron_python script by passing project location for three param    ${scripts}\\pmexCounterKPIThreeParamVerification.py     ${data}     ${loc}		MOID		ERBS  
    Execute iron python script     ${test_script}     False 
    ${DATETIME_VALUE}=    Read parameters from the text file    ${file_loc}\\datevalue.txt
    ${UNIQUE_ID_VALUE}=    Read parameters from the text file     ${file_loc}\\moidvalue.txt
	${NODE_NAME_VALUE}=    Read parameters from the text file     ${file_loc}\\NRCellDUvalue.txt
    ${MEASURE_Value}=    Read parameters from the text file     ${file_loc}\\measurevalue.txt
    ${DB_Value}=     Query ENIQ database for kpiValue for three param  ${data}[SQL]    ${DATETIME_VALUE}    ${UNIQUE_ID_VALUE}		${NODE_NAME_VALUE}
	${MEASURE_Value}=		Remove zeros after decimal point from measure value     ${MEASURE_Value}
    Verify UI value is matching with DB value    ${MEASURE_Value}     ${DB_Value}
    [Teardown]     Close Tibco spotfire PMEX Application		