*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/repdb_connection.robot



*** Test Cases ***
Verify the command engine -e startSet
    Connect to server as a dcuser
    Adding datebase file in SERVER
    Execute the Command    dos2unix test.bsh
    ${etlrep_pwd}=    Execute Command     ./test.bsh REP ETLREP | grep -i Password | cut -d ':' -f 2
    ${INTF_Loader}=    Execute the Command    echo -e "Select COLLECTION_NAME from META_COLLECTIONS Where COLLECTION_NAME LIKE ('Loader%');\ngo\n" | isql -P ${etlrep_pwd} -U etlrep -S repdb -b
    @{spilting_techpack}=    Split To Lines    ${INTF_Loader}
    ${Techpack_list}=    Get From List    ${spilting_techpack}    15
    @{seperate_techpackname}=    Get Regexp Matches    ${Techpack_list}    DC_[a-zA-Z]*_[a-zA-Z]*
    ${Techpack_name}=    Get From List    ${seperate_techpackname}    0
    ${engine_startset}=    Execute the command    ${engine_startset_techpack} ${Techpack_name} ${Techpack_list}   
    Verify the msg    ${engine_startset}    Start set requested successfully
    Go to the folder    ${Engine_Logs}${Techpack_name} ; ls
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${grepError_results_1}=    Grep message from file    error    engine-${current_date}.log
    ${grepError_results_2}=    Grep message from file    exception    engine-${current_date}.log
    verify for no errors in logs    ${grepError_results_1}
    verify for no errors in logs    ${grepError_results_2}

*** Keywords ***
Test Teardown
    Close All Connections   