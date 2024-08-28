*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Connect to server
Suite Teardown    Close All Connections

*** Test Cases ***
Verify examples folder got removed
    ${output}    Execute Command    ls /eniq/sw/runtime/tomcat/webapps | grep -i examples
    Should Not Contain     ${output}   examples
    Log    ${output}

