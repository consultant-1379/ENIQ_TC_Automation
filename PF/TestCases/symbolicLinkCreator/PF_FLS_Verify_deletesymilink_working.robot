*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections


*** Test Cases ***
Check for working of Delete_SymlinkFiles
    ${fls_conf_data}=    Execute Command    cat /eniq/installation/config/fls_conf
    @{fls_oss_list}=    Split To Lines    ${fls_conf_data}
    Skip If    @{fls_oss_list} == @{EMPTY}
    Set Suite Variable    ${fls_oss_list}
    Log    fls conf data: ${fls_oss_list}
    FOR    ${fls_alias_name}    IN    @{fls_oss_list}
        #check if eniq alias folder is present
        ${check_eniq_oss_folder}=    Execute command     [ -d /eniq/data/pmdata/${fls_alias_name} ] && echo "True" || echo "False"
        IF     ${check_eniq_oss_folder} == True
            ${files_count_older_than_3_days}    ${dlsymlink_stderr}=    Execute Command    find /eniq/data/pmdata/${fls_alias_name}/ -type f -mtime +4 ! -user root -print | wc -l    return_stderr=True
            # ${files_count_older_than_3_days}=    Execute Command    find /eniq/data/pmdata/${fls_alias_name}/ -type f -mtime +3 ! -user root -print | wc -l
            Should be Empty    ${dlsymlink_stderr}
            Log     ${files_count_older_than_3_days}   
            Should Be Equal     ${files_count_older_than_3_days}    0    
        END
    END 
    