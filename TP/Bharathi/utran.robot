*** Settings ***
Library    SSHLibrary
Library    ../Resources/tp.py
Library    Collections
Library    String
Library    Process
Library    RPA.Windows
Test Teardown    Close Connection
Resource    ../Resources/login.resource

*** Variables ***
${sql_query}    Select distinct RNC_ID from DIM_E_RAN_RBSLOCALCELL
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
    Get RNCID value from xml
 
*** Keywords ***
Creating Connection
    ${index}    Open Connection    ${host}    port=${port}    timeout=10    
    Set Global Variable    ${index}
    Login    dcuser     Dcuser%12
    
Get RNCID value from xml
    Execute Command    cd /eniq/home/ && mkdir utran
    Put File    ${path}/ENIQ_TC_Automation/TP/Resources/TopologyFiles/UTRAN/utran/topologyData/RBS/*.xml    /eniq/home/utran
    ${output2}=    Read    delay=7s
    ${engine_utran_file_name}    Execute Command     cd /eniq/home/utran && ls -Art *.xml
    ${y}    Split Command Line    ${engine_utran_file_name}
    Log To Console    ${y}
    FOR    ${engine_utran_file_name}    IN    @{y}
        ${associatedTag}    Execute Command      grep 'associatedRnc' /eniq/home/utran/${engine_utran_file_name}
        Log To Console    ${\n}associatedRNCtag ${associatedTag}
        ${Empty}    Run Keyword And Return Status    Should not Be Empty      ${associatedTag}
        IF    ${Empty} == True
            ${con_xml}    Execute Command      grep 'associatedRnc' /eniq/home/utran/${engine_utran_file_name} | awk -F "[><]" '{print $3}' | cut -d"=" -f4-
            Write    echo -e "${sql_query}\\nwhere RBS_ID='${con_xml}'\\n\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
            ${output1}=    Read    delay=7s
            ${comp}    tp.compare    ${output1}    ${con_xml}
            Set Global Variable    ${comp}
        ELSE
            ${fd}    Execute Command    cat /eniq/home/utran/${engine_utran_file_name} | grep -m1 fdn | cut -d"=" -f2- | awk '{print $1}'
            ${fd} =	Split String	${fd}    ,
            ${fd1}    Convert To String    ${fd}
            ${fd}    Remove String    ${fd1}    "
            ${fd}    Remove String    ${fd}    '  
            
            ${mecontext}    ${con_xml}    ${comp1}   tp.compare1    ${fd}
            Write    echo -e "${sql_query}\\nwhere RBS_ID='${mecontext}'\\n\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
            ${output1}=    Read    delay=7s
            ${comp}    tp.compare2    ${output1}    ${con_xml}    ${comp1}
            Log To Console    ${comp}
            Set Global Variable    ${comp}
        END
        
        Log To Console    ${comp}
        IF    '${comp}' == 'True'
            ${final}    set Variable    False
            ${final2}    set Variable    False
            Log To Console    "RNC_ID key is validated from database and xml"
        ELSE IF    '${comp}' == 'EMPTY'
            ${final}    set Variable    False
            ${final2}    set Variable    False
            Log To Console    RNC_ID KEY not load if SubNetwork=SubNetwork orSubNetwork=ONRM* 
        ELSE
            Log To Console    "Mismatch of RNC_ID from database and xml or data is not loaded"
            ${final2}    set Variable    True
            ${final}    set Variable    True
            Set Global Variable    ${final}
        END
       
    END
    IF    '${final2}' == 'True'
            Fail
    END
    IF    '${final}' == 'True' 
         FAIL
    END
    ${del_dir}    Execute Command    cd /eniq/home/ && rm -rf utran

