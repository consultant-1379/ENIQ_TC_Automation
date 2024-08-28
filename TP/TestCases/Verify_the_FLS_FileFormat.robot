*** Settings ***
Resource          ../Resources/login.resource
Library           ./server.py
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections

*** Variables ***
${sql_query1}    select COLLECTION_SET_ID from META_COLLECTION_SETS WHERE COLLECTION_SET_NAME LIKE 'INTF_DC_E_HSS_TSP'

*** Tasks ***
Checking rege if TP is Hss
    IF    'DC_E_HSS' == 'DC_E_HSS'
        Getting Interface sheet of TCP
    ELSE
        Log To Console    IT is not HSS TP
    END
*** Keywords ***
Getting Interface sheet of TCP
    Set Client Configuration    prompt=eniqs[eniq_stats] {dcuser} #:    timeout=3600
    Write    cd eniq/home/dcuser 
    Read    delay=20s
    Write    echo -e "${sql_query1}\\n${run}\\n" | isql -P Etlrep12# -U etlrep -S repdb
    ${output1}=    Read Until Prompt
    ${collection_id}=    Test    ${output1}
    Write    echo -e "select ACTION_CONTENTS_01 from Meta_transfer_actions WHERE COLLECTION_SET_ID like '${collection_id}' and ACTION_TYPE LIKE 'parse';\\n${run}\\n" | isql -P Etlrep12# -U etlrep -S repdb
    ${output2}=    Read Until Prompt
    ${fileformat_pattern}=    Processed Directory    ${output2}
    IF    '${fileformat_pattern}' == 'A(.{18}).*'
        Log To Console    File Format pattern supports FLS
    ELSE
        Fail
    END