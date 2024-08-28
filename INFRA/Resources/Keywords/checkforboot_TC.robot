*** Settings ***
Library    ../resources/opensession_runcommand.py

*** Variables ***

${command}    df -h|grep boot

*** Keywords ***
check_for_boot_partition
    [Arguments]    ${mwshost}    ${mwsuser}    ${mwspwd}
    ${output}=    connect_to_terminal_runcommand    ${mwshost}    ${mwsuser}    ${mwspwd}    ${command}
    [Return]    ${output}

