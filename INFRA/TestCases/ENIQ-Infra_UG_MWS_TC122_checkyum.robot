*** Settings ***
Library    ../Scripts/opensession_runcommand.py
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkyum_TC.robot


*** Test Cases ***
check yum

    ${output}=    check_yum_repos    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${output}    ericRHEL.repo


