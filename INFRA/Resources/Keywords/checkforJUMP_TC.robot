*** Settings ***
Library    ../resources/opensession_runcommand.py

*** Variables ***

${command}    df -h|grep JUMP

*** Keywords ***
check_for_JUMP_partition
    [Arguments]    ${mwshost}    ${mwsuser}    ${mwspwd}
    ${output}=    connect_to_terminal_runcommand    ${mwshost}    ${mwsuser}    ${mwspwd}    ${command}
    [Return]    ${output}

