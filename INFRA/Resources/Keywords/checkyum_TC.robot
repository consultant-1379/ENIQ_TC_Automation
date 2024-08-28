*** Settings ***
Library    ../../Scripts/opensession_runcommand.py


*** Variables ***
${command}    cd /etc/yum.repos.d; ls -l|grep ericRHEL.repo

*** Keywords ***
check_yum_repos
    [Arguments]    ${mwshost}    ${mwsuser}    ${mwspwd}
    ${output}=    connect_to_terminal_runcommand    ${mwshost}    ${mwsuser}    ${mwspwd}    ${command}
    [Return]    ${output}


