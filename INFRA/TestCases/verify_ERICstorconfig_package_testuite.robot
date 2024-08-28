*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkERICstorconfigpackage_TC.robot
Resource    ../Resources/Keywords/checkcachedERICstorconfigpackage_TC.robot

Test Teardown    Run Keyword If Test Failed    log    ERICstorconfig package has not been installed properly

*** Test Cases ***

check if ERICstorconfig package successfully installed and version matches with latest media

    ${output_ERICstorconfig}=    check_ERICstorconfig_package    ${mwshost}    ${mwsuser}    ${mwspwd}
    ${output_cached_ERICstorconfig}=    check_cached_ERICstorconfig_package    ${mwshost}    ${mwsuser}    ${mwspwd}

    Should Contain    ${output_cached_ERICstorconfig}     ${output_ERICstorconfig}

