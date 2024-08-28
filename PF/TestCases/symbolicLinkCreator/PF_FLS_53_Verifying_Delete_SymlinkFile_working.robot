*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Test Teardown    Close All Connections


*** Test Cases ***
 Check for physical Delete_SymlinkFile
     Connect to server as a dcuser
    ${Latest_DeleteSymlinkFile}    Execute Command    cd /eniq/log/sw_log/symboliclinkcreator/ ; ls -Art DeleteSymlinkFile-*| tail -1
    ${output}    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${Latest_DeleteSymlinkFile}
    Log To Console    ${output}
    ${Deleted_File_count}    Evaluate    "0" in """${output}"""
    IF    ${Deleted_File_count}
        Log To Console    Total number of files which are older than 3 days =  0, hence passsing the testcase 
    ELSE
        ${fls_delete_symlink_file}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${Latest_DeleteSymlinkFile} | grep -A 99999 'days'| tail -n +2 
    Log To Console    ${fls_delete_symlink_file}
    @{check_path}=    Split To Lines    ${fls_delete_symlink_file}  
    Log To Console    ${check_path}
    FOR    ${element}    IN    @{check_path}
        ${check_file_present}    ${rc}=    Execute Command    cat ${element}    return_rc=True 
        ${output_length}    Get Length    ${check_file_present}
        IF   '${rc}' == '1' and '${output_length}' == '0'
            Log    ${element} not present
        ELSE
            Fail    ${element} is present
        END
    END
    END


    