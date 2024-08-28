*** Settings ***
Library    SSHLibrary
Library    String
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot

*** Test Cases ***
Verify the installation logs for no errors
    Connect to server as a dcuser
    Execute the Command    ${platform_installer}
    ${latest}=    Get latest file from directory    installer*.log
    ${latest}    Split String    ${latest}
    ${Verify}    ${rc}    Execute Command    ${platform_installer} && cat ${latest}[0] | grep -iE "warning\|exception\|severe\|not found\|error"    return_rc=true
    IF    ${rc}==0
        Fail    Failing the testcase, since log has some warning/error/exception/not found
    ELSE
        Log    Passing the testcase, since there is no warning/error/exception
    END

*** Keywords ***
Test Teardown
    Close All Connections
