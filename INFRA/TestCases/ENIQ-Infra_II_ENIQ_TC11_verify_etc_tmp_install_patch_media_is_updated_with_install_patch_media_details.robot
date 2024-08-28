*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
check for install patch media is updated
    ${output}=    Execute Command    cat /etc/.tmp_install_patch_media
    Should Contain     ${output}    /JUMP/INSTALL_PATCH_MEDIA/


