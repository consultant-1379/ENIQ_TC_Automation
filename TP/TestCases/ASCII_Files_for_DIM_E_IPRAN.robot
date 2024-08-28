*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
*** Variables ***
${sql_query}    select distinct TECHPACKNAME from  TechPackDependency where VERSIONID LIKE '${pkg}:%'and TECHPACKNAME like 'DIM_%';
@{addapterintf}    INTF_DIM_E_IPRAN_TWAMPASCII    INTF_DIM_E_IPRAN_TWAMPSESSIONS    INTF_DIM_E_IPRAN_QOSPOLICY    INTF_DIM_E_IPRAN_STNMAP    INTF_DIM_E_IPRAN_ASSOCIATIONS
${temp}    DIM_E_IPRAN
*** Test Cases ***
Loading Ascii File for IPRAN
    Loading ascii file
*** Keywords *** ***
 Loading ascii file
    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${output1}=    Read    delay=3s
    Log To Console    ${output1}
    @{intfDIM}    Filter Topotp Name    ${output1}
        IF    '${temp}' == 'DIM_E_IPRAN'
            Put File    H:/ENIQ_TC_Automation/TP/Resources/TWAMPDSCPMAP.txt    /eniq/data/pmdata/eniq_oss_1/ipran/topologyData/twamp/TWAMPASCII/
            Put File    H:/ENIQ_TC_Automation/TP/Resources/TWAMPSVCDEF.txt    /eniq/data/pmdata/eniq_oss_1/ipran/topologyData/twamp/TWAMPASCII/
            Put File    H:/ENIQ_TC_Automation/TP/Resources/IpranSTN.txt    /eniq/data/pmdata/eniq_oss_1/ipran/topologyData/STN
            Put File    H:/ENIQ_TC_Automation/TP/Resources/SLA.txt    /eniq/data/pmdata/eniq_oss_1/IPRAN/SLA/       
            FOR    ${element}    IN    @{addapterintf}
                Write    engine -e startSet '${element}-eniq_oss_1' 'Adapter_${element}_ascii'
                Read    delay=10
            END
        END
    
    