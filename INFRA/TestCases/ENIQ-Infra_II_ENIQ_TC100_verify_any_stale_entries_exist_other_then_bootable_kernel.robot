*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/verify_any_stale_entries_exist_other_then_bootable_kernel_on_eniq_server.py
Library    SSHLibrary



*** Test Cases ***
check for any stale entry
    ${output}=    check_emc_package_exist    ${hostname}    ${username}    ${password}
    Should Contain     ${output}    True


