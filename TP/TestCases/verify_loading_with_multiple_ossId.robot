*** Settings ***
Library    ./server.py
Library    RPA.Cloud.Azure
Resource    ../Resources/login.resource
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***
${sql_query}    select distinct substr(CONFIG,charindex('basetable',CONFIG)+10) test from Transformation where target like 'dc_release' and TRANSFORMERID like '${pkg}:%'
${intfstring}
#${path}    /root/CI/cicd/space/workspace/TP_ROBOT_Test/
${path}    H:/
*** Test Cases ***
Task To Perform Activating Interface
    verifying loading with multiple ossid
     
*** Keywords ***
verifying loading with multiple ossid
    Get interfaces for TP
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    FOR    ${element}    IN    @{interface_list_for_DCTP}
        ${output}   Execute Command    cd /eniq/sw/installer && ./activate_interface -o eniq_oss_2 -i ${element} && echo true || echo false
        ${true_or_false}    return true false    ${output}
        IF    '${true_or_false}' == 'false'
           Write    cd /eniq/sw/installer ; rm -rf install_lockfile
           ${output1}=    Read    delay=3
           Write    cd /eniq/sw/installer && ./activate_interface -o eniq_oss_2 -i ${element} && echo true || echo false
           ${output2}=    Read Until Prompt
        END
    END
    FOR    ${element}    IN    @{interface_list_for_DCTP}
       ${intfstring}=    Catenate    SEPARATOR=|    ${element}${SPACE}eniq_oss_2    ${intfstring}
    END
    Log To Console    ${intfstring}    
    ${newstr}=    removestr    ${intfstring}
    ${length}=    Get Length    ${interface_list_for_DCTP}
    Write    cd /eniq/sw/installer ; ./get_active_interfaces | egrep '${newstr}' | wc -l
    ${st}=    Read Until Prompt
    ${length2}=    filterlength    ${st}
    IF    ${length} == ${length2}
        Log To Console    pass
        Write    cd /eniq/home/dcuser/epfg ; ./epfg_preconfig_for_ft.sh
        Read Until Prompt
        Put File    ${path}ENIQ_TC_Automation/TP/Resources/epfgdataGeneration.pl    /eniq/home/dcuser
        Put File    ${path}ENIQ_TC_Automation/TP/Resources/data.txt    /eniq/home/dcuser
        Put Directory    ${path}ENIQ_TC_Automation/TP/Resources/TopologyFiles/    /eniq/home/dcuser
        Write    cd /eniq/home/dcuser ; perl epfgdataGeneration.pl
        ${output3}=    Read Until Prompt
        Edit Epfg For Multiple Oss    ${host}    ${port}    ${uname}    ${pwd}
        Write    cd /eniq/home/dcuser/epfg ; ./start_epfg.sh
        Read Until Prompt
        Sleep    30s
        FOR    ${element}    IN    @{interface_list_for_DCTP}
            Write    echo -e "select DATAFORMATTYPE from DataInterface where INTERFACENAME LIKE '${element}'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
	        ${par}    Read Until Prompt
	        ${parser_name}    Filter Name    ${par} 
            Write    engine -e startSet '${element}-eniq_oss_2' 'Adapter_${element}_${parser_name}'
            Read Until Prompt  
        END
    ${filegentime}=    filter date from epfg    ${output3}
    Open clearcasevobs
    ${name}=    Get Element Attribute    //a[text()='${pkg}']    href
    ${tpname}=    Fetch From Right    ${name}    /
    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${out1}=    Read Until Prompt
    ${topotable}=    Filter Topotable Name    ${out1}
    Write    echo -e "select DATANAME from ReferenceColumn where typeid like '%${topotable}' and DATANAME like '%[_]name%'\\n${run}\\n" | isql -P ${password_db} -U ${username} -S ${database} -b
    ${out2}=    Read Until Prompt
    ${nodeVersiontable}=    Filter Node Name    ${out2}
    Write    echo -e "select distinct ERBS from DC_E_ERBS_BBPROCESSINGRESOURCE_RAW where Datetime_id = '2022-09-20 10:00:00'\\n${run}\\n" | isql -P Dc12# -U dc -S dwhdb -b
    ${out3}=    Read Until Prompt
    @{node_name_list}=    list of nodename    ${out3}
    FOR    ${element}    IN    @{node_name_list}
        ${output4}=    Execute Command    cd /eniq/home/dcuser && rm -rf BT-FT_Script && rm -rf BT-FT_Log && unzip BT-FT_Script_R9B_b13.zip && cd BT-FT_Script/ && chmod 777 * && echo -e "${tpname} \\n ${filegentime} \\n ERBS \\n ${element} \\n 5 \\n" | ./BT-FT_script.sh
    END
    ELSE
        FAIL
    END

    