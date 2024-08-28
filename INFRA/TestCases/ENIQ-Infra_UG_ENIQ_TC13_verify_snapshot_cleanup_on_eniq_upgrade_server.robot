*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/update_check.py
Library    ../Scripts/snapshot_deletion_check.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
check for snapshot cleanup
    ${value}=    update_check    ${eniq_upg_hostname}     ${eniq_upg_username}    ${eniq_upg_password}
    ${value2}=    snap_deletion_check    ${eniq_upg_hostname}     ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${value}"=="True"
        IF    "${value2}"=="False"
            ${output}=    Execute Command   sudo lvs |grep snap
            Should Be Empty     ${output}
        ELSE
            ${output}=    Execute Command   sudo lvs |grep snap
            Should Not Be Empty     ${output}
        END
    END

