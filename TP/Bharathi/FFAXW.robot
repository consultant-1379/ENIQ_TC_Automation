*** Settings ***
Library    SSHLibrary
Library    ./ffaxw_cal.py
Library    String

Test Teardown    Close Connection

*** Variables ***
${sql_query}    select TOP 1 DATE_ID from DC_E_FFAXW_KPI
${sql_query1}    select TOP 61 DCVECTOR_INDEX from DC_E_RBSG2_CARRIER_V_DAY
${sql_query2}    select TOP 61 pmBranchDeltaSir from DC_E_RBSG2_CARRIER_V_DAY
${sql_query3}    select pmBranchDeltaSir_Samples_SD_SD,pmBranchDeltaSir_Samples_MEAN,pmBranchDeltaSir_Samples_MEAN_MEAN from DC_E_FFAXW_KPI
${host}    atvts4130.athtem.eei.ericsson.se
${port}    2251
${uname}    dc
${pwd}    Dc12#
${run}		go
${database}      dwhdb
${path}    H:
${package}    DC_E_FFAXW

*** Tasks ***
Test
    Creating Connection
    ffaxw
    

*** Keywords ***
Creating Connection
    ${index}    Open Connection    ${host}    port=${port}    timeout=10    
    Login    dcuser     Dcuser%12
ffaxw
    ${package}    Evaluate    'DC_E_FFAXW' in '${package}'
    IF    ${package}
        Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=10
        Write    cd /eniq/home/dcuser
        Read    delay=5s
        Write    echo -e "${sql_query}\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
        ${output3}=    Read Until Prompt
        ${output3}    ffaxw_cal.Ffaxw Date    ${output3}
        Write    echo -e "${sql_query1}\\nwhere DATE_ID='${output3}'\\n\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
        ${output1}=    Read Until Prompt
        Write    echo -e "${sql_query2}\\nwhere DATE_ID='${output3}'\\n\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
        ${output2}=    Read Until Prompt
        Write    echo -e "${sql_query3}\\n${run}\\n" | isql -P ${pwd} -U ${uname} -S ${database} -b
            ${output4}=    Read Until Prompt
            ${output4} =  Split String    ${output4}     
            Log To Console    ${\n}Standard Deviation=${output4}[0]${\n}Mean=${output4}[1]${\n}Mean_Mean=${output4}[2]
            ${out}    ffaxw_cal.ffaxw    ${output1}    ${output2}
            ${Status_ffaxw}    ffaxw_cal.ffaxw_comapare    ${output4}    ${out}    
            IF    '${Status_ffaxw}' == 'True'
            Pass Execution    "validated calculated values from RBSG2 with FFAXW" 
            ELSE
                Fail
            END
    END
        