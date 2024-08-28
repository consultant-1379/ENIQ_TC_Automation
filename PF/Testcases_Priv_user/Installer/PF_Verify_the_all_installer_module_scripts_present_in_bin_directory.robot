*** Settings ***
Documentation    Testing of installer testcases
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Installer.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections


*** Test Cases ***
Verify the All installer Module scripts present in server
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Removing Automation_bin text file
    Put File    ${EXEC_DIR}//PF//Scripts//Automation_bin_scripts.txt    /var/tmp
    Write    cd /var/tmp
    Write    cp Automation_bin_scripts.txt /eniq/sw/bin
    ${output}=    Read    delay=1s
    ${flag}    Set Variable    True
    @{lst}=    Create List
    ${content}=    Execute Command    cat ${bin_path_for_scripts}Automation_bin_scripts.txt
    Should Not Be Empty    ${content}
    @{files}    Split To Lines    ${content}
    FOR    ${Scripts_name}    IN    @{files}
        ${checking_file}    Execute Command    ${List_of_files_bin} ${Scripts_name}
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

        
