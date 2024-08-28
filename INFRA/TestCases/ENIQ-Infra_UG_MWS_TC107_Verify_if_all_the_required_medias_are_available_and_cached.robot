*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check for upgrade patch media
    ${output}=    Execute Command   ls /JUMP |grep UPGRADE_PATCH_MEDIA
    Should Not Be Empty     ${output}

check for om media
    ${output}=    Execute Command   ls /JUMP |grep OM_LINUX_MEDIA
    Should Not Be Empty     ${output}


check for INSTALL_PATCH_MEDIA
    ${output}=    Execute Command   ls /JUMP |grep INSTALL_PATCH_MEDIA
    Should Not Be Empty     ${output}

check for LIN_MEDIA
    ${output}=    Execute Command   ls /JUMP |grep LIN_MEDIA
    Should Not Be Empty     ${output}



