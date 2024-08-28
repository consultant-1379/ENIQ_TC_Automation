*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_kernal_version
    ${output}=    Execute Command    grubby --info=ALL | grep -E "^kernel"
    ${output1}=    Execute Command    uname -r
    ${output2}=    Should Contain     ${output}     ${output1}
    [Return]     ${output2}



