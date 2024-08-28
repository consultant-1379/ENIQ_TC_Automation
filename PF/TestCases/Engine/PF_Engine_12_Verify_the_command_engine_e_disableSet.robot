*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/repdb_connection.robot


*** Test Cases ***
Verify the command engine -e disableSet
    Connect to physical server
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    ${etlrep_pwd}=    Execute Command     ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    ${Adapter_INTF}=    Execute the Command    echo -e "Select COLLECTION_NAME from META_COLLECTIONS Where COLLECTION_NAME LIKE ('Adapter_INTF%');\ngo\n" | isql -P ${etlrep_pwd} -U etlrep -S repdb -b
    @{spilting_techpack}=    Split To Lines    ${Adapter_INTF}    3
    ${Techpack_list}=    Get From List    ${spilting_techpack}    3
    ${Techpack_name}=    Get Regexp Matches    ${Techpack_list}    INTF_[a-zA-Z]+_[a-zA-Z]+_[a-zA-Z]+
    ${interface_name}=    Get From List    ${Techpack_name}    0
    ${disable_set}=    Executing the command    ${engine_disableset_techpack} ${interface_name} ${Techpack_list} 
    Verification of disable Sets    ${disable_set}    Disabled Sets
    Verify the msg    ${disable_set}    Completed successfully
    ${show_disabledsets}=    Executing the command    ${engine_showdisable_sets}  
    Verify the msg    ${show_disabledsets}    Completed successfully
    ${start_set}=    Executing the command    ${engine_disableset_techpack} ${interface_name} ${Techpack_list}
    Verification of disable Sets    ${start_set}        Disabled Sets
    Verify the msg    ${start_set}    Completed successfully
    [Teardown]    Test Teardown
    

*** Keywords ***
Test Teardown
    Close All Connections
   
    