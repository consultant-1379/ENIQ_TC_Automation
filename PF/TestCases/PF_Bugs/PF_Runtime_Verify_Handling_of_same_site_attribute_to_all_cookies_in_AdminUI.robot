*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections


*** Test Cases ***
Verify Handling of same site attribute to all cookies in AdminUI 
    ${check_context_log}    ${stderr}=    Execute Command    cat /eniq/sw/runtime/tomcat/conf/context.xml | grep -i "\\bstrict\\b"    return_stderr=True
    Should Be Empty    ${stderr}
    Should Not Be Empty    ${check_context_log}