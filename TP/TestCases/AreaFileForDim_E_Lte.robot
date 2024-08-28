*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
*** Variables ***
${sql_query}    select distinct TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME like 'DIM_%';
${temp}    DIM_E_UTRAN
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
        IF    '${intfDIM}[0]' == 'DIM_E_LTE'
            Put File    ${path}/ENIQ_TC_Automation/TP/Resources/DIM_LTE_AREA.txt    /eniq/data/pmdata/eniq_oss_1/lte/topologyData/DIM_LTE_AREA/               
            Write    engine -e startSet 'INTF_LTE_BASE_AREA-eniq_oss_1' 'Adapter_INTF_LTE_BASE_AREA_ascii'
        END
    
    