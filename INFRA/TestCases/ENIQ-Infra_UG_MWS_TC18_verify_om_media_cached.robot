*** Settings ***
Library    ../Scripts/verify_latest_om_media.py
Library    ../Scripts/verify_latest_release.py
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to mws
Test Teardown    Close All Connections
*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1
*** Test Cases ***
check if om media is cached
    ${sprints}=    check_emc_package_exist    ${mwshost}    ${mwsuser}    ${mwspwd}
    ${releases}=    latest_release_value    ${mwshost}    ${mwsuser}    ${mwspwd}

    ${output_JUMP}=    Execute Command    ls /JUMP/OM_LINUX_MEDIA/${releases}/${sprints}/om_linux/
    Should Not Be Empty    ${output_JUMP}

