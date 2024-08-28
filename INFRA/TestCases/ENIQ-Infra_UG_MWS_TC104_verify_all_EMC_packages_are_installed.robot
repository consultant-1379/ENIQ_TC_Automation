*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary
Library    ../Scripts/verify_all_EMC_packages_are_installed.py



*** Test Cases ***
check for emc packages
    ${result}=    check_emc_package_exist    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${result}    Nice



