*** Settings ***
Documentation    Testing of installer testcases
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Installer.robot
Resource    ../../Resources/Keywords/Variables.robot
Test Setup    Connect to server as a dcuser
Test Teardown    Close All Connections


*** Test Cases ***
Verify the All installer Module scripts present in server
    Removing Automation_installer text file
    Adding Installer script files in SERVER
    ${flag}    Set Variable    True
    @{lst}=    Create List
    ${content}=    Execute Command    cat ${insatller_path_for_scripts}Automation_installer_scripts.txt
    Should Not Be Empty    ${content}
    @{files}    Split To Lines    ${content}
    FOR    ${Scripts_name}    IN    @{files}
        ${checking_file}    Execute Command    ${List_of_files} ${Scripts_name}
        IF    '${checking_file}'!='${EMPTY}'
            Log To Console    ${insatller_path_for_scripts}${Scripts_name} file is there
        ELSE
            Append To List    ${lst}    ${insatller_path_for_scripts}${Scripts_name}    
            Log To Console    ${insatller_path_for_scripts}${Scripts_name} file is not there
            ${flag}    Set Variable    False
        END
    END
    IF    '${flag}' == 'True'
        Pass Execution    All files are present
    ELSE
        Fail    Some files are not present:${lst}
    END

        
