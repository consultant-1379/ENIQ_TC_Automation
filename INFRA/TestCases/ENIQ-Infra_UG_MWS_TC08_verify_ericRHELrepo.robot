*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Library    String
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkericRHEL_repo_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check if yum.repos.d directory is present

    ${output_dir}=    check_ericRHEL_repo
    Should Not Contain    ${output_dir}    No such file or directory


check if baseurl updated in yum.repos.d

    ${output_verify_baseurl}=    check_ericRHEL_repo
    ${output_baseurl}=    Get Substring    ${output_verify_baseurl}    14
    ${path_to_installed_rhel}=    Catenate    SEPARATOR=/    ${output_baseurl}    media.repo
    ${verify_rhelversion}=    Execute Command    cat ${path_to_installed_rhel}
    Should Contain    ${verify_rhelversion}    ${rhel_version_installed_mws}

