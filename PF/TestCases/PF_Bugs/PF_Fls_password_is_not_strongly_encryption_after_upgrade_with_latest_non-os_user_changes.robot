*** Settings ***
Documentation    Testing symboliclinkcreator
Library           SSHLibrary
Library        String
Library        Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Teardown    Close All Connections

*** Variables ***
@{server_details}


*** Test Cases ***
Fls password is not strongly encryption after upgrade with latest non-os user changes
    Open connection as root user
    ${output}    Execute Command    cat /eniq/sw/conf/enmserverdetail
    ${server_details}    Split To Lines    ${output}
    Log To Console    ${server_details}
    FOR    ${element}    IN    @{server_details}
        ${host_details}    Split String    ${element}   
        Should Match Regexp    ${host_details}[6]    \\bYY\\b
    END