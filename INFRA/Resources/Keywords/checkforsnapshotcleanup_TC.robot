*** Settings ***
Library    SSHLibrary

*** Keywords ***

check_for_rootsnap_cleanup
    ${output_rootsnap}=    Execute Command    lvs| grep rootsnap
    [Return]    ${output_rootsnap}

check_for_varsnap_cleanup
    ${output_varsnap}=    Execute Command    lvs| grep varsnap
    [Return]    ${output_varsnap}


