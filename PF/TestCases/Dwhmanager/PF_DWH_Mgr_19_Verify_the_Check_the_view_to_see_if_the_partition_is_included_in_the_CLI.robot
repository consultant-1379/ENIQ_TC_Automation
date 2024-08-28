*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/repdb_connection.robot



*** Test Cases ***
Verify the check the view to see if the partition is included in the CLI
    Connect to server as a dcuser
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    Connect to dc username in CLI
    #${DC_Z_Alarm}=    Execute the Command    echo -e "sp_helptext DC_Z_ALARM_INFO_RAW;\ngo\n" | isql -P ${dc_pwd} -U dc -S dwhdb -b    
    Write     sp_helptext DC_Z_ALARM_INFO_RAW
    ${DC_Z_Alarm}=    Read    delay=2s
    Write    Exit
    ${output}=    Read    delay=1s
    Connect to dwhrep in CLi
    Write    select tablename from DWHPartition Where TABLENAME like '%ALARM_INFO%'
    ${Query_2}=    Read    delay=2s
    #${Query_2}=    Execute the Command    echo -e "select tablename from DWHPartition Where TABLENAME like '%ALARM_INFO%';\ngo\n" | dbisql -c "UID=dwhrep;PWD=${dwhrep_pwd};eng=repdb" -host localhost -port 2641 -nogui
    Sleep    5s
    ${DC_Z_Alarm_Info}=    Get Regexp Matches    ${Query_2}    DC_Z_ALARM.*\\d
    Log To Console    ${DC_Z_Alarm_Info}
    FOR    ${Dc_Alarm_table}    IN    @{DC_Z_Alarm_Info}
        Log    ${Dc_Alarm_table}
        Verify the msg    ${DC_Z_Alarm}    ${Dc_Alarm_table}   
        
    END
    [Teardown]    Test Teardown

*** Keywords ***
Test Teardown
    Close All Connections    