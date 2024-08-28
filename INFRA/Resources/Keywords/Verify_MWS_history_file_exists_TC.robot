*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_mws_history_file_exists
    ${output}=    Execute Command    ls /ericsson/config | grep mws_history
    [Return]     ${output}

