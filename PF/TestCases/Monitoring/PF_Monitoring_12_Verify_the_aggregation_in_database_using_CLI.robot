*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections
Library    DateTime
Resource     ../../Resources/Keywords/Monitoring.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/repdb_connection.robot
Test Teardown    Close All Connections



*** Test Cases ***
Verify the aggregation in database using CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    Execute the Command     dos2unix test.bsh
    @{lst_aggregated}=    Create List
    @{lst_not_aggregated}=    Create List
    ${dc_pwd}=    Execute Command    ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    # ${Current_date}=    Get current date in yyyy.mm.dd result_format
    # ${output}=    Connect to dwhrep in CLi
    # Verify the msg    ${output}    (dwhrep)>
    # ${query_01}=    Execute the Command    Select TYPENAME from log_aggregationstatus WHERE TYPENAME like '%DC_E_ERBSG2%' and date_id = '${Current_date}'
    ${query_01}=    Execute the Command   echo -e "WITH MaxMTableIDPerGroup AS (SELECT MAX(MTABLEID) AS MaxMTABLEID, SUBSTRING(BASETABLENAME, 1, LENGTH(BASETABLENAME) - 4) AS BASETABLENAME FROM MEASUREMENTTABLE WHERE BASETABLENAME LIKE 'DC_E_ERBSG2_%' AND BASETABLENAME NOT LIKE 'DC_E_ERBSG2_EVENT%' AND TABLELEVEL = 'RAW' GROUP BY BASETABLENAME) SELECT BASETABLENAME FROM MaxMTableIDPerGroup ORDER BY BASETABLENAME ASC;\ngo\n" | isql -P ${dc_pwd} -U dwhrep -S repdb -b
    # ${Techpack}=    Get Regexp Matches    ${query_01}    DC_E_ERBSG2_\\w*
    ${Techpack}=    Get Regexp Matches    ${query_01}    DC_E_ERBSG2_\\w*
    ${total_tables_count}=    Get Length    ${Techpack}
    Log    ${Techpack}
    Execute the Command    Exit
    ${dc1_pwd}=    Execute Command    ./test.bsh DWH DC | grep -i Password | cut -d ':' -f 2
    FOR    ${selecting_techpack}    IN    @{Techpack}
        ${Techpack_01}=    Catenate    ${selecting_techpack}
        # ${Query_02}=    Execute the Command     echo -e "select OSS_ID,ROWSTATUS,YEAR_ID,DAY_ID from ${Techpack_01} where rowstatus='AGGREGATED';\ngo\n" | isql -P ${dc_pwd} -U dc -S dwhdb -b
        # ${Query_02}=    Execute the Command    echo -e "select TYPENAME,AGGREGATION,STATUS from log_aggregationstatus where TYPENAME='${Techpack_01}' and status='AGGREGATED' and Date_ID=NOW()-1 and TIMELEVEL='DAY' ;\ngo\n" | isql -P ${dc1_pwd} -U dc -S dwhdb -b
        ${Query_02}=    Execute the Command    echo -e "select TYPENAME,AGGREGATION,STATUS from log_aggregationstatus where TYPENAME='${Techpack_01}' and status='AGGREGATED' and Date_ID=NOW()-1 and TIMELEVEL='DAY' ;\ngo\n" | isql -P ${dc1_pwd} -U dc -S dwhdb -b
        # Log To Console    ${Query_02}
        ${check_status}=    Run Keyword And Return Status    Verify the AGGREGATED status    ${Query_02}    AGGREGATED     
        Log To Console    ${check_status}
        IF    ${check_status} == True
            Append To List    ${lst_aggregated}    ${Techpack_01}
            Log To Console    ${Techpack_01} is AGGREGATED 
        ELSE
            Append To List    ${lst_not_aggregated}    ${Techpack_01}
            Log To Console    ${Techpack_01} is not AGGREGATED
        END
    END
    ${aggregated_count}=    Get Length    ${lst_aggregated} 
    Should Not Be Empty    ${lst_aggregated}
    ${not_aggregated_count}=    Get Length    ${lst_not_aggregated}    
    IF    ${not_aggregated_count} > 0
        Fail    Techpacks not aggregated: ${lst_not_aggregated}
    END 