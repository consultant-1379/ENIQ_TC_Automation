*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py
*** Variables ***
${sql_query}     select distinct TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME like 'DIM_%';
${path}    /root/CI/cicd/space/workspace/TP_ROBOT_Test
*** Test Cases ***
Loading Area File for UTRAN
    Loading area file
*** Keywords *** ***
 Loading area file
    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
    Log To Console    ${output1}
    @{intfDIM}    Filter Topotp Name    ${output1}
        IF    '${intfDIM}[0]' == 'DIM_E_UTRAN'
            Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_RAN_AREA.txt    /eniq/data/pmdata/eniq_oss_1/utran/topologyData/DIM_RAN_AREA/               
            Write    engine -e startSet 'INTF_UTRAN_BASE_AREA-eniq_oss_1' 'Adapter_INTF_UTRAN_BASE_AREA_ascii'
            Read    10s
        END
    
    