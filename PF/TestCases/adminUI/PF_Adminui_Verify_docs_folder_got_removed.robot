*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Connect to server
Suite Teardown    Close All Connections

*** Test Cases ***
Verify docs folder got removed
    ${output}    Execute Command    ls /eniq/sw/runtime/tomcat/webapps | grep -i docs
    Should Not Contain     ${output}   docs
    Log    ${output}

