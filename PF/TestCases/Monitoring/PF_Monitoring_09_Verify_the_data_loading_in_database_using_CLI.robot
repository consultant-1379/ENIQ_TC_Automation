*** Settings ***
Documentation     Testing Monitoring
Library    SSHLibrary
Library    Collections
Library    String
Library    DateTime
Resource     ../../Resources/Keywords/Monitoring.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/repdb_connection.robot
Test Teardown    Close All Connections



*** Test Cases ***
Verify the data loading in database using CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    @{lst_loaded}=    Create List
    @{lst_notloaded}=    Create List
    ${dc_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    # ${Current_date}=    Get current date in yyyy.mm.dd result_format
    # ${output}=    Connect to dwhrep in CLi
    # Verify the msg    ${output}    (dwhrep)>
    # ${query_01}=    Execute the Command    Select TYPENAME from log_aggregationstatus WHERE TYPENAME like '%DC_E_ERBSG2%' and date_id = '${Current_date}'
    ${query_01}=    Execute the Command   echo -e "WITH MaxMTableIDPerGroup AS (SELECT MAX(MTABLEID) AS MaxMTABLEID, BASETABLENAME FROM MEASUREMENTTABLE WHERE BASETABLENAME LIKE 'DC_E_ERBSG2_%' AND BASETABLENAME NOT LIKE 'DC_E_ERBSG2_EVENT%' AND TABLELEVEL = 'RAW' GROUP BY BASETABLENAME) SELECT BASETABLENAME FROM MaxMTableIDPerGroup ORDER BY BASETABLENAME ASC;\ngo\n" | isql -P ${dc_pwd} -U dwhrep -S repdb -b
    ${Techpack}=    Get Regexp Matches    ${query_01}    DC_E_ERBSG2_\\w*
    Log To Console    ${Techpack}
    Execute the Command    Exit
    ${dc1_pwd}=    Execute Command    ./test.bsh DWH DC | grep -i Password | cut -d ':' -f 2
    FOR    ${selecting_techpack}    IN    @{Techpack}
        ${techpack_table}=    Catenate    ${selecting_techpack}
        ${Loaded_status}=    Execute the Command    echo -e "select distinct OSS_ID,ROWSTATUS,YEAR_ID,DAY_ID from ${techpack_table} where rowstatus='LOADED' and Date_ID=NOW() ;\ngo\n" | isql -P ${dc1_pwd} -U dc -S dwhdb -b
        ${check_status}=    Run Keyword And Return Status    Verify the Loaded status    ${Loaded_status}    LOADED        
        Log To Console    ${check_status}
        IF    ${check_status}==True
            Append To List    ${lst_loaded}    ${techpack_table}
            Log To Console    ${techpack_table} is loaded
        ELSE
            Append To List    ${lst_notloaded}    ${techpack_table}
            Log To Console    ${techpack_table} is not loaded
        END
    END
    Should Not Be Empty    ${lst_loaded}
    ${not_loaded_count}=    Get Length    ${lst_notloaded}
    IF    ${not_loaded_count} > 0
        Fail    Techpacks not loaded: ${lst_notloaded}
    END 
    

