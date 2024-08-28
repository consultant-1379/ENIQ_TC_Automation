*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_Lin_media
    ${output}=    Execute Command    ls /JUMP/LIN_MEDIA|grep -E "[0-9]+"
    [Return]     ${output}

