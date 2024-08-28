*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
Verify the All respository Module scripts present in server
    verify all respository module scripts present in bin directory

*** Keywords ***
verify all respository module scripts present in bin directory
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Execute Command    rm -rf /eniq/sw/bin/Repository_bin_scripts.txt
    Execute Command    rm -rf /var/tmp/Repository_bin_scripts.txt
    Put File    ${EXEC_DIR}//PF//Scripts//Repository_bin_scripts.txt    /var/tmp
    Write    cd /var/tmp
    Write    cp Repository_bin_scripts.txt /eniq/sw/bin
    ${repository_output}=    Read    delay=1s  
    ${flag}    Set Variable    True
    @{lst}=    Create List
    ${content}=    Execute Command    cat /eniq/sw/bin/Repository_bin_scripts.txt
    Should Not Be Empty    ${content}
    @{files}    Split To Lines    ${content}
    FOR    ${Scripts_name}    IN    @{files}
        ${checking_file}    Execute Command    ls /eniq/sw/platform/repository-*/bin | grep -i ${Scripts_name}
        IF    '${checking_file}'!='${EMPTY}'
            Log To Console    ${bin_path_for_scripts}${Scripts_name} file is there
        ELSE
            Append To List    ${lst}    ${bin_path_for_scripts}${Scripts_name}    
            Log To Console    ${bin_path_for_scripts}${Scripts_name} file is not there
            ${flag}    Set Variable    False
        END
    END
    IF    '${flag}' == 'True'
        Pass Execution    All files are present
    ELSE
        Fail    Some files are not present:${lst}
    END
