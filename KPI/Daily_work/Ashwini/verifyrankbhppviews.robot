*** Settings ***
Library    SSHLibrary
Library    Collections
Library    String
Library    RPA.Database

*** Variables *** 
${RANKBHCP0_SQL_query}    Select * from DC_E_MRS_BGFBH_RANKBH_BGF_CP0 where DATE_ID = '2023-03-01'
${CP0_Query}    DC_E_MRS_BGFBH_RANKBH_BGF_CP0
${host}    atvts4114.athtem.eei.ericsson.se
${username}    dc
${password}    Dc12#
${port_number}    2251
${database}    dwhdb
${path}    H:\Robot_Automation
${Run}    go
${output}

#REPDB vairables defined
${busyhour_query_two}    Select BHCRITERIA from Busyhour WHERE VERSIONID like '%DC_E_MRS%' and BHTYPE like '%CP0%' and DESCRIPTION like '%CP0%'
${repdb_password}     Dwhrep12#
${repdb_username}     dwhrep
${repdb_database}    repdb
${busyhour_query}         Select BHCRITERIA,* from Busyhour WHERE VERSIONID like '%DC_E_MRS%' and BHTYPE like '%CP0%' and DESCRIPTION like '%CP0%'
${query_countername}    Select nbNbVoiceTranscodingSess,* from DC_E_MRS_BGF_BGFINSTANCE_RAW 
*** Test Cases ***
Testcase No 1
...    Creating connection to server
        Verify the RANKBHCP0 View
        Creating Connection to REPDB
        Resuming connection to DWHDB
****Keywords***
# Test
    # Write    cd \eniq\home\dcuser
    # Read    delay=2s
    
Creating connection to server
    ${index}    Open Connection    ${host}    port=${port_number}    timeout=10
    Set Global Variable    ${index}
    Login    dcuser    Dcuser%12

#Quering the output in DWHDB
Verify the RANKBHCP0 View
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser}     timeout=20s
    Write    cd \eniq\home\dcuser
    Read    delay=2s
    SSHLibrary.Write     echo -e "${RANKBHCP0_SQL_query}\\n${Run}\\n"| isql -P ${password} -U ${username} -S ${database} -b
    ${RANKBHCP0_SQL_query}      Read Until Prompt
    ${RANKBHCP0_SQL_query_output}    Split String    ${RANKBHCP0_SQL_query}   
    Log    ${RANKBHCP0_SQL_query_output}
    
Creating connection to REPDB
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser}     timeout=20s

#Quering Busy hour with version id and bhtype 

    SSHLibrary.Write     echo -e "${busyhour_query}\\n${Run}\\n"| isql -P ${repdb_password} -U ${repdb_username} -S ${repdb_database} -b
    ${busyhour_query}      Read Until Prompt
    ${busyhour_query_output}    Split String    ${busyhour_query}    \r\n
    Log    ${busyhour_query_output}
    ${a}    Strip String    ${busyhour_query_output}[0]
    Log     ${busyhour_query_output}[0]
    ${b}    Split String From Right   ${busyhour_query_output}[0]    (       
    ${c}    Strip String    ${b}[1]
    ${d}    Remove String    ${b}[1]   )
    ${e}    Strip String    ${d}
    
    Set global variable    Log     ${e}
#Quering measurement counter with Dataname as a condition
    SSHLibrary.Write        echo -e "select * from Measurementcounter where DATANAME like '%${e}%'\\n${Run}\\n"| isql -P ${repdb_password} -U ${repdb_username} -S ${repdb_database} -b
    ${query_measurement_counter}      Read Until Prompt
    ${query_measurement_counter_output}    Split String    ${query_measurement_counter}   
    Log    ${query_measurement_counter_output}[0]
    ${f}    Split String From Right   ${query_measurement_counter_output}[0]    :
    Set global variable    Log    ${f}[2]
    
Resuming connection to DWHDB
    Switch Connection    ${index}
#Quering countername from RAW table
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser}     timeout=20s
    SSHLibrary.Write     echo -e "Select ${e},* from ${f}[2]_RAW \\n${Run}\\n"| isql -P ${password} -U ${username} -S ${database} -b
    ${query_counter_name}    Read Until Prompt
    ${query_counter_name_output}    Split String    ${query_counter_name}
    Log    ${query_counter_name_output}
    