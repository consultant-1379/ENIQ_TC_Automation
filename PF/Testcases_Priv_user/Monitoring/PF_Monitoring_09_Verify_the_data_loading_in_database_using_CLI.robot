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

*** Variables ***
${host_123}    ieatrcxb8506.athtem.eei.ericsson.se
${SERVER}    ieatrcxb8506
${user_for_vapp}    DmCi
${pass_for_vapp}    StatENIQ%1234
${port_for_vapp}    22



*** Test Cases ***
Verify the data loading in database using CLI
    Open connection as root user
    Put File    ${EXEC_DIR}//PF//Scripts//test.bsh    /home/DMCI
    Execute the Command    dos2unix test.bsh
    ${dwhrep_pwd}=    Execute Command    sudo ./test.bsh REP DWHREP | grep -i Password | cut -d ':' -f 2
    ${dc_pwd}=    Execute Command    sudo ./test.bsh DWH DC | grep -i Password | cut -d ':' -f 2
    Write    sudo su - dcuser
    ${output_01}=    Read    delay=1s
    @{lst_loaded}=    Create List
    @{lst_notloaded}=    Create List
    ${query_01}=    Execute the Command   echo -e "WITH MaxMTableIDPerGroup AS (SELECT MAX(MTABLEID) AS MaxMTABLEID, BASETABLENAME FROM MEASUREMENTTABLE WHERE BASETABLENAME LIKE 'DC_E_ERBSG2_%' AND BASETABLENAME NOT LIKE 'DC_E_ERBSG2_EVENT%' AND TABLELEVEL = 'RAW' GROUP BY BASETABLENAME) SELECT BASETABLENAME FROM MaxMTableIDPerGroup ORDER BY BASETABLENAME ASC;\ngo\n" | isql -P ${dwhrep_pwd} -U dwhrep -S repdb -b
    ${Techpack}=    Get Regexp Matches    ${query_01}    DC_E_ERBSG2_\\w*
    FOR    ${selecting_techpack}    IN    @{Techpack}
        ${techpack_table}=    Catenate    ${selecting_techpack}
        ${Loaded_status}=    Execute the command    echo -e "select count(*) from ${selecting_techpack} where Date_ID=today() ;\ngo\n" | isql -P ${dc_pwd} -U dc -S dwhdb -b 
        ${check_status}    Split To Lines    ${Loaded_status}    2    3
        ${check_status}    Evaluate    ${check_status}[0] > 0
        IF    ${check_status}==True
            Append To List    ${lst_loaded}    ${techpack_table}
            Log To Console    ${techpack_table} is Loaded.
        ELSE
            Append To List    ${lst_notloaded}    ${techpack_table}
            Log To Console    ${techpack_table} is not Loaded.
        END
    END
    Should Not Be Empty    ${lst_loaded}
    ${not_loaded_count}=    Get Length    ${lst_notloaded}
    IF    ${not_loaded_count} > 0
        Fail    ${not_loaded_count} Tables not loaded: ${lst_notloaded}
    END
    

