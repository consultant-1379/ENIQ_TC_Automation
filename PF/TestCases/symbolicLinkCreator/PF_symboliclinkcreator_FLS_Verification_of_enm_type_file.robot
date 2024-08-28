*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot

*** Test Cases ***
Verifying enm_type file should be present in the following path
    [Tags]    FLS
    Connect to server as a dcuser
    Verifying whether enm_type is should be displayed as "cENM"  

*** Keywords ***
Verifying whether enm_type is should be displayed as "cENM" 
    ${mount_path_1}=    Execute Command    ls /eniq/connectd/mount_info/
    @{spliting_oss_ref_file}=    Split To Lines    ${mount_path_1}
    FOR    ${mount_path_1}    IN    @{spliting_oss_ref_file}
        
        ${enm_type_file}=    Execute Command    ls /eniq/connectd/mount_info/${mount_path_1} | grep -i enm_type
        ${get_length}    Get Length    ${enm_type_file}
        IF    ${get_length}!= 0
            ${enm_type}=    Execute Command    cat /eniq/connectd/mount_info/${mount_path_1}/${enm_type_file}
            Verify the PENM and CENM    ${enm_type}    pENM    cENM
            
        END
        
    END
    [Teardown]    Test teardown

Test teardown
    Close Connection