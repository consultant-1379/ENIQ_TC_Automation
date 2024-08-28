*** Settings ***
Library   ../resources/opensession_runcommand.py
Library    CryptoLibrary    variable_decryption=True
Variables    ../variables/variables_for_patch_TC.py
Resource    ../testcases/checkmountpath_TC.robot


*** Test Cases ***
check mount path

    ${output}=    check_mount_path    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${output}    ${patchver}

