*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections
 
*** Test Cases ***
Verify examples folder and docs folder got removed
    ${output}    Execute Command    ls /eniq/sw/runtime/tomcat/webapps
    Should Not Contain     ${output}   examples
    Should Not Contain     ${output}   docs
    Log    ${output}