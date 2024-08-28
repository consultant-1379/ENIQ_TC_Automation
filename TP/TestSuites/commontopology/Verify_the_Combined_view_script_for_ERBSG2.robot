*** Settings ***
Resource    ../../Resources/login.resource
Library    RPA.RobotLogListener
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections  
Library    ../TestCases/server.py

*** Variables ***
#${path1}=    /root/CI/cicd/space/workspace/TP_ROBOT_Test
#${path2}=    /root/tppkg
${path1}=    H:
${path2}=    H:/Downloads
*** Tasks ***
testing
    Verify the Combined view script for ERBSG2
    

*** Keywords ***
Verify the Combined view script for ERBSG2
    IF    '${pkg}' =='DC_E_ERBS'
        ${output}=    Execute Command    cd /eniq/sw/installer && ./erbscombinedview.bsh
        Put File    ${path1}/ENIQ_TC_Automation/TP/Resources/epfgerbs.pl    /eniq/home/dcuser
        Write    cd /eniq/home/dcuser/epfg ; ./epfg_preconfig_for_ft.sh
        ${output2}=    Read    delay=10s
        Write    cd /eniq/home/dcuser && perl epfgerbs.pl
        ${output1}=    Read    delay=10s
        Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
        Write     engine -e startSet 'INTF_DC_E_ERBSG2-eniq_oss_1' 'Adapter_INTF_DC_E_ERBSG2_3gpp32435'
        Write     engine -e startSet 'INTF_DC_E_RADIONODE_MIXED-eniq_oss_1' 'Adapter_INTF_DC_E_RADIONODE_MIXED_3gpp32435'
        Checking Log of dim intf    ${pkg}    ${host}    ${port}    ${uname}    ${pwd}
        Open nexus tpkpiscript
        ${scriptlink}=    Get Element Attribute    //a[contains(text(),'KeyCounter_Loading_Check')]    href
        ${scriptname}=    Fetch From Right    ${scriptlink}    /
        Open Connection    atvts4051.athtem.eei.ericsson.se
        Login               root        shroot
        Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${scriptlink} ; pwd
        sleep    10
        Read    delay=10s
        Switch Connection    ${index}
        Write    cd /eniq/home/dcuser ; rm -r Loading
        Write    cd /eniq/home/dcuser ; mkdir Loading
        Put File    ${path2}/${scriptname}     /eniq/home/dcuser/Loading/
        Write    cd /eniq/home/dcuser/Loading ; unzip ${scriptname}
        ${repo}    Fetch From Right  ${pkg}     _
        ${etl}    Convert To Lower Case  ${repo}
        Open clearcasevobs
        ${rstate}    Get Text    //table//a[text()='DC_E_ERBSG2']/../following-sibling::td[3]
        Go To    https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/ERBSG2/erbsg2_etl/FD/${rstate}
        Click Element    //a[contains(text(),'ERBSG2')]
        ${modeltlink}=    Get Element Attribute    //tr[3]//a    href
        ${modeltname}=    Fetch From Right    ${modeltlink}    /
        Open Connection    atvts4051.athtem.eei.ericsson.se
        Login               root        shroot
        Write    rm -rf tppkg ; mkdir tppkg ; cd tppkg ; wget ${modeltlink} ; pwd
        sleep    10
        Switch Connection    ${index}
        Put File    ${path2}/${modeltname}     /eniq/home/dcuser/Loading
        ${filegentime}=    filter date from epfg    ${output1}
        update automation file    ${scriptname}    ${filegentime}    ${pkg}_%_RAW    ${modeltname}    ${host}    ${port}    ${uname}    ${pwd}
        ${finak_log}=   Execute Command    cd /eniq/home/dcuser/Loading ; java -jar LoadingCheck.jar input.properties 
        Write    cd /eniq/home/dcuser/Loading ; egrep ':fail|:null|:failed' output | wc -l 
        ${temp}=    Read    delay=10s
        ${failorpass}=    Filter err COunt    ${temp}
        IF    '${failorpass}' == '0'
            Log To Console    'TC is passing'
        ELSE
            FAIL
        END
        Write    cd /eniq/home/dcuser ; mkdir Loading
        Put File    H:/KeyCounter_Loading_Check.zip    /eniq/home/dcuser/Loading/
    END