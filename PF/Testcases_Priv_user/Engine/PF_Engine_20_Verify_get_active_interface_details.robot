*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Verify get active interface details
    Open connection as root user
    Write    sudo su - dcuser
    ${refernce_file}=    Execute Command    cat /eniq/sw/conf/.oss_ref_name_file
    @{spliting_oss_ref_file}=    Split To Lines    ${refernce_file}
    FOR    ${refernce_file}    IN    @{spliting_oss_ref_file}
        
        ${Get_oss_file}=    Get Regexp Matches    ${refernce_file}    eniq_oss_\\d
        ${Techpack}=    Get From List    ${Get_oss_file}    0
        Execute the command    ${installer_path}
        ${interface_oss_ref_files}=    Execute the command    ${get_active_interfaces_01} ${Techpack}
        Verify the msg    ${interface_oss_ref_files}    ${Techpack}
        
        
    END

*** Keywords ***
Test Teardown
    Close All Connections   