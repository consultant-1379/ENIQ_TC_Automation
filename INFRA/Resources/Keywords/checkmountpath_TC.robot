*** Settings ***
Library    ../resources/opensession_runcommand.py
Variables    ../variables/variables_for_patch_TC.py
*** Variables ***

${command}    cd ${mountpath}; ls -l|grep ${patchver}

*** Keywords ***
check_mount_path
    [Arguments]    ${mwshost}    ${mwsuser}    ${mwspwd}
    ${output}=    connect_to_terminal_runcommand    ${mwshost}    ${mwsuser}    ${mwspwd}    ${command}
    [Return]    ${output}

