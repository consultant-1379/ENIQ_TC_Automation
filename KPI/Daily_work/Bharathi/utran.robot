*** Settings ***
Library    SSHLibrary
Library    utra.py
Library    Collections
Library    String
Library    Process
Test Teardown    Close Connection

*** Variables ***
${sql_query}    Select RNC_ID from DIM_E_RAN_RBSLOCALCELL
${host}    atvts4134.athtem.eei.ericsson.se
${port}    2251
${uname}    dc
${pwd}    Dc12#
${run}		go
${database}      dwhdb
${path}    H:

*** Tasks ***
Test1
    Creating Connection
    Get RNCID value from DB
    Get RNCID value from xml

*** Keywords ***
Creating Connection
    ${index}    Open Connection    ${host}    port=${port}    timeout=10    
    Set Global Variable    ${index}
    Login    dcuser     Dcuser%12
    
Get RNCID value from DB
...    Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
       ${output1}=    Read    delay=7s
       Set Global Variable    ${output1}
       Log To Console    ${\n}${output1}
Get RNCID value from xml
    Execute Command    cd /eniq/home/ && mkdir utran
    Put File    ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles/UTRAN/utran/topologyData/RBS/*.xml    /eniq/home/utran
    ${output2}=    Read    delay=7s
    ${engine_utran_file_name}    Execute Command     cd /eniq/home/utran && ls -Art *.xml
    ${y}    Split Command Line    ${engine_utran_file_name}
    Log To Console    ${y}
    FOR    ${engine_utran_file_name}    IN    @{y}
        ${associatedTag}    Execute Command      grep 'associatedRnc' /eniq/home/utran/${engine_utran_file_name}
        Set Global Variable    ${associatedTag}
        Log To Console    ${associatedTag}
    ${Empty}    Run Keyword And Return Status    Should not Be Empty      ${associatedTag}
        IF    ${Empty} == True
            ${associatedTags}    Execute Command      grep 'associatedRnc' /eniq/home/utran/${engine_utran_file_name} | awk -F "[><]" '{print $3}' | cut -d"=" -f4-
            Log To Console    ${associatedTags}
            ${comp}    utra.compare    ${output1}    ${associatedTags}
        ELSE
            ${fd}    Execute Command    cat /eniq/home/utran/${engine_utran_file_name} | grep -m1 fdn | cut -d"=" -f2- | awk '{print $1}'
            ${fd} =	Split String	${fd}    ,
            ${fd1}    Convert To String    ${fd}
            ${fd}    Remove String    ${fd1}    "
            ${fd}    Remove String    ${fd}    '
            Log To Console    ${fd}    
            ${comp1}    utra.compare1    ${fd}    ${output1}
        END
    END
    ${del_dir}    Execute Command    cd /eniq/home/ && rm -rf utran
